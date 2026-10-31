[2K503: fcn.140001ca0 (int64_t arg1);
0x140001ca0      4053           push rbx
0x140001ca2      4881ece00200.  sub rsp, 0x2e0
0x140001ca9      488b05504300.  mov rax, qword [section..data]         ; [0x140006000:8]=0x2b992ddfa232 ; "2\xa2\xdf-\x99+"
0x140001cb0      4833c4         xor rax, rsp
0x140001cb3      48898424d002.  mov qword [var_2d0h], rax
0x140001cbb      488bd9         mov rbx, rcx                           ; arg1
0x140001cbe      488d542430     lea rdx, [var_30h]
0x140001cc3      b902020000     mov ecx, 0x202                         ; 514
0x140001cc8      ff150a250000   call qword [sym.imp.WS2_32.dll_Ordinal_115] ; [0x1400041d8:8]=0x8000000000000073 ; "s"
0x140001cce      85c0           test eax, eax
0x140001cd0      740a           je 0x140001cdc
0x140001cd2      b801000000     mov eax, 1
0x140001cd7      e9a2010000     jmp 0x140001e7e
0x140001cdc      4889b424f802.  mov qword [var_2f8h], rsi
0x140001ce4      ba01000000     mov edx, 1
0x140001ce9      be02000000     mov esi, 2
0x140001cee      4889bc240003.  mov qword [var_300h], rdi
0x140001cf6      8bce           mov ecx, esi
0x140001cf8      41b806000000   mov r8d, 6
0x140001cfe      ff15b4240000   call qword [sym.imp.WS2_32.dll_Ordinal_23] ; [0x1400041b8:8]=0x8000000000000017
0x140001d04      488bf8         mov rdi, rax
0x140001d07      4883f8ff       cmp rax, 0xffffffffffffffff
0x140001d0b      0f8452010000   je 0x140001e63
0x140001d11      b9697a0000     mov ecx, 0x7a69                        ; 'iz'
0x140001d16      6689742420     mov word [var_20h], si
0x140001d1b      ff1577240000   call qword [sym.imp.WS2_32.dll_Ordinal_9] ; [0x140004198:8]=0x8000000000000009 ; "\t"
0x140001d21      4c8d442424     lea r8, [var_24h]
0x140001d26      8bce           mov ecx, esi
0x140001d28      488d15f12700.  lea rdx, str.127.0.0.1                 ; 0x140004520 ; "127.0.0.1"
0x140001d2f      6689442422     mov word [var_22h], ax
0x140001d34      ff1566240000   call qword [sym.imp.WS2_32.dll_inet_pton] ; [0x1400041a0:8]=0x5412 reloc.WS2_32.dll_inet_pton
0x140001d3a      41b810000000   mov r8d, 0x10                          ; reloc.ws2_32_Ordinal_16
0x140001d40      488d542420     lea rdx, [var_20h]
0x140001d45      488bcf         mov rcx, rdi
0x140001d48      ff157a240000   call qword [sym.imp.WS2_32.dll_Ordinal_2] ; [0x1400041c8:8]=0x8000000000000002
0x140001d4e      83f8ff         cmp eax, 0xffffffff
0x140001d51      0f8403010000   je 0x140001e5a
0x140001d57      baffffff7f     mov edx, 0x7fffffff
0x140001d5c      488bcf         mov rcx, rdi
0x140001d5f      ff157b240000   call qword [sym.imp.WS2_32.dll_Ordinal_13] ; [0x1400041e0:8]=0x800000000000000d ; "\r"
0x140001d65      83f8ff         cmp eax, 0xffffffff
0x140001d68      0f84ec000000   je 0x140001e5a
0x140001d6e      4533c0         xor r8d, r8d
0x140001d71      33d2           xor edx, edx
0x140001d73      488bcf         mov rcx, rdi
0x140001d76      ff1534240000   call qword [sym.imp.WS2_32.dll_Ordinal_1] ; [0x1400041b0:8]=0x8000000000000001
0x140001d7c      488bf0         mov rsi, rax
0x140001d7f      4883f8ff       cmp rax, 0xffffffffffffffff
0x140001d83      0f84be000000   je 0x140001e47
0x140001d89      33d2           xor edx, edx
0x140001d8b      488d8c24d001.  lea rcx, [var_1d0h]
0x140001d93      41b800010000   mov r8d, 0x100                         ; 256
0x140001d99      e834160000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140001d9e      4533c9         xor r9d, r9d
0x140001da1      488d9424d001.  lea rdx, [var_1d0h]
0x140001da9      41b8ff000000   mov r8d, 0xff                          ; 255
0x140001daf      488bce         mov rcx, rsi
0x140001db2      ff1508240000   call qword [sym.imp.WS2_32.dll_Ordinal_16] ; [0x1400041c0:8]=0x8000000000000010
0x140001db8      83f808         cmp eax, 8                             ; 8
0x140001dbb      0f8e7d000000   jle 0x140001e3e
0x140001dc1      41b809000000   mov r8d, 9
0x140001dc7      488d15622700.  lea rdx, str.OVERRIDE:                 ; 0x140004530 ; "OVERRIDE:"
0x140001dce      488d8c24d001.  lea rcx, [var_1d0h]
0x140001dd6      ff151c250000   call qword [sym.imp.api_ms_win_crt_string_l1_1_0.dll_strncmp] ; [0x1400042f8:8]=0x54f2 reloc.api_ms_win
0x140001ddc      85c0           test eax, eax
0x140001dde      755e           jne 0x140001e3e
0x140001de0      488b5308       mov rdx, qword [rbx + 8]
0x140001de4      4c8d8424d901.  lea r8, [var_1d9h]
0x140001dec      488b0b         mov rcx, qword [rbx]
0x140001def      49c7c1ffffff.  mov r9, 0xffffffffffffffff
0x140001df6      ff1504250000   call qword [sym.imp.api_ms_win_crt_string_l1_1_0.dll_strncpy_s] ; [0x140004300:8]=0x54cc reloc.api_ms_w
0x140001dfc      488b0b         mov rcx, qword [rbx]
0x140001dff      33d2           xor edx, edx
0x140001e01      48c7c0ffffff.  mov rax, 0xffffffffffffffff
0x140001e08      48ffc0         inc rax
0x140001e0b      381401         cmp byte [rcx + rax], dl
0x140001e0e      75f8           jne 0x140001e08
0x140001e10      4885c0         test rax, rax
0x140001e13      7429           je 0x140001e3e
0x140001e15      80341133       xor byte [rcx + rdx], 0x33             ; [0x33:1]=255 ; 51
0x140001e19      488b03         mov rax, qword [rbx]
0x140001e1c      80041005       add byte [rax + rdx], 5
0x140001e20      48c7c0ffffff.  mov rax, 0xffffffffffffffff
0x140001e27      488b0b         mov rcx, qword [rbx]
0x140001e2a      48ffc2         inc rdx
0x140001e2d      0f1f00         nop dword [rax]
0x140001e30      48ffc0         inc rax
0x140001e33      803c0100       cmp byte [rcx + rax], 0
0x140001e37      75f7           jne 0x140001e30
0x140001e39      483bd0         cmp rdx, rax
0x140001e3c      72d7           jb 0x140001e15
0x140001e3e      488bce         mov rcx, rsi
0x140001e41      ff1589230000   call qword [sym.imp.WS2_32.dll_Ordinal_3] ; [0x1400041d0:8]=0x8000000000000003
0x140001e47      488bcf         mov rcx, rdi
0x140001e4a      ff1580230000   call qword [sym.imp.WS2_32.dll_Ordinal_3] ; [0x1400041d0:8]=0x8000000000000003
0x140001e50      ff1552230000   call qword [sym.imp.WS2_32.dll_Ordinal_116] ; [0x1400041a8:8]=0x8000000000000074 ; "t"
0x140001e56      33c0           xor eax, eax
0x140001e58      eb14           jmp 0x140001e6e
0x140001e5a      488bcf         mov rcx, rdi
0x140001e5d      ff156d230000   call qword [sym.imp.WS2_32.dll_Ordinal_3] ; [0x1400041d0:8]=0x8000000000000003
0x140001e63      ff153f230000   call qword [sym.imp.WS2_32.dll_Ordinal_116] ; [0x1400041a8:8]=0x8000000000000074 ; "t"
0x140001e69      b801000000     mov eax, 1
0x140001e6e      488bb424f802.  mov rsi, qword [var_2f8h]
0x140001e76      488bbc240003.  mov rdi, qword [var_300h]
0x140001e7e      488b8c24d002.  mov rcx, qword [var_2d0h]
0x140001e86      4833cc         xor rcx, rsp
0x140001e89      e882080000     call fcn.140002710
0x140001e8e      4881c4e00200.  add rsp, 0x2e0
0x140001e95      5b             pop rbx
0x140001e96      c3             ret
697: fcn.140001860 (int64_t arg1);
0x140001860      48895c2410     mov qword [var_10h], rbx
0x140001865      57             push rdi
0x140001866      4881ec100200.  sub rsp, 0x210
0x14000186d      488b058c4700.  mov rax, qword [section..data]         ; [0x140006000:8]=0x2b992ddfa232 ; "2\xa2\xdf-\x99+"
0x140001874      4833c4         xor rax, rsp
0x140001877      488984240002.  mov qword [var_200h], rax
0x14000187f      660f6f05092e.  movdqa xmm0, xmmword [0x140004690]
0x140001887      488d542454     lea rdx, [var_54h]
0x14000188c      660f6f1dcc2d.  movdqa xmm3, xmmword [0x140004660]
0x140001894      488bf9         mov rdi, rcx                           ; arg1
0x140001897      660f6f25d12d.  movdqa xmm4, xmmword [0x140004670]
0x14000189f      b908000000     mov ecx, 8
0x1400018a4      660f7f442440   movdqa xmmword [var_40h], xmm0
0x1400018aa      448b442440     mov r8d, dword [var_40h]
0x1400018af      c7442430efbe.  mov dword [var_30h], 0xdeadbeef        ; [0xdeadbeef:4]=-1
0x1400018b7      660f1f840000.  nop word [rax + rax]
0x1400018c0      8d41f8         lea eax, [rcx - 8]
0x1400018c3      66410f6ec0     movd xmm0, r8d
0x1400018c8      660f6ec8       movd xmm1, eax
0x1400018cc      488d5210       lea rdx, [rdx + 0x10]
0x1400018d0      660f70c900     pshufd xmm1, xmm1, 0
0x1400018d5      8d41fc         lea eax, [rcx - 4]
0x1400018d8      660ffecb       paddd xmm1, xmm3
0x1400018dc      660f6ed0       movd xmm2, eax
0x1400018e0      660f70d200     pshufd xmm2, xmm2, 0
0x1400018e5      8d4104         lea eax, [rcx + 4]
0x1400018e8      660ffed3       paddd xmm2, xmm3
0x1400018ec      0f54cc         andps xmm1, xmm4
0x1400018ef      0f54d4         andps xmm2, xmm4
0x1400018f2      660f67c9       packuswb xmm1, xmm1
0x1400018f6      660f67d2       packuswb xmm2, xmm2
0x1400018fa      660f67c9       packuswb xmm1, xmm1
0x1400018fe      0f57c8         xorps xmm1, xmm0
0x140001901      660f67d2       packuswb xmm2, xmm2
0x140001905      660f7e4aec     movd dword [rdx - 0x14], xmm1
0x14000190a      66410f6ec0     movd xmm0, r8d
0x14000190f      0f57d0         xorps xmm2, xmm0
0x140001912      660f6ec9       movd xmm1, ecx
0x140001916      660f7e52f0     movd dword [rdx - 0x10], xmm2
0x14000191b      83c110         add ecx, 0x10                          ; reloc.ws2_32_Ordinal_16
0x14000191e      660f70c900     pshufd xmm1, xmm1, 0
0x140001923      660ffecb       paddd xmm1, xmm3
0x140001927      660f6ed0       movd xmm2, eax
0x14000192b      660f70d200     pshufd xmm2, xmm2, 0
0x140001930      0f54cc         andps xmm1, xmm4
0x140001933      660ffed3       paddd xmm2, xmm3
0x140001937      660f67c9       packuswb xmm1, xmm1
0x14000193b      0f54d4         andps xmm2, xmm4
0x14000193e      66410f6ec0     movd xmm0, r8d
0x140001943      660f67d2       packuswb xmm2, xmm2
0x140001947      8d41f8         lea eax, [rcx - 8]
0x14000194a      660f67c9       packuswb xmm1, xmm1
0x14000194e      660f67d2       packuswb xmm2, xmm2
0x140001952      0f57c8         xorps xmm1, xmm0
0x140001955      660f7e4af4     movd dword [rdx - 0xc], xmm1
0x14000195a      66410f6ec0     movd xmm0, r8d
0x14000195f      0f57d0         xorps xmm2, xmm0
0x140001962      660f7e52f8     movd dword [rdx - 8], xmm2
0x140001967      3d00010000     cmp eax, 0x100                         ; 256
0x14000196c      0f8c4effffff   jl 0x1400018c0
0x140001972      33db           xor ebx, ebx
0x140001974      8bcb           mov ecx, ebx
0x140001976      66660f1f8400.  nop word [rax + rax]
0x140001980      8b442430       mov eax, dword [var_30h]
0x140001984      4c8d442450     lea r8, [var_50h]
0x140001989      4469d1371300.  imul r10d, ecx, 0x1337
0x140001990      4433d0         xor r10d, eax
0x140001993      b881808080     mov eax, 0x80808081
0x140001998      41c1ca1b       ror r10d, 0x1b
0x14000199c      41f7e2         mul r10d
0x14000199f      c1ea07         shr edx, 7
0x1400019a2      69c2ff000000   imul eax, edx, 0xff
0x1400019a8      418bd2         mov edx, r10d
0x1400019ab      2bd0           sub edx, eax
0x1400019ad      8b442430       mov eax, dword [var_30h]
0x1400019b1      33d0           xor edx, eax
0x1400019b3      418d040a       lea eax, [r10 + rcx]
0x1400019b7      89542430       mov dword [var_30h], edx
0x1400019bb      0fb6d1         movzx edx, cl
0x1400019be      ffc1           inc ecx
0x1400019c0      4c03c2         add r8, rdx
0x1400019c3      0fb6d0         movzx edx, al
0x1400019c6      0fb6441450     movzx eax, byte [rsp + rdx + 0x50]
0x1400019cb      450fb608       movzx r9d, byte [r8]
0x1400019cf      418800         mov byte [r8], al
0x1400019d2      44884c1450     mov byte [rsp + rdx + 0x50], r9b
0x1400019d7      81f910270000   cmp ecx, 0x2710
0x1400019dd      7ca1           jl 0x140001980
0x1400019df      488d8c245001.  lea rcx, [var_150h]
0x1400019e7      ff158b260000   call qword [sym.imp.KERNEL32.dll_GetSystemInfo] ; [0x140004078:8]=0x52f0 reloc.KERNEL32.dll_GetSystemIn
0x1400019ed      8b442430       mov eax, dword [var_30h]
0x1400019f1      038424700100.  add eax, dword [var_170h]
0x1400019f8      89442430       mov dword [var_30h], eax
0x1400019fc      8b4c2430       mov ecx, dword [var_30h]
0x140001a00      0fb784245001.  movzx eax, word [var_150h]
0x140001a08      33c8           xor ecx, eax
0x140001a0a      c78424800100.  mov dword [var_180h], 0x40             ; '@'
                                                                       ; [0x40:4]=-1 ; 64
0x140001a15      894c2430       mov dword [var_30h], ecx
0x140001a19      488d8c248001.  lea rcx, [var_180h]
0x140001a21      ff1581260000   call qword [sym.imp.KERNEL32.dll_GlobalMemoryStatusEx] ; [0x1400040a8:8]=0x535c reloc.KERNEL32.dll_Glob
0x140001a27      85c0           test eax, eax
0x140001a29      7437           je 0x140001a62
0x140001a2b      488b8c248801.  mov rcx, qword [var_188h]
0x140001a33      48b847088f36.  movabs rax, 0x4f8b588e368f0847
0x140001a3d      48f7e1         mul rcx
0x140001a40      488bc1         mov rax, rcx
0x140001a43      482bc2         sub rax, rdx
0x140001a46      48d1e8         shr rax, 1
0x140001a49      4803c2         add rax, rdx
0x140001a4c      48c1e810       shr rax, 0x10
0x140001a50      69c0a0860100   imul eax, eax, 0x186a0
0x140001a56      2bc8           sub ecx, eax
0x140001a58      8b442430       mov eax, dword [var_30h]
0x140001a5c      03c1           add eax, ecx
0x140001a5e      89442430       mov dword [var_30h], eax
0x140001a62      ff1560260000   call qword [sym.imp.KERNEL32.dll_GetTickCount] ; [0x1400040c8:8]=0x53ae reloc.KERNEL32.dll_GetTickCount
0x140001a68      4c8d05892a00.  lea r8, str.Telemetry__u__x            ; 0x1400044f8 ; "Telemetry_%u_%x"
0x140001a6f      ba40000000     mov edx, 0x40                          ; '@' ; 64
0x140001a74      448bc8         mov r9d, eax
0x140001a77      488d8c24c001.  lea rcx, [var_1c0h]
0x140001a7f      8b442430       mov eax, dword [var_30h]
0x140001a83      89442420       mov dword [var_20h], eax
0x140001a87      e844f6ffff     call fcn.1400010d0
0x140001a8c      833dd54b0000.  cmp dword [0x140006668], 1             ; [0x140006668:4]=0
0x140001a93      752b           jne 0x140001ac0
0x140001a95      4c8b4710       mov r8, qword [rdi + 0x10]
0x140001a99      488b5708       mov rdx, qword [rdi + 8]
0x140001a9d      488b0f         mov rcx, qword [rdi]
0x140001aa0      e88bf6ffff     call fcn.140001130
0x140001aa5      4c8b4f20       mov r9, qword [rdi + 0x20]
0x140001aa9      4c8b4710       mov r8, qword [rdi + 0x10]
0x140001aad      488b5728       mov rdx, qword [rdi + 0x28]
0x140001ab1      488b4f18       mov rcx, qword [rdi + 0x18]
0x140001ab5      e816f6ffff     call fcn.1400010d0
0x140001aba      660f1f440000   nop word [rax + rax]
0x140001ac0      f30f6f442450   movdqu xmm0, xmmword [var_50h]
0x140001ac6      b904000000     mov ecx, 4
0x140001acb      0f578424c001.  xorps xmm0, xmmword [var_1c0h]
0x140001ad3      f30f7f8424c0.  movdqu xmmword [var_1c0h], xmm0
0x140001adc      0f1f4000       nop dword [rax]
0x140001ae0      0fb6441c60     movzx eax, byte [rsp + rbx + 0x60]
0x140001ae5      30841cd00100.  xor byte [rsp + rbx + 0x1d0], al
0x140001aec      488d5b01       lea rbx, [rbx + 1]
0x140001af0      4883e901       sub rcx, 1
0x140001af4      75ea           jne 0x140001ae0
0x140001af6      33c0           xor eax, eax
0x140001af8      488b8c240002.  mov rcx, qword [var_200h]
0x140001b00      4833cc         xor rcx, rsp
0x140001b03      e8080c0000     call fcn.140002710
0x140001b08      488b9c242802.  mov rbx, qword [var_10h]
0x140001b10      4881c4100200.  add rsp, 0x210
0x140001b17      5f             pop rdi
0x140001b18      c3             ret
384: fcn.140001b20 (int64_t arg1, int64_t arg2, int64_t arg3, int64_t arg4);
0x140001b20      48895c2408     mov qword [var_8h], rbx
0x140001b25      48896c2410     mov qword [var_10h], rbp
0x140001b2a      4889742418     mov qword [var_18h], rsi
0x140001b2f      57             push rdi
0x140001b30      4883ec20       sub rsp, 0x20
0x140001b34      8bda           mov ebx, edx                           ; arg2
0x140001b36      81fa81000000   cmp edx, 0x81                          ; 129 ; arg2
0x140001b3c      baebffffff     mov edx, 0xffffffeb                    ; 4294967275
0x140001b41      498bf1         mov rsi, r9                            ; arg4
0x140001b44      498be8         mov rbp, r8                            ; arg3
0x140001b47      488bf9         mov rdi, rcx                           ; arg1
0x140001b4a      7513           jne 0x140001b5f
0x140001b4c      4d8b01         mov r8, qword [r9]
0x140001b4f      ff15eb250000   call qword [sym.imp.USER32.dll_SetWindowLongPtrW] ; [0x140004140:8]=0x53e0 reloc.USER32.dll_SetWindowLo
0x140001b55      b801000000     mov eax, 1
0x140001b5a      e92c010000     jmp 0x140001c8b
0x140001b5f      ff15e3250000   call qword [sym.imp.USER32.dll_GetWindowLongPtrW] ; [0x140004148:8]=0x53cc reloc.USER32.dll_GetWindowLo
0x140001b65      4c8bc8         mov r9, rax
0x140001b68      4533c0         xor r8d, r8d
0x140001b6b      418bc0         mov eax, r8d
0x140001b6e      4d85c9         test r9, r9
0x140001b71      7408           je 0x140001b7b
0x140001b73      418b4120       mov eax, dword [r9 + 0x20]
0x140001b77      41895920       mov dword [r9 + 0x20], ebx
0x140001b7b      440fb6db       movzx r11d, bl
0x140001b7f      4432d8         xor r11b, al
0x140001b82      83fb01         cmp ebx, 1                             ; reloc.ws2_32_Ordinal_1
0x140001b85      7416           je 0x140001b9d
0x140001b87      4c8bce         mov r9, rsi
0x140001b8a      4c8bc5         mov r8, rbp
0x140001b8d      8bd3           mov edx, ebx
0x140001b8f      488bcf         mov rcx, rdi
0x140001b92      ff15b8250000   call qword [sym.imp.USER32.dll_DefWindowProcW] ; [0x140004150:8]=0x53f4 reloc.USER32.dll_DefWindowProcW
0x140001b98      e9ee000000     jmp 0x140001c8b
0x140001b9d      4d85c9         test r9, r9
0x140001ba0      0f84de000000   je 0x140001c84
0x140001ba6      498b4118       mov rax, qword [r9 + 0x18]
0x140001baa      49394110       cmp qword [r9 + 0x10], rax
0x140001bae      0f8680000000   jbe 0x140001c34
0x140001bb4      498b11         mov rdx, qword [r9]
0x140001bb7      48c7c0ffffff.  mov rax, 0xffffffffffffffff
0x140001bbe      6690           nop
0x140001bc0      48ffc0         inc rax
0x140001bc3      44380402       cmp byte [rdx + rax], r8b
0x140001bc7      75f7           jne 0x140001bc0
0x140001bc9      4885c0         test rax, rax
0x140001bcc      7429           je 0x140001bf7
0x140001bce      4d8bd0         mov r10, r8
0x140001bd1      45301c12       xor byte [r10 + rdx], r11b
0x140001bd5      4d8d5201       lea r10, [r10 + 1]
0x140001bd9      498b11         mov rdx, qword [r9]
0x140001bdc      41ffc0         inc r8d
0x140001bdf      48c7c0ffffff.  mov rax, 0xffffffffffffffff
0x140001be6      48ffc0         inc rax
0x140001be9      803c0200       cmp byte [rdx + rax], 0
0x140001bed      75f7           jne 0x140001be6
0x140001bef      4963c8         movsxd rcx, r8d
0x140001bf2      483bc8         cmp rcx, rax
0x140001bf5      72da           jb 0x140001bd1
0x140001bf7      80328b         xor byte [rdx], 0x8b                   ; [0x8b:1]=255 ; 139
0x140001bfa      8072018f       xor byte [rdx + 1], 0x8f               ; [0x8f:1]=255 ; 143
0x140001bfe      80720292       xor byte [rdx + 2], 0x92               ; [0x92:1]=255 ; 146
0x140001c02      80720385       xor byte [rdx + 3], 0x85               ; [0x85:1]=255 ; 133
0x140001c06      80720488       xor byte [rdx + 4], 0x88               ; [0x88:1]=255 ; 136
0x140001c0a      80720596       xor byte [rdx + 5], 0x96               ; [0x96:1]=255 ; 150
0x140001c0e      80720698       xor byte [rdx + 6], 0x98               ; [0x98:1]=255 ; 152
0x140001c12      8072079b       xor byte [rdx + 7], 0x9b               ; [0x9b:1]=255 ; 155
0x140001c16      80720894       xor byte [rdx + 8], 0x94               ; [0x94:1]=255 ; 148
0x140001c1a      8072098b       xor byte [rdx + 9], 0x8b               ; [0x8b:1]=255 ; 139
0x140001c1e      80720a95       xor byte [rdx + 0xa], 0x95             ; [0x95:1]=255 ; 149
0x140001c22      80720be6       xor byte [rdx + 0xb], 0xe6             ; [0xe6:1]=255 ; 230
0x140001c26      80720ced       xor byte [rdx + 0xc], 0xed             ; [0xed:1]=255 ; 237
0x140001c2a      80720df0       xor byte [rdx + 0xd], 0xf0             ; [0xf0:1]=255 ; 240
0x140001c2e      80720ee7       xor byte [rdx + 0xe], 0xe7             ; [0xe7:1]=255 ; 231
0x140001c32      eb50           jmp 0x140001c84
0x140001c34      498b4908       mov rcx, qword [r9 + 8]
0x140001c38      80318b         xor byte [rcx], 0x8b                   ; [0x8b:1]=255 ; 139
0x140001c3b      8071018f       xor byte [rcx + 1], 0x8f               ; [0x8f:1]=255 ; 143
0x140001c3f      80710292       xor byte [rcx + 2], 0x92               ; [0x92:1]=255 ; 146
0x140001c43      80710385       xor byte [rcx + 3], 0x85               ; [0x85:1]=255 ; 133
0x140001c47      80710488       xor byte [rcx + 4], 0x88               ; [0x88:1]=255 ; 136
0x140001c4b      80710596       xor byte [rcx + 5], 0x96               ; [0x96:1]=255 ; 150
0x140001c4f      80710698       xor byte [rcx + 6], 0x98               ; [0x98:1]=255 ; 152
0x140001c53      8071079b       xor byte [rcx + 7], 0x9b               ; [0x9b:1]=255 ; 155
0x140001c57      80710894       xor byte [rcx + 8], 0x94               ; [0x94:1]=255 ; 148
0x140001c5b      8071098b       xor byte [rcx + 9], 0x8b               ; [0x8b:1]=255 ; 139
0x140001c5f      80710a95       xor byte [rcx + 0xa], 0x95             ; [0x95:1]=255 ; 149
0x140001c63      80710be6       xor byte [rcx + 0xb], 0xe6             ; [0xe6:1]=255 ; 230
0x140001c67      80710ced       xor byte [rcx + 0xc], 0xed             ; [0xed:1]=255 ; 237
0x140001c6b      80710df0       xor byte [rcx + 0xd], 0xf0             ; [0xf0:1]=255 ; 240
0x140001c6f      80710ee7       xor byte [rcx + 0xe], 0xe7             ; [0xe7:1]=255 ; 231
0x140001c73      488d0d8e2800.  lea rcx, str.SESSION_TOKEN_CACHE       ; 0x140004508 ; "SESSION_TOKEN_CACHE"
0x140001c7a      498b5108       mov rdx, qword [r9 + 8]
0x140001c7e      ff151c240000   call qword [sym.imp.KERNEL32.dll_SetEnvironmentVariableA] ; [0x1400040a0:8]=0x5342 reloc.KERNEL32.dll_S
0x140001c84      48c7c0ffffff.  mov rax, 0xffffffffffffffff
0x140001c8b      488b5c2430     mov rbx, qword [var_8h]
0x140001c90      488b6c2438     mov rbp, qword [var_10h]
0x140001c95      488b742440     mov rsi, qword [var_18h]
0x140001c9a      4883c420       add rsp, 0x20
0x140001c9e      5f             pop rdi
0x140001c9f      c3             ret
