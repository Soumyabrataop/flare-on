import os, hashlib
base = os.path.dirname(__file__)

clues = [
    'mainframe_ebcdic_ghost',
    'jbig2_fax_geometry',
    'udf_tagged_descriptor',
    'reduce_not_deflate',
    '\u00d8d1n_373rn4l_fl4r3',  # UTF-8 bytes c3 98 64 31 ...
    'FLARE-STANDARD-ANTIVIRUS-TEST-FILE!',
]
targets = {
    'd82180ab7986e8c8286ef00f16c04885',
    '555cca3a364f57bd4e550e8758f1c08d',
    'c790cb74ddc76a4f9f83c9f79882d6fc',
    'cf0cbd1b55755a81ff87f2be8fba8ebf',
    'd400db493c31ebf21fa0b2a4adeae070',
    '9fc1de183e2761585dfce907afa249dc',
}
acc = bytearray(32)
for c in clues:
    b = c.encode('utf-8')
    h = hashlib.md5(b).hexdigest()
    print(repr(c), h, 'OK' if h in targets else 'NO MATCH')
    assert h in targets
    dg = hashlib.sha256(b).digest()
    acc = bytearray(x ^ y for x, y in zip(acc, dg))

ct = bytes.fromhex('645128013769750e50451f917558f493e3aeed5a51d0cbfae98eed185e1b00b042a8f813a9d5551c')
key = bytes(acc)
print('key:', key.hex())

S = list(range(256))
j = 0
for i in range(256):
    j = (j + S[i] + key[i % 32]) & 255
    S[i], S[j] = S[j], S[i]
out = bytearray()
i = j = 0
for c in ct:
    i = (i + 1) & 255
    j = (j + S[i]) & 255
    S[i], S[j] = S[j], S[i]
    out.append(c ^ S[(S[i] + S[j]) & 255])
print('FLAG:', out.decode('utf-8', 'replace'))
print('raw :', bytes(out))
