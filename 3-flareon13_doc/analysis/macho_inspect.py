"""Read-only static Mach-O inspection; never loads or executes the input."""
import argparse
import hashlib
import re
import struct
import sys
from pathlib import Path

sys.dont_write_bytecode = True
BASE = Path(__file__).resolve().parent
if sys.platform == 'win32':
    sys.path.insert(0, str(BASE / "vendor"))
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN
from capstone.arm64 import ARM64_OP_IMM, ARM64_OP_REG, ARM64_OP_MEM



def zstr(b):
    return b.split(b"\0", 1)[0].decode("utf-8", "replace")


class MachO:
    def __init__(self, blob, offset, size):
        self.blob, self.offset, self.size = blob, offset, size
        self.data = blob[offset:offset + size]
        magic, self.cpu, self.subtype, self.filetype, ncmds, cmdsize, flags, reserved = struct.unpack_from("<8I", self.data)
        if magic != 0xFEEDFACF:
            raise ValueError("Not a little-endian 64-bit Mach-O")
        self.commands, self.sections, self.symbols, self.functions = [], [], [], []
        self.entry = None
        pos = 32
        for _ in range(ncmds):
            cmd, size = struct.unpack_from("<II", self.data, pos)
            if size < 8 or pos + size > len(self.data):
                raise ValueError("Invalid load command")
            self.commands.append((cmd, pos, size))
            if cmd == 0x19:
                name, va, vs, fo, fs, maxprot, prot, ns, segflags = struct.unpack_from("<16sQQQQiiII", self.data, pos + 8)
                for i in range(ns):
                    secname, segname, addr, length, fileoff, align, reloff, nreloc, sflags, r1, r2, r3 = struct.unpack_from("<16s16sQQ8I", self.data, pos + 72 + i * 80)
                    self.sections.append(dict(name=zstr(segname) + "," + zstr(secname), addr=addr, size=length, offset=fileoff, flags=sflags, r1=r1, r2=r2))
            elif cmd == 2:
                self.symtab = struct.unpack_from("<4I", self.data, pos + 8)
            elif cmd == 0xB:
                self.dysymtab = struct.unpack_from("<18I", self.data, pos + 8)
            elif cmd == 0x80000028:
                self.entry, self.stacksize = struct.unpack_from("<QQ", self.data, pos + 8)
            elif cmd == 0x26:
                self.funcdata = struct.unpack_from("<II", self.data, pos + 8)
            pos += size
        if hasattr(self, "symtab"):
            so, sn, stro, strsize = self.symtab
            strings = self.data[stro:stro + strsize]
            for i in range(sn):
                si, typ, sect, desc, value = struct.unpack_from("<IBBHQ", self.data, so + i * 16)
                self.symbols.append(dict(name=zstr(strings[si:]), type=typ, sect=sect, desc=desc, addr=value))
        self.labels = {s["addr"]: s["name"] for s in self.symbols if s["addr"]}
        if hasattr(self, "dysymtab"):
            indirectoff, indirectcount = self.dysymtab[12:14]
            indirect = struct.unpack_from("<" + "I" * indirectcount, self.data, indirectoff)
            for sec in self.sections:
                typ = sec["flags"] & 0xFF
                stride = sec["r2"] if typ == 8 else 8
                if typ in (6, 7, 8) and stride:
                    for i in range(sec["size"] // stride):
                        ix = sec["r1"] + i
                        if ix < len(indirect) and indirect[ix] < len(self.symbols):
                            self.labels[sec["addr"] + i * stride] = self.symbols[indirect[ix]]["name"] + " [indirect]"
        if hasattr(self, "funcdata"):
            off, size = self.funcdata
            stream = self.data[off:off + size]
            text = next(s for s in self.sections if s["name"] == "__TEXT,__text")
            # LC_FUNCTION_STARTS uses the __TEXT segment base, not __text.
            addr = text["addr"] - text["offset"]
            value = shift = 0
            for b in stream:
                value |= (b & 127) << shift
                if b & 128:
                    shift += 7
                else:
                    if not value:
                        break
                    addr += value
                    self.functions.append(addr)
                    value = shift = 0

    def section_at(self, addr):
        return next((s for s in self.sections if s["addr"] <= addr < s["addr"] + s["size"]), None)

    def file_at(self, addr):
        sec = self.section_at(addr)
        if sec is None or sec["flags"] & 0xFF in (1, 0xC, 0x12):
            return None
        return sec["offset"] + addr - sec["addr"]

    def describe(self, addr):
        label = self.labels.get(addr, "")
        off = self.file_at(addr)
        if off is not None:
            raw = self.data[off:off + 180].split(b"\0", 1)[0]
            if raw and all(32 <= b < 127 or b in (9, 10, 13) for b in raw):
                label += " " + repr(raw.decode("ascii"))
        return label.strip()

    def disasm(self, start, count):
        off = self.file_at(start)
        if off is None:
            raise ValueError("Address is not file-backed")
        md = Cs(CS_ARCH_ARM64, CS_MODE_LITTLE_ENDIAN)
        md.detail = True
        regs = {}
        for ins in md.disasm(self.data[off:off + count * 4], start):
            if ins.address in self.labels:
                print("\n" + self.labels[ins.address] + ":")
            notes = []
            for operand in ins.operands:
                if operand.type == ARM64_OP_IMM:
                    desc = self.describe(operand.imm)
                    if desc:
                        notes.append(desc)
            if ins.mnemonic in ("adrp", "adr"):
                regs[ins.operands[0].reg] = ins.operands[1].imm
            elif ins.mnemonic == "add" and len(ins.operands) == 3 and ins.operands[2].type == ARM64_OP_IMM:
                dst, src = ins.operands[0].reg, ins.operands[1].reg
                if src in regs:
                    regs[dst] = regs[src] + ins.operands[2].imm
                    notes.append(f"=> {regs[dst]:#x} " + self.describe(regs[dst]))
                else:
                    regs.pop(dst, None)
            elif ins.mnemonic == "mov" and len(ins.operands) == 2:
                dst, src = ins.operands
                if src.type == ARM64_OP_IMM:
                    regs[dst.reg] = src.imm
                elif src.type == ARM64_OP_REG and src.reg in regs:
                    regs[dst.reg] = regs[src.reg]
                else:
                    regs.pop(dst.reg, None)
            elif ins.mnemonic.startswith("ldr") and len(ins.operands) > 1 and ins.operands[1].type == ARM64_OP_MEM:
                mem = ins.operands[1].mem
                if mem.base in regs:
                    addr = regs[mem.base] + mem.disp
                    notes.append(f"load {addr:#x} " + self.describe(addr))
                regs.pop(ins.operands[0].reg, None)
            else:
                try:
                    _, written = ins.regs_access()
                    for reg in written:
                        regs.pop(reg, None)
                except Exception:
                    pass
            if ins.mnemonic in ("bl", "blr"):
                regs.clear()
            print(f"{ins.address:016x} file={self.offset + off + ins.address - start:#08x}  {ins.mnemonic:8} {ins.op_str:44} {'; '.join(notes)}")

    def summary(self):
        print(f"SLICE offset={self.offset:#x} size={self.size:#x} cpu={self.cpu:#x} subtype={self.subtype:#x} filetype={self.filetype}")
        print("LOAD COMMANDS")
        for cmd, off, size in self.commands:
            extra = ""
            if cmd in (0xC, 0xD, 0x80000018, 0x8000001F):
                nameoff = struct.unpack_from("<I", self.data, off + 8)[0]
                extra = zstr(self.data[off + nameoff:off + size])
            print(f"  cmd={cmd:#x} sliceoff={off:#x} size={size:#x} {extra}")
        print("SECTIONS")
        for s in self.sections:
            print(f"  {s['name']:28} va={s['addr']:#x} size={s['size']:#x} sliceoff={s['offset']:#x} absolute={self.offset + s['offset']:#x}")
        print(f"LC_MAIN entryoff={self.entry!r}")
        if self.entry is not None:
            sec = next((s for s in self.sections if s["flags"] & 0xFF not in (1, 0xC, 0x12) and s["offset"] <= self.entry < s["offset"] + s["size"]), None)
            if sec:
                print(f"ENTRY VA={sec['addr'] + self.entry - sec['offset']:#x} absolute={self.offset + self.entry:#x}")
        print("SYMBOLS")
        for s in self.symbols:
            print(f"  {s['addr']:#018x} type={s['type']:#x} sect={s['sect']} {s['name']}")
        print("FUNCTION STARTS", " ".join(hex(a) for a in self.functions))
        for cmd, pos, _ in self.commands:
            if cmd != 0x1D:
                continue
            off, length = struct.unpack_from("<II", self.data, pos + 8)
            magic, total, count = struct.unpack_from(">III", self.data, off)
            if magic != 0xFADE0CC0:
                continue
            for i in range(count):
                slot, relative = struct.unpack_from(">II", self.data, off + 12 + i * 8)
                directory = off + relative
                if struct.unpack_from(">I", self.data, directory)[0] == 0xFADE0C02:
                    identoff = struct.unpack_from(">I", self.data, directory + 20)[0]
                    ident = directory + identoff
                    print(f"CODE SIGNATURE identifier={zstr(self.data[ident:])!r} absolute={self.offset + ident:#x}")


def recover(blob):
    """Translate constant-only data transformations, not machine-code emulation."""
    if hashlib.sha256(blob).hexdigest() != "c1df0f6bfdc367097a8fc2f904da0bdc1576fc0744e2fbbad27e205635cc92f9":
        raise ValueError("Recovery offsets apply only to the inspected click_me")
    block = bytearray(64)
    block[:16] = blob[0x5270:0x5280]
    block[16:32] = blob[0x5260:0x5270]
    block[48:64] = blob[0x5250:0x5260]
    words = list(struct.unpack("<16I", block)) + [0] * 64
    # The zero-valued volatile switch selects XOR without SHA-1's ROL1.
    for i in range(16, 80):
        words[i] = words[i - 3] ^ words[i - 8] ^ words[i - 14] ^ words[i - 16]
    iv = (0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0)
    a, b, c, d, e = iv
    mask = 0xFFFFFFFF
    def rol(x, n):
        return ((x << n) | (x >> (32 - n))) & mask
    for i in range(80):
        phase = ((i * 205) >> 12) & 15
        if phase == 0:
            f, k = (b & c) | (d & ~b), 0x5A827999
        elif phase == 1:
            f, k = b ^ c ^ d, 0x6ED9EBA1
        elif phase == 2:
            f, k = (c & d) | (b & (c | d)), 0x8F1BBCDC
        else:
            f, k = b ^ c ^ d, 0xCA62C1D6
        a, b, c, d, e = (rol(a, 5) + e + f + k + words[i]) & mask, a, rol(b, 30), c, d
    digest = "".join(f"{(x + y) & mask:08x}" for x, y in zip((a, b, c, d, e), iv))
    xor_key = blob[0x5280:0x5290] + bytes((0x50, 0x4A, 7))
    result = bytes(x ^ y for x, y in zip(digest.encode()[:19], xor_key))
    assert result == "Ød1n_373rn4l_fl4r3".encode("utf-8")
    print(f"SLICE 0 reconstructed block: {block.hex()}")
    print(f"SLICE 0 nonstandard SHA-1-like digest: {digest}")
    print(f"SLICE 0 display bytes: {result!r}; UTF-8: {result.decode('utf-8')}")
    print("SLICE 0 XOR80 display palette:", repr(bytes(x ^ 128 for x in blob[0x5200:0x5250]) + bytes(x ^ 128 for x in (0xC2, 0xA6, 0xC0))))
    def pack_nibbles(data):
        return bytes(((hi << 4) | (lo & 15)) & 255 for hi, lo in zip(data[::2], data[1::2]))
    targets = []
    for off in range(0x4DE30, 0x4DEF0, 32):
        target = pack_nibbles(blob[off:off + 32])
        targets.append(target)
        print(f"SLICE 1 MD5 target absolute={off:#x}: {target.hex()}")
    clue = b"mainframe_ebcdic_ghost"
    clue_md5 = hashlib.md5(clue).digest()
    assert clue_md5 == targets[1]
    print(f"VERIFIED: MD5({clue!r})={clue_md5.hex()} matches target 2 (unordered matching)")
    print("SLICE 1 packed RC4 ciphertext absolute=0x4def0, encoded=80 bytes, decoded=40 bytes:", pack_nibbles(blob[0x4DEF0:0x4DF40]).hex())


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--slice", type=int, default=0)
    ap.add_argument("--disasm", type=lambda x: int(x, 0))
    ap.add_argument("--count", type=int, default=100)
    ap.add_argument("--strings", action="store_true")
    ap.add_argument("--recover", action="store_true")
    args = ap.parse_args()
    blob = (BASE / "disc" / "click_me").read_bytes()
    print(f"FILE size={len(blob)} sha256={hashlib.sha256(blob).hexdigest()}")
    slices = []
    magic = struct.unpack_from(">I", blob)[0]
    if magic == 0xCAFEBABE:
        n = struct.unpack_from(">I", blob, 4)[0]
        for i in range(n):
            cpu, subtype, off, size, align = struct.unpack_from(">5I", blob, 8 + 20 * i)
            print(f"FAT {i}: cpu={cpu:#x} subtype={subtype:#x} offset={off:#x} size={size:#x} align=2^{align}")
            slices.append((off, size))
    elif magic == 0xCAFEBABF:
        n = struct.unpack_from(">I", blob, 4)[0]
        for i in range(n):
            cpu, subtype, off, size, align, reserved = struct.unpack_from(">IIQQII", blob, 8 + 32 * i)
            print(f"FAT {i}: cpu={cpu:#x} subtype={subtype:#x} offset={off:#x} size={size:#x} align=2^{align}")
            slices.append((off, size))
    else:
        slices.append((0, len(blob)))
    if args.recover:
        recover(blob)
        return
    m = MachO(blob, *slices[args.slice])
    if args.disasm is not None:
        m.disasm(args.disasm, args.count)
    elif args.strings:
        for match in re.finditer(rb"[\x20-\x7e]{4,}", m.data):
            sec = next((s for s in m.sections if s["flags"] & 0xFF not in (1, 0xC, 0x12) and s["offset"] <= match.start() < s["offset"] + s["size"]), None)
            va = hex(sec["addr"] + match.start() - sec["offset"]) if sec else "-"
            print(f"absolute={m.offset + match.start():#x} sliceoff={match.start():#x} va={va} {match.group().decode('ascii')}")
    else:
        m.summary()


if __name__ == "__main__":
    main()
