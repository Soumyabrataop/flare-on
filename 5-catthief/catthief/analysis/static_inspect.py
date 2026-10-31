"""Static PE inspection only; never executes the sample."""
import argparse
from pathlib import Path
import pefile
import capstone
from capstone.x86 import X86_OP_MEM, X86_REG_RIP

ROOT = Path(__file__).resolve().parents[1]
pe = pefile.PE(str(ROOT / 'catthief.exe'))
base = pe.OPTIONAL_HEADER.ImageBase
md = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
md.detail = True
md.skipdata = True
parser = argparse.ArgumentParser()
parser.add_argument('--range', nargs=2, type=lambda x: int(x, 0))
parser.add_argument('--xref', nargs=2, type=lambda x: int(x, 0))
parser.add_argument('--bytes', nargs=2, type=lambda x: int(x, 0))
args = parser.parse_args()
if args.bytes:
    va, size = args.bytes
    data = pe.get_data(va - base, size)
    print(data.hex(' '))
    print(repr(data))
if args.range:
    start, end = args.range
    for insn in md.disasm(pe.get_data(start - base, end - start), start):
        print(f'{insn.address:016x} {insn.mnemonic:8} {insn.op_str}')
if args.xref:
    low, high = args.xref
    text = pe.sections[0]
    funcs = [(base + e.struct.BeginAddress, base + e.struct.EndAddress) for e in pe.DIRECTORY_ENTRY_EXCEPTION]
    for insn in md.disasm(text.get_data(), base + text.VirtualAddress):
        if insn.id == 0:
            continue
        refs = [insn.address + insn.size + op.mem.disp for op in insn.operands if op.type == X86_OP_MEM and op.mem.base == X86_REG_RIP]
        if any(low <= ref < high for ref in refs):
            func = next(((hex(a), hex(b)) for a, b in funcs if a <= insn.address < b), None)
            print(hex(insn.address), insn.mnemonic, insn.op_str, 'function', func)
