import os, struct, zlib
d = open(os.path.join(os.path.dirname(__file__), '..', 'flareon13.doc'), 'rb').read()

# ZIP part
p = d.find(b'PK\x03\x04')
print('=== ZIP LFH at', hex(p))
sig, ver, flags, method, mt, md, crc, csize, usize, nlen, elen = struct.unpack('<IHHHHHIIIHH', d[p:p+30])
name = d[p+30:p+30+nlen]
print('name:', name, 'flags:', hex(flags), 'method:', method, 'crc:', hex(crc), 'csize:', csize, 'usize:', usize, 'elen:', elen)
extra = d[p+30+nlen:p+30+nlen+elen]
print('extra:', extra.hex())
data = d[p+30+nlen+elen:p+30+nlen+elen+csize]
print('first 16 data bytes:', data[:16].hex())
end = p + 30 + nlen + elen + csize
print('after data:', d[end:end+64].hex())

q = d.find(b'PK\x01\x02')
print('=== ZIP CDH at', hex(q))
sig, vem, vne, flags, method, mt, md, crc, csize, usize, nlen, elen, clen, dnum, iattr, eattr, lho = struct.unpack('<IHHHHHHIIIHHHHHII', d[q:q+46])
print('name:', d[q+46:q+46+nlen], 'extra:', d[q+46+nlen:q+46+nlen+elen].hex(), 'comment:', d[q+46+nlen+elen:q+46+nlen+elen+clen])

e = d.find(b'PK\x05\x06')
print('=== EOCD at', hex(e), ':', d[e:].hex())

print('=== VHD footer at 0x1c4f8f')
v = d[0x1c4f8f:]
print(len(v))
print('cookie:', v[:8])
print('hexdump:')
for i in range(0, len(v), 16):
    row = v[i:i+16]
    print('%04x  %-47s  %s' % (i, ' '.join('%02x' % b for b in row), ''.join(chr(b) if 32 <= b < 127 else '.' for b in row)))
