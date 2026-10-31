"""Reproduce ToxicMiner's flag derivation without running the miner.

Verification (WSL): python3 solve.py --verify
Decrypt a serial:   python3 solve.py --serial 0x12345678
Optional verification dependencies: pefile, unicorn (also searched in .solver-deps).
"""
import argparse
from pathlib import Path
import random
import struct
import sys

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / '.solver-deps'))
MASK = 0xffffffff
IV = (0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
      0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19)
K = (
    0x71374491, 0x428a2f98, 0xb5c0fbcf, 0xe9b5dba5,
    0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
    0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
    0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
    0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
    0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
)
TABLE = struct.pack('<64I', *K)
CIPHERTEXT = bytes.fromhex(
    'f4f9659f31f3da5cf137a1b8cf90a1581eebe499a7c11b1502af7463d3b21928'
    '66de3de97163e775dfe4ab616fb90c2789fc87')
NONCE = 0x0b501e7e


def ror(value, count):
    return ((value >> count) | (value << (32 - count))) & MASK


def compress(state, block):
    """Input/output are native uint32_t words, not serialized SHA digests."""
    w = list(block)
    for i in range(16, 32):
        s0 = ror(w[i - 15], 7) ^ ror(w[i - 15], 18) ^ (w[i - 15] >> 3)
        s1 = ror(w[i - 2], 17) ^ ror(w[i - 2], 19) ^ (w[i - 2] >> 10)
        w.append((w[i - 16] + s0 + w[i - 7] + s1) & MASK)
    a, b, c, d, e, f, g, h = state
    for i in range(32):
        choice = (((f + g) & MASK) & e) ^ g
        majority = (((a & c) + (b & c)) & MASK) ^ (a & b)
        t1 = (h + (ror(e, 6) ^ ror(e, 11) ^ ror(e, 25))
              + choice + K[i] + w[i]) & MASK
        t2 = ((ror(a, 2) ^ ror(a, 13) ^ ror(a, 22)) + majority) & MASK
        a, b, c, d, e, f, g, h = (t1 + t2) & MASK, a, b, c, (d + t1) & MASK, e, f, g
    result = [(x + y) & MASK for x, y in zip(state, (a, b, c, d, e, f, g, h))]
    packed = struct.pack('<8I', *result)
    result[0] ^= TABLE[result[0] & 255] ^ struct.unpack_from('<I', packed, result[1] % 28)[0]
    return result


def derive(serial, nonce=NONCE):
    first = compress(IV, [serial, nonce, 0x80000000] + [0] * 12 + [64])
    second = compress(IV, first + [0x80000000] + [0] * 6 + [256])
    return struct.pack('<8I', *second)


def rc4(key, data):
    s = list(range(256))
    j = 0
    for i in range(256):
        j = (j + s[i] + key[i % len(key)]) & 255
        s[i], s[j] = s[j], s[i]
    i = j = 0
    out = bytearray()
    for byte in data:
        i = (i + 1) & 255
        j = (j + s[i]) & 255
        s[i], s[j] = s[j], s[i]
        out.append(byte ^ s[(s[i] + s[j]) & 255])
    return bytes(out)


class BinaryOracle:
    """Emulate only the pure hash/RC4 functions; never enter the miner."""
    def __init__(self):
        import pefile
        from unicorn import Uc, UC_ARCH_X86, UC_MODE_64
        from unicorn import x86_const
        self.regs = x86_const
        pe = pefile.PE(str(ROOT / 'ToxicMiner.exe'))
        self.base = pe.OPTIONAL_HEADER.ImageBase
        self.uc = Uc(UC_ARCH_X86, UC_MODE_64)
        self.uc.mem_map(self.base, (pe.OPTIONAL_HEADER.SizeOfImage + 4095) & ~4095)
        self.uc.mem_write(self.base, pe.get_memory_mapped_image())
        # The compiler's stack-cookie check is unrelated to the algorithm.
        self.uc.mem_write(self.base + 0x1b5790, b'\xc3')
        self.uc.mem_map(0x10000000, 0x20000)
        self.stack = 0x10010008
        self.stop = 0x10001000
        assert pe.get_data(0x1bd270, 256) == TABLE
        assert pe.get_data(0x1bd3b0, 51) == CIPHERTEXT

    def call(self, rva, rcx, rdx, r8=0, r9=0, fifth=0):
        r = self.regs
        self.uc.reg_write(r.UC_X86_REG_RSP, self.stack)
        self.uc.mem_write(self.stack, struct.pack('<Q', self.stop))
        self.uc.mem_write(self.stack + 40, struct.pack('<Q', fifth))
        for reg, val in ((r.UC_X86_REG_RCX, rcx), (r.UC_X86_REG_RDX, rdx),
                         (r.UC_X86_REG_R8, r8), (r.UC_X86_REG_R9, r9)):
            self.uc.reg_write(reg, val)
        self.uc.emu_start(self.base + rva, self.stop, count=100000)
        assert self.uc.reg_read(r.UC_X86_REG_RIP) == self.stop

    def compress(self, state, block):
        self.uc.mem_write(0x10002000, struct.pack('<8I', *state))
        self.uc.mem_write(0x10003000, struct.pack('<16I', *block))
        self.call(0x135240, 0x10002000, 0x10003000)
        return list(struct.unpack('<8I', self.uc.mem_read(0x10002000, 32)))

    def derive(self, serial, nonce=NONCE):
        self.call(0x134ca0, serial, nonce, 0x10002000)
        return bytes(self.uc.mem_read(0x10002000, 32))

    def decrypt(self, key, data):
        self.uc.mem_write(0x10002000, key)
        self.uc.mem_write(0x10003000, data)
        self.call(0x134d70, 0x10002000, len(key), 0x10003000, len(data), 0x10004000)
        assert self.uc.mem_read(0x10004000 + len(data), 1) == b'\x00'
        return bytes(self.uc.mem_read(0x10004000, len(data)))


def verify():
    oracle = BinaryOracle()
    rng = random.Random(0x544f5849)
    for _ in range(100):
        state = [rng.getrandbits(32) for _ in range(8)]
        block = [rng.getrandbits(32) for _ in range(16)]
        actual = oracle.compress(state, block)
        expected = compress(state, block)
        assert actual == expected, (actual, expected)
    for serial in [0, 1, NONCE, MASK] + [rng.getrandbits(32) for _ in range(25)]:
        key = derive(serial)
        assert key == oracle.derive(serial)
        assert rc4(key[:16], CIPHERTEXT) == oracle.decrypt(key[:16], CIPHERTEXT)
    print('Verified 100 compressor vectors and 29 complete hash/RC4 vectors against the binary.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--verify', action='store_true')
    parser.add_argument('--serial', type=lambda s: int(s, 0))
    args = parser.parse_args()
    if args.verify:
        verify()
    if args.serial is not None:
        if not 0 <= args.serial <= MASK:
            parser.error('serial must be a uint32_t')
        digest = derive(args.serial)
        flag = rc4(digest[:16], CIPHERTEXT)
        print(f'Serial: 0x{args.serial:08x}')
        print(f'RC4 key: {digest[:16].hex()}')
        print(f'Mining target: {digest.hex()}')
        print(f'Plaintext: {flag!r}')
        if args.verify:
            oracle = BinaryOracle()
            assert digest == oracle.derive(args.serial)
            assert flag == oracle.decrypt(digest[:16], CIPHERTEXT)


if __name__ == '__main__':
    main()
