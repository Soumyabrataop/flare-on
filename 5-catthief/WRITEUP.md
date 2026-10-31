# Flare-On 11 - Challenge 5: catthief Writeup

## Solution / Flag
```
th3r3_b3_tr34sure_1n_th4t_pc4p@flare-on.com
```

---

## 1. Summary of Objective & Inputs

- **Inputs**:
  - `catthief.exe`: A 64-bit Windows binary written in Rust acting as an exfiltration agent.
  - `capture.pcapng`: A packet capture containing network traffic between the host (`192.168.56.103`) and C2 server (`192.168.56.102:8080`).
- **Objective**: Recover the exfiltrated contraband images from the packet capture and retrieve the challenge flag.

---

## 2. Technical Analysis & Root Cause

### Network Traffic Structure
The packet capture contains six sequential HTTP POST transactions to `http://192.168.56.102:8080/exfil`:
- **Stream 0**: Bootstrap probe (`264` bytes). C2 server responds with encrypted path `C:\Users\flare\Desktop\important.jpg`.
- **Stream 1**: Upload of `important.jpg` (`3,121,086` bytes). C2 responds with `C:\Users\flare\Desktop\anothercat.jpg`.
- **Stream 2**: Upload of `anothercat.jpg` (`2,736,058` bytes). C2 responds with `C:\Users\flare\Desktop\yetanothercat.jpg`.
- **Stream 3**: Upload of `yetanothercat.jpg` (`3,061,432` bytes). C2 responds with `C:\Users\flare\Desktop\catcatcat.jpg`.
- **Stream 4**: Upload of `catcatcat.jpg` (`3,079,606` bytes). C2 responds with `C:\Users\flare\Desktop\myfavoritecat.jpg`.
- **Stream 5**: Upload of `myfavoritecat.jpg` (`2,842,789` bytes). C2 responds with HTTP 200 (empty body).

### Encryption (RC4)
Static disassembly of `catthief.exe` around addresses `0x1400034b0` - `0x14000350b` reveals an RC4 implementation (`0x1400052e2` for KSA, `0x140005281` for PRGA):
- Key length: 25 bytes (`0x19`).
- Key components:
  - 16 bytes stored in `.rdata` at `0x1400c9010`: `5a 02 02 6c 51 00 6c 43 02 46 5d 57 00 41 02 5d`
  - 8 bytes immediate in code: `0x407576c41004a6c` (`6c 4a 00 41 6c 57 07 04`)
  - 1 byte immediate in code: `0x07`
  - All 25 bytes are XORed with constant `0x33`.
- Resulting RC4 key:
  ```
  b'i11_b3_p1und3r1n_y3r_d474'  (ASCII: "i11_b3_p1und3r1n_y3r_d474")
  ```
- Both HTTP response bodies (next filename commands) and HTTP request bodies (compressed payloads) are encrypted using this key.

### Custom Compression / Framing (Canonical Huffman)
Once decrypted with RC4, the POST body stream follows a custom framing structure:
1. **11 bits**: Symbol count `n_symbols` (typically `256` / `0x100`).
2. **32 bits**: Payload byte length `payload_byte_len` (in big-endian bit order).
3. **`n_symbols * 8` bits**: Code length table (1 byte per symbol `0..255`).
4. **`payload_byte_len * 8` bits**: Compressed data payload.

#### Codec Details:
- The symbol lengths are sorted by `(length ascending, symbol ascending)` (`0x1400018b8`, `0x140004d85`).
- Canonical Huffman codes are generated using standard rules:
  $$\text{code}_0 = 0$$
  $$\text{code}_i = (\text{code}_{i-1} + 1) \ll (\text{len}_i - \text{len}_{i-1})$$
- The bitstream is written MSB-to-LSB and packed into bytes.

---

## 3. Reproduction & Validation

### Reproduction Command (WSL Ubuntu)
```bash
wsl.exe -d Ubuntu --exec python3 /mnt/c/Users/hp/Downloads/5-catthief/catthief/solve.py
```
Or directly on Windows:
```powershell
python catthief\solve.py
```

### Script Outputs & Validation
- **Stream 1 (`important.jpg`)**: Decoded 3,123,324 bytes. JPEG SOI (`\xff\xd8`) and EOI (`\xff\xd9`) valid.
- **Stream 2 (`anothercat.jpg`)**: Decoded 2,738,892 bytes. JPEG SOI and EOI valid.
- **Stream 3 (`yetanothercat.jpg`)**: Decoded 3,065,529 bytes. JPEG SOI and EOI valid.
- **Stream 4 (`catcatcat.jpg`)**: Decoded 3,084,399 bytes. JPEG SOI and EOI valid. Image contains a pirate cat standing beside a treasure chest with a parchment scroll reading:
  ```
  th3r3_b3_tr34sure_1n_th4t_pc4p@flare-on.com
  ```
- **Stream 5 (`myfavoritecat.jpg`)**: Decoded 2,844,616 bytes. JPEG SOI and EOI valid.

---

## 4. Key Artifacts
- Solver script: [`catthief/solve.py`](file:///c:/Users/hp/Downloads/5-catthief/catthief/solve.py)
- Full stream extractor: [`catthief/analysis/decode_all.py`](file:///c:/Users/hp/Downloads/5-catthief/catthief/analysis/decode_all.py)
- Recovered flag image: [`catthief/analysis/catcatcat.jpg`](file:///c:/Users/hp/Downloads/5-catthief/catthief/analysis/catcatcat.jpg)
