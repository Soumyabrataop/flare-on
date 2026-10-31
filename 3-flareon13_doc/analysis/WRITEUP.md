# Flare-On 13, Challenge 3 — Full Solve Story

This is the step-by-step account of how `flareon13.doc` was cracked, written so you
can follow along without knowing anything about file formats or programming.

Flag: **`Ju$7_4_l177l3_7r34$ur3_HUN7@flare-on.com`**

---

## Step 0: The setup

We were given one file, `flareon13.doc` (about 1.8 MB), plus a README that joked it
was a *"benign corpus payload"* — antivirus test files are called "corpus", so this is
the challenge saying: "this file looks like a harmless specimen, but it isn't."

The task: find the hidden flag, in the usual Flare-On email format
`something@flare-on.com`.

---

## Step 1: Realizing the file is several files at once

The first instinct with any mystery file is to look at its raw bytes and hunt for
"signatures" — short byte patterns that mark where well-known file formats begin.
It's like finding the seams in a costume.

Scanning the file turned up an absurd number of seams:

- A **PDF** header near the start (that's the "Word document" — it was never a Word
  document at all)
- An encrypted **ZIP** archive near the end
- A **virtual hard disk (VHD)** footer at the very end — the kind of footer used by
  disk image files for virtual machines
- Deep inside the PDF, an entire **CD-ROM disc image** (1.6 MB worth)

So the file is a matryoshka: a PDF wearing a DOS-program hat, containing a CD, next
to a ZIP, wearing a hard disk as a shoe. Six hidden compartments — which matters
later, because the checker turns out to want exactly **six** secret words.

One nice early touch: the VHD footer contains the text `FLAREONPOLYGLOT!` in a field
where a disk would normally say "conectix" (Microsoft's old Virtual PC signature).
That was the challenge author winking at us: yes, it's a polyglot, keep digging.

---

## Step 2: Finding the referee

Before guessing anything, we needed to know what a "correct answer" looks like.
Inside the CD image sat a Mac program called `click_me`. Reverse-engineering it
(translating its machine code back into human-readable logic) revealed the actual
game:

- It asks for **six separate strings**, one at a time.
- For each string it computes a **hash** — think of a hash as a "fingerprint" of a
  piece of text. Two different texts almost never share a fingerprint.
- It compares each fingerprint against six stored fingerprints.

This is the classic "guess the password, but I only show you its fingerprint" trick:
you can't reverse a fingerprint back into text, so you must *derive* each answer from
the clues hidden in the document layers, then check it by fingerprint.

The six fingerprints (MD5 hashes) became our fixed targets:

```
555cca...   c790cb...   cf0cbd...
d400db...   9fc1de...   d82180...
```

---

## Step 3: Clue 1 — the invisible mainframe text

Opening the PDF, the visible page just says:

> *"Strings ? Where we're going, we don't need strings..."*

(That's a *Back to the Future* quote — and a taunt: the real clues are literally not
"strings" you can search for.)

But the PDF's internal drawing instructions contained text marked **invisible**
(render mode 3 — drawn, but not shown, not selectable). Extracting it produced
garbage like `×ÎÉÎÆËÁîÅÃÓÄÉÖ...]IÐËÁ...`. That's **EBCDIC**, the character encoding
IBM mainframes used in the 1960s–80s — a completely different mapping of numbers to
letters than the one every modern computer uses. Re-mapping it to modern encoding
gave:

> **`mainframe_ebcdic_ghost`**

Fingerprint match confirmed. Clue 1 done. (The name itself describes what it was: a
ghost of a mainframe haunting a modern document.)

---

## Step 4: Clue 2 — the picture drawn in an ancient fax format

PDFs can embed images in dozens of formats. One embedded image here used **JBIG2** —
an obscure bitmap format designed for fax machines, notorious in security circles
because of a 2017 incident where researchers showed you could manipulate a JBIG2
image so that a PDF's *font definitions got overwritten* and any text on the page
could be rewritten — the famous "TR21" technique. (That's why the challenge's checker
prompt says *"font is just a glyph"* — a direct nod.)

Decoding the JBIG2 image and rendering it produced a grainy picture of letters. At
first glance it read like `ibiq2_fax_qeometry` — JBIG2 stores *glyph shapes* and
reuses them, so similar-looking letters get the same shape, which mangles low-res
renderings. Correcting the shape-confused letters (i→j, b→b, q→g) gives:

> **`jbig2_fax_geometry`**

Fingerprint match confirmed. Clue 2 done. The decoded image is saved as
`hidden_image.png` in this folder.

---

## Step 5: Clue 3 — the fine print on the CD-ROM

The CD-ROM image inside the PDF uses **UDF**, the format optical discs are written
with. When Apple's disc-burning software creates such a disc, it stamps metadata
into the disc's "volume info" record: the volume name, the implementation ID (which
software burned it), the framework version, and so on.

Most of that metadata was normal Apple boilerplate. But the *implementation
identifier* field had been set to a custom string:

> **`udf_tagged_descriptor`**

Fingerprint match confirmed. Clue 3 done. The joke: it's the least interesting field
on the disc, describing UDF's own descriptors, hiding in plain sight — you'd only
find it if you actually parsed the disc metadata instead of just extracting files.

(Also on the disc: `click_me`, the Mac program, and `README.TXT` saying *"benign
corpus payload"*. Those are decoration and misdirection.)

---

## Step 6: Clue 4 — the ZIP that lied about its compression

At the end of the file sits a small encrypted ZIP containing `flag.txt` (18 bytes).
First hurdle: the password. After trying the obvious (the 7-zip hint `flare` doesn't
work here), the password turned out to be **`infected`** — the ancient running joke
of malware research, where a file named `passwords.txt` or an archive is
password-protected with the word "infected" so that sandboxes and lazy analysts trip
over it.

Second hurdle: `flag.txt` decrypts to... a decoy. The real clue was in the ZIP's
header metadata:

- The file claims to be 18 bytes but the archive holds **210 bytes** of compressed
  data — 12 of which are the ZipCrypto "check header" (planted as
  `11 22 33 44 55 66 77 88 99 aa bb` + one real byte, a deliberate red herring for
  anyone doing known-plaintext attacks).
- More tellingly, the compression **method field says 2**, which in ZIP means
  "reduce" — a compression algorithm from 1989 that predates and lost to "deflate"
  (method 8, which everything uses today). Nothing has used "reduce" in 30 years.

That anachronism is the message:

> **`reduce_not_deflate`**

Fingerprint match confirmed. Clue 4 done. Again, the clue was never in the file's
*content* — it was in the file's *behavior*.

---

## Step 7: Clue 5 — the animation worth 1.8 MB

The Mac program `click_me` is what actually eats the file's size. Dissected, it's a
**particle animation** built with the Apple "Flare" particle engine (the challenge's
in-joke): thousands of dots fly around the screen and at each animation step the
program draws glyphs from a text it holds in memory.

That text, recovered from the program's logic, is:

> **`Ød1n_373rn4l_fl4r3`**

which reads as leetspeak for *"Odin's eternal flare"* — matching the Norse/mythic
vibe of the spinning particle art. (This is also where the checker's other taunt
lives: *"no ptrace attached"* — it warns debuggers away, which is how you know the
animation logic is worth watching.)

Fingerprint match confirmed. Clue 5 done. A 1.8 MB fireworks show to encode 19
characters.

---

## Step 8: Clue 6 — the string that never existed in the file

This was the one that nearly didn't fall.

After five matches, one fingerprint (`d82180...`) refused every candidate we could
find — every string in the file, every file name, every metadata field, every joke,
brute-forced against wordlists of plausible phrases. Nothing.

The answer required actually *reading* the very first 132 bytes of the file. Those
bytes are a **DOS COM program** — 1980s executable code — that pretends to be the
**EICAR test string**. EICAR is a real-world thing: an industry-standard fake "virus"
(a printable sentence, not real code) that antivirus vendors agree to detect so
people can test their scanners. Here it is, byte for byte:

```
X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*
```

But the file's version is *not* quite that sentence — and it's not just text, it's
genuine 16-bit x86 code. Disassembling it showed the trick: the code **XORs four
bytes in place** (turning the word EICAR into FLARE), then rewrites its own tail into
`print string` + `exit` DOS calls (`int 21h` / `int 20h`).

In other words, if you actually ran this stub (DOSBox, or any emulator), it would
print:

> **`FLARE-STANDARD-ANTIVIRUS-TEST-FILE!`**

That string **exists nowhere in the file** — it is manufactured at runtime by the
self-modification. Every text search in the world would fail, because the file only
contains the EICAR version; the FLARE version exists for a moment in memory. That's
the whole punchline of the challenge's first taunt: *"we don't need strings."*

Fingerprint match confirmed. Clue 6 done. All six fingerprints accounted for:

| # | Clue | Where it hid |
|---|------|--------------|
| 1 | `mainframe_ebcdic_ghost` | Invisible EBCDIC text in the PDF |
| 2 | `jbig2_fax_geometry` | JBIG2 fax image in the PDF |
| 3 | `udf_tagged_descriptor` | CD-ROM UDF metadata |
| 4 | `reduce_not_deflate` | ZIP compression method (a 1989 algorithm in 2025) |
| 5 | `Ød1n_373rn4l_fl4r3` | Text animated by the Mac particle program |
| 6 | `FLARE-STANDARD-ANTIVIRUS-TEST-FILE!` | Printed by the self-modifying DOS stub |

---

## Step 9: Turning six clues into one flag

The checker in the Mac program combines the answers like this:

1. Take each clue's **SHA-256 fingerprint** (a stronger fingerprint than MD5, used
   here for key material).
2. **XOR all six fingerprints together**, byte by byte. XOR is the "exclusive or"
   operation — combining six values with XOR produces a single 32-byte value that is
   only correct if every single input is correct. One wrong letter anywhere and the
   whole key turns to garbage. (This is also why partial progress felt useless
   during the solve: five of six right is exactly as informative as zero of six.)
3. Use that 32-byte mixture as an **RC4 key**. RC4 is an old-but-simple cipher that
   turns a key into a stream of random-looking bytes, which are XORed with the
   ciphertext to recover the plaintext.
4. Decrypt the 40-byte ciphertext that was embedded in the checker the whole time:

```
64 51 28 01 37 69 75 0e 50 45 1f 91 75 58 f4 93
e3 ae ed 5a 51 d0 cb fa e9 8e ed 18 5e 1b 00 b0
42 a8 f8 13 a9 d5 55 1c
```

With all six clues correct, the XOR of their SHA-256 fingerprints produced:

```
5517bf5185094a81c64837a1387c8c2d 755a2b26cbe342b34752ef62da43f473
```

and RC4 decryption spat out, in one clean shot:

```
Ju$7_4_l177l3_7r34$ur3_HUN7@flare-on.com
```

Leetspeak for *"Just a little treasure hunt"* — which is precisely what the file was.

---

## The moral

The challenge never hid the flag in any *content* you could search for. Every clue
lived in structure, behavior, or history:

- an encoding from dead mainframes,
- a fax format with a glyph-substitution quirk,
- metadata fields nobody reads,
- a compression algorithm from 1989,
- a firework show that exists only in motion,
- and a sentence that is manufactured, never stored.

Six layers, six wrong ways to look at a file — and one right way each.

---

## What's in this folder

| File | What it is |
|------|------------|
| `WRITEUP.md` | This writeup |
| `final_flag.py` | The end-to-end solve: verifies all six clue fingerprints and decrypts the flag (pure Python, no dependencies — just run `python final_flag.py`) |
| `macho_notes.txt` | Notes from reverse-engineering the `click_me` checker (hashes, XOR/RC4 logic, prompts) |
| `macho_inspect.py` | Static Mach-O inspection tool used to analyze `click_me` |
| `zipcrack.py` | ZIP password + reduce-compression cracking work |
| `scan_sigs.py` | Locates every embedded file-format layer in `flareon13.doc` |
| `dump_zip_vhd.py` | Dumps the ZIP entry metadata and the VHD footer (contains `FLAREONPOLYGLOT!`) |
| `disc.iso` | The CD-ROM image extracted from inside the PDF |
| `disc/click_me` | The Mac checker/animation program from the disc |
| `disc/README.TXT` | The challenge's README |
| `hidden_image.png` | The decoded JBIG2 clue image |
| `page.png` | Render of the PDF page |
