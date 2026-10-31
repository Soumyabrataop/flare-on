import struct, sys, zlib

import os
doc_path = '../flareon13.doc' if os.path.exists('../flareon13.doc') else r'C:/Users/hp/Downloads/3-flareon13_doc/flareon13.doc'
d = open(doc_path, 'rb').read()
p = d.rindex(b'PK\x03\x04')
(sig, ver, flags, method, mt, md, crc, csize, usize, nlen, elen) = struct.unpack('<IHHHHHIIIHH', d[p:p + 30])
data = d[p + 30 + nlen + elen: p + 30 + nlen + elen + csize]
print('flags', flags, 'method', method, 'crc', hex(crc), 'csize', csize, 'usize', usize)

CRC = [0] * 256
for i in range(256):
    c = i
    for _ in range(8):
        c = (c >> 1) ^ 0xEDB88320 if c & 1 else c >> 1
    CRC[i] = c


def upd(k, b):
    return ((k >> 8) ^ CRC[(k ^ b) & 0xFF]) & 0xFFFFFFFF


def decrypt(pw, blob):
    k0, k1, k2 = 0x12345678, 0x23456789, 0x34567890
    for ch in pw:
        k0 = upd(k0, ch)
        k1 = ((k1 + (k0 & 0xFF)) * 134775813 + 1) & 0xFFFFFFFF
        k2 = upd(k2, k1 >> 24)
    out = bytearray()
    for c in blob:
        t = (k2 | 2) & 0xFFFF
        m = ((t * (t ^ 1)) >> 8) & 0xFF
        pch = c ^ m
        k0 = upd(k0, pch)
        k1 = ((k1 + (k0 & 0xFF)) * 134775813 + 1) & 0xFFFFFFFF
        k2 = upd(k2, k1 >> 24)
        out.append(pch)
    return bytes(out)


def reduce_decompress(buf, factor, usize):
    # PKWARE Reduce (methods 2-5), per APPNOTE section 5.3
    pos = [0]
    bits = [0, 0]

    def getbits(n):
        while bits[1] < n:
            if pos[0] >= len(buf):
                raise EOFError
            bits[0] |= buf[pos[0]] << bits[1]
            pos[0] += 1
            bits[1] += 8
        v = bits[0] & ((1 << n) - 1)
        bits[0] >>= n
        bits[1] -= n
        return v

    L_mask = {1: 0x7F, 2: 0x3F, 3: 0x1F, 4: 0x0F}[factor]
    D_shift = 8 - factor
    D_mask = (1 << D_shift) - 1

    def bitlen(n):
        return max(1, (n - 1).bit_length()) if n > 1 else 0

    follow = [[] for _ in range(256)]
    for x in range(255, -1, -1):
        n = getbits(6)
        s = [getbits(8) for _ in range(n)]
        follow[x] = s
    out = bytearray()
    last = 0
    state = 0
    V = 0
    Len = 0
    while len(out) < usize:
        fs = follow[last]
        if len(fs) == 0:
            c = getbits(8)
        else:
            nb = (len(fs) - 1).bit_length()
            if getbits(1):
                c = getbits(8)
            else:
                c = fs[getbits(nb)]
        if state == 0:
            if c != 0x90:
                out.append(c)
            else:
                state = 1
        elif state == 1:
            if c == 0:
                out.append(0x90)
                state = 0
            else:
                V = c
                Len = V & L_mask
                state = 2 if Len == L_mask else 3
        elif state == 2:
            Len += c
            state = 3
        else:
            offset = (((V >> D_shift) & D_mask) << 8) + c + 1
            Len += 3
            for _ in range(Len):
                out.append(out[-offset] if len(out) >= offset else 0)
            state = 0
        last = c
    return bytes(out[:usize])


def try_pw(pw):
    dec = decrypt(pw, data)
    ok_hdr = dec[11] == (crc >> 24)
    return ok_hdr, dec[12:]


if __name__ == '__main__':
    candidates = [
        'flare',
        'mainframe_ebcdic_ghost',
        'jbig2_fax_geometry',
        'FLARE-STANDARD-ANTIVIRUS-TEST-FILE!',
        'FLARE-STANDARD-ANTIVIRUS-TEST-FILE',
        'flare-standard-antivirus-test-file!',
        'Ød1n_373rn4l_fl4r3',
        'Odin_eternal_flare',
        'odin_eternal_flare',
        'conectix',
        'FLAREONPOLYGLOT!',
        'FLAREON',
        'benign corpus payload',
        'totally_fake_flag',
        'true_honest_flag',
        'FlareOn13.doc',
        'flareon13.doc',
        'click_me',
        'flag.txt',
    ]
    pws = sys.argv[1:] or candidates
    for pw in pws:
        try:
            pw_bytes = pw.encode('utf-8')
        except Exception:
            pw_bytes = pw.encode('latin1')
        ok, body = try_pw(pw_bytes)
        print(repr(pw), 'header-check', ok)
        if ok:
            try:
                out = reduce_decompress(body, method - 1, usize)
                print('  crc ok', zlib.crc32(out) == crc, out)
            except Exception as e:
                print('  decompress error', repr(e), body[:32].hex())

