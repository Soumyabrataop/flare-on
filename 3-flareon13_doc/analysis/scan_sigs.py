import os
d = open(os.path.join(os.path.dirname(__file__), '..', 'flareon13.doc'), 'rb').read()
print('len', len(d), hex(len(d)))
sigs = {
    b'PK\x03\x04': 'ZIP_LFH', b'PK\x01\x02': 'ZIP_CDH', b'PK\x05\x06': 'ZIP_EOCD',
    b'%PDF': 'PDF_HDR', b'%%EOF': 'PDF_EOF', b'conectix': 'VHD',
    b'\x1f\x8b': 'GZIP', b'7z\xbc\xaf\x27\x1c': '7Z', b'Rar!': 'RAR',
    b'\x89PNG': 'PNG', b'\xff\xd8\xff': 'JPEG', b'CD001': 'ISO9660',
    b'BEA01': 'UDF_BEA', b'NSR02': 'NSR02', b'NSR03': 'NSR03',
    b'JB2': 'JB2', b'\x00\x00\x00\x0cjP  ': 'JP2', b'07070': 'CPPIO',
    b'\xed\xab\xee\xdb': 'RPM', b'MSCF': 'CAB', b'KGB': 'KGB',
    b'\x04\x22\x4d\x18': 'LZ4', b'\x28\xb5\x2f\xfd': 'ZSTD',
}
for s, name in sigs.items():
    pos, st = [], 0
    while True:
        i = d.find(s, st)
        if i < 0:
            break
        pos.append(hex(i))
        st = i + 1
        if len(pos) > 14:
            break
    if pos:
        print(name, pos)
