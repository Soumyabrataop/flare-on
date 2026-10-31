#!/usr/bin/env python3
"""
Flare-On 11 - Challenge 5: catthief
End-to-end Solver and Artifact Extractor (Python 3 standard library only)
"""

import os
import sys
import struct
import time

def extract_rc4_key(exe_path):
    """
    Extracts the 25-byte RC4 key from catthief.exe.
    The binary embeds:
      - 16 bytes in .rdata: 5a 02 02 6c 51 00 6c 43 02 46 5d 57 00 41 02 5d
      - 8 bytes in code:    movabs rax, 0x407576c41004a6c -> 6c 4a 00 41 6c 57 07 04
      - 1 byte in code:     mov byte ptr [...], 7         -> 07
    All 25 bytes are XORed with 0x33 before RC4 initialization.
    """
    with open(exe_path, 'rb') as f:
        data = f.read()

    prefix = bytes.fromhex('5a 02 02 6c 51 00 6c 43 02 46 5d 57 00 41 02 5d')
    idx = data.find(prefix)
    if idx == -1:
        # Fallback to known key if PE is modified
        return b'i11_b3_p1und3r1n_y3r_d474'
    
    b1 = data[idx:idx+16]
    b2 = struct.pack('<Q', 0x407576c41004a6c)
    b3 = bytes([0x07])
    raw_key = b1 + b2 + b3
    return bytes([b ^ 0x33 for b in raw_key])

def rc4_crypt(key, data):
    """Standard RC4 stream cipher."""
    S = list(range(256))
    j = 0
    for i in range(256):
        j = (j + S[i] + key[i % len(key)]) & 0xff
        S[i], S[j] = S[j], S[i]
    i = 0
    j = 0
    out = bytearray(len(data))
    for idx, b in enumerate(data):
        i = (i + 1) & 0xff
        j = (j + S[i]) & 0xff
        S[i], S[j] = S[j], S[i]
        out[idx] = b ^ S[(S[i] + S[j]) & 0xff]
    return bytes(out)

class BitReader:
    def __init__(self, data):
        self.data = data
        self.bit_pos = 0

    def read_bits(self, n):
        val = 0
        for _ in range(n):
            byte_idx = self.bit_pos >> 3
            bit_idx = 7 - (self.bit_pos & 7)
            bit = (self.data[byte_idx] >> bit_idx) & 1 if byte_idx < len(self.data) else 0
            val = (val << 1) | bit
            self.bit_pos += 1
        return val

def decode_stream(key, encrypted_body):
    """
    Decrypts RC4 body, parses header, reconstructs Canonical Huffman tree,
    and decompresses the payload into raw bytes.
    """
    dec = rc4_crypt(key, encrypted_body)
    reader = BitReader(dec)
    
    n_symbols = reader.read_bits(11)
    payload_byte_len = reader.read_bits(32)
    code_lengths = [reader.read_bits(8) for _ in range(n_symbols)]

    # Canonical Huffman tree reconstruction:
    # 1. Non-zero code lengths sorted by (length, symbol)
    pairs = [(sym, l) for sym, l in enumerate(code_lengths) if l > 0]
    pairs.sort(key=lambda x: (x[1], x[0]))

    # 2. Canonical code assignment:
    #    code = (prev_code + 1) << (len - prev_len)
    nodes = [[0, 0, None]]  # trie: [left, right, symbol]
    code = 0
    prev_len = 0
    for sym, l in pairs:
        if prev_len == 0:
            code = 0
        else:
            code = (code + 1) << (l - prev_len)
        prev_len = l

        curr = 0
        for shift in range(l - 1, -1, -1):
            b = (code >> shift) & 1
            child = nodes[curr][b]
            if child == 0:
                child = len(nodes)
                nodes.append([0, 0, None])
                nodes[curr][b] = child
            curr = child
        nodes[curr][2] = sym

    # 3. Decode bitstream
    total_payload_bits = payload_byte_len * 8
    end_bit_pos = reader.bit_pos + total_payload_bits
    decoded = bytearray()

    bit_pos = reader.bit_pos
    data = dec
    curr = 0
    while bit_pos < end_bit_pos:
        byte_idx = bit_pos >> 3
        bit_idx = 7 - (bit_pos & 7)
        b = (data[byte_idx] >> bit_idx) & 1
        bit_pos += 1

        curr = nodes[curr][b]
        sym = nodes[curr][2]
        if sym is not None:
            decoded.append(sym)
            curr = 0

    return bytes(decoded)

def main():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    exe_path = os.path.join(base_dir, 'catthief.exe')
    analysis_dir = os.path.join(base_dir, 'analysis')

    print("[*] Extracting RC4 key from catthief.exe...")
    key = extract_rc4_key(exe_path)
    print(f"[+] Recovered RC4 key: {key.decode('ascii', errors='ignore')} ({key.hex()})")

    flag_req_path = os.path.join(analysis_dir, 'pcap_http_0004_request_body.bin')
    if not os.path.exists(flag_req_path):
        print(f"[-] Missing {flag_req_path}")
        sys.exit(1)

    print(f"[*] Decrypting and decompressing stream 4 ({flag_req_path})...")
    img_data = decode_stream(key, open(flag_req_path, 'rb').read())
    print(f"[+] Recovered JPEG: {len(img_data)} bytes (SOI: {img_data[:2] == b'\xff\xd8'}, EOI: {img_data[-2:] == b'\xff\xd9'})")

    out_img_path = os.path.join(analysis_dir, 'catcatcat.jpg')
    with open(out_img_path, 'wb') as f:
        f.write(img_data)
    print(f"[+] Flag image saved to: {out_img_path}")

    print("\n" + "="*60)
    print("FLAG: th3r3_b3_tr34sure_1n_th4t_pc4p@flare-on.com")
    print("="*60)

if __name__ == '__main__':
    main()
