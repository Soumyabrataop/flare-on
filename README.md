# FLARE-On Challenge Solutions

Solutions and detailed write-ups for the challenges I solved in the FLARE-On reverse-engineering CTF. Each folder contains the original challenge artifacts, my solver scripts, analysis notes, and a full `WRITEUP.md` explaining how the flag was recovered.

> FLARE-On is an annual reverse-engineering contest run by the Mandiant (FLARE) team. Every flag is an email address ending in `@flare-on.com`.

## Challenges

| # | Challenge | Type | Key techniques | Write-up |
|---|-----------|------|----------------|----------|
| 1 | [FlareCaptcha](./1-flarecaptcha) | Web / JavaScript | Source review, double-layer XOR, known-plaintext recovery | [WRITEUP](./1-flarecaptcha/WRITEUP.md) |
| 2 | [GhostStream](./2-GhostStream) | Windows RE | NTFS alternate data stream, embedded PE, named pipe, modified RC4 + XOR | [WRITEUP](./2-GhostStream/WRITEUP.md) |
| 3 | [flareon13_doc](./3-flareon13_doc) | Polyglot / Forensics | PDF/ZIP/VHD/UDF polyglot, EBCDIC, JBIG2, self-modifying DOS stub, RC4 key from XORed hashes | [WRITEUP](./3-flareon13_doc/WRITEUP.md) |
| 4 | [ToxicMiner](./4-ToxicMiner) | Windows RE | Custom SHA-256 compression, RC4, emulated serial derivation | [WRITEUP](./4-ToxicMiner/README.md) |
| 5 | [catthief](./5-catthief) | Network forensics / Rust RE | PCAP carving, RC4, canonical Huffman decompression | [WRITEUP](./5-catthief/WRITEUP.md) |

## Flags

| # | Challenge | Flag |
|---|-----------|------|
| 1 | FlareCaptcha | `triskaidekaphobia@flare-on.com` |
| 2 | GhostStream | `y0u_kn0w_n07h1n6_j0n_5n0w@flare-on.com` |
| 3 | flareon13_doc | `Ju$7_4_l177l3_7r34$ur3_HUN7@flare-on.com` |
| 4 | ToxicMiner | `cpu_m3lt3d_4nd_all_i_g0t_w4s_th1s_fl4g@flare-on.com` |
| 5 | catthief | `th3r3_b3_tr34sure_1n_th4t_pc4p@flare-on.com` |

<details>
<summary>Spoiler warning</summary>

The flags above and the write-ups contain full spoilers. If you want to solve the challenges yourself, start from the artifacts in each folder and skip the `WRITEUP.md` files.

</details>

## Repository layout

```
.
├── 1-flarecaptcha/     # flarecaptcha.html + writeup
├── 2-GhostStream/      # extracted binaries, disassembly, writeup
├── 3-flareon13_doc/    # polyglot doc, disc image, analysis scripts, writeup
├── 4-ToxicMiner/       # ToxicMiner.exe, solve.py, solve_serial.c, README
└── 5-catthief/         # catthief.exe, capture.pcapng, solver + analysis
```

## Notes

- Binaries (`.exe`) are kept for reference only. Treat challenge samples as untrusted and run them only in an isolated VM.
- Solver scripts are written in Python / C and documented in each challenge's write-up, including how to reproduce the flag without executing the sample where possible.
