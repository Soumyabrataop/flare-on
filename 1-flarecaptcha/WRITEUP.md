# FLARE-On 13 — Challenge 1: FlareCaptcha

## Getting started

The first challenge came as a password-protected archive. After extracting it with the password `flare`, I found a single file: `flarecaptcha.html`.

The page presents a familiar-looking “I’m not a robot” checkbox. However, it is not a real CAPTCHA service. Everything needed to solve the challenge is inside the HTML file, including the JavaScript responsible for displaying the flag.

## Looking behind the checkbox

Instead of trying to convince the checkbox that I was human, I inspected the page’s source code.

The mouse-handling code revealed a trick: a normal left-click triggers failure. The successful action is to **hold the right mouse button over the checkbox for approximately two seconds**, without releasing it or moving away.

That explains how the page is intended to work, but the flag is not written plainly in the source. It is stored as this array of numbers:

```text
123, 5, 102, 4, 100, 22, 102, 19, ...
```

These numbers represent scrambled character codes. A character code is simply the number assigned to a letter or symbol. For example, the number `116` represents the lowercase letter `t`.

## Unscrambling the numbers

The JavaScript applies two layers of XOR to the array. XOR is a reversible operation: applying the same XOR value twice restores the original number.

The first layer uses the number **5**. This comes from the length of the text `UTF-8`, which is the page’s character encoding.

The second layer alternates between two values: one for positions 0, 2, 4, and so on, and another for positions 1, 3, 5, and so on. The page calculates these values using the mouse-hold duration and the length of a JavaScript function.

Rather than reproduce that calculation, I used a clue provided by the challenge:

> Every FLARE-On flag ends with `@flare-on.com`.

Because I already knew the last 13 characters, I could compare those characters with the last 13 scrambled numbers and work backwards to recover the two missing XOR values.

The values were:

- **10** for even-numbered positions.
- **114** for odd-numbered positions.

For example, the first array entry becomes:

```text
123 XOR 5 XOR 10 = 116
```

And character code `116` is `t`.

The next two entries become:

```text
5 XOR 5 XOR 114 = 114  → r
102 XOR 5 XOR 10 = 105 → i
```

Repeating the process for the whole array produced the complete flag. This recovery was performed directly from the source; it did not require running the page in a browser.

## Flag

```text
triskaidekaphobia@flare-on.com
```

## Takeaway

The important lesson was to inspect the code rather than trust the interface. The checkbox was a distraction; the page already contained everything required to recover the flag.
