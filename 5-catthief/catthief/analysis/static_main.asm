00000001400029aa push     rbp
00000001400029ab push     r15
00000001400029ad push     r14
00000001400029af push     r13
00000001400029b1 push     r12
00000001400029b3 push     rsi
00000001400029b4 push     rdi
00000001400029b5 push     rbx
00000001400029b6 sub      rsp, 0xcc8
00000001400029bd lea      rbp, [rsp + 0x80]
00000001400029c5 movdqa   xmmword ptr [rbp + 0xc30], xmm11
00000001400029ce movdqa   xmmword ptr [rbp + 0xc20], xmm10
00000001400029d7 movaps   xmmword ptr [rbp + 0xc10], xmm9
00000001400029df movaps   xmmword ptr [rbp + 0xc00], xmm8
00000001400029e7 movaps   xmmword ptr [rbp + 0xbf0], xmm7
00000001400029ee movaps   xmmword ptr [rbp + 0xbe0], xmm6
00000001400029f5 mov      qword ptr [rbp + 0xbd8], -2
0000000140002a00 lea      rdx, [rip + 0xc6729]
0000000140002a07 lea      rcx, [rbp + 0xb20]
0000000140002a0e call     0x140005493
0000000140002a13 mov      eax, 0x10a
0000000140002a18 lea      r12, [rbp + 0x1e0]
0000000140002a1f lea      rcx, [r12 + rax]
0000000140002a23 mov      qword ptr [rbp + 0xac8], rcx
0000000140002a2a lea      rcx, [rbp + 0x750]
0000000140002a31 add      rax, rcx
0000000140002a34 mov      qword ptr [rbp + 0xb10], rax
0000000140002a3b movups   xmm6, xmmword ptr [rip + 0xf551e]
0000000140002a42 movups   xmm7, xmmword ptr [rip + 0xf5527]
0000000140002a49 movaps   xmm8, xmmword ptr [rip + 0xc65bf]
0000000140002a51 xorps    xmm9, xmm9
0000000140002a55 pcmpeqd  xmm10, xmm10
0000000140002a5a mov      qword ptr [rbp + 0xb08], 0
0000000140002a65 mov      rsi, qword ptr [rbp + 0xb28]
0000000140002a6c mov      r14, qword ptr [rbp + 0xb30]
0000000140002a73 test     r14, r14
0000000140002a76 je       0x1400036d9
0000000140002a7c lea      rcx, [rip - 0x16b4]
0000000140002a83 call     0x14006317e
0000000140002a88 movaps   xmmword ptr [rbp + 0x1e0], xmm6
0000000140002a8f movaps   xmmword ptr [rbp + 0x1f0], xmm7
0000000140002a96 mov      qword ptr [rbp + 0x200], rax
0000000140002a9d mov      qword ptr [rbp + 0x208], rdx
0000000140002aa4 add      r14, rsi
0000000140002aa7 cmp      rsi, r14
0000000140002aaa je       0x140002bed
0000000140002ab0 mov      dil, byte ptr [rsi]
0000000140002ab3 inc      rsi
0000000140002ab6 mov      rcx, qword ptr [rbp + 0x200]
0000000140002abd mov      rdx, qword ptr [rbp + 0x208]
0000000140002ac4 mov      r8d, edi
0000000140002ac7 call     0x1400016b6
0000000140002acc mov      rbx, rax
0000000140002acf mov      r12, rax
0000000140002ad2 shr      r12, 0x39
0000000140002ad6 mov      r15, qword ptr [rbp + 0x1e0]
0000000140002add mov      r13, qword ptr [rbp + 0x1e8]
0000000140002ae4 movd     xmm0, r12d
0000000140002ae9 punpcklbw xmm0, xmm0
0000000140002aed pshuflw  xmm0, xmm0, 0
0000000140002af2 pshufd   xmm0, xmm0, 0x44
0000000140002af7 xor      eax, eax
0000000140002af9 mov      rcx, rbx
0000000140002afc and      rcx, r13
0000000140002aff movdqu   xmm1, xmmword ptr [r15 + rcx]
0000000140002b05 movdqa   xmm2, xmm1
0000000140002b09 pcmpeqb  xmm2, xmm0
0000000140002b0d pmovmskb edx, xmm2
0000000140002b11 test     dx, dx
0000000140002b14 je       0x140002b40
0000000140002b16 bsf      r9d, edx
0000000140002b1a add      r9, rcx
0000000140002b1d and      r9, r13
0000000140002b20 shl      r9, 4
0000000140002b24 mov      r8, r15
0000000140002b27 sub      r8, r9
0000000140002b2a cmp      byte ptr [r8 - 0x10], dil
0000000140002b2e je       0x140002bb7
0000000140002b34 lea      r8d, [rdx - 1]
0000000140002b38 and      r8d, edx
0000000140002b3b mov      edx, r8d
0000000140002b3e jmp      0x140002b11
0000000140002b40 pcmpeqb  xmm1, xmm10
0000000140002b45 pmovmskb edx, xmm1
0000000140002b49 test     edx, edx
0000000140002b4b jne      0x140002b5a
0000000140002b4d add      rcx, rax
0000000140002b50 add      rcx, 0x10
0000000140002b54 add      rax, 0x10
0000000140002b58 jmp      0x140002afc
0000000140002b5a mov      rax, qword ptr [rbp + 0x1f0]
0000000140002b61 test     rax, rax
0000000140002b64 je       0x140002bc0
0000000140002b66 mov      rcx, r15
0000000140002b69 mov      rdx, r13
0000000140002b6c mov      r8, rbx
0000000140002b6f mov      rbx, rax
0000000140002b72 call     0x1400012ba
0000000140002b77 movzx    ecx, byte ptr [r15 + rax]
0000000140002b7c lea      rdx, [rax - 0x10]
0000000140002b80 and      rdx, r13
0000000140002b83 mov      byte ptr [r15 + rax], r12b
0000000140002b87 mov      byte ptr [r15 + rdx + 0x10], r12b
0000000140002b8c shl      rax, 4
0000000140002b90 mov      r8, r15
0000000140002b93 sub      r8, rax
0000000140002b96 and      ecx, 1
0000000140002b99 sub      rbx, rcx
0000000140002b9c mov      qword ptr [rbp + 0x1f0], rbx
0000000140002ba3 neg      rax
0000000140002ba6 mov      byte ptr [r15 + rax - 0x10], dil
0000000140002bab and      qword ptr [r8 - 8], 0
0000000140002bb0 inc      qword ptr [rbp + 0x1f8]
0000000140002bb7 inc      qword ptr [r8 - 8]
0000000140002bbb jmp      0x140002aa7
0000000140002bc0 lea      rcx, [rbp + 0x1e0]
0000000140002bc7 lea      rdx, [rbp + 0x200]
0000000140002bce call     0x1400c34c0
0000000140002bd3 mov      r15, qword ptr [rbp + 0x1e0]
0000000140002bda mov      r13, qword ptr [rbp + 0x1e8]
0000000140002be1 mov      rax, qword ptr [rbp + 0x1f0]
0000000140002be8 jmp      0x140002b66
0000000140002bed and      qword ptr [rbp + 0x5e0], 0
0000000140002bf5 mov      qword ptr [rbp + 0x5e8], 8
0000000140002c00 and      qword ptr [rbp + 0x5f0], 0
0000000140002c08 mov      r15, qword ptr [rbp + 0x1e0]
0000000140002c0f mov      r9, qword ptr [rbp + 0x1e8]
0000000140002c16 mov      r12, qword ptr [rbp + 0x1f8]
0000000140002c1d movdqa   xmm11, xmmword ptr [r15]
0000000140002c22 test     r9, r9
0000000140002c25 je       0x140002c64
0000000140002c27 inc      r9
0000000140002c2a lea      rcx, [rbp + 0x750]
0000000140002c31 push     0x10
0000000140002c33 pop      rdx
0000000140002c34 mov      r8, rdx
0000000140002c37 call     0x140001000
0000000140002c3c mov      rdi, qword ptr [rbp + 0x750]
0000000140002c43 mov      rax, qword ptr [rbp + 0x758]
0000000140002c4a mov      qword ptr [rbp + 0xbd0], rax
0000000140002c51 mov      rax, r15
0000000140002c54 sub      rax, qword ptr [rbp + 0x760]
0000000140002c5b mov      qword ptr [rbp + 0xba8], rax
0000000140002c62 jmp      0x140002c66
0000000140002c64 xor      edi, edi
0000000140002c66 lea      r13, [r15 + 0x10]
0000000140002c6a pmovmskb eax, xmm11
0000000140002c6f not      eax
0000000140002c71 sub      r12, 1
0000000140002c75 jae      0x140002c90
0000000140002c77 jmp      0x140002ccf
0000000140002c79 movdqa   xmm0, xmmword ptr [r13]
0000000140002c7f add      r15, -0x100
0000000140002c86 add      r13, 0x10
0000000140002c8a pmovmskb eax, xmm0
0000000140002c8e not      eax
0000000140002c90 test     ax, ax
0000000140002c93 je       0x140002c79
0000000140002c95 lea      esi, [rax - 1]
0000000140002c98 bsf      ecx, eax
0000000140002c9b and      esi, eax
0000000140002c9d shl      ecx, 4
0000000140002ca0 mov      rax, r15
0000000140002ca3 sub      rax, rcx
0000000140002ca6 mov      bl, byte ptr [rax - 0x10]
0000000140002ca9 mov      r14, qword ptr [rax - 8]
0000000140002cad call     0x1400012fe
0000000140002cb2 and      qword ptr [rax], 0
0000000140002cb6 mov      byte ptr [rax + 8], bl
0000000140002cb9 lea      rcx, [rbp + 0x5e0]
0000000140002cc0 mov      rdx, rax
0000000140002cc3 mov      r8, r14
0000000140002cc6 call     0x14000284b
0000000140002ccb mov      eax, esi
0000000140002ccd jmp      0x140002c71
0000000140002ccf test     rdi, rdi
0000000140002cd2 je       0x140002cea
0000000140002cd4 mov      rcx, qword ptr [rbp + 0xba8]
0000000140002cdb mov      rdx, rdi
0000000140002cde mov      r8, qword ptr [rbp + 0xbd0]
0000000140002ce5 call     0x1400013ae
0000000140002cea lea      r12, [rbp + 0x1e0]
0000000140002cf1 lea      r15, [rbp + 0x5e0]
0000000140002cf8 mov      rbx, qword ptr [rbp + 0x5f0]
0000000140002cff mov      rcx, r15
0000000140002d02 call     0x14000275a
0000000140002d07 mov      rsi, rax
0000000140002d0a cmp      rbx, 1
0000000140002d0e jbe      0x140002d52
0000000140002d10 test     rsi, rsi
0000000140002d13 je       0x140004f17
0000000140002d19 mov      rdi, rdx
0000000140002d1c mov      rcx, r15
0000000140002d1f call     0x14000275a
0000000140002d24 test     rax, rax
0000000140002d27 je       0x140004f20
0000000140002d2d mov      r14, rax
0000000140002d30 mov      rbx, rdx
0000000140002d33 add      rbx, rdi
0000000140002d36 call     0x1400012fe
0000000140002d3b mov      qword ptr [rax], rsi
0000000140002d3e mov      qword ptr [rax + 8], r14
0000000140002d42 mov      rcx, r15
0000000140002d45 mov      rdx, rax
0000000140002d48 mov      r8, rbx
0000000140002d4b call     0x14000284b
0000000140002d50 jmp      0x140002cf8
0000000140002d52 test     rsi, rsi
0000000140002d55 je       0x140002d6b
0000000140002d57 movdqu   xmm0, xmmword ptr [rsi]
0000000140002d5b movdqa   xmmword ptr [rbp + 0x8b0], xmm0
0000000140002d63 mov      rcx, rsi
0000000140002d66 call     0x140046c7b
0000000140002d6b mov      rdi, qword ptr [rbp + 0x5e8]
0000000140002d72 mov      r14, qword ptr [rbp + 0x5f0]
0000000140002d79 mov      rbx, rdi
0000000140002d7c sub      r14, 1
0000000140002d80 jb       0x140002d90
0000000140002d82 mov      rcx, rbx
0000000140002d85 call     0x140001552
0000000140002d8a add      rbx, 0x10
0000000140002d8e jmp      0x140002d7c
0000000140002d90 mov      rcx, qword ptr [rbp + 0x5e0]
0000000140002d97 mov      rdx, rdi
0000000140002d9a push     8
0000000140002d9c pop      r8
0000000140002d9e push     0x10
0000000140002da0 pop      r9
0000000140002da2 call     0x14000ea6d
0000000140002da7 test     rsi, rsi
0000000140002daa je       0x1400036d2
0000000140002db0 movdqa   xmm0, xmmword ptr [rbp + 0x8b0]
0000000140002db8 movdqa   xmmword ptr [rbp + 0x8a0], xmm0
0000000140002dc0 mov      edx, 0x100
0000000140002dc5 mov      rcx, r12
0000000140002dc8 call     0x140014719
0000000140002dcd xor      esi, esi
0000000140002dcf lea      rcx, [rbp + 0x8b0]
0000000140002dd6 xor      edx, edx
0000000140002dd8 mov      r8, r12
0000000140002ddb call     0x1400053ab
0000000140002de0 mov      rax, qword ptr [rbp + 0x1e0]
0000000140002de7 mov      qword ptr [rbp + 0xab0], rax
0000000140002dee mov      rbx, qword ptr [rbp + 0x1e8]
0000000140002df5 mov      rax, qword ptr [rbp + 0x1f0]
0000000140002dfc and      qword ptr [rbp + 0xd8], 0
0000000140002e04 mov      qword ptr [rbp + 0xe0], 1
0000000140002e0f and      qword ptr [rbp + 0xe8], 0
0000000140002e17 mov      qword ptr [rbp + 0xb18], rax
0000000140002e1e lea      rdi, [rbx + rax]
0000000140002e22 push     -2
0000000140002e24 pop      r14
0000000140002e26 push     1
0000000140002e28 pop      rax
0000000140002e29 mov      qword ptr [rbp + 0xb00], rbx
0000000140002e30 xor      r15d, r15d
0000000140002e33 cmp      rbx, rdi
0000000140002e36 je       0x140002e80
0000000140002e38 mov      r12d, r15d
0000000140002e3b lea      r15d, [r12 + 1]
0000000140002e40 mov      r13b, byte ptr [rbx]
0000000140002e43 inc      rbx
0000000140002e46 test     r13b, r13b
0000000140002e49 je       0x140002e33
0000000140002e4b cmp      rsi, qword ptr [rbp + 0xd8]
0000000140002e52 jne      0x140002e67
0000000140002e54 lea      rcx, [rbp + 0xd8]
0000000140002e5b call     0x14000292a
0000000140002e60 mov      rax, qword ptr [rbp + 0xe0]
0000000140002e67 mov      byte ptr [rax + rsi*2], r12b
0000000140002e6b mov      byte ptr [rax + rsi*2 + 1], r13b
0000000140002e70 inc      rsi
0000000140002e73 mov      qword ptr [rbp + 0xe8], rsi
0000000140002e7a add      r14, 2
0000000140002e7e jmp      0x140002e33
0000000140002e80 mov      rdi, qword ptr [rbp + 0xe0]
0000000140002e87 cmp      rsi, 2
0000000140002e8b lea      r12, [rbp + 0x1e0]
0000000140002e92 jae      0x1400046b6
0000000140002e98 lea      rcx, [rip - 0x1ad0]
0000000140002e9f call     0x14006317e
0000000140002ea4 movaps   xmmword ptr [rbp + 0x1e0], xmm6
0000000140002eab movaps   xmmword ptr [rbp + 0x1f0], xmm7
0000000140002eb2 mov      qword ptr [rbp + 0x200], rax
0000000140002eb9 and      dword ptr [rbp + 0x8c0], 0
0000000140002ec0 mov      qword ptr [rbp + 0x208], rdx
0000000140002ec7 lea      rbx, [rdi + rsi*2]
0000000140002ecb xor      eax, eax
0000000140002ecd xor      r14d, r14d
0000000140002ed0 cmp      rdi, rbx
0000000140002ed3 je       0x14000312d
0000000140002ed9 mov      sil, byte ptr [rdi]
0000000140002edc mov      r13b, byte ptr [rdi + 1]
0000000140002ee0 test     al, al
0000000140002ee2 je       0x140002ef6
0000000140002ee4 inc      r14d
0000000140002ee7 mov      ecx, r13d
0000000140002eea sub      cl, al
0000000140002eec shl      r14d, cl
0000000140002eef mov      dword ptr [rbp + 0x8c0], r14d
0000000140002ef6 movzx    eax, r13b
0000000140002efa lea      rcx, [rbp + 0x8c0]
0000000140002f01 mov      qword ptr [rbp + 0x750], rcx
0000000140002f08 lea      rcx, [rip + 0x9ae1]
0000000140002f0f mov      qword ptr [rbp + 0x758], rcx
0000000140002f16 and      qword ptr [rbp + 0x760], 0
0000000140002f1e mov      word ptr [rbp + 0x768], ax
0000000140002f25 lea      rcx, [rbp + 0x5e0]
0000000140002f2c lea      rdx, [rip + 0xc6285]
0000000140002f33 lea      r8, [rbp + 0x750]
0000000140002f3a call     0x140005fa0
0000000140002f3f mov      rcx, qword ptr [rbp + 0x200]
0000000140002f46 mov      rdx, qword ptr [rbp + 0x208]
0000000140002f4d mov      r8d, esi
0000000140002f50 call     0x1400016b6
0000000140002f55 mov      r15, rax
0000000140002f58 cmp      qword ptr [rbp + 0x1f0], 0
0000000140002f60 je       0x140003104
0000000140002f66 add      rdi, 2
0000000140002f6a mov      rax, qword ptr [rbp + 0x1e0]
0000000140002f71 mov      rcx, qword ptr [rbp + 0x1e8]
0000000140002f78 mov      r8, rcx
0000000140002f7b and      r8, r15
0000000140002f7e shr      r15, 0x39
0000000140002f82 movd     xmm0, r15d
0000000140002f87 punpcklbw xmm0, xmm0
0000000140002f8b pshuflw  xmm0, xmm0, 0
0000000140002f90 pshufd   xmm0, xmm0, 0x44
0000000140002f95 xor      r10d, r10d
0000000140002f98 xor      r9d, r9d
0000000140002f9b movdqu   xmm1, xmmword ptr [rax + r8]
0000000140002fa1 movdqa   xmm2, xmm0
0000000140002fa5 pcmpeqb  xmm2, xmm1
0000000140002fa9 pmovmskb r11d, xmm2
0000000140002fae test     r11w, r11w
0000000140002fb2 je       0x140002fe2
0000000140002fb4 bsf      edx, r11d
0000000140002fb8 add      rdx, r8
0000000140002fbb and      rdx, rcx
0000000140002fbe shl      rdx, 5
0000000140002fc2 mov      r12, rax
0000000140002fc5 sub      r12, rdx
0000000140002fc8 cmp      sil, byte ptr [r12 - 0x20]
0000000140002fcd je       0x140003031
0000000140002fcf lea      edx, [r11 - 1]
0000000140002fd3 and      edx, r11d
0000000140002fd6 mov      r11d, edx
0000000140002fd9 lea      r12, [rbp + 0x1e0]
0000000140002fe0 jmp      0x140002fae
0000000140002fe2 cmp      r10, 1
0000000140002fe6 mov      r10, qword ptr [rbp + 0xbd0]
0000000140002fed je       0x140003001
0000000140002fef pmovmskb edx, xmm1
0000000140002ff3 test     edx, edx
0000000140002ff5 je       0x14000301b
0000000140002ff7 bsf      r10d, edx
0000000140002ffb add      r10, r8
0000000140002ffe and      r10, rcx
0000000140003001 pcmpeqb  xmm1, xmm10
0000000140003006 pmovmskb edx, xmm1
000000014000300a test     edx, edx
000000014000300c jne      0x140003071
000000014000300e mov      qword ptr [rbp + 0xbd0], r10
0000000140003015 push     1
0000000140003017 pop      r10
0000000140003019 jmp      0x14000301e
000000014000301b xor      r10d, r10d
000000014000301e add      r8, r9
0000000140003021 add      r8, 0x10
0000000140003025 add      r9, 0x10
0000000140003029 and      r8, rcx
000000014000302c jmp      0x140002f9b
0000000140003031 mov      rcx, qword ptr [r12 - 0x18]
0000000140003036 mov      rdx, qword ptr [r12 - 0x10]
000000014000303b mov      rax, qword ptr [rbp + 0x5f0]
0000000140003042 mov      qword ptr [r12 - 8], rax
0000000140003047 movdqu   xmm0, xmmword ptr [rbp + 0x5e0]
000000014000304f movdqu   xmmword ptr [r12 - 0x18], xmm0
0000000140003056 lea      r12, [rbp + 0x1e0]
000000014000305d mov      qword ptr [rbp + 0xa20], rdx
0000000140003064 call     0x14000156f
0000000140003069 mov      eax, r13d
000000014000306c jmp      0x140002ed0
0000000140003071 mov      r8b, byte ptr [rax + r10]
0000000140003075 test     r8b, r8b
0000000140003078 jns      0x140003118
000000014000307e mov      rdx, qword ptr [rbp + 0x5f0]
0000000140003085 lea      r9, [rbp + 0x757]
000000014000308c mov      qword ptr [r9 + 0x10], rdx
0000000140003090 movups   xmm0, xmmword ptr [rbp + 0x5e0]
0000000140003097 and      r8b, 1
000000014000309b movzx    edx, r8b
000000014000309f sub      qword ptr [rbp + 0x1f0], rdx
00000001400030a6 movups   xmmword ptr [r9], xmm0
00000001400030aa lea      rdx, [r10 - 0x10]
00000001400030ae and      rdx, rcx
00000001400030b1 mov      byte ptr [rax + r10], r15b
00000001400030b5 mov      byte ptr [rax + rdx + 0x10], r15b
00000001400030ba inc      qword ptr [rbp + 0x1f8]
00000001400030c1 shl      r10, 5
00000001400030c5 mov      rcx, rax
00000001400030c8 sub      rcx, r10
00000001400030cb mov      byte ptr [rcx - 0x20], sil
00000001400030cf neg      r10
00000001400030d2 movdqu   xmm0, xmmword ptr [rbp + 0x750]
00000001400030da movdqu   xmm1, xmmword ptr [rbp + 0x75f]
00000001400030e2 movdqu   xmmword ptr [rax + r10 - 0x1f], xmm0
00000001400030e9 movdqu   xmmword ptr [rcx - 0x10], xmm1
00000001400030ee movabs   rcx, 0x8000000000000000
00000001400030f8 mov      rdx, qword ptr [rbp + 0xa20]
00000001400030ff jmp      0x14000305d
0000000140003104 mov      rcx, r12
0000000140003107 lea      rdx, [rbp + 0x200]
000000014000310e call     0x1400c36a8
0000000140003113 jmp      0x140002f66
0000000140003118 movdqa   xmm0, xmmword ptr [rax]
000000014000311c pmovmskb edx, xmm0
0000000140003120 bsf      r10d, edx
0000000140003124 mov      r8b, byte ptr [rax + r10]
0000000140003128 jmp      0x14000307e
000000014000312d movdqa   xmm0, xmmword ptr [rbp + 0x1e0]
0000000140003135 movdqa   xmm1, xmmword ptr [rbp + 0x1f0]
000000014000313d movdqa   xmm2, xmmword ptr [rbp + 0x200]
0000000140003145 movdqa   xmmword ptr [rbp + 0x9e0], xmm2
000000014000314d movdqa   xmmword ptr [rbp + 0x9d0], xmm1
0000000140003155 movdqa   xmmword ptr [rbp + 0x9c0], xmm0
000000014000315d mov      rcx, qword ptr [rbp + 0xd8]
0000000140003164 mov      rdx, qword ptr [rbp + 0xe0]
000000014000316b call     0x140001541
0000000140003170 mov      r13, qword ptr [rbp + 0xb28]
0000000140003177 and      qword ptr [rbp + 0x750], 0
000000014000317f mov      qword ptr [rbp + 0x758], 1
000000014000318a and      qword ptr [rbp + 0x760], 0
0000000140003192 mov      r15, qword ptr [rbp + 0xb30]
0000000140003199 add      r15, r13
000000014000319c mov      rax, qword ptr [rbp + 0x9d8]
00000001400031a3 mov      qword ptr [rbp + 0xbd0], rax
00000001400031aa mov      rsi, qword ptr [rbp + 0x9c0]
00000001400031b1 mov      rdi, qword ptr [rbp + 0x9c8]
00000001400031b8 mov      rax, qword ptr [rbp + 0x9e0]
00000001400031bf mov      qword ptr [rbp + 0xba8], rax
00000001400031c6 mov      rax, qword ptr [rbp + 0x9e8]
00000001400031cd mov      qword ptr [rbp + 0xbc0], rax
00000001400031d4 xor      r12d, r12d
00000001400031d7 mov      rax, r13
00000001400031da cmp      rax, r15
00000001400031dd je       0x1400032cb
00000001400031e3 lea      r13, [rax + 1]
00000001400031e7 mov      bl, byte ptr [rax]
00000001400031e9 mov      rax, r13
00000001400031ec cmp      qword ptr [rbp + 0xbd0], 0
00000001400031f4 je       0x1400031da
00000001400031f6 mov      rcx, qword ptr [rbp + 0xba8]
00000001400031fd mov      rdx, qword ptr [rbp + 0xbc0]
0000000140003204 mov      r8d, ebx
0000000140003207 call     0x1400016b6
000000014000320c mov      rcx, rax
000000014000320f shr      rcx, 0x39
0000000140003213 movd     xmm0, ecx
0000000140003217 punpcklbw xmm0, xmm0
000000014000321b pshuflw  xmm0, xmm0, 0
0000000140003220 pshufd   xmm0, xmm0, 0x44
0000000140003225 xor      ecx, ecx
0000000140003227 and      rax, rdi
000000014000322a movdqu   xmm1, xmmword ptr [rsi + rax]
000000014000322f movdqa   xmm2, xmm1
0000000140003233 pcmpeqb  xmm2, xmm0
0000000140003237 pmovmskb edx, xmm2
000000014000323b test     dx, dx
000000014000323e je       0x140003266
0000000140003240 bsf      r9d, edx
0000000140003244 add      r9, rax
0000000140003247 and      r9, rdi
000000014000324a shl      r9, 5
000000014000324e mov      r8, rsi
0000000140003251 sub      r8, r9
0000000140003254 cmp      bl, byte ptr [r8 - 0x20]
0000000140003258 je       0x140003284
000000014000325a lea      r8d, [rdx - 1]
000000014000325e and      r8d, edx
0000000140003261 mov      edx, r8d
0000000140003264 jmp      0x14000323b
0000000140003266 pcmpeqb  xmm1, xmm10
000000014000326b pmovmskb edx, xmm1
000000014000326f test     edx, edx
0000000140003271 jne      0x1400031d7
0000000140003277 add      rax, rcx
000000014000327a add      rax, 0x10
000000014000327e add      rcx, 0x10
0000000140003282 jmp      0x140003227
0000000140003284 mov      r14, qword ptr [r8 - 0x10]
0000000140003288 mov      rbx, qword ptr [r8 - 8]
000000014000328c lea      rcx, [rbp + 0x750]
0000000140003293 mov      rdx, rbx
0000000140003296 call     0x14000f547
000000014000329b mov      r12, qword ptr [rbp + 0x760]
00000001400032a2 test     rbx, rbx
00000001400032a5 je       0x1400032bc
00000001400032a7 mov      rcx, qword ptr [rbp + 0x758]
00000001400032ae add      rcx, r12
00000001400032b1 mov      rdx, r14
00000001400032b4 mov      r8, rbx
00000001400032b7 call     0x1400c33c6
00000001400032bc add      r12, rbx
00000001400032bf mov      qword ptr [rbp + 0x760], r12
00000001400032c6 jmp      0x1400031d7
00000001400032cb mov      rsi, qword ptr [rbp + 0x758]
00000001400032d2 and      qword ptr [rbp + 0x1e0], 0
00000001400032da mov      qword ptr [rbp + 0x1e8], 1
00000001400032e5 and      qword ptr [rbp + 0x1f0], 0
00000001400032ed add      r12, rsi
00000001400032f0 mov      qword ptr [rbp + 0x5e0], rsi
00000001400032f7 mov      qword ptr [rbp + 0x5e8], r12
00000001400032fe xor      edi, edi
0000000140003300 xor      ebx, ebx
0000000140003302 lea      r12, [rbp + 0x1e0]
0000000140003309 lea      r14, [rbp + 0x5e0]
0000000140003310 mov      rcx, r14
0000000140003313 call     0x140001329
0000000140003318 cmp      eax, 0x110000
000000014000331d je       0x140003342
000000014000331f mov      ecx, ebx
0000000140003321 add      cl, bl
0000000140003323 cmp      eax, 0x31
0000000140003326 sete     bl
0000000140003329 or       bl, cl
000000014000332b inc      edi
000000014000332d cmp      edi, 8
0000000140003330 jne      0x140003310
0000000140003332 mov      rcx, r12
0000000140003335 mov      edx, ebx
0000000140003337 call     0x140079c3d
000000014000333c xor      edi, edi
000000014000333e xor      ebx, ebx
0000000140003340 jmp      0x140003310
0000000140003342 test     edi, edi
0000000140003344 jle      0x14000335b
0000000140003346 neg      dil
0000000140003349 and      dil, 7
000000014000334d mov      ecx, edi
000000014000334f shl      bl, cl
0000000140003351 mov      rcx, r12
0000000140003354 mov      edx, ebx
0000000140003356 call     0x140079c3d
000000014000335b mov      rax, qword ptr [rbp + 0x1e0]
0000000140003362 mov      qword ptr [rbp + 0xab8], rax
0000000140003369 mov      r15, qword ptr [rbp + 0x1e8]
0000000140003370 mov      rdi, qword ptr [rbp + 0x1f0]
0000000140003377 mov      rcx, qword ptr [rbp + 0x750]
000000014000337e mov      rdx, rsi
0000000140003381 call     0x140016b3a
0000000140003386 and      qword ptr [rbp + 0xa30], 0
000000014000338e push     1
0000000140003390 pop      rbx
0000000140003391 mov      qword ptr [rbp + 0xa38], rbx
0000000140003398 and      qword ptr [rbp + 0xa40], 0
00000001400033a0 lea      rsi, [rbp + 0xa30]
00000001400033a7 mov      rcx, rsi
00000001400033aa mov      r13, qword ptr [rbp + 0xb18]
00000001400033b1 mov      rdx, r13
00000001400033b4 push     0xb
00000001400033b6 pop      r8
00000001400033b8 call     0x1400053fe
00000001400033bd mov      rcx, rsi
00000001400033c0 mov      rdx, rdi
00000001400033c3 push     0x20
00000001400033c5 pop      r8
00000001400033c7 call     0x1400053fe
00000001400033cc mov      rcx, rsi
00000001400033cf mov      rdx, qword ptr [rbp + 0xb00]
00000001400033d6 mov      r8, r13
00000001400033d9 call     0x140005457
00000001400033de mov      rcx, rsi
00000001400033e1 mov      qword ptr [rbp + 0xb18], r15
00000001400033e8 mov      rdx, r15
00000001400033eb mov      r8, rdi
00000001400033ee call     0x140005457
00000001400033f3 mov      rsi, qword ptr [rbp + 0xa30]
00000001400033fa mov      rdi, qword ptr [rbp + 0xa38]
0000000140003401 mov      rax, qword ptr [rbp + 0xa40]
0000000140003408 add      rax, rdi
000000014000340b and      qword ptr [rbp + 0x1e0], 0
0000000140003413 mov      qword ptr [rbp + 0x1e8], rbx
000000014000341a and      qword ptr [rbp + 0x1f0], 0
0000000140003422 mov      qword ptr [rbp + 0x750], rdi
0000000140003429 mov      qword ptr [rbp + 0x758], rax
0000000140003430 xor      ebx, ebx
0000000140003432 xor      r15d, r15d
0000000140003435 lea      rcx, [rbp + 0x750]
000000014000343c call     0x140001329
0000000140003441 cmp      eax, 0x110000
0000000140003446 je       0x14000346c
0000000140003448 mov      ecx, r15d
000000014000344b add      cl, r15b
000000014000344e cmp      eax, 0x31
0000000140003451 sete     r15b
0000000140003455 or       r15b, cl
0000000140003458 inc      ebx
000000014000345a cmp      ebx, 8
000000014000345d jne      0x140003435
000000014000345f mov      rcx, r12
0000000140003462 mov      edx, r15d
0000000140003465 call     0x140079c3d
000000014000346a jmp      0x140003430
000000014000346c test     ebx, ebx
000000014000346e jle      0x140003485
0000000140003470 neg      bl
0000000140003472 and      bl, 7
0000000140003475 mov      ecx, ebx
0000000140003477 shl      r15b, cl
000000014000347a mov      rcx, r12
000000014000347d mov      edx, r15d
0000000140003480 call     0x140079c3d
0000000140003485 mov      rax, qword ptr [rbp + 0x1e0]
000000014000348c mov      qword ptr [rbp + 0xac0], rax
0000000140003493 mov      rax, qword ptr [rbp + 0x1e8]
000000014000349a mov      qword ptr [rbp + 0xba8], rax
00000001400034a1 mov      rbx, qword ptr [rbp + 0x1f0]
00000001400034a8 mov      rcx, rsi
00000001400034ab mov      rdx, rdi
00000001400034ae call     0x140016b3a
00000001400034b3 movups   xmmword ptr [rbp + 0x9f7], xmm8
00000001400034bb movabs   rax, 0x407576c41004a6c
00000001400034c5 mov      qword ptr [rbp + 0xa07], rax
00000001400034cc mov      byte ptr [rbp + 0xa0f], 7
00000001400034d3 xor      eax, eax
00000001400034d5 cmp      rax, 0x19
00000001400034d9 je       0x1400034e8
00000001400034db xor      byte ptr [rbp + rax + 0x9f7], 0x33
00000001400034e3 inc      rax
00000001400034e6 jmp      0x1400034d5
00000001400034e8 lea      rsi, [rbp + 0xd8]
00000001400034ef mov      rcx, rsi
00000001400034f2 lea      rdx, [rbp + 0x9f7]
00000001400034f9 call     0x1400052e2
00000001400034fe mov      rcx, rsi
0000000140003501 mov      rdx, qword ptr [rbp + 0xba8]
0000000140003508 mov      r8, rbx
000000014000350b call     0x140005281
0000000140003510 mov      rax, qword ptr [rip + 0x140b81]
0000000140003517 cmp      rax, 2
000000014000351b jne      0x1400046e2
0000000140003521 mov      al, byte ptr [rip + 0x140b7a]
0000000140003527 test     al, al
0000000140003529 mov      qword ptr [rbp + 0xbc0], rbx
0000000140003530 je       0x1400037d6
0000000140003536 mov      al, byte ptr [rip + 0x140d04]
000000014000353c test     al, al
000000014000353e je       0x140004735
0000000140003544 and      qword ptr [rbp + 0x8c0], 0
000000014000354c mov      rcx, r12
000000014000354f lea      rdx, [rip + 0xf4fea]
0000000140003556 push     0xb
0000000140003558 pop      r8
000000014000355a call     0x140074e30
000000014000355f mov      rdi, qword ptr [rbp + 0x1e0]
0000000140003566 mov      rsi, qword ptr [rbp + 0x1e8]
000000014000356d test     rdi, rdi
0000000140003570 je       0x14000373a
0000000140003576 mov      qword ptr [rbp + 0xbb0], rdi
000000014000357d mov      rax, qword ptr [rbp + 0x1f0]
0000000140003584 mov      qword ptr [rbp + 0xbc8], rax
000000014000358b mov      r15, qword ptr [rbp + 0x1f8]
0000000140003592 xor      ebx, ebx
0000000140003594 mov      qword ptr [rbp + 0xbd0], r15
000000014000359b cmp      rsi, r15
000000014000359e je       0x140004f58
00000001400035a4 movzx    eax, word ptr [rsi]
00000001400035a7 cmp      ax, 2
00000001400035ab je       0x140004f58
00000001400035b1 mov      rdi, qword ptr [rsi + 0xc]
00000001400035b5 mov      r13d, dword ptr [rsi + 0x14]
00000001400035b9 mov      r14d, dword ptr [rsi + 0x18]
00000001400035bd movzx    r12d, word ptr [rsi + 0x1c]
00000001400035c2 movzx    ecx, word ptr [rsi + 0xa]
00000001400035c6 mov      word ptr [rbp + 0x5e8], cx
00000001400035cd mov      rcx, qword ptr [rsi + 2]
00000001400035d1 mov      qword ptr [rbp + 0x5e0], rcx
00000001400035d8 cmp      ax, 1
00000001400035dc jne      0x140003608
00000001400035de push     0x17
00000001400035e0 pop      rcx
00000001400035e1 call     0x140072160
00000001400035e6 mov      rbx, rdx
00000001400035e9 test     al, 1
00000001400035eb jne      0x1400036b6
00000001400035f1 rol      r12w, 8
00000001400035f6 mov      ax, 0x17
00000001400035fa mov      rcx, qword ptr [rbp + 0x5e2]
0000000140003601 mov      r15, rbx
0000000140003604 push     0x1c
0000000140003606 jmp      0x14000363a
0000000140003608 push     2
000000014000360a pop      rcx
000000014000360b call     0x140072160
0000000140003610 mov      rbx, rdx
0000000140003613 test     al, 1
0000000140003615 jne      0x1400036b6
000000014000361b movzx    r12d, word ptr [rbp + 0x5e4]
0000000140003623 rol      r12w, 8
0000000140003628 mov      ax, 2
000000014000362c mov      r13d, dword ptr [rbp + 0x5e0]
0000000140003633 mov      r15, rbx
0000000140003636 xor      ecx, ecx
0000000140003638 push     0x10
000000014000363a pop      r8
000000014000363c mov      word ptr [rbp + 0x1e0], ax
0000000140003643 mov      word ptr [rbp + 0x1e2], r12w
000000014000364b mov      dword ptr [rbp + 0x1e4], r13d
0000000140003652 mov      qword ptr [rbp + 0x1e8], rcx
0000000140003659 mov      qword ptr [rbp + 0x1f0], rdi
0000000140003660 mov      dword ptr [rbp + 0x1f8], r14d
0000000140003667 mov      rcx, r15
000000014000366a lea      r12, [rbp + 0x1e0]
0000000140003671 mov      rdx, r12
0000000140003674 call     qword ptr [rip + 0xc4c26]
000000014000367a cmp      eax, -1
000000014000367d je       0x140003696
000000014000367f mov      rcx, r15
0000000140003682 mov      edx, 0x80
0000000140003687 call     qword ptr [rip + 0xc4c0b]
000000014000368d cmp      eax, -1
0000000140003690 jne      0x14000371a
0000000140003696 call     qword ptr [rip + 0xc4bf4]
000000014000369c mov      ebx, eax
000000014000369e shl      rbx, 0x20
00000001400036a2 or       rbx, 2
00000001400036a6 mov      rcx, r15
00000001400036a9 call     qword ptr [rip + 0xc4bd9]
00000001400036af mov      r15, qword ptr [rbp + 0xbd0]
00000001400036b6 lea      rcx, [rbp + 0x8c0]
00000001400036bd call     0x14007d9e5
00000001400036c2 mov      qword ptr [rbp + 0x8c0], rbx
00000001400036c9 add      rsi, 0x20
00000001400036cd jmp      0x14000359b
00000001400036d2 mov      rsi, qword ptr [rbp + 0xb28]
00000001400036d9 mov      rcx, r12
00000001400036dc lea      rdx, [rip + 0xc5a72]
00000001400036e3 call     0x140005493
00000001400036e8 mov      rcx, qword ptr [rbp + 0xb20]
00000001400036ef mov      rdx, rsi
00000001400036f2 call     0x140016b3a
00000001400036f7 mov      rax, qword ptr [rbp + 0x1f0]
00000001400036fe mov      qword ptr [rbp + 0xb30], rax
0000000140003705 movdqu   xmm0, xmmword ptr [rbp + 0x1e0]
000000014000370d movdqa   xmmword ptr [rbp + 0xb20], xmm0
0000000140003715 jmp      0x1400041b6
000000014000371a mov      rdi, qword ptr [rbp + 0xbb0]
0000000140003721 mov      rcx, rdi
0000000140003724 mov      rdx, qword ptr [rbp + 0xbc8]
000000014000372b call     0x1400807e2
0000000140003730 mov      rsi, r15
0000000140003733 lea      r14, [rbp + 0x5e0]
000000014000373a lea      rcx, [rbp + 0x8c0]
0000000140003741 call     0x14007d9e5
0000000140003746 test     rdi, rdi
0000000140003749 je       0x140004f79
000000014000374f movaps   xmmword ptr [rbp + 0x250], xmm9
0000000140003757 movaps   xmmword ptr [rbp + 0x240], xmm9
000000014000375f movaps   xmmword ptr [rbp + 0x230], xmm9
0000000140003767 movaps   xmmword ptr [rbp + 0x220], xmm9
000000014000376f movaps   xmmword ptr [rbp + 0x210], xmm9
0000000140003777 movaps   xmmword ptr [rbp + 0x200], xmm9
000000014000377f movaps   xmmword ptr [rbp + 0x1f0], xmm9
0000000140003787 movaps   xmmword ptr [rbp + 0x1e0], xmm9
000000014000378f mov      dword ptr [rbp + 0x5e0], 0x80
0000000140003799 mov      rcx, rsi
000000014000379c mov      rdx, r12
000000014000379f mov      r8, r14
00000001400037a2 call     qword ptr [rip + 0xc4a88]
00000001400037a8 cmp      eax, -1
00000001400037ab je       0x140004ff9
00000001400037b1 mov      eax, dword ptr [rbp + 0x5e0]
00000001400037b7 movzx    ecx, word ptr [rbp + 0x1e0]
00000001400037be cmp      ecx, 0x17
00000001400037c1 je       0x1400037ee
00000001400037c3 cmp      ecx, 2
00000001400037c6 jne      0x140005065
00000001400037cc cmp      eax, 0xf
00000001400037cf ja       0x1400037f7
00000001400037d1 jmp      0x140004f2e
00000001400037d6 mov      rcx, r12
00000001400037d9 call     0x1400812d1
00000001400037de mov      rcx, r12
00000001400037e1 call     0x140081437
00000001400037e6 push     0x20
00000001400037e8 pop      rbx
00000001400037e9 jmp      0x140003b3c
00000001400037ee cmp      eax, 0x1b
00000001400037f1 jbe      0x140004f40
00000001400037f7 movzx    edi, word ptr [rbp + 0x1e2]
00000001400037fe rol      di, 8
0000000140003802 mov      word ptr [rbp + 0xad8], di
0000000140003809 push     8
000000014000380b pop      rcx
000000014000380c push     0x18
000000014000380e pop      rdx
000000014000380f call     0x140077a64
0000000140003814 mov      rcx, rax
0000000140003817 push     1
0000000140003819 pop      rax
000000014000381a mov      qword ptr [rcx], rax
000000014000381d mov      qword ptr [rcx + 8], rax
0000000140003821 mov      byte ptr [rcx + 0x10], 0
0000000140003825 mov      qword ptr [rbp + 0xbd0], rcx
000000014000382c lock inc qword ptr [rcx]
0000000140003830 jle      0x140005096
0000000140003836 mov      word ptr [rbp + 0xbb0], di
000000014000383d movabs   rax, 0x8000000000000000
0000000140003847 mov      qword ptr [rbp + 0x1f0], rax
000000014000384e and      qword ptr [rbp + 0x1e0], 0
0000000140003856 mov      byte ptr [rbp + 0x208], 0
000000014000385d mov      r15, qword ptr [rip + 0x1409e4]
0000000140003864 test     r15, r15
0000000140003867 je       0x140003875
0000000140003869 dec      r15
000000014000386c push     0x30
000000014000386e pop      r14
0000000140003870 jmp      0x1400038ff
0000000140003875 mov      rcx, r14
0000000140003878 call     0x14006316c
000000014000387d mov      rbx, qword ptr [rbp + 0x5e0]
0000000140003884 mov      r15d, 0x200000
000000014000388a mov      rax, rbx
000000014000388d neg      rax
0000000140003890 push     0x30
0000000140003892 pop      r14
0000000140003894 jo       0x1400038f4
0000000140003896 mov      r13, qword ptr [rbp + 0x5e8]
000000014000389d mov      r8, qword ptr [rbp + 0x5f0]
00000001400038a4 lea      rdi, [rbp + 0xa48]
00000001400038ab mov      rcx, rdi
00000001400038ae mov      rdx, r13
00000001400038b1 call     0x140007860
00000001400038b6 cmp      dword ptr [rbp + 0xa48], 1
00000001400038bd je       0x1400038e9
00000001400038bf mov      rdx, qword ptr [rbp + 0xa50]
00000001400038c6 mov      r8, qword ptr [rbp + 0xa58]
00000001400038cd mov      rcx, rdi
00000001400038d0 push     0xa
00000001400038d2 pop      r9
00000001400038d4 call     0x14007ab73
00000001400038d9 cmp      byte ptr [rbp + 0xa48], 0
00000001400038e0 jne      0x1400038e9
00000001400038e2 mov      r15, qword ptr [rbp + 0xa50]
00000001400038e9 mov      rcx, rbx
00000001400038ec mov      rdx, r13
00000001400038ef call     0x140075e8b
00000001400038f4 lea      rax, [r15 + 1]
00000001400038f8 mov      qword ptr [rip + 0x140949], rax
00000001400038ff call     0x1400723e0
0000000140003904 mov      rcx, rax
0000000140003907 lea      rdx, [rbp + 0x1f0]
000000014000390e call     0x140072a10
0000000140003913 mov      rbx, rax
0000000140003916 mov      qword ptr [rbp + 0xa48], rax
000000014000391d lea      rcx, [rbp + 0x8c0]
0000000140003924 lea      rdx, [rbp + 0xa48]
000000014000392b call     0x1400733e0
0000000140003930 push     8
0000000140003932 pop      rdi
0000000140003933 mov      rcx, rdi
0000000140003936 mov      rdx, r14
0000000140003939 call     0x140077a64
000000014000393e mov      r13, rax
0000000140003941 push     1
0000000140003943 pop      rax
0000000140003944 mov      qword ptr [r13], rax
0000000140003948 mov      qword ptr [r13 + 8], rax
000000014000394c movups   xmmword ptr [r13 + 0x10], xmm9
0000000140003951 mov      qword ptr [rbp + 0x5e0], r13
0000000140003958 lock inc qword ptr [r13]
000000014000395d jle      0x140005096
0000000140003963 mov      rcx, rdi
0000000140003966 push     0x40
0000000140003968 pop      rdx
0000000140003969 call     0x140077a64
000000014000396e mov      r14, rax
0000000140003971 movdqu   xmm0, xmmword ptr [rbp + 0x8c0]
0000000140003979 movdqu   xmm1, xmmword ptr [rbp + 0x8d0]
0000000140003981 movdqu   xmmword ptr [rax], xmm0
0000000140003985 movdqu   xmmword ptr [rax + 0x10], xmm1
000000014000398a mov      qword ptr [rax + 0x20], r13
000000014000398e mov      qword ptr [rax + 0x28], rsi
0000000140003992 mov      rax, qword ptr [rbp + 0xbd0]
0000000140003999 mov      qword ptr [r14 + 0x30], rax
000000014000399d lea      rax, [rip + 0x7ddf8]
00000001400039a4 mov      qword ptr [r14 + 0x38], rax
00000001400039a8 lock inc qword ptr [rbx]
00000001400039ac jle      0x140005096
00000001400039b2 mov      rcx, rdi
00000001400039b5 push     0x18
00000001400039b7 pop      rdx
00000001400039b8 call     0x140077a64
00000001400039bd mov      qword ptr [rax], rbx
00000001400039c0 mov      qword ptr [rax + 8], r14
00000001400039c4 lea      rcx, [rip + 0xf48b5]
00000001400039cb mov      qword ptr [rax + 0x10], rcx
00000001400039cf mov      rcx, r15
00000001400039d2 mov      rdx, rax
00000001400039d5 call     0x140072430
00000001400039da mov      rsi, rdx
00000001400039dd test     al, 1
00000001400039df jne      0x140005009
00000001400039e5 mov      qword ptr [rbp + 0xb60], rbx
00000001400039ec mov      qword ptr [rbp + 0xb68], r13
00000001400039f3 mov      qword ptr [rbp + 0xb70], rsi
00000001400039fa mov      rcx, rsi
00000001400039fd call     qword ptr [rip + 0xc4645]
0000000140003a03 lea      rcx, [rbp + 0xb60]
0000000140003a0a call     0x140080d01
0000000140003a0f lea      rcx, [rbp + 0xb68]
0000000140003a16 call     0x140080f7a
0000000140003a1b lea      r14, [rbp + 0x5e0]
0000000140003a22 push     8
0000000140003a24 pop      rsi
0000000140003a25 lea      rax, [rbp + 0xad8]
0000000140003a2c mov      qword ptr [rbp + 0x5e0], rax
0000000140003a33 lea      rax, [rip + 0x79a6]
0000000140003a3a mov      qword ptr [rbp + 0x5e8], rax
0000000140003a41 mov      rcx, r12
0000000140003a44 lea      rdx, [rip + 0xf4b95]
0000000140003a4b mov      r8, r14
0000000140003a4e call     0x1400811fe
0000000140003a53 mov      rcx, r12
0000000140003a56 call     0x1400807f0
0000000140003a5b mov      qword ptr [rbp + 0x8c0], rax
0000000140003a62 mov      qword ptr [rbp + 0x8c8], rdx
0000000140003a69 cmp      rax, 1
0000000140003a6d jne      0x140003ac1
0000000140003a6f mov      qword ptr [rbp + 0x5e0], rdx
0000000140003a76 mov      rcx, rdx
0000000140003a79 call     0x140076505
0000000140003a7e cmp      al, 2
0000000140003a80 jne      0x140003a90
0000000140003a82 xor      ecx, ecx
0000000140003a84 mov      edx, 0x5f5e100
0000000140003a89 call     0x1400745d0
0000000140003a8e jmp      0x140003ab4
0000000140003a90 mov      qword ptr [rbp + 0x1e0], r14
0000000140003a97 lea      rax, [rip + 0x6ee12]
0000000140003a9e mov      qword ptr [rbp + 0x1e8], rax
0000000140003aa5 lea      rcx, [rip + 0xf4b41]
0000000140003aac mov      rdx, r12
0000000140003aaf call     0x140074310
0000000140003ab4 mov      rcx, r14
0000000140003ab7 call     0x1400759ea
0000000140003abc jmp      0x140003a25
0000000140003ac1 lea      rcx, [rbp + 0x8c0]
0000000140003ac8 call     0x1400759d0
0000000140003acd mov      rcx, r12
0000000140003ad0 call     0x1400812d1
0000000140003ad5 mov      rcx, rsi
0000000140003ad8 push     0x20
0000000140003ada pop      rbx
0000000140003adb mov      rdx, rbx
0000000140003ade call     0x140077a64
0000000140003ae3 mov      rsi, rax
0000000140003ae6 push     1
0000000140003ae8 pop      rax
0000000140003ae9 mov      qword ptr [rsi], rax
0000000140003aec mov      qword ptr [rsi + 8], rax
0000000140003af0 mov      rax, qword ptr [rbp + 0xbd0]
0000000140003af7 mov      qword ptr [rsi + 0x10], rax
0000000140003afb movzx    eax, word ptr [rbp + 0xbb0]
0000000140003b02 mov      word ptr [rsi + 0x18], ax
0000000140003b06 lea      rcx, [rbp + 0x2b8]
0000000140003b0d call     0x1400463f0
0000000140003b12 mov      qword ptr [rbp + 0x2b8], rsi
0000000140003b19 lea      rax, [rip + 0x1060a8]
0000000140003b20 mov      qword ptr [rbp + 0x2c0], rax
0000000140003b27 mov      ecx, 0x100
0000000140003b2c mov      rdi, r14
0000000140003b2f mov      rsi, r12
0000000140003b32 rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003b34 mov      rcx, r14
0000000140003b37 call     0x140081437
0000000140003b3c mov      qword ptr [rbp + 0x1e0], rax
0000000140003b43 mov      qword ptr [rbp + 0x1e8], rdx
0000000140003b4a mov      rcx, rax
0000000140003b4d call     0x1400812bf
0000000140003b52 mov      rsi, rax
0000000140003b55 mov      rdi, rdx
0000000140003b58 lea      rcx, [rbp + 0x6e8]
0000000140003b5f lea      rdx, [rip + 0xf4f9a]
0000000140003b66 push     4
0000000140003b68 pop      r8
0000000140003b6a call     0x140075789
0000000140003b6f lea      rcx, [rbp + 0x700]
0000000140003b76 lea      rdx, [rip + 0xc55b8]
0000000140003b7d mov      r8, rbx
0000000140003b80 call     0x140075789
0000000140003b85 mov      qword ptr [rbp + 0x740], rsi
0000000140003b8c mov      qword ptr [rbp + 0x748], rdi
0000000140003b93 and      qword ptr [rbp + 0x718], 0
0000000140003b9b mov      qword ptr [rbp + 0x720], 8
0000000140003ba6 and      qword ptr [rbp + 0x728], 0
0000000140003bae mov      edi, 0x3b9aca00
0000000140003bb3 mov      dword ptr [rbp + 0x738], edi
0000000140003bb9 mov      rcx, r12
0000000140003bbc call     0x140081246
0000000140003bc1 mov      rax, qword ptr [rbp + 0xba8]
0000000140003bc8 mov      qword ptr [rbp + 0xae0], rax
0000000140003bcf mov      rax, qword ptr [rbp + 0xbc0]
0000000140003bd6 mov      qword ptr [rbp + 0xae8], rax
0000000140003bdd movabs   rax, 0x8000000000000003
0000000140003be7 mov      qword ptr [rbp + 0xad8], rax
0000000140003bee mov      qword ptr [rsp + 0x20], 4
0000000140003bf7 mov      rcx, r12
0000000140003bfa lea      rdx, [rip + 0x104f66]
0000000140003c01 push     0xf
0000000140003c03 pop      r8
0000000140003c05 lea      r9, [rip + 0x104f6a]
0000000140003c0c call     0x140084f79
0000000140003c11 lea      rcx, [rbp + 0x718]
0000000140003c18 mov      rdx, r12
0000000140003c1b call     0x140084fda
0000000140003c20 mov      eax, dword ptr [rbp + 0x738]
0000000140003c26 mov      rsi, qword ptr [rbp + 0x740]
0000000140003c2d mov      ebx, eax
0000000140003c2f cmp      eax, edi
0000000140003c31 jne      0x140003c39
0000000140003c33 mov      ebx, dword ptr [rsi + 0xb0]
0000000140003c39 cmp      ebx, edi
0000000140003c3b je       0x140003cdb
0000000140003c41 lea      rcx, [rsi + 0xa8]
0000000140003c48 mov      r15d, 0x3b9aca00
0000000140003c4e cmp      eax, r15d
0000000140003c51 lea      rax, [rbp + 0x730]
0000000140003c58 cmovne   rcx, rax
0000000140003c5c mov      rdi, qword ptr [rcx]
0000000140003c5f call     0x140071e90
0000000140003c64 mov      rcx, rax
0000000140003c67 mov      r8, rdi
0000000140003c6a mov      r9d, ebx
0000000140003c6d call     0x140071410
0000000140003c72 cmp      edx, r15d
0000000140003c75 jne      0x140003cd2
0000000140003c77 lea      rcx, [rbp + 0x758]
0000000140003c7e lea      rdx, [rip + 0x104ef5]
0000000140003c85 push     0x1b
0000000140003c87 pop      r8
0000000140003c89 call     0x140075789
0000000140003c8e movabs   rax, 0x8000000000000000
0000000140003c98 mov      qword ptr [rbp + 0x750], rax
0000000140003c9f mov      qword ptr [rbp + 0x770], rax
0000000140003ca6 and      qword ptr [rbp + 0x7c8], 0
0000000140003cae mov      byte ptr [rbp + 0x7d8], 8
0000000140003cb5 lea      rcx, [rbp + 0xad8]
0000000140003cbc call     0x140085c5d
0000000140003cc1 lea      rcx, [rbp + 0x6e8]
0000000140003cc8 call     0x140085c9d
0000000140003ccd jmp      0x140004042
0000000140003cd2 mov      edi, edx
0000000140003cd4 mov      qword ptr [rbp + 0x890], rax
0000000140003cdb mov      dword ptr [rbp + 0x898], edi
0000000140003ce1 movdqu   xmm0, xmmword ptr [rbp + 0xad8]
0000000140003ce9 movdqu   xmm1, xmmword ptr [rbp + 0xae8]
0000000140003cf1 movdqa   xmmword ptr [rbp + 0xb60], xmm0
0000000140003cf9 movdqa   xmmword ptr [rbp + 0xb70], xmm1
0000000140003d01 mov      rax, qword ptr [rbp + 0xaf8]
0000000140003d08 mov      qword ptr [rbp + 0xb80], rax
0000000140003d0f lea      rax, [rbp + 0x890]
0000000140003d16 mov      qword ptr [rbp + 0xb88], rax
0000000140003d1d mov      rdx, qword ptr [rbp + 0x748]
0000000140003d24 cmp      qword ptr [rdx + 0x20], 0
0000000140003d29 je       0x140003e0d
0000000140003d2f mov      rcx, rsi
0000000140003d32 call     0x1400812bf
0000000140003d37 mov      qword ptr [rbp + 0xa10], rax
0000000140003d3e mov      qword ptr [rbp + 0xa18], rdx
0000000140003d45 mov      rax, qword ptr [rdx + 0x18]
0000000140003d49 mov      rcx, qword ptr [rdx + 0x20]
0000000140003d4d shl      rcx, 4
0000000140003d51 add      rcx, rax
0000000140003d54 mov      qword ptr [rbp + 0x880], rax
0000000140003d5b mov      qword ptr [rbp + 0x888], rcx
0000000140003d62 push     8
0000000140003d64 pop      rcx
0000000140003d65 push     0x30
0000000140003d67 pop      rdx
0000000140003d68 call     0x140077a64
0000000140003d6d mov      rbx, rax
0000000140003d70 movdqa   xmm0, xmmword ptr [rbp + 0xb60]
0000000140003d78 movdqa   xmm1, xmmword ptr [rbp + 0xb70]
0000000140003d80 movdqa   xmm2, xmmword ptr [rbp + 0xb80]
0000000140003d88 movdqu   xmmword ptr [rax], xmm0
0000000140003d8c movdqu   xmmword ptr [rax + 0x10], xmm1
0000000140003d91 movdqu   xmmword ptr [rax + 0x20], xmm2
0000000140003d96 lea      rax, [rbp + 0x880]
0000000140003d9d mov      qword ptr [rbp + 0x860], rax
0000000140003da4 lea      rcx, [rip + 0x104ded]
0000000140003dab mov      qword ptr [rbp + 0x868], rcx
0000000140003db2 mov      qword ptr [rbp + 0x870], rbx
0000000140003db9 lea      rcx, [rip + 0x104e10]
0000000140003dc0 mov      qword ptr [rbp + 0x878], rcx
0000000140003dc7 push     0x68
0000000140003dc9 pop      rcx
0000000140003dca lea      r15, [rbp + 0xa48]
0000000140003dd1 mov      rdi, r15
0000000140003dd4 lea      r13, [rbp + 0x6e8]
0000000140003ddb mov      rsi, r13
0000000140003dde rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003de0 mov      rcx, rax
0000000140003de3 call     0x14008c3f3
0000000140003de8 test     rax, rax
0000000140003deb je       0x140003e9f
0000000140003df1 mov      r10, rdx
0000000140003df4 mov      rcx, r12
0000000140003df7 mov      rdx, rax
0000000140003dfa mov      r8, r15
0000000140003dfd lea      r9, [rbp + 0x860]
0000000140003e04 call     qword ptr [r10 + 0x18]
0000000140003e08 jmp      0x140003ebc
0000000140003e0d mov      rcx, r12
0000000140003e10 lea      rdx, [rbp + 0xb60]
0000000140003e17 lea      r8, [rbp + 0x6e8]
0000000140003e1e call     0x140085022
0000000140003e23 mov      rax, qword ptr [rbp + 0x1e0]
0000000140003e2a mov      ecx, 0x100
0000000140003e2f mov      rdi, r14
0000000140003e32 lea      rsi, [rbp + 0x1e8]
0000000140003e39 rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003e3b movzx    ebx, word ptr [rbp + 0x2e8]
0000000140003e42 mov      rdx, qword ptr [rbp + 0xac8]
0000000140003e49 mov      ecx, dword ptr [rdx]
0000000140003e4b mov      dword ptr [rbp + 0xa48], ecx
0000000140003e51 movzx    ecx, word ptr [rdx + 4]
0000000140003e55 mov      word ptr [rbp + 0xa4c], cx
0000000140003e5c movabs   rcx, 0x8000000000000001
0000000140003e66 cmp      rax, rcx
0000000140003e69 jne      0x140004009
0000000140003e6f mov      ecx, 0x100
0000000140003e74 lea      rdi, [rbp + 0x8c0]
0000000140003e7b mov      rsi, r14
0000000140003e7e rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003e80 movzx    eax, word ptr [rbp + 0xa4c]
0000000140003e87 mov      word ptr [rbp + 0xbbc], ax
0000000140003e8e mov      eax, dword ptr [rbp + 0xa48]
0000000140003e94 mov      dword ptr [rbp + 0xbb8], eax
0000000140003e9a jmp      0x140003f3f
0000000140003e9f mov      rcx, r12
0000000140003ea2 mov      rdx, rbx
0000000140003ea5 mov      r8, r13
0000000140003ea8 call     0x14008c3dd
0000000140003ead mov      rcx, rbx
0000000140003eb0 push     8
0000000140003eb2 pop      rdx
0000000140003eb3 push     0x30
0000000140003eb5 pop      r8
0000000140003eb7 call     0x1400013ae
0000000140003ebc mov      rax, qword ptr [rbp + 0x1e0]
0000000140003ec3 mov      ecx, 0x100
0000000140003ec8 mov      rdi, r14
0000000140003ecb lea      rsi, [rbp + 0x1e8]
0000000140003ed2 rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003ed4 movzx    ebx, word ptr [rbp + 0x2e8]
0000000140003edb mov      rdx, qword ptr [rbp + 0xac8]
0000000140003ee2 mov      ecx, dword ptr [rdx]
0000000140003ee4 mov      dword ptr [rbp + 0xba0], ecx
0000000140003eea movzx    ecx, word ptr [rdx + 4]
0000000140003eee mov      word ptr [rbp + 0xba4], cx
0000000140003ef5 movabs   rcx, 0x8000000000000001
0000000140003eff cmp      rax, rcx
0000000140003f02 jne      0x140003f8c
0000000140003f08 mov      ecx, 0x100
0000000140003f0d lea      rdi, [rbp + 0x8c0]
0000000140003f14 mov      rsi, r14
0000000140003f17 rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003f19 movzx    eax, word ptr [rbp + 0xba4]
0000000140003f20 mov      word ptr [rbp + 0xbbc], ax
0000000140003f27 mov      eax, dword ptr [rbp + 0xba0]
0000000140003f2d mov      dword ptr [rbp + 0xbb8], eax
0000000140003f33 lea      rcx, [rbp + 0xa10]
0000000140003f3a call     0x140081246
0000000140003f3f mov      ecx, 0x100
0000000140003f44 cmp      bx, 0x18f
0000000140003f49 jbe      0x140003fd3
0000000140003f4f lea      rdi, [rbp + 0x750]
0000000140003f56 lea      rsi, [rbp + 0x8c0]
0000000140003f5d rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003f5f movzx    eax, word ptr [rbp + 0xbbc]
0000000140003f66 lea      rcx, [rbp + 0x757]
0000000140003f6d mov      word ptr [rcx + 0xff], ax
0000000140003f74 mov      eax, dword ptr [rbp + 0xbb8]
0000000140003f7a mov      dword ptr [rcx + 0xfb], eax
0000000140003f80 mov      word ptr [rbp + 0x850], bx
0000000140003f87 jmp      0x14000403b
0000000140003f8c mov      ecx, 0x100
0000000140003f91 lea      rdi, [rbp + 0x758]
0000000140003f98 mov      rsi, r14
0000000140003f9b rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003f9d movzx    ecx, word ptr [rbp + 0xba4]
0000000140003fa4 mov      rdx, qword ptr [rbp + 0xb10]
0000000140003fab mov      word ptr [rdx + 4], cx
0000000140003faf mov      ecx, dword ptr [rbp + 0xba0]
0000000140003fb5 mov      dword ptr [rdx], ecx
0000000140003fb7 mov      qword ptr [rbp + 0x750], rax
0000000140003fbe mov      word ptr [rbp + 0x858], bx
0000000140003fc5 lea      rcx, [rbp + 0xa10]
0000000140003fcc call     0x140081246
0000000140003fd1 jmp      0x140004042
0000000140003fd3 lea      rdi, [rbp + 0x758]
0000000140003fda lea      rsi, [rbp + 0x8c0]
0000000140003fe1 rep movsb byte ptr [rdi], byte ptr [rsi]
0000000140003fe3 movzx    eax, word ptr [rbp + 0xbbc]
0000000140003fea mov      rcx, qword ptr [rbp + 0xb10]
0000000140003ff1 mov      word ptr [rcx + 4], ax
0000000140003ff5 mov      eax, dword ptr [rbp + 0xbb8]
0000000140003ffb mov      dword ptr [rcx], eax
0000000140003ffd movabs   rax, 0x8000000000000001
0000000140004007 jmp      0x140004034
0000000140004009 mov      ecx, 0x100
000000014000400e lea      rdi, [rbp + 0x758]
0000000140004015 mov      rsi, r14
0000000140004018 rep movsb byte ptr [rdi], byte ptr [rsi]
000000014000401a movzx    ecx, word ptr [rbp + 0xa4c]
0000000140004021 mov      rdx, qword ptr [rbp + 0xb10]
0000000140004028 mov      word ptr [rdx + 4], cx
000000014000402c mov      ecx, dword ptr [rbp + 0xa48]
0000000140004032 mov      dword ptr [rdx], ecx
0000000140004034 mov      qword ptr [rbp + 0x750], rax
000000014000403b mov      word ptr [rbp + 0x858], bx
0000000140004042 cmp      dword ptr [rbp + 0xb08], 4
0000000140004049 jg       0x140004e65
000000014000404f lea      rcx, [rbp + 0xb40]
0000000140004056 lea      rdx, [rip + 0xc50f8]
000000014000405d call     0x140005493
0000000140004062 movabs   rax, 0x8000000000000001
000000014000406c cmp      qword ptr [rbp + 0x750], rax
0000000140004073 jne      0x140004121
0000000140004079 mov      ecx, 0x108
000000014000407e lea      rdi, [rbp - 0x30]
0000000140004082 lea      rsi, [rbp + 0x758]
0000000140004089 rep movsb byte ptr [rdi], byte ptr [rsi]
000000014000408b and      qword ptr [rbp + 0xad8], 0
0000000140004093 mov      qword ptr [rbp + 0xae0], 1
000000014000409e and      qword ptr [rbp + 0xae8], 0
00000001400040a6 mov      rdi, qword ptr [rbp + 0xb0]
00000001400040ad mov      rsi, qword ptr [rbp + 0xb8]
00000001400040b4 mov      rcx, qword ptr [rbp - 0x30]
00000001400040b8 mov      rdx, qword ptr [rbp - 0x28]
00000001400040bc call     0x140075e8b
00000001400040c1 mov      rcx, qword ptr [rbp + 0x28]
00000001400040c5 mov      rdx, qword ptr [rbp + 0x30]
00000001400040c9 call     0x140075e8b
00000001400040ce lea      rcx, [rbp + 0x40]
00000001400040d2 call     0x140080640
00000001400040d7 lea      rcx, [rbp + 0x58]
00000001400040db call     0x1400806a5
00000001400040e0 mov      rcx, rdi
00000001400040e3 lea      rdx, [rbp + 0xad8]
00000001400040ea call     qword ptr [rsi + 0x30]
00000001400040ed test     rax, rax
00000001400040f0 je       0x1400041c5
00000001400040f6 mov      rcx, rdx
00000001400040f9 call     0x140001455
00000001400040fe mov      rcx, rdi
0000000140004101 mov      rdx, rsi
0000000140004104 call     0x14008066a
0000000140004109 mov      rcx, qword ptr [rbp + 0xad8]
0000000140004110 mov      rdx, qword ptr [rbp + 0xae0]
0000000140004117 call     0x140016b3a
000000014000411c mov      sil, 1
000000014000411f jmp      0x140004123
0000000140004121 xor      esi, esi
0000000140004123 mov      rcx, qword ptr [rbp + 0xb20]
000000014000412a mov      rdx, qword ptr [rbp + 0xb28]
0000000140004131 call     0x140016b3a
0000000140004136 mov      rax, qword ptr [rbp + 0xb50]
000000014000413d mov      qword ptr [rbp + 0xb30], rax
0000000140004144 movdqa   xmm0, xmmword ptr [rbp + 0xb40]
000000014000414c movdqa   xmmword ptr [rbp + 0xb20], xmm0
0000000140004154 test     sil, sil
0000000140004157 jne      0x140004165
0000000140004159 lea      rcx, [rbp + 0x750]
0000000140004160 call     0x140001641
0000000140004165 mov      rcx, qword ptr [rbp + 0xac0]
000000014000416c mov      rdx, qword ptr [rbp + 0xba8]
0000000140004173 call     0x140016b3a
0000000140004178 mov      rcx, qword ptr [rbp + 0xab0]
000000014000417f mov      rdx, qword ptr [rbp + 0xb00]
0000000140004186 call     0x140016b3a
000000014000418b mov      rcx, qword ptr [rbp + 0xab8]
0000000140004192 mov      rdx, qword ptr [rbp + 0xb18]
0000000140004199 call     0x140016b3a
000000014000419e lea      rcx, [rbp + 0x9c0]
00000001400041a5 call     0x14000157c
00000001400041aa lea      rcx, [rbp + 0x8a0]
00000001400041b1 call     0x140001498
00000001400041b6 push     0x1e
00000001400041b8 pop      rcx
00000001400041b9 xor      edx, edx
00000001400041bb call     0x1400745d0
00000001400041c0 jmp      0x140002a65
00000001400041c5 mov      rcx, rdi
00000001400041c8 mov      rdx, rsi
00000001400041cb call     0x14008066a
00000001400041d0 mov      rcx, r14
00000001400041d3 lea      rdx, [rbp + 0x9f7]
00000001400041da call     0x1400052e2
00000001400041df mov      rdx, qword ptr [rbp + 0xae0]
00000001400041e6 mov      r8, qword ptr [rbp + 0xae8]
00000001400041ed mov      rcx, r14
00000001400041f0 call     0x140005281
00000001400041f5 mov      rsi, qword ptr [rbp + 0xae8]
00000001400041fc test     rsi, rsi
00000001400041ff je       0x140004109
0000000140004205 mov      rbx, qword ptr [rbp + 0xad8]
000000014000420c mov      rdi, qword ptr [rbp + 0xae0]
0000000140004213 mov      rcx, r12
0000000140004216 mov      rdx, rdi
0000000140004219 mov      r8, rsi
000000014000421c call     0x140007860
0000000140004221 cmp      byte ptr [rbp + 0x1e0], 0
0000000140004228 je       0x140004249
000000014000422a mov      rax, rbx
000000014000422d neg      rax
0000000140004230 jno      0x140004342
0000000140004236 mov      qword ptr [rbp + 0xad0], rdi
000000014000423d mov      rdi, rsi
0000000140004240 mov      rsi, qword ptr [rbp + 0x1e8]
0000000140004247 jmp      0x140004250
0000000140004249 mov      qword ptr [rbp + 0xad0], rbx
0000000140004250 mov      rcx, r12
0000000140004253 mov      qword ptr [rbp + 0xbc8], rdi
000000014000425a mov      rdx, rdi
000000014000425d mov      r8, rsi
0000000140004260 call     0x14006f920
0000000140004265 mov      rdi, qword ptr [rbp + 0x1e0]
000000014000426c mov      r15, qword ptr [rbp + 0x1e8]
0000000140004273 mov      rax, rdi
0000000140004276 neg      rax
0000000140004279 jno      0x1400042f3
000000014000427b mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004282 mov      rcx, r12
0000000140004285 lea      rdx, [rip + 0xc4ec9]
000000014000428c call     0x140005493
0000000140004291 mov      rcx, qword ptr [rbp + 0xb40]
0000000140004298 mov      rdx, qword ptr [rbp + 0xb48]
000000014000429f call     0x140016b3a
00000001400042a4 mov      rax, qword ptr [rbp + 0x1f0]
00000001400042ab mov      qword ptr [rbp + 0xb50], rax
00000001400042b2 movdqu   xmm0, xmmword ptr [rbp + 0x1e0]
00000001400042ba movdqa   xmmword ptr [rbp + 0xb40], xmm0
00000001400042c2 mov      rcx, r15
00000001400042c5 call     0x140001455
00000001400042ca mov      rcx, qword ptr [rbp + 0xad0]
00000001400042d1 mov      rdx, rdi
00000001400042d4 call     0x140016b3a
00000001400042d9 movabs   rax, 0x8000000000000001
00000001400042e3 cmp      qword ptr [rbp + 0x750], rax
00000001400042ea sete     sil
00000001400042ee jmp      0x140004123
00000001400042f3 mov      rax, qword ptr [rbp + 0x1f0]
00000001400042fa mov      qword ptr [rbp + 0xb60], rdi
0000000140004301 mov      qword ptr [rbp + 0xb68], r15
0000000140004308 mov      qword ptr [rbp + 0xb70], rax
000000014000430f cmp      rax, 4
0000000140004313 jae      0x140004392
0000000140004315 test     rax, rax
0000000140004318 je       0x14000443d
000000014000431e cmp      rax, 3
0000000140004322 je       0x1400043cf
0000000140004328 cmp      rax, 1
000000014000432c jne      0x140004414
0000000140004332 cmp      word ptr [r15], 0
0000000140004337 jne      0x14000443d
000000014000433d jmp      0x140004880
0000000140004342 mov      rcx, rbx
0000000140004345 mov      rdx, rdi
0000000140004348 call     0x140016b3a
000000014000434d mov      rcx, r12
0000000140004350 lea      rdx, [rip + 0xc4dfe]
0000000140004357 call     0x140005493
000000014000435c mov      rcx, qword ptr [rbp + 0xb40]
0000000140004363 mov      rdx, qword ptr [rbp + 0xb48]
000000014000436a call     0x140016b3a
000000014000436f mov      rax, qword ptr [rbp + 0x1f0]
0000000140004376 mov      qword ptr [rbp + 0xb50], rax
000000014000437d movdqu   xmm0, xmmword ptr [rbp + 0x1e0]
0000000140004385 movdqa   xmmword ptr [rbp + 0xb40], xmm0
000000014000438d jmp      0x14000411c
0000000140004392 movabs   rcx, 0x5c003f005c005c
000000014000439c cmp      qword ptr [r15], rcx
000000014000439f je       0x140004880
00000001400043a5 movabs   rcx, 0x5c003f003f005c
00000001400043af cmp      qword ptr [r15], rcx
00000001400043b2 je       0x140004880
00000001400043b8 cmp      rax, 0xf8
00000001400043be jae      0x14000443d
00000001400043c0 cmp      word ptr [r15 + 2], 0x3a
00000001400043c6 jne      0x140004414
00000001400043c8 movzx    eax, word ptr [r15 + 4]
00000001400043cd jmp      0x1400043e1
00000001400043cf cmp      word ptr [r15 + 2], 0x3a
00000001400043d5 jne      0x140004414
00000001400043d7 movzx    eax, word ptr [r15 + 4]
00000001400043dc test     ax, ax
00000001400043df je       0x140004402
00000001400043e1 cmp      ax, 0x2f
00000001400043e5 je       0x1400043ef
00000001400043e7 movzx    eax, ax
00000001400043ea cmp      eax, 0x5c
00000001400043ed jne      0x140004414
00000001400043ef movzx    eax, word ptr [r15]
00000001400043f3 cmp      eax, 0x2f
00000001400043f6 je       0x140004418
00000001400043f8 cmp      eax, 0x5c
00000001400043fb je       0x140004418
00000001400043fd jmp      0x140004880
0000000140004402 movzx    eax, word ptr [r15]
0000000140004406 cmp      eax, 0x2f
0000000140004409 je       0x140004414
000000014000440b cmp      eax, 0x5c
000000014000440e jne      0x140004880
0000000140004414 movzx    eax, word ptr [r15]
0000000140004418 cmp      ax, 0x5c
000000014000441c je       0x140004426
000000014000441e movzx    eax, ax
0000000140004421 cmp      eax, 0x2f
0000000140004424 jne      0x14000443d
0000000140004426 movzx    eax, word ptr [r15 + 2]
000000014000442b cmp      eax, 0x2f
000000014000442e je       0x140004880
0000000140004434 cmp      eax, 0x5c
0000000140004437 je       0x140004880
000000014000443d mov      qword ptr [rbp + 0xbd0], r15
0000000140004444 and      qword ptr [rbp + 0xa48], 0
000000014000444c mov      qword ptr [rbp + 0xa50], 2
0000000140004457 and      qword ptr [rbp + 0xa58], 0
000000014000445f mov      esi, 0x200
0000000140004464 push     2
0000000140004466 pop      rax
0000000140004467 mov      qword ptr [rbp + 0xbb0], rax
000000014000446e xor      r14d, r14d
0000000140004471 xor      r12d, r12d
0000000140004474 xor      r15d, r15d
0000000140004477 cmp      rsi, 0x201
000000014000447e jae      0x140004491
0000000140004480 mov      ebx, 0x200
0000000140004485 lea      rdi, [rbp + 0x1e0]
000000014000448c mov      r13, rsi
000000014000448f jmp      0x1400044c9
0000000140004491 sub      rsi, r15
0000000140004494 sub      r12, r15
0000000140004497 cmp      rsi, r12
000000014000449a ja       0x140004537
00000001400044a0 mov      eax, 0xffffffff
00000001400044a5 cmp      r14, rax
00000001400044a8 mov      r15d, 0xffffffff
00000001400044ae cmovb    r15, r14
00000001400044b2 mov      qword ptr [rbp + 0xa58], r15
00000001400044b9 mov      r12, r14
00000001400044bc mov      rbx, r15
00000001400044bf mov      rdi, qword ptr [rbp + 0xbb0]
00000001400044c6 mov      r13, r15
00000001400044c9 xor      ecx, ecx
00000001400044cb call     qword ptr [rip + 0xc3b7f]
00000001400044d1 mov      rcx, qword ptr [rbp + 0xbd0]
00000001400044d8 mov      edx, r13d
00000001400044db mov      qword ptr [rbp + 0xbc0], rdi
00000001400044e2 mov      r8, rdi
00000001400044e5 xor      r9d, r9d
00000001400044e8 call     qword ptr [rip + 0xc3b6a]
00000001400044ee mov      edi, eax
00000001400044f0 test     eax, eax
00000001400044f2 jne      0x140004502
00000001400044f4 call     qword ptr [rip + 0xc3b66]
00000001400044fa test     eax, eax
00000001400044fc jne      0x1400045b7
0000000140004502 mov      esi, edi
0000000140004504 cmp      r13, rsi
0000000140004507 jne      0x14000452f
0000000140004509 call     qword ptr [rip + 0xc3b51]
000000014000450f cmp      eax, 0x7a
0000000140004512 jne      0x14000504c
0000000140004518 add      r13, r13
000000014000451b mov      eax, 0xffffffff
0000000140004520 cmp      r13, rax
0000000140004523 cmovae   r13, rax
0000000140004527 mov      rsi, r13
000000014000452a jmp      0x140004477
000000014000452f jb       0x140004477
0000000140004535 jmp      0x140004571
0000000140004537 mov      qword ptr [rsp + 0x20], 2
0000000140004540 lea      rcx, [rbp + 0xa48]
0000000140004547 mov      rdx, r15
000000014000454a mov      r8, rsi
000000014000454d push     2
000000014000454f pop      r9
0000000140004551 call     0x1400c6190
0000000140004556 nop      
0000000140004557 mov      r14, qword ptr [rbp + 0xa48]
000000014000455e mov      rax, qword ptr [rbp + 0xa50]
0000000140004565 mov      qword ptr [rbp + 0xbb0], rax
000000014000456c jmp      0x1400044a0
0000000140004571 cmp      rbx, rsi
0000000140004574 jb       0x140004fa7
000000014000457a and      qword ptr [rbp + 0xb70], 0
0000000140004582 cmp      edi, 2
0000000140004585 lea      r12, [rbp + 0x1e0]
000000014000458c jbe      0x1400045e5
000000014000458e mov      rcx, qword ptr [rbp + 0xbc0]
0000000140004595 movzx    eax, word ptr [rcx + 2]
0000000140004599 cmp      eax, 0x3a
000000014000459c jne      0x1400045f7
000000014000459e cmp      word ptr [rcx + 4], 0x5c
00000001400045a3 jne      0x1400045f7
00000001400045a5 xor      edi, edi
00000001400045a7 push     4
00000001400045a9 pop      r13
00000001400045ab lea      rbx, [rip + 0xf15a6]
00000001400045b2 jmp      0x14000475b
00000001400045b7 call     qword ptr [rip + 0xc3aa3]
00000001400045bd mov      r15d, eax
00000001400045c0 shl      r15, 0x20
00000001400045c4 or       r15, 2
00000001400045c8 cmp      qword ptr [rbp + 0xa48], 0
00000001400045d0 je       0x140004634
00000001400045d2 lea      r12, [rbp + 0x1e0]
00000001400045d9 mov      rdi, qword ptr [rbp + 0xbc8]
00000001400045e0 jmp      0x140004830
00000001400045e5 jne      0x140004647
00000001400045e7 mov      rax, qword ptr [rbp + 0xbc0]
00000001400045ee movzx    ecx, word ptr [rax]
00000001400045f1 movzx    eax, word ptr [rax + 2]
00000001400045f5 jmp      0x1400045ff
00000001400045f7 movzx    ecx, word ptr [rcx]
00000001400045fa cmp      edi, 3
00000001400045fd jne      0x14000464f
00000001400045ff mov      dil, 1
0000000140004602 cmp      ax, 0x5c
0000000140004606 jne      0x140004755
000000014000460c cmp      cx, 0x5c
0000000140004610 jne      0x140004755
0000000140004616 add      rsi, -2
000000014000461a add      qword ptr [rbp + 0xbc0], 4
0000000140004622 xor      edi, edi
0000000140004624 push     8
0000000140004626 pop      r13
0000000140004628 lea      rbx, [rip + 0xf1531]
000000014000462f jmp      0x14000475b
0000000140004634 lea      r12, [rbp + 0x1e0]
000000014000463b mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004642 jmp      0x140004844
0000000140004647 mov      dil, 1
000000014000464a jmp      0x140004755
000000014000464f mov      dil, 1
0000000140004652 cmp      cx, 0x5c
0000000140004656 jne      0x140004755
000000014000465c cmp      eax, 0x3f
000000014000465f je       0x140004755
0000000140004665 mov      cx, 0x5c
0000000140004669 cmp      eax, 0x5c
000000014000466c jne      0x1400045ff
000000014000466e mov      rax, qword ptr [rbp + 0xbc0]
0000000140004675 movzx    ecx, word ptr [rax + 4]
0000000140004679 mov      ax, 0x5c
000000014000467d cmp      ecx, 0x3f
0000000140004680 je       0x14000473f
0000000140004686 cmp      ecx, 0x2e
0000000140004689 jne      0x140004c77
000000014000468f mov      rcx, qword ptr [rbp + 0xbc0]
0000000140004696 cmp      word ptr [rcx + 6], 0x5c
000000014000469b mov      cx, 0x5c
000000014000469f jne      0x1400045ff
00000001400046a5 add      rsi, -4
00000001400046a9 add      qword ptr [rbp + 0xbc0], 8
00000001400046b1 jmp      0x1400045a5
00000001400046b6 cmp      rsi, 0x15
00000001400046ba jae      0x140004d85
00000001400046c0 lea      rbx, [rdi + 2]
00000001400046c4 test     r14, r14
00000001400046c7 je       0x140002e98
00000001400046cd mov      rcx, rdi
00000001400046d0 mov      rdx, rbx
00000001400046d3 call     0x1400018b8
00000001400046d8 add      rbx, 2
00000001400046dc add      r14, -2
00000001400046e0 jmp      0x1400046c4
00000001400046e2 lea      rcx, [rip + 0x13f9af]
00000001400046e9 mov      qword ptr [rbp + 0x8c0], rcx
00000001400046f0 lea      rax, [rip + 0x13f9a9]
00000001400046f7 mov      qword ptr [rbp + 0x5e0], rax
00000001400046fe lea      rax, [rbp + 0x8c0]
0000000140004705 mov      qword ptr [rbp + 0x1e0], rax
000000014000470c mov      qword ptr [rbp + 0x1e8], r14
0000000140004713 lea      rax, [rbp + 0xb9f]
000000014000471a mov      qword ptr [rbp + 0x1f0], rax
0000000140004721 mov      rdx, r12
0000000140004724 lea      r8, [rip + 0x1056ad]
000000014000472b call     0x140016b88
0000000140004730 jmp      0x140003521
0000000140004735 call     0x1400c68a0
000000014000473a jmp      0x140003544
000000014000473f mov      rcx, qword ptr [rbp + 0xbc0]
0000000140004746 cmp      word ptr [rcx + 6], 0x5c
000000014000474b mov      cx, 0x5c
000000014000474f jne      0x1400045ff
0000000140004755 xor      r13d, r13d
0000000140004758 push     2
000000014000475a pop      rbx
000000014000475b lea      rax, [rsi + r13]
000000014000475f mov      rdx, qword ptr [rbp + 0xb60]
0000000140004766 cmp      rax, rdx
0000000140004769 jae      0x140004c1f
000000014000476f mov      r15, rdx
0000000140004772 mov      qword ptr [rbp + 0xbb0], rbx
0000000140004779 cmp      r13, r15
000000014000477c ja       0x140004cfd
0000000140004782 mov      r14d, 0
0000000140004788 mov      ebx, 0
000000014000478d test     dil, dil
0000000140004790 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004797 jne      0x1400047bb
0000000140004799 lea      r8d, [r13*2]
00000001400047a1 mov      rax, qword ptr [rbp + 0xbd0]
00000001400047a8 lea      rcx, [rax + r14*2]
00000001400047ac mov      rdx, qword ptr [rbp + 0xbb0]
00000001400047b3 call     0x1400c33c6
00000001400047b8 mov      rbx, r14
00000001400047bb add      rbx, r13
00000001400047be mov      qword ptr [rbp + 0xb70], rbx
00000001400047c5 mov      rax, r15
00000001400047c8 sub      rax, rbx
00000001400047cb cmp      rsi, rax
00000001400047ce ja       0x140004d44
00000001400047d4 test     rsi, rsi
00000001400047d7 je       0x1400047f4
00000001400047d9 lea      r8, [rsi + rsi]
00000001400047dd mov      rax, qword ptr [rbp + 0xbd0]
00000001400047e4 lea      rcx, [rax + rbx*2]
00000001400047e8 mov      rdx, qword ptr [rbp + 0xbc0]
00000001400047ef call     0x1400c33c6
00000001400047f4 add      rbx, rsi
00000001400047f7 mov      qword ptr [rbp + 0xb70], rbx
00000001400047fe cmp      rbx, r15
0000000140004801 mov      rax, qword ptr [rbp + 0xbd0]
0000000140004808 jne      0x14000481e
000000014000480a lea      rcx, [rbp + 0xb60]
0000000140004811 call     0x1400c63a0
0000000140004816 nop      
0000000140004817 mov      rax, qword ptr [rbp + 0xb68]
000000014000481e and      word ptr [rax + rbx*2], 0
0000000140004823 cmp      qword ptr [rbp + 0xa48], 0
000000014000482b je       0x140004866
000000014000482d xor      r15d, r15d
0000000140004830 mov      rcx, qword ptr [rbp + 0xa50]
0000000140004837 push     2
0000000140004839 pop      rdx
000000014000483a call     0x140005767
000000014000483f test     r15, r15
0000000140004842 je       0x140004866
0000000140004844 cmp      qword ptr [rbp + 0xb60], 0
000000014000484c je       0x140004282
0000000140004852 mov      rcx, qword ptr [rbp + 0xb68]
0000000140004859 push     2
000000014000485b pop      rdx
000000014000485c call     0x140005767
0000000140004861 jmp      0x140004282
0000000140004866 mov      rdi, qword ptr [rbp + 0xb60]
000000014000486d mov      r15, qword ptr [rbp + 0xb68]
0000000140004874 mov      rax, rdi
0000000140004877 neg      rax
000000014000487a jo       0x14000427b
0000000140004880 and      qword ptr [rsp + 0x30], 0
0000000140004886 and      dword ptr [rsp + 0x28], 0
000000014000488b mov      dword ptr [rsp + 0x20], 3
0000000140004893 mov      rcx, r15
0000000140004896 mov      edx, 0x80000000
000000014000489b push     7
000000014000489d pop      r8
000000014000489f xor      r9d, r9d
00000001400048a2 call     qword ptr [rip + 0xc37c0]
00000001400048a8 mov      rsi, rax
00000001400048ab cmp      rax, -1
00000001400048af je       0x1400048bb
00000001400048b1 mov      r13, rsi
00000001400048b4 test     rdi, rdi
00000001400048b7 jne      0x1400048d5
00000001400048b9 jmp      0x1400048ea
00000001400048bb call     qword ptr [rip + 0xc379f]
00000001400048c1 mov      r13d, eax
00000001400048c4 shl      r13, 0x20
00000001400048c8 or       r13, 2
00000001400048cc test     rdi, rdi
00000001400048cf je       0x14000496b
00000001400048d5 mov      rcx, r15
00000001400048d8 push     2
00000001400048da pop      rdx
00000001400048db call     0x140005767
00000001400048e0 cmp      rsi, -1
00000001400048e4 je       0x14000496b
00000001400048ea movaps   xmmword ptr [rbp + 0x200], xmm9
00000001400048f2 movaps   xmmword ptr [rbp + 0x1f0], xmm9
00000001400048fa movaps   xmmword ptr [rbp + 0x1e0], xmm9
0000000140004902 and      dword ptr [rbp + 0x210], 0
0000000140004909 mov      rcx, r13
000000014000490c mov      rdx, r12
000000014000490f call     qword ptr [rip + 0xc375b]
0000000140004915 test     eax, eax
0000000140004917 mov      rdi, qword ptr [rbp + 0xbc8]
000000014000491e je       0x140004973
0000000140004920 test     byte ptr [rbp + 0x1e1], 4
0000000140004927 je       0x14000494c
0000000140004929 and      qword ptr [rbp + 0xa48], 0
0000000140004931 mov      rcx, r13
0000000140004934 push     9
0000000140004936 pop      rdx
0000000140004937 lea      r8, [rbp + 0xa48]
000000014000493e push     8
0000000140004940 pop      r9
0000000140004942 call     qword ptr [rip + 0xc3730]
0000000140004948 test     eax, eax
000000014000494a je       0x140004973
000000014000494c mov      esi, dword ptr [rbp + 0x200]
0000000140004952 shl      rsi, 0x20
0000000140004956 jns      0x140004d95
000000014000495c movabs   r15, 0x2600000003
0000000140004966 jmp      0x140004a09
000000014000496b mov      r15, r13
000000014000496e jmp      0x14000427b
0000000140004973 mov      qword ptr [rbp + 0xbd0], r13
000000014000497a call     qword ptr [rip + 0xc36e0]
0000000140004980 shl      rax, 0x20
0000000140004984 or       rax, 2
0000000140004988 mov      qword ptr [rbp + 0x8c8], rax
000000014000498f mov      qword ptr [rbp + 0x8c0], 1
000000014000499a lea      rcx, [rbp + 0x8c8]
00000001400049a1 call     0x14006a7d0
00000001400049a6 nop      
00000001400049a7 and      qword ptr [rbp + 0x8c0], 0
00000001400049af mov      qword ptr [rbp + 0x8c8], 1
00000001400049ba and      qword ptr [rbp + 0x8d0], 0
00000001400049c2 mov      r14b, 1
00000001400049c5 mov      ebx, 0x2000
00000001400049ca xor      esi, esi
00000001400049cc mov      rcx, qword ptr [rbp + 0xbd0]
00000001400049d3 lea      rdx, [rbp + 0x8c0]
00000001400049da call     0x140074840
00000001400049df nop      
00000001400049e0 mov      r15, rdx
00000001400049e3 cmp      rax, 1
00000001400049e7 jne      0x140004a18
00000001400049e9 mov      r13, qword ptr [rbp + 0xbd0]
00000001400049f0 cmp      qword ptr [rbp + 0x8c0], 0
00000001400049f8 je       0x140004a09
00000001400049fa mov      rcx, qword ptr [rbp + 0x8c8]
0000000140004a01 push     1
0000000140004a03 pop      rdx
0000000140004a04 call     0x140005767
0000000140004a09 movabs   rsi, 0x8000000000000000
0000000140004a13 jmp      0x140004bc6
0000000140004a18 mov      rax, r15
0000000140004a1b mov      r15, qword ptr [rbp + 0x8d0]
0000000140004a22 test     rax, rax
0000000140004a25 je       0x140004ba7
0000000140004a2b mov      rdx, qword ptr [rbp + 0x8c0]
0000000140004a32 mov      r13, qword ptr [rbp + 0xbd0]
0000000140004a39 mov      qword ptr [rbp + 0xbd0], r13
0000000140004a40 cmp      r15, rdx
0000000140004a43 jne      0x140004a84
0000000140004a45 cmp      rdx, rsi
0000000140004a48 jne      0x140004a84
0000000140004a4a mov      rcx, r13
0000000140004a4d lea      rdx, [rbp + 0x8c0]
0000000140004a54 call     0x140074840
0000000140004a59 nop      
0000000140004a5a mov      r15, rdx
0000000140004a5d cmp      rax, 1
0000000140004a61 je       0x1400049e9
0000000140004a63 mov      rax, r15
0000000140004a66 mov      r15, qword ptr [rbp + 0x8d0]
0000000140004a6d test     rax, rax
0000000140004a70 je       0x140004ba7
0000000140004a76 mov      rdx, qword ptr [rbp + 0x8c0]
0000000140004a7d mov      r13, qword ptr [rbp + 0xbd0]
0000000140004a84 mov      r8, qword ptr [rbp + 0x8c8]
0000000140004a8b cmp      r15, rdx
0000000140004a8e je       0x140004b52
0000000140004a94 mov      rdi, rdx
0000000140004a97 add      r8, r15
0000000140004a9a mov      rax, rdi
0000000140004a9d sub      rax, r15
0000000140004aa0 cmp      rbx, rax
0000000140004aa3 cmovb    rax, rbx
0000000140004aa7 movdqu   xmm0, xmmword ptr [rip + 0xf19d1]
0000000140004aaf movdqa   xmmword ptr [rbp + 0x1e0], xmm0
0000000140004ab7 mov      ecx, 0xffffffff
0000000140004abc cmp      rax, rcx
0000000140004abf cmovae   rax, rcx
0000000140004ac3 movups   xmmword ptr [rsp + 0x38], xmm9
0000000140004ac9 mov      qword ptr [rsp + 0x28], r8
0000000140004ace mov      qword ptr [rsp + 0x20], r12
0000000140004ad3 mov      dword ptr [rsp + 0x30], eax
0000000140004ad7 mov      rcx, r13
0000000140004ada xor      edx, edx
0000000140004adc xor      r8d, r8d
0000000140004adf xor      r9d, r9d
0000000140004ae2 call     qword ptr [rip + 0xc3908]
0000000140004ae8 cmp      eax, 0x103
0000000140004aed jne      0x140004b01
0000000140004aef mov      rcx, r13
0000000140004af2 push     -1
0000000140004af4 pop      rdx
0000000140004af5 call     qword ptr [rip + 0xc3585]
0000000140004afb mov      eax, dword ptr [rbp + 0x1e0]
0000000140004b01 cmp      eax, 0xc0000011
0000000140004b06 je       0x140004ba0
0000000140004b0c cmp      eax, 0x103
0000000140004b11 je       0x140004fc1
0000000140004b17 test     eax, eax
0000000140004b19 js       0x140004c80
0000000140004b1f mov      rax, qword ptr [rbp + 0x1e8]
0000000140004b26 add      r15, rax
0000000140004b29 mov      qword ptr [rbp + 0x8d0], r15
0000000140004b30 test     rax, rax
0000000140004b33 je       0x140004ccc
0000000140004b39 test     r14b, r14b
0000000140004b3c push     -1
0000000140004b3e pop      rax
0000000140004b3f cmovne   rbx, rax
0000000140004b43 mov      rdx, rdi
0000000140004b46 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004b4d jmp      0x140004a40
0000000140004b52 lea      rax, [rdx + 0x20]
0000000140004b56 lea      rdi, [rdx + rdx]
0000000140004b5a cmp      rax, rdi
0000000140004b5d cmova    rdi, rax
0000000140004b61 push     1
0000000140004b63 pop      rax
0000000140004b64 mov      qword ptr [rsp + 0x28], rax
0000000140004b69 mov      qword ptr [rsp + 0x20], rax
0000000140004b6e mov      rcx, r12
0000000140004b71 mov      r9, rdi
0000000140004b74 call     0x1400c6220
0000000140004b79 cmp      dword ptr [rbp + 0x1e0], 1
0000000140004b80 je       0x140004ce7
0000000140004b86 mov      r8, qword ptr [rbp + 0x1e8]
0000000140004b8d mov      qword ptr [rbp + 0x8c8], r8
0000000140004b94 mov      qword ptr [rbp + 0x8c0], rdi
0000000140004b9b jmp      0x140004a97
0000000140004ba0 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004ba7 mov      r13, qword ptr [rbp + 0xbd0]
0000000140004bae mov      rsi, qword ptr [rbp + 0x8c0]
0000000140004bb5 mov      rax, qword ptr [rbp + 0x8c8]
0000000140004bbc mov      qword ptr [rbp + 0xa28], r15
0000000140004bc3 mov      r15, rax
0000000140004bc6 mov      rcx, r13
0000000140004bc9 call     qword ptr [rip + 0xc3479]
0000000140004bcf mov      rax, rsi
0000000140004bd2 neg      rax
0000000140004bd5 jo       0x140004282
0000000140004bdb mov      rcx, qword ptr [rbp + 0xb40]
0000000140004be2 mov      rdx, qword ptr [rbp + 0xb48]
0000000140004be9 call     0x140016b3a
0000000140004bee mov      qword ptr [rbp + 0xb40], rsi
0000000140004bf5 mov      qword ptr [rbp + 0xb48], r15
0000000140004bfc mov      rax, qword ptr [rbp + 0xa28]
0000000140004c03 mov      qword ptr [rbp + 0xb50], rax
0000000140004c0a mov      rax, qword ptr [rbp + 0xb08]
0000000140004c11 inc      eax
0000000140004c13 mov      qword ptr [rbp + 0xb08], rax
0000000140004c1a jmp      0x1400042ca
0000000140004c1f lea      r15, [rsi + r13]
0000000140004c23 inc      r15
0000000140004c26 push     2
0000000140004c28 pop      rax
0000000140004c29 mov      qword ptr [rsp + 0x28], rax
0000000140004c2e mov      qword ptr [rsp + 0x20], rax
0000000140004c33 lea      rcx, [rbp + 0x8c0]
0000000140004c3a mov      r8, qword ptr [rbp + 0xbd0]
0000000140004c41 mov      r9, r15
0000000140004c44 call     0x1400c6220
0000000140004c49 cmp      byte ptr [rbp + 0x8c0], 0
0000000140004c50 jne      0x140005082
0000000140004c56 mov      rax, qword ptr [rbp + 0x8c8]
0000000140004c5d mov      qword ptr [rbp + 0xbd0], rax
0000000140004c64 mov      qword ptr [rbp + 0xb68], rax
0000000140004c6b mov      qword ptr [rbp + 0xb60], r15
0000000140004c72 jmp      0x140004772
0000000140004c77 mov      cx, 0x5c
0000000140004c7b jmp      0x1400045ff
0000000140004c80 mov      ecx, eax
0000000140004c82 call     qword ptr [rip + 0xc3760]
0000000140004c88 mov      rcx, rax
0000000140004c8b shl      rcx, 0x20
0000000140004c8f or       rcx, 2
0000000140004c93 mov      qword ptr [rbp + 0xa48], 1
0000000140004c9e mov      rsi, rcx
0000000140004ca1 mov      qword ptr [rbp + 0xa50], rcx
0000000140004ca8 mov      ecx, eax
0000000140004caa call     0x1400711e0
0000000140004caf cmp      al, 0xb
0000000140004cb1 jne      0x140004cd8
0000000140004cb3 lea      rcx, [rbp + 0xa50]
0000000140004cba call     0x14006a7d0
0000000140004cbf nop      
0000000140004cc0 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004cc7 jmp      0x140004ba7
0000000140004ccc mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004cd3 jmp      0x140004bae
0000000140004cd8 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004cdf mov      r15, rsi
0000000140004ce2 jmp      0x1400049f0
0000000140004ce7 movabs   r15, 0x2600000003
0000000140004cf1 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004cf8 jmp      0x1400049f0
0000000140004cfd mov      qword ptr [rsp + 0x20], 2
0000000140004d06 lea      rcx, [rbp + 0xb60]
0000000140004d0d xor      edx, edx
0000000140004d0f mov      r8, r13
0000000140004d12 push     2
0000000140004d14 pop      r9
0000000140004d16 call     0x1400c6190
0000000140004d1b nop      
0000000140004d1c mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004d23 mov      r14, qword ptr [rbp + 0xb70]
0000000140004d2a mov      r15, qword ptr [rbp + 0xb60]
0000000140004d31 mov      rax, qword ptr [rbp + 0xb68]
0000000140004d38 mov      qword ptr [rbp + 0xbd0], rax
0000000140004d3f jmp      0x140004799
0000000140004d44 mov      qword ptr [rsp + 0x20], 2
0000000140004d4d lea      rcx, [rbp + 0xb60]
0000000140004d54 mov      rdx, rbx
0000000140004d57 mov      r8, rsi
0000000140004d5a push     2
0000000140004d5c pop      r9
0000000140004d5e call     0x1400c6190
0000000140004d63 nop      
0000000140004d64 mov      rbx, qword ptr [rbp + 0xb70]
0000000140004d6b mov      r15, qword ptr [rbp + 0xb60]
0000000140004d72 mov      rax, qword ptr [rbp + 0xb68]
0000000140004d79 mov      qword ptr [rbp + 0xbd0], rax
0000000140004d80 jmp      0x1400047d9
0000000140004d85 mov      rcx, rdi
0000000140004d88 mov      rdx, rsi
0000000140004d8b call     0x140001b2d
0000000140004d90 jmp      0x140002e98
0000000140004d95 mov      qword ptr [rbp + 0xbd0], r13
0000000140004d9c mov      eax, dword ptr [rbp + 0x204]
0000000140004da2 or       rsi, rax
0000000140004da5 test     rsi, rsi
0000000140004da8 je       0x140004de7
0000000140004daa xor      ecx, ecx
0000000140004dac mov      rdx, rsi
0000000140004daf call     0x14006f3a0
0000000140004db4 test     rax, rax
0000000140004db7 jne      0x140004dec
0000000140004db9 movabs   r15, 0x2600000003
0000000140004dc3 movabs   rsi, 0x8000000000000000
0000000140004dcd lea      r12, [rbp + 0x1e0]
0000000140004dd4 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004ddb mov      r13, qword ptr [rbp + 0xbd0]
0000000140004de2 jmp      0x140004bc6
0000000140004de7 xor      esi, esi
0000000140004de9 push     1
0000000140004deb pop      rax
0000000140004dec mov      qword ptr [rbp + 0x8c0], rsi
0000000140004df3 mov      qword ptr [rbp + 0x8c8], rax
0000000140004dfa and      qword ptr [rbp + 0x8d0], 0
0000000140004e02 lea      rax, [rsi + 0x400]
0000000140004e09 mov      ecx, eax
0000000140004e0b and      ecx, 0x1fff
0000000140004e11 mov      rbx, rsi
0000000140004e14 sub      rbx, rcx
0000000140004e17 add      rbx, 0x2400
0000000140004e1e cmp      rbx, rax
0000000140004e21 mov      edx, 0x2000
0000000140004e26 cmovb    rbx, rdx
0000000140004e2a test     rcx, rcx
0000000140004e2d cmove    rbx, rax
0000000140004e31 xor      r14d, r14d
0000000140004e34 test     rsi, rsi
0000000140004e37 je       0x140004e52
0000000140004e39 mov      rdx, rsi
0000000140004e3c xor      r15d, r15d
0000000140004e3f lea      r12, [rbp + 0x1e0]
0000000140004e46 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004e4d jmp      0x140004a32
0000000140004e52 lea      r12, [rbp + 0x1e0]
0000000140004e59 mov      rdi, qword ptr [rbp + 0xbc8]
0000000140004e60 jmp      0x1400049cc
0000000140004e65 lea      rcx, [rbp + 0x750]
0000000140004e6c call     0x140001641
0000000140004e71 mov      rcx, qword ptr [rbp + 0xac0]
0000000140004e78 mov      rdx, qword ptr [rbp + 0xba8]
0000000140004e7f call     0x140016b3a
0000000140004e84 mov      rcx, qword ptr [rbp + 0xab0]
0000000140004e8b mov      rdx, qword ptr [rbp + 0xb00]
0000000140004e92 call     0x140016b3a
0000000140004e97 mov      rcx, qword ptr [rbp + 0xab8]
0000000140004e9e mov      rdx, qword ptr [rbp + 0xb18]
0000000140004ea5 call     0x140016b3a
0000000140004eaa lea      rcx, [rbp + 0x9c0]
0000000140004eb1 call     0x14000157c
0000000140004eb6 lea      rcx, [rbp + 0x8a0]
0000000140004ebd call     0x140001498
0000000140004ec2 mov      rcx, qword ptr [rbp + 0xb20]
0000000140004ec9 mov      rdx, qword ptr [rbp + 0xb28]
0000000140004ed0 call     0x140016b3a
0000000140004ed5 movaps   xmm6, xmmword ptr [rbp + 0xbe0]
0000000140004edc movaps   xmm7, xmmword ptr [rbp + 0xbf0]
0000000140004ee3 movaps   xmm8, xmmword ptr [rbp + 0xc00]
0000000140004eeb movaps   xmm9, xmmword ptr [rbp + 0xc10]
0000000140004ef3 movaps   xmm10, xmmword ptr [rbp + 0xc20]
0000000140004efb movaps   xmm11, xmmword ptr [rbp + 0xc30]
0000000140004f03 add      rsp, 0xcc8
0000000140004f0a pop      rbx
0000000140004f0b pop      rdi
0000000140004f0c pop      rsi
0000000140004f0d pop      r12
0000000140004f0f pop      r13
0000000140004f11 pop      r14
0000000140004f13 pop      r15
0000000140004f15 pop      rbp
0000000140004f16 ret      
0000000140004f17 lea      rcx, [rip + 0xc4252]
0000000140004f1e jmp      0x140004f27
0000000140004f20 lea      rcx, [rip + 0xc4261]
0000000140004f27 call     0x1400c3cf0
0000000140004f2c ud2      
0000000140004f2e lea      rcx, [rip + 0xf2153]
0000000140004f35 lea      r8, [rip + 0xf21e4]
0000000140004f3c push     0x34
0000000140004f3e jmp      0x140004f50
0000000140004f40 lea      rcx, [rip + 0xf21f1]
0000000140004f47 lea      r8, [rip + 0xf2222]
0000000140004f4e push     0x35
0000000140004f50 pop      rdx
0000000140004f51 call     0x1400c3d10
0000000140004f56 ud2      
0000000140004f58 mov      rcx, qword ptr [rbp + 0xbb0]
0000000140004f5f mov      rdx, qword ptr [rbp + 0xbc8]
0000000140004f66 call     0x1400807e2
0000000140004f6b test     rbx, rbx
0000000140004f6e lea      rsi, [rip + 0xf324b]
0000000140004f75 cmovne   rsi, rbx
0000000140004f79 lea      r8, [rbp + 0x1e0]
0000000140004f80 mov      qword ptr [r8], rsi
0000000140004f83 lea      rax, [rip + 0xf3626]
0000000140004f8a mov      qword ptr [rsp + 0x20], rax
0000000140004f8f lea      rcx, [rip + 0x105efd]
0000000140004f96 lea      r9, [rip + 0xf34c3]
0000000140004f9d push     0x2b
0000000140004f9f pop      rdx
0000000140004fa0 call     0x1400c3e10
0000000140004fa5 ud2      
0000000140004fa7 lea      r9, [rip + 0xf08da]
0000000140004fae xor      ecx, ecx
0000000140004fb0 mov      rdx, rsi
0000000140004fb3 mov      r8, rbx
0000000140004fb6 call     0x1400c3c30
0000000140004fbb nop      
0000000140004fbc jmp      0x140005096
0000000140004fc1 lea      rcx, [rbp + 0x860]
0000000140004fc8 and      dword ptr [rcx], 0
0000000140004fcb mov      byte ptr [rcx + 4], 0
0000000140004fcf lea      rdx, [rip + 0xf14ba]
0000000140004fd6 mov      r8d, 0xab
0000000140004fdc call     0x14006a600
0000000140004fe1 nop      
0000000140004fe2 lea      rcx, [rbp + 0xb60]
0000000140004fe9 mov      qword ptr [rcx], rax
0000000140004fec call     0x14006a6b0
0000000140004ff1 nop      
0000000140004ff2 push     7
0000000140004ff4 pop      rcx
0000000140004ff5 int      0x29
0000000140004ff7 ud2      
0000000140004ff9 call     qword ptr [rip + 0xc3291]
0000000140004fff shl      rax, 0x20
0000000140005003 or       rax, 2
0000000140005007 jmp      0x14000506c
0000000140005009 lea      rcx, [rbp + 0x5e0]
0000000140005010 call     0x140080f7a
0000000140005015 lea      rcx, [rbp + 0xa48]
000000014000501c call     0x140080d01
0000000140005021 lea      r8, [rbp + 0x1e0]
0000000140005028 mov      qword ptr [r8], rsi
000000014000502b lea      rax, [rip + 0xf3216]
0000000140005032 mov      qword ptr [rsp + 0x20], rax
0000000140005037 lea      rcx, [rip + 0xf319a]
000000014000503e lea      r9, [rip + 0xf341b]
0000000140005045 push     0x16
0000000140005047 jmp      0x140004f9f
000000014000504c lea      rcx, [rip + 0x106348]
0000000140005053 lea      r8, [rip + 0xf0846]
000000014000505a push     0x28
000000014000505c pop      rdx
000000014000505d call     0x1400c3d10
0000000140005062 nop      
0000000140005063 jmp      0x140005096
0000000140005065 lea      rax, [rip + 0xf212c]
000000014000506c lea      r8, [rbp + 0x1e0]
0000000140005073 mov      qword ptr [r8], rax
0000000140005076 lea      rax, [rip + 0xf354b]
000000014000507d jmp      0x140004f8a
0000000140005082 mov      rcx, qword ptr [rbp + 0x8c8]
0000000140005089 mov      rdx, qword ptr [rbp + 0x8d0]
0000000140005090 call     0x1400c389e
0000000140005095 nop      
0000000140005096 ud2      
