# FLARE-On 13 — Challenge 2: GhostStream

## Getting started

The challenge archive uses the password `flare`. The extracted challenge contained `GhostStream.wim`, a Windows image file. Extracting that image revealed two files:

- `GhostStream.exe`
- `PolyjuicePotion.txt`

The description suggested that the executable was hiding something and that the text file was important. That turned out to be true, although the connection was not immediately obvious.

## A text file with something hidden

The visible contents of `PolyjuicePotion.txt` describe a failed Polyjuice Potion and mention that its effects last for seven days.

During extraction, however, the tool reported that the text file contained a **named data stream**.

On Windows, a file can have extra data attached to it that does not appear when you open the file normally. This is called an alternate data stream. Think of it as a hidden compartment attached to an otherwise ordinary file.

In this case, the hidden compartment was named:

```text
LordVoldemort
```

Its contents were:

```text
AlbusDumbledore
```

There was also a trailing space and a Windows line ending. The complete contents were 18 bytes long.

This was an important discovery, but it was **not the flag**, and using it directly as a decryption key did not solve the challenge. It also highlighted an extraction pitfall: ordinary extraction or copying can discard alternate data streams, leaving only the visible text.

## Another program inside the executable

Next, I inspected `GhostStream.exe`.

The executable contained another Windows program inside its resources. The main program extracts this embedded program to disk and launches it. In other words, the challenge is split between two executables rather than being contained in just one.

The embedded program communicates with the main program through a **named pipe**. A named pipe is simply a way for two local programs to exchange data.

The embedded program also contained:

- An encrypted block of 38 bytes.
- A flag-printing success message.
- A decryption routine resembling RC4, but with modifications.
- Code that temporarily changes the behaviour of a string function.

Those extra modifications were why a straightforward decoding attempt did not work.

## Correcting the decryption

My initial reconstruction of the routine was wrong. I tried several candidate keys, including the names found in the hidden stream, but the results were unreadable. Those attempts were dead ends, not successful solutions.

An independent recheck shown in the agent output eventually found a combination that decoded the entire flag:

| Part of the decoding | Successful value |
| --- | --- |
| Cipher key | `HarryPotter` |
| Cipher index step | `18` |
| Repeating XOR phrase | `Piertotum Locomotor` |
| Amount added to each encrypted byte | `18` |

The process can be understood as three pieces working together:

1. **Use `HarryPotter` to generate a stream of decoding values.** The modified cipher advances its index by 18 for each output byte.
2. **Add 18 to each encrypted byte**, wrapping around if the result exceeds the size of a byte.
3. **Combine that byte with the decoding stream and the repeating spell phrase using XOR.** The phrase repeats as needed until all 38 bytes have been processed.

XOR is a reversible operation commonly used to scramble and unscramble bytes. Here, the cipher’s output and the spell phrase both contribute to recovering each character.

For reference, the successful calculation for each byte was:

```python
decoded_byte = (
    keystream[n]
    ^ spell[n % len(spell)]
    ^ ((encrypted[n] + 18) & 255)
)
```

The `& 255` keeps the addition within one byte. Each resulting number is then interpreted as a character.

After processing all 38 bytes, the result was a readable email-address-formatted flag ending in `@flare-on.com`.

## Flag

```text
y0u_kn0w_n07h1n6_j0n_5n0w@flare-on.com
```

## Evidence and limitations

The successful agent-output screenshot directly showed the key `HarryPotter`, the step and addition values of 18, the phrase `Piertotum Locomotor`, and the resulting flag.

The available screenshot does not show every intermediate step used to discover those parameters. This write-up therefore describes the observed successful decoding, rather than claiming a complete debugger walkthrough or a fully documented derivation of the key and spell phrase. The earlier local execution attempts did not display the correct flag.

## Takeaway

Finding hidden data is only the beginning. The alternate data stream, embedded executable, and modified decryption routine were all parts of the investigation. The decisive step was correcting the decoding logic rather than continuing to guess keys.
