import os
import sys
import time

def rc4_crypt(key, data):
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

KEY = b'i11_b3_p1und3r1n_y3r_d474'

STREAMS = [
    (1, 'catthief/analysis/pcap_http_0001_request_body.bin', 'catthief/analysis/important.jpg'),
    (2, 'catthief/analysis/pcap_http_0002_request_body.bin', 'catthief/analysis/anothercat.jpg'),
    (3, 'catthief/analysis/pcap_http_0003_request_body.bin', 'catthief/analysis/yetanothercat.jpg'),
    (4, 'catthief/analysis/pcap_http_0004_request_body.bin', 'catthief/analysis/catcatcat.jpg'),
    (5, 'catthief/analysis/pcap_http_0005_request_body.bin', 'catthief/analysis/myfavoritecat.jpg'),
]

for stream_num, in_path, out_path in STREAMS:
    t0 = time.time()
    print(f"Decoding stream {stream_num}: {in_path} -> {out_path}...")
    with open(in_path, 'rb') as f:
        raw_req = f.read()

    dec = rc4_crypt(KEY, raw_req)
    reader = BitReader(dec)
    n_symbols = reader.read_bits(11)
    payload_byte_len = reader.read_bits(32)
    code_lengths = [reader.read_bits(8) for _ in range(n_symbols)]

    pairs = [(sym, l) for sym, l in enumerate(code_lengths) if l > 0]
    pairs.sort(key=lambda x: (x[1], x[0]))

    # Build array-based trie for speed
    # node: [child0_index, child1_index, sym_or_None]
    nodes = [[0, 0, None]]
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

    total_payload_bits = payload_byte_len * 8
    end_bit_pos = reader.bit_pos + total_payload_bits
    decoded = bytearray()
    
    # Fast bit decoding loop
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

    reader.bit_pos = bit_pos
    t1 = time.time()
    print(f"  Decoded {len(decoded)} bytes in {t1 - t0:.2f}s")
    valid_soi = decoded[:2] == b'\xff\xd8'
    valid_eoi = decoded[-2:] == b'\xff\xd9'
    print(f"  SOI: {valid_soi}, EOI: {valid_eoi}")
    
    with open(out_path, 'wb') as f:
        f.write(decoded)

print("All streams decoded successfully!")
