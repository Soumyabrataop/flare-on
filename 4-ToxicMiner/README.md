# ToxicMiner — solved

Flag:

```text
cpu_m3lt3d_4nd_all_i_g0t_w4s_th1s_fl4g@flare-on.com
```


- Volume serial: `0x01cec01d` (30326813)
- Fixed flag-derivation nonce: `0x0b501e7e`
- RC4 key: `761fcd4a32f712d302644850b953b63d`
- Full derived target: `761fcd4a32f712d302644850b953b63d3cbdef20da4cceb3d9d87529163b06ff`

## Why the earlier solver failed

The earlier brute-force solver used standard double SHA-256. The binary instead
uses a modified compression function at RVA `0x135240`:

1. Only 32 rounds; the first two SHA-256 constants are swapped.
2. Choice is `((f + g) & e) ^ g`.
3. Majority is `((a & c) + (b & c)) ^ (a & b)`.
4. After feed-forward, state word 0 is XORed with a byte from the little-endian
   constant table and an **unaligned 32-bit word** from state byte offset
   `state[1] % 28`. Both lookups use the state before this final modification.
5. The hash receives numeric words directly, and its output is serialized
   little-endian for RC4—not as a standard big-endian SHA digest.

All arithmetic wraps to 32 bits. The double-hash helper at RVA `0x134ca0`
processes `[serial, nonce]`, with normal SHA-style padding represented as numeric
words. Its first 16 output bytes key the standard RC4 function at RVA `0x134d70`.
The ciphertext is 51 bytes at RVA `0x1bd3b0`.

The previous solver also required decrypted byte 50 to be null. That is wrong:
all **51 bytes are flag text**; the binary appends a null afterward. Furthermore,
its `found` variable was never updated, so it always printed `NOT FOUND`.
Obsolete exploratory scripts and generated artifacts have been removed; the
verified solver sources remain.

## Reproduce without running the miner

From this directory in Ubuntu/WSL:

```sh
python3 solve.py --serial 0x01cec01d
```

`solve.py` has no third-party dependencies for decryption. Optional verification
uses `pefile` and `unicorn`; it also finds packages installed in `.solver-deps`:

```sh
python3 -m pip install --target .solver-deps pefile unicorn
python3 solve.py --verify --serial 0x01cec01d
```

This emulates only the isolated hash and RC4 functions. It never starts the
miner or calls its entry point; the compiler's stack-cookie check is stubbed.

To rebuild the multithreaded offline serial search:

```sh
gcc -std=c11 -O3 -march=native -fopenmp solve_serial.c -o solve_serial
./solve_serial 0 0xffffffff 16
```

Search bounds are inclusive. Exit codes are 0 for FOUND, 1 for NOT FOUND, and 2
for invalid arguments. The full search is no longer necessary; a one-candidate
regression check is:

```sh
./solve_serial 0x01cec01d 0x01cec01d 1
```

Validation passed: 100 random compressor comparisons and 29 full hash/RC4
comparisons against the binary, 1,004 C/Python derivation comparisons, and the
recovered serial's exact digest and plaintext against the binary. The recovered
flag was also confirmed correct by the challenge participant.
