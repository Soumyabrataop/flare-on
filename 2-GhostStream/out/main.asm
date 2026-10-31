[2K2132: int main (int argc, char **argv, char **envp);
0x140001ea0      48895c2418     mov qword [var_18h], rbx
0x140001ea5      48897c2420     mov qword [var_20h], rdi
0x140001eaa      55             push rbp
0x140001eab      488dac2460f9.  lea rbp, [rsp - 0x6a0]
0x140001eb3      4881eca00700.  sub rsp, 0x7a0
0x140001eba      488b053f4100.  mov rax, qword [section..data]         ; [0x140006000:8]=0x2b992ddfa232 ; "2\xa2\xdf-\x99+"
0x140001ec1      4833c4         xor rax, rsp
0x140001ec4      488985900600.  mov qword [var_690h], rax
0x140001ecb      33d2           xor edx, edx                           ; int c
0x140001ecd      488d8d700100.  lea rcx, [s]                           ; void *s
0x140001ed4      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x140001eda      e8f3140000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140001edf      33d2           xor edx, edx                           ; int c
0x140001ee1      488d8d700200.  lea rcx, [var_270h]                    ; void *s
0x140001ee8      41b804010000   mov r8d, 0x104                         ; 260 ; size_t n
0x140001eee      e8df140000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140001ef3      33d2           xor edx, edx                           ; int c
0x140001ef5      488d8d800300.  lea rcx, [var_380h]                    ; void *s
0x140001efc      41b804010000   mov r8d, 0x104                         ; 260 ; size_t n
0x140001f02      e8cb140000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140001f07      33d2           xor edx, edx                           ; int c
0x140001f09      488d8d900500.  lea rcx, [var_590h]                    ; void *s
0x140001f10      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x140001f16      e8b7140000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140001f1b      c74528f2401d.  mov dword [var_28h], 0x3c1d40f2
0x140001f22      c7452c394637.  mov dword [var_2ch], 0x42374639        ; '9F7B'
0x140001f29      c74530363032.  mov dword [var_30h], 0x1d323036        ; '602\x1d'
0x140001f30      c745343c4136.  mov dword [var_34h], 0x3c36413c        ; '<A6<'
0x140001f37      c745383bfb41.  mov dword [var_38h], 0x4541fb3b
0x140001f3e      c7453c410719.  mov dword [var_3ch], 0x3c190741
0x140001f45      c745403f3123.  mov dword [var_40h], 0x3c23313f        ; '?1#<'
0x140001f4c      c74544393132.  mov dword [var_44h], 0x3a323139        ; '912:'
0x140001f53      66c745483c3f   mov word [var_48h], 0x3f3c             ; '<?'
0x140001f59      c6454a41       mov byte [var_4ah], 0x41               ; 'A' ; 65
0x140001f5d      ff155d210000   call qword [sym.imp.KERNEL32.dll_GetConsoleWindow] ; [0x1400040c0:8]=0x539a reloc.KERNEL32.dll_GetConsoleWin
0x140001f63      488d0dd62500.  lea rcx, str.user32.dll                ; 0x140004540 ; "user32.dll"
0x140001f6a      c74424607944.  mov dword [var_60h], 0x5a4f4479        ; 'yDOZ'
                                                                       ; [0x5a4f4479:4]=-1
0x140001f72      488bf8         mov rdi, rax
0x140001f75      c74424647558.  mov dword [var_64h], 0x445b5875        ; 'uX[D'
                                                                       ; [0x445b5875:4]=-1
0x140001f7d      c74424685659.  mov dword [var_68h], 0x46535956        ; 'VYSF'
                                                                       ; [0x46535956:4]=-1
0x140001f85      c644246c50     mov byte [var_6ch], 0x50               ; 'P'
                                                                       ; [0x50:1]=255 ; 80
0x140001f8a      ff15b0200000   call qword [sym.imp.KERNEL32.dll_GetModuleHandleA] ; [0x140004040:8]=0x5288 reloc.KERNEL32.dll_GetModuleHand
0x140001f90      488bd8         mov rbx, rax
0x140001f93      4885c0         test rax, rax
0x140001f96      7515           jne 0x140001fad
0x140001f98      488d0da12500.  lea rcx, str.user32.dll                ; 0x140004540 ; "user32.dll"
0x140001f9f      ff15bb200000   call qword [sym.imp.KERNEL32.dll_LoadLibraryA] ; [0x140004060:8]=0x52c2 reloc.KERNEL32.dll_LoadLibraryA
0x140001fa5      488bd8         mov rbx, rax
0x140001fa8      4885c0         test rax, rax
0x140001fab      743b           je 0x140001fe8
0x140001fad      33d2           xor edx, edx                           ; int c
0x140001faf      488d4d70       lea rcx, [var_70h]                     ; void *s
0x140001fb3      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x140001fb9      e814140000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140001fbe      4c8d4570       lea r8, [var_70h]                      ; void *arg3
0x140001fc2      ba0d000000     mov edx, 0xd                           ; reloc.ws2_32_Ordinal_13 ; int64_t arg2
0x140001fc7      488d4c2460     lea rcx, [var_60h]                     ; char *arg1
0x140001fcc      e85ff1ffff     call fcn.140001130
0x140001fd1      488d5570       lea rdx, [var_70h]
0x140001fd5      488bcb         mov rcx, rbx
0x140001fd8      ff15ba200000   call qword [sym.imp.KERNEL32.dll_GetProcAddress] ; [0x140004098:8]=0x5330 reloc.KERNEL32.dll_GetProcAddress 
0x140001fde      4885c0         test rax, rax
0x140001fe1      7405           je 0x140001fe8
0x140001fe3      488bcf         mov rcx, rdi
0x140001fe6      ffd0           call rax
0x140001fe8      41b804010000   mov r8d, 0x104                         ; 260
0x140001fee      488d95700200.  lea rdx, [var_270h]
0x140001ff5      33c9           xor ecx, ecx
0x140001ff7      ff150b200000   call qword [sym.imp.KERNEL32.dll_GetModuleFileNameA] ; [0x140004008:8]=0x520c reloc.KERNEL32.dll_GetModuleFi
0x140001ffd      85c0           test eax, eax
0x140001fff      751e           jne 0x14000201f
0x140002001      ff1549200000   call qword [sym.imp.KERNEL32.dll_GetLastError] ; [0x140004050:8]=0x52a4 reloc.KERNEL32.dll_GetLastError
0x140002007      8bd0           mov edx, eax                           ; int64_t arg2
0x140002009      488d0d402500.  lea rcx, str._Parent__Failed_to_get_executable_path._Error:__lu_n ; 0x140004550 ; "[Parent] Failed to get ex
0x140002010      e85bf0ffff     call fcn.140001070
0x140002015      b801000000     mov eax, 1
0x14000201a      e9a4060000     jmp 0x1400026c3
0x14000201f      ba5c000000     mov edx, 0x5c                          ; '\\' ; 92 ; int c
0x140002024      4889b424b007.  mov qword [var_7b0h], rsi
0x14000202c      488d8d700200.  lea rcx, [var_270h]                    ; const char *s
0x140002033      ff153f210000   call qword [sym.imp.VCRUNTIME140.dll_strrchr] ; [0x140004178:8]=0x542a reloc.VCRUNTIME140.dll_strrchr ; "*T"
0x140002039      488bc8         mov rcx, rax
0x14000203c      4885c0         test rax, rax
0x14000203f      7405           je 0x140002046
0x140002041      48ffc1         inc rcx
0x140002044      eb07           jmp 0x14000204d
0x140002046      488d8d700200.  lea rcx, [var_270h]
0x14000204d      48c7c3ffffff.  mov rbx, 0xffffffffffffffff
0x140002054      488bc3         mov rax, rbx
0x140002057      48ffc0         inc rax
0x14000205a      803c0100       cmp byte [rcx + rax], 0
0x14000205e      75f7           jne 0x140002057
0x140002060      ba5c000000     mov edx, 0x5c                          ; '\\' ; 92 ; int c
0x140002065      69f09f020000   imul esi, eax, 0x29f
0x14000206b      488d8d700200.  lea rcx, [var_270h]                    ; const char *s
0x140002072      ff1500210000   call qword [sym.imp.VCRUNTIME140.dll_strrchr] ; [0x140004178:8]=0x542a reloc.VCRUNTIME140.dll_strrchr ; "*T"
0x140002078      4885c0         test rax, rax
0x14000207b      7404           je 0x140002081
0x14000207d      c6400100       mov byte [rax + 1], 0
0x140002081      4c8d8d700200.  lea r9, [var_270h]                     ; int64_t arg4
0x140002088      4c89b424b807.  mov qword [var_7b8h], r14
0x140002090      4c8d05f12400.  lea r8, str._sPolyjuicePotion.txt      ; 0x140004588 ; "%sPolyjuicePotion.txt" ; int64_t arg3
0x140002097      ba04010000     mov edx, 0x104                         ; 260 ; int64_t arg2
0x14000209c      488d8d800300.  lea rcx, [var_380h]                    ; int64_t arg1
0x1400020a3      e828f0ffff     call fcn.1400010d0
0x1400020a8      488d4528       lea rax, [var_28h]
0x1400020ac      48c745a82300.  mov qword [var_58h], 0x23              ; '#' ; 35
0x1400020b4      488945a0       mov qword [var_bp_60h], rax
0x1400020b8      b910000000     mov ecx, 0x10                          ; reloc.ws2_32_Ordinal_16 ; size_t size
0x1400020bd      488d85900500.  lea rax, [var_590h]
0x1400020c4      48c745c80401.  mov qword [var_38h_2], 0x104           ; 260
0x1400020cc      488945b0       mov qword [var_50h], rax
0x1400020d0      488d85800300.  lea rax, [var_380h]
0x1400020d7      488945b8       mov qword [var_48h_2], rax
0x1400020db      488d85700200.  lea rax, [var_270h]
0x1400020e2      488945c0       mov qword [var_40h_2], rax
0x1400020e6      ff1504210000   call qword [sym.imp.api_ms_win_crt_heap_l1_1_0.dll_malloc] ; [0x1400041f0:8]=0x5516 reloc.api_ms_win_crt_hea
0x1400020ec      4885c0         test rax, rax
0x1400020ef      0f84bc050000   je 0x1400026b1
0x1400020f5      488d8d700100.  lea rcx, [s]
0x1400020fc      48c740080001.  mov qword [rax + 8], 0x100             ; [0x100:8]=-1 ; 256
0x140002104      4533f6         xor r14d, r14d
0x140002107      488908         mov qword [rax], rcx
0x14000210a      33c9           xor ecx, ecx
0x14000210c      4c89742428     mov qword [var_sp_28h], r14
0x140002111      4c8bc8         mov r9, rax
0x140002114      4489742420     mov dword [var_20h_2], r14d
0x140002119      4c8d0580fbff.  lea r8, [0x140001ca0]
0x140002120      33d2           xor edx, edx
0x140002122      ff15581f0000   call qword [sym.imp.KERNEL32.dll_CreateThread] ; [0x140004080:8]=0x5300 reloc.KERNEL32.dll_CreateThread
0x140002128      b910270000     mov ecx, 0x2710                        ; '\x10''
0x14000212d      488bf8         mov rdi, rax
0x140002130      ff15121f0000   call qword [sym.imp.KERNEL32.dll_Sleep] ; [0x140004048:8]=0x529c reloc.KERNEL32.dll_Sleep
0x140002136      4885ff         test rdi, rdi
0x140002139      7409           je 0x140002144
0x14000213b      488bcf         mov rcx, rdi
0x14000213e      ff152c1f0000   call qword [sym.imp.KERNEL32.dll_CloseHandle] ; [0x140004070:8]=0x52e2 reloc.KERNEL32.dll_CloseHandle
0x140002144      4c89742428     mov qword [var_sp_28h], r14
0x140002149      4c8d4da0       lea r9, [var_bp_60h]
0x14000214d      4c8d050cf7ff.  lea r8, [0x140001860]
0x140002154      4489742420     mov dword [var_20h_2], r14d
0x140002159      33d2           xor edx, edx
0x14000215b      33c9           xor ecx, ecx
0x14000215d      ff151d1f0000   call qword [sym.imp.KERNEL32.dll_CreateThread] ; [0x140004080:8]=0x5300 reloc.KERNEL32.dll_CreateThread
0x140002163      488bf8         mov rdi, rax
0x140002166      4885c0         test rax, rax
0x140002169      7417           je 0x140002182
0x14000216b      baffffffff     mov edx, 0xffffffff                    ; -1
0x140002170      488bc8         mov rcx, rax
0x140002173      ff15b71e0000   call qword [sym.imp.KERNEL32.dll_WaitForSingleObject] ; [0x140004030:8]=0x5264 reloc.KERNEL32.dll_WaitForSin
0x140002179      488bcf         mov rcx, rdi
0x14000217c      ff15ee1e0000   call qword [sym.imp.KERNEL32.dll_CloseHandle] ; [0x140004070:8]=0x52e2 reloc.KERNEL32.dll_CloseHandle
0x140002182      488d0d372200.  lea rcx, str.ntdll.dll                 ; 0x1400043c0 ; "ntdll.dll"
0x140002189      ff15b11e0000   call qword [sym.imp.KERNEL32.dll_GetModuleHandleA] ; [0x140004040:8]=0x5288 reloc.KERNEL32.dll_GetModuleHand
0x14000218f      33d2           xor edx, edx                           ; int c
0x140002191      488d4d70       lea rcx, [var_70h]                     ; void *s
0x140002195      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x14000219b      488bf8         mov rdi, rax
0x14000219e      e82f120000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x1400021a3      4c8d4570       lea r8, [var_70h]                      ; void *arg3
0x1400021a7      c74424607a40.  mov dword [var_60h], 0x4f65407a        ; 'z@eO'
                                                                       ; [0x4f65407a:4]=-1
0x1400021af      ba16000000     mov edx, 0x16                          ; 22 ; int64_t arg2
0x1400021b4      c7442464407b.  mov dword [var_64h], 0x525a7b40        ; '@{ZR'
                                                                       ; [0x525a7b40:4]=-1
0x1400021bc      488d4c2460     lea rcx, [var_60h]                     ; char *arg1
0x1400021c1      c74424685946.  mov dword [var_68h], 0x53574659        ; 'YFWS'
                                                                       ; [0x53574659:4]=-1
0x1400021c9      c744246c405b.  mov dword [var_6ch], 0x5a595b40        ; '@[YZ'
                                                                       ; [0x5a595b40:4]=-1
0x1400021d1      c7442470605c.  mov dword [var_sp_70h], 0x4f465c60     ; '`\\FO'
                                                                       ; [0x4f465c60:4]=-1
0x1400021d9      66c744247453.  mov word [var_74h], 0x5053             ; 'SP'
                                                                       ; [0x5053:2]=0xffff
0x1400021e0      e84befffff     call fcn.140001130
0x1400021e5      4885ff         test rdi, rdi
0x1400021e8      7426           je 0x140002210
0x1400021ea      488d5570       lea rdx, [var_70h]
0x1400021ee      488bcf         mov rcx, rdi
0x1400021f1      ff15a11e0000   call qword [sym.imp.KERNEL32.dll_GetProcAddress] ; [0x140004098:8]=0x5330 reloc.KERNEL32.dll_GetProcAddress 
0x1400021f7      4885c0         test rax, rax
0x1400021fa      7414           je 0x140002210
0x1400021fc      4533c9         xor r9d, r9d
0x1400021ff      4533c0         xor r8d, r8d
0x140002202      ba11000000     mov edx, 0x11                          ; 17
0x140002207      48c7c1feffff.  mov rcx, 0xfffffffffffffffe
0x14000220e      ffd0           call rax
0x140002210      4c89742430     mov qword [var_sp_30h], r14
0x140002215      488d8d800300.  lea rcx, [var_380h]
0x14000221c      c74424288000.  mov dword [var_sp_28h], 0x80           ; [0x80:4]=-1 ; 128
0x140002224      4533c9         xor r9d, r9d
0x140002227      ba00000080     mov edx, 0x80000000
0x14000222c      c74424200300.  mov dword [var_20h_2], 3
0x140002234      41b801000000   mov r8d, 1
0x14000223a      83c60f         add esi, 0xf                           ; 15
0x14000223d      ff15151e0000   call qword [sym.imp.KERNEL32.dll_CreateFileA] ; [0x140004058:8]=0x52b4 reloc.KERNEL32.dll_CreateFileA
0x140002243      488bf8         mov rdi, rax
0x140002246      483bc3         cmp rax, rbx
0x140002249      0f849e040000   je 0x1400026ed
0x14000224f      4c8d4d20       lea r9, [var_bp_20h]
0x140002253      4c89742420     mov qword [var_20h_2], r14
0x140002258      41b8ff000000   mov r8d, 0xff                          ; 255
0x14000225e      488d95700100.  lea rdx, [s]
0x140002265      488bc8         mov rcx, rax
0x140002268      ff15921d0000   call qword [sym.imp.KERNEL32.dll_ReadFile] ; [0x140004000:8]=0x5200 reloc.KERNEL32.dll_ReadFile
0x14000226e      488bcf         mov rcx, rdi
0x140002271      85c0           test eax, eax
0x140002273      0f846e040000   je 0x1400026e7
0x140002279      8b4520         mov eax, dword [var_bp_20h]
0x14000227c      4488b4057001.  mov byte [rbp + rax + 0x170], r14b
0x140002284      ff15e61d0000   call qword [sym.imp.KERNEL32.dll_CloseHandle] ; [0x140004070:8]=0x52e2 reloc.KERNEL32.dll_CloseHandle
0x14000228a      660f6f05ee23.  movdqa xmm0, xmmword [0x140004680]
0x140002292      f30f7f4550     movdqu xmmword [var_50h_2], xmm0
0x140002297      c745602e3939.  mov dword [rbp + 0x60], 0x3239392e     ; '.992'
0x14000229e      66c745643b34   mov word [var_bp_64h], 0x343b          ; ';4'
0x1400022a4      c6456632       mov byte [var_66h], 0x32               ; '2' ; 50
0x1400022a8      e8d3f3ffff     call fcn.140001680
0x1400022ad      0f57c0         xorps xmm0, xmm0
0x1400022b0      44897598       mov dword [var_bp_68h], r14d
0x1400022b4      0f57c9         xorps xmm1, xmm1
0x1400022b7      48c745d05000.  mov qword [var_30h_2], 0x50            ; 'P' ; 80
0x1400022bf      488d85700100.  lea rax, [s]
0x1400022c6      660f7f45e0     movdqa xmmword [rbp - 0x20], xmm0
0x1400022cb      4889442478     mov qword [var_78h], rax
0x1400022d0      33c9           xor ecx, ecx
0x1400022d2      488d4550       lea rax, [var_50h_2]
0x1400022d6      660f7f4df0     movdqa xmmword [var_10h], xmm1
0x1400022db      48894580       mov qword [var_80h], rax
0x1400022df      488b058a4300.  mov rax, qword [0x140006670]           ; [0x140006670:8]=0
0x1400022e6      48894588       mov qword [var_bp_78h], rax
0x1400022ea      4863c6         movsxd rax, esi
0x1400022ed      48894590       mov qword [var_70h_2], rax
0x1400022f1      488d0528f8ff.  lea rax, [0x140001b20]
0x1400022f8      488945d8       mov qword [var_28h_2], rax
0x1400022fc      660f7f4500     movdqa xmmword [rbp], xmm0
0x140002301      660f7f4d10     movdqa xmmword [var_10h_2], xmm1
0x140002306      ff15ac1d0000   call qword [sym.imp.KERNEL32.dll_GetModuleHandleW] ; [0x1400040b8:8]=0x5386 reloc.KERNEL32.dll_GetModuleHand
0x14000230c      488d358d2200.  lea rsi, [0x1400045a0]                 ; "x"
0x140002313      c7442460664f.  mov dword [var_60h], 0x5b514f66        ; 'fOQ['
                                                                       ; [0x5b514f66:4]=-1
0x14000231b      488d0d1e2200.  lea rcx, str.user32.dll                ; 0x140004540 ; "user32.dll"
0x140002322      488945e8       mov qword [var_bp_18h], rax
0x140002326      48897510       mov qword [var_10h_2], rsi
0x14000232a      c74424644540.  mov dword [var_64h], 0x464f4045        ; 'E@OF'
                                                                       ; [0x464f4045:4]=-1
0x140002332      c74424687558.  mov dword [var_68h], 0x45535875        ; 'uXSE'
                                                                       ; [0x45535875:4]=-1
0x14000233a      c744246c456f.  mov dword [var_6ch], 0x734c6f45        ; 'EoLs'
                                                                       ; [0x734c6f45:4]=-1
0x140002342      ff15f81c0000   call qword [sym.imp.KERNEL32.dll_GetModuleHandleA] ; [0x140004040:8]=0x5288 reloc.KERNEL32.dll_GetModuleHand
0x140002348      488bf8         mov rdi, rax
0x14000234b      4885c0         test rax, rax
0x14000234e      751a           jne 0x14000236a
0x140002350      488d0de92100.  lea rcx, str.user32.dll                ; 0x140004540 ; "user32.dll"
0x140002357      ff15031d0000   call qword [sym.imp.KERNEL32.dll_LoadLibraryA] ; [0x140004060:8]=0x52c2 reloc.KERNEL32.dll_LoadLibraryA
0x14000235d      488bf8         mov rdi, rax
0x140002360      4885c0         test rax, rax
0x140002363      7505           jne 0x14000236a
0x140002365      498bc6         mov rax, r14
0x140002368      eb31           jmp 0x14000239b
0x14000236a      33d2           xor edx, edx                           ; int c
0x14000236c      488d4d70       lea rcx, [var_70h]                     ; void *s
0x140002370      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x140002376      e857100000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x14000237b      4c8d4570       lea r8, [var_70h]                      ; void *arg3
0x14000237f      ba10000000     mov edx, 0x10                          ; reloc.ws2_32_Ordinal_16 ; int64_t arg2
0x140002384      488d4c2460     lea rcx, [var_60h]                     ; char *arg1
0x140002389      e8a2edffff     call fcn.140001130
0x14000238e      488d5570       lea rdx, [var_70h]
0x140002392      488bcf         mov rcx, rdi
0x140002395      ff15fd1c0000   call qword [sym.imp.KERNEL32.dll_GetProcAddress] ; [0x140004098:8]=0x5330 reloc.KERNEL32.dll_GetProcAddress 
0x14000239b      488d4dd0       lea rcx, [var_30h_2]
0x14000239f      ffd0           call rax
0x1400023a1      488d0d982100.  lea rcx, str.user32.dll                ; 0x140004540 ; "user32.dll"
0x1400023a8      c744246078a7.  mov dword [var_60h], 0x969aa778        ; [0x969aa778:4]=-1
0x1400023b0      c7442464a99a.  mov dword [var_64h], 0x9e8c9aa9        ; [0x9e8c9aa9:4]=-1
0x1400023b8      c7442468a399.  mov dword [var_68h], 0xaca499a3        ; [0xaca499a3:4]=-1
0x1400023c0      66c744246c7a.  mov word [var_6ch], 0xad7a             ; [0xad7a:2]=0xffff
0x1400023c7      c644246e76     mov byte [var_6eh], 0x76               ; 'v'
                                                                       ; [0x76:1]=255 ; 118
0x1400023cc      ff156e1c0000   call qword [sym.imp.KERNEL32.dll_GetModuleHandleA] ; [0x140004040:8]=0x5288 reloc.KERNEL32.dll_GetModuleHand
0x1400023d2      488bf8         mov rdi, rax
0x1400023d5      4885c0         test rax, rax
0x1400023d8      751a           jne 0x1400023f4
0x1400023da      488d0d5f2100.  lea rcx, str.user32.dll                ; 0x140004540 ; "user32.dll"
0x1400023e1      ff15791c0000   call qword [sym.imp.KERNEL32.dll_LoadLibraryA] ; [0x140004060:8]=0x52c2 reloc.KERNEL32.dll_LoadLibraryA
0x1400023e7      488bf8         mov rdi, rax
0x1400023ea      4885c0         test rax, rax
0x1400023ed      7505           jne 0x1400023f4
0x1400023ef      498bc6         mov rax, r14
0x1400023f2      eb31           jmp 0x140002425
0x1400023f4      33d2           xor edx, edx                           ; int c
0x1400023f6      488d4d70       lea rcx, [var_70h]                     ; void *s
0x1400023fa      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x140002400      e8cd0f0000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140002405      4c8d4570       lea r8, [var_70h]                      ; void *arg3
0x140002409      ba0f000000     mov edx, 0xf                           ; 15 ; int64_t arg2
0x14000240e      488d4c2460     lea rcx, [var_60h]                     ; char *arg1
0x140002413      e818edffff     call fcn.140001130
0x140002418      488d5570       lea rdx, [var_70h]
0x14000241c      488bcf         mov rcx, rdi
0x14000241f      ff15731c0000   call qword [sym.imp.KERNEL32.dll_GetProcAddress] ; [0x140004098:8]=0x5330 reloc.KERNEL32.dll_GetProcAddress 
0x140002425      488d4c2478     lea rcx, [var_78h]
0x14000242a      41b90000cf00   mov r9d, 0xcf0000
0x140002430      48894c2458     mov qword [var_sp_58h], rcx
0x140002435      4c8d05682100.  lea r8, [0x1400045a4]                  ; "y"
0x14000243c      488b4de8       mov rcx, qword [var_bp_18h]
0x140002440      488bd6         mov rdx, rsi
0x140002443      48894c2450     mov qword [var_sp_50h], rcx
0x140002448      33c9           xor ecx, ecx
0x14000244a      4c89742448     mov qword [var_sp_48h], r14
0x14000244f      4c89742440     mov qword [var_sp_40h], r14
0x140002454      4489742438     mov dword [var_sp_38h], r14d
0x140002459      4489742430     mov dword [var_sp_30h], r14d
0x14000245e      c74424280000.  mov dword [var_sp_28h], 0x80000000     ; [0x80000000:4]=-1
0x140002466      c74424200000.  mov dword [var_20h_2], 0x80000000      ; [0x80000000:4]=-1
0x14000246e      ffd0           call rax
0x140002470      488d8d700100.  lea rcx, [s]
0x140002477      488bc3         mov rax, rbx
0x14000247a      660f1f440000   nop word [rax + rax]
0x140002480      48ffc0         inc rax
0x140002483      44383401       cmp byte [rcx + rax], r14b
0x140002487      75f7           jne 0x140002480
0x140002489      83f814         cmp eax, 0x14                          ; 20
0x14000248c      7e09           jle 0x140002497
0x14000248e      488d0d132100.  lea rcx, [0x1400045a8]                 ; "\n[*] Try harded to find the secrets.\n"
0x140002495      eb10           jmp 0x1400024a7
0x140002497      80bd70010000.  cmp byte [s], 0x41
0x14000249e      750c           jne 0x1400024ac
0x1400024a0      488d0d292100.  lea rcx, str._n___The_Polyjuice_Potion_is_still_effective__preventing_the_true_identity_from_being_revealed.
0x1400024a7      e8c4ebffff     call fcn.140001070
0x1400024ac      33d2           xor edx, edx                           ; int c
0x1400024ae      488d8d900400.  lea rcx, [var_490h]                    ; void *s
0x1400024b5      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x1400024bb      e8120f0000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x1400024c0      4c8d85900400.  lea r8, [var_490h]                     ; void *arg3
0x1400024c7      c74424602929.  mov dword [var_60h], 0x29fb2929        ; [0x29fb2929:4]=-1
0x1400024cf      ba17000000     mov edx, 0x17                          ; reloc.ws2_32_Ordinal_23 ; int64_t arg2
0x1400024d4      c74424643d36.  mov dword [var_64h], 0x323d363d        ; '=6=2'
                                                                       ; [0x323d363d:4]=-1
0x1400024dc      488d4c2460     lea rcx, [var_60h]                     ; char *arg1
0x1400024e1      c74424682913.  mov dword [var_68h], 0x2e391329        ; ')\x139.'
                                                                       ; [0x2e391329:4]=-1
0x1400024e9      c744246c3f32.  mov dword [var_6ch], 0x3510323f        ; '?2\x105'
                                                                       ; [0x3510323f:4]=-1
0x1400024f1      c74424702e39.  mov dword [var_sp_70h], 0x3239392e     ; '.992'
                                                                       ; [0x3239392e:4]=-1
0x1400024f9      66c74424743b.  mov word [var_74h], 0x343b             ; ';4'
                                                                       ; [0x343b:2]=0xffff
0x140002500      c644247632     mov byte [var_76h], 0x32               ; '2'
                                                                       ; [0x32:1]=255 ; 50
0x140002505      e826ecffff     call fcn.140001130
0x14000250a      488d0dd71f00.  lea rcx, str.kernel32.dll              ; 0x1400044e8 ; "kernel32.dll"
0x140002511      c74424607546.  mov dword [var_60h], 0x534f4675        ; 'uFOS'
                                                                       ; [0x534f4675:4]=-1
0x140002519      c7442464404f.  mov dword [var_64h], 0x537a4f40        ; '@OzS'
                                                                       ; [0x537a4f40:4]=-1
0x140002521      c7442468574f.  mov dword [var_68h], 0x64504f57        ; 'WOPd'
                                                                       ; [0x64504f57:4]=-1
0x140002529      c744246c5b44.  mov dword [var_6ch], 0x734f445b        ; '[DOs'
                                                                       ; [0x734f445b:4]=-1
0x140002531      ff15091b0000   call qword [sym.imp.KERNEL32.dll_GetModuleHandleA] ; [0x140004040:8]=0x5288 reloc.KERNEL32.dll_GetModuleHand
0x140002537      488bf8         mov rdi, rax
0x14000253a      4885c0         test rax, rax
0x14000253d      7519           jne 0x140002558
0x14000253f      488d0da21f00.  lea rcx, str.kernel32.dll              ; 0x1400044e8 ; "kernel32.dll"
0x140002546      ff15141b0000   call qword [sym.imp.KERNEL32.dll_LoadLibraryA] ; [0x140004060:8]=0x52c2 reloc.KERNEL32.dll_LoadLibraryA
0x14000254c      488bf8         mov rdi, rax
0x14000254f      4885c0         test rax, rax
0x140002552      0f8459010000   je 0x1400026b1
0x140002558      33d2           xor edx, edx                           ; int c
0x14000255a      488d4d70       lea rcx, [var_70h]                     ; void *s
0x14000255e      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x140002564      e8690e0000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140002569      4c8d4570       lea r8, [var_70h]                      ; void *arg3
0x14000256d      ba10000000     mov edx, 0x10                          ; reloc.ws2_32_Ordinal_16 ; int64_t arg2
0x140002572      488d4c2460     lea rcx, [var_60h]                     ; char *arg1
0x140002577      e8b4ebffff     call fcn.140001130
0x14000257c      488d5570       lea rdx, [var_70h]
0x140002580      488bcf         mov rcx, rdi
0x140002583      ff150f1b0000   call qword [sym.imp.KERNEL32.dll_GetProcAddress] ; [0x140004098:8]=0x5330 reloc.KERNEL32.dll_GetProcAddress 
0x140002589      4885c0         test rax, rax
0x14000258c      0f841f010000   je 0x1400026b1
0x140002592      4c89742438     mov qword [var_sp_38h], r14
0x140002597      488d8d900400.  lea rcx, [var_490h]
0x14000259e      4489742430     mov dword [var_sp_30h], r14d
0x1400025a3      ba02000000     mov edx, 2
0x1400025a8      c74424280001.  mov dword [var_sp_28h], 0x100          ; [0x100:4]=-1 ; 256
0x1400025b0      41b901000000   mov r9d, 1
0x1400025b6      41b806000000   mov r8d, 6
0x1400025bc      c74424200001.  mov dword [var_20h_2], 0x100           ; [0x100:4]=-1 ; 256
0x1400025c4      ffd0           call rax
0x1400025c6      488bf0         mov rsi, rax
0x1400025c9      483bc3         cmp rax, rbx
0x1400025cc      0f841b010000   je 0x1400026ed
0x1400025d2      e829eeffff     call fcn.140001400
0x1400025d7      488d0d0a1f00.  lea rcx, str.kernel32.dll              ; 0x1400044e8 ; "kernel32.dll"
0x1400025de      c74424607559.  mov dword [var_60h], 0x5a5a5975        ; 'uYZZ'
                                                                       ; [0x5a5a5975:4]=-1
0x1400025e6      c74424644f55.  mov dword [var_64h], 0x7a40554f        ; 'OU@z'
                                                                       ; [0x7a40554f:4]=-1
0x1400025ee      c74424685357.  mov dword [var_68h], 0x504f5753        ; 'SWOP'
                                                                       ; [0x504f5753:4]=-1
0x1400025f6      c744246c645b.  mov dword [var_6ch], 0x4f445b64        ; 'd[DO'
                                                                       ; [0x4f445b64:4]=-1
0x1400025fe      ff153c1a0000   call qword [sym.imp.KERNEL32.dll_GetModuleHandleA] ; [0x140004040:8]=0x5288 reloc.KERNEL32.dll_GetModuleHand
0x140002604      488bf8         mov rdi, rax
0x140002607      4885c0         test rax, rax
0x14000260a      751a           jne 0x140002626
0x14000260c      488d0dd51e00.  lea rcx, str.kernel32.dll              ; 0x1400044e8 ; "kernel32.dll"
0x140002613      ff15471a0000   call qword [sym.imp.KERNEL32.dll_LoadLibraryA] ; [0x140004060:8]=0x52c2 reloc.KERNEL32.dll_LoadLibraryA
0x140002619      488bf8         mov rdi, rax
0x14000261c      4885c0         test rax, rax
0x14000261f      7505           jne 0x140002626
0x140002621      498bc6         mov rax, r14
0x140002624      eb31           jmp 0x140002657
0x140002626      33d2           xor edx, edx                           ; int c
0x140002628      488d4d70       lea rcx, [var_70h]                     ; void *s
0x14000262c      41b800010000   mov r8d, 0x100                         ; 256 ; size_t n
0x140002632      e89b0d0000     call sub.VCRUNTIME140.dll_memset       ; void *memset(void *s, int c, size_t n)
0x140002637      4c8d4570       lea r8, [var_70h]                      ; void *arg3
0x14000263b      ba10000000     mov edx, 0x10                          ; reloc.ws2_32_Ordinal_16 ; int64_t arg2
0x140002640      488d4c2460     lea rcx, [var_60h]                     ; char *arg1
0x140002645      e8e6eaffff     call fcn.140001130
0x14000264a      488d5570       lea rdx, [var_70h]
0x14000264e      488bcf         mov rcx, rdi
0x140002651      ff15411a0000   call qword [sym.imp.KERNEL32.dll_GetProcAddress] ; [0x140004098:8]=0x5330 reloc.KERNEL32.dll_GetProcAddress 
0x140002657      33d2           xor edx, edx
0x140002659      488bce         mov rcx, rsi
0x14000265c      ffd0           call rax
0x14000265e      4885c0         test rax, rax
0x140002661      750d           jne 0x140002670
0x140002663      ff15e7190000   call qword [sym.imp.KERNEL32.dll_GetLastError] ; [0x140004050:8]=0x52a4 reloc.KERNEL32.dll_GetLastError
0x140002669      3d17020000     cmp eax, 0x217                         ; 535
0x14000266e      752c           jne 0x14000269c
0x140002670      488d85700100.  lea rax, [s]
0x140002677      48ffc3         inc rbx
0x14000267a      44383418       cmp byte [rax + rbx], r14b
0x14000267e      75f7           jne 0x140002677
0x140002680      4c8d4d20       lea r9, [var_bp_20h]
0x140002684      4c89742420     mov qword [var_20h_2], r14
0x140002689      448bc3         mov r8d, ebx
0x14000268c      488d95700100.  lea rdx, [s]
0x140002693      488bce         mov rcx, rsi
0x140002696      ff1584190000   call qword [sym.imp.KERNEL32.dll_WriteFile] ; [0x140004020:8]=0x5248 reloc.KERNEL32.dll_WriteFile ; "HR"
0x14000269c      488bce         mov rcx, rsi
0x14000269f      ff15cb190000   call qword [sym.imp.KERNEL32.dll_CloseHandle] ; [0x140004070:8]=0x52e2 reloc.KERNEL32.dll_CloseHandle
0x1400026a5      488d0d8c1f00.  lea rcx, str.___Execution_complete._n  ; 0x140004638 ; "[+] Execution complete.\n" ; int64_t arg1
0x1400026ac      e8bfe9ffff     call fcn.140001070
0x1400026b1      33c0           xor eax, eax
0x1400026b3      4c8bb424b807.  mov r14, qword [var_7b8h]
0x1400026bb      488bb424b007.  mov rsi, qword [var_7b0h]
0x1400026c3      488b8d900600.  mov rcx, qword [var_690h]
0x1400026ca      4833cc         xor rcx, rsp                           ; uint32_t arg1
0x1400026cd      e83e000000     call fcn.140002710
0x1400026d2      4c8d9c24a007.  lea r11, [var_7a0h]
0x1400026da      498b5b20       mov rbx, qword [r11 + 0x20]
0x1400026de      498b7b28       mov rdi, qword [r11 + 0x28]
0x1400026e2      498be3         mov rsp, r11
0x1400026e5      5d             pop rbp
0x1400026e6      c3             ret
0x1400026e7      ff1583190000   call qword [sym.imp.KERNEL32.dll_CloseHandle] ; [0x140004070:8]=0x52e2 reloc.KERNEL32.dll_CloseHandle
0x1400026ed      b801000000     mov eax, 1
0x1400026f2      ebbf           jmp 0x1400026b3
