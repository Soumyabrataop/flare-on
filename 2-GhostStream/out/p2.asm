[2K0x1400013a1      450fb61a       movzx r11d, byte [r10]
0x1400013a5      418bc1         mov eax, r9d
0x1400013a8      99             cdq
0x1400013a9      f7fb           idiv ebx
0x1400013ab      4863c2         movsxd rax, edx
0x1400013ae      0fb68c05d001.  movzx ecx, byte [rbp + rax + 0x1d0]
0x1400013b6      4403c1         add r8d, ecx
0x1400013b9      4503c3         add r8d, r11d
0x1400013bc      4181e0ff0000.  and r8d, 0x800000ff
0x1400013c3      7d0d           jge 0x1400013d2
0x1400013c5      41ffc8         dec r8d
0x1400013c8      4181c800ffff.  or r8d, 0xffffff00
0x1400013cf      41ffc0         inc r8d
0x1400013d2      4963c0         movsxd rax, r8d
0x1400013d5      488d4c2470     lea rcx, [var_sp_70h]
0x1400013da      4803c8         add rcx, rax
0x1400013dd      41ffc1         inc r9d
0x1400013e0      0fb601         movzx eax, byte [rcx]
0x1400013e3      418802         mov byte [r10], al
0x1400013e6      49ffc2         inc r10
0x1400013e9      448819         mov byte [rcx], r11b
0x1400013ec      4181f9000100.  cmp r9d, 0x100
0x1400013f3      7cac           jl 0x1400013a1
0x1400013f5      4981f60df0ad.  xor r14, 0xbadf00d
0x1400013fc      4981ee403020.  sub r14, 0x10203040
0x140001403      4c89356e4200.  mov qword [0x140005678], r14
0x14000140a      4c33f6         xor r14, rsi
0x14000140d      4c8d4c2468     lea r9, [var_68h]
0x140001412      498bce         mov rcx, r14
0x140001415      ba17000000     mov edx, 0x17
0x14000141a      41b840000000   mov r8d, 0x40
0x140001420      ff15ea1b0000   call qword [sym.imp.KERNEL32.dll_VirtualProtect]
0x140001426      410f1036       movups xmm6, xmmword [r14]
0x14000142a      418b5e10       mov ebx, dword [r14 + 0x10]
0x14000142e      488d95900000.  lea rdx, [var_90h]
0x140001435      410fb77e14     movzx edi, word [r14 + 0x14]
0x14000143a      488d0d2f1f00.  lea rcx, str.COMPUTERNAME
0x140001441      410fb67616     movzx esi, byte [r14 + 0x16]
0x140001446      0f57c0         xorps xmm0, xmm0
0x140001449      41c70631c004.  mov dword [r14], 0x1304c031
0x140001450      41b840000000   mov r8d, 0x40
0x140001456      41c74604b201.  mov dword [r14 + 4], 0x17501b2
0x14000145e      41c74608e800.  mov dword [r14 + 8], 0x301100e8
0x140001466      41c7460c01fe.  mov dword [r14 + 0xc], 0x48c2fe01
0x14000146e      41c74610ffc1.  mov dword [r14 + 0x10], 0x2138c1ff
0x140001476      6641c7461475.  mov word [r14 + 0x14], 0xf375
0x14000147d      41c64616c3     mov byte [r14 + 0x16], 0xc3
0x140001482      0f1185900000.  movups xmmword [var_90h], xmm0
0x140001489      0f1185a00000.  movups xmmword [var_a0h], xmm0
0x140001490      0f1185b00000.  movups xmmword [var_b0h], xmm0
0x140001497      0f1185c00000.  movups xmmword [var_c0h], xmm0
0x14000149e      ff157c1b0000   call qword [sym.imp.KERNEL32.dll_GetEnvironmentVariableA]
0x1400014a4      488d8d900000.  lea rcx, [var_90h]
0x1400014ab      ff15671b0000   call qword [sym.imp.KERNEL32.dll_lstrlenA]
0x1400014b1      ff15a91b0000   call qword [sym.imp.KERNEL32.dll_IsDebuggerPresent]
0x1400014b7      ff159b1b0000   call qword [sym.imp.KERNEL32.dll_GetTickCount]
0x1400014bd      0fb705cc1e00.  movzx eax, word [0x140003390]
0x1400014c4      4c8d2dad3b00.  lea r13, str.Bxs_bv_u_TpcnolVjN
0x1400014cb      0f1005ae1e00.  movups xmm0, xmmword [str.Wingardium_Leviosa]
0x1400014d2      668985800000.  mov word [var_80h], ax
0x1400014d9      498bcd         mov rcx, r13
0x1400014dc      0fb605af1e00.  movzx eax, byte [0x140003392]
0x1400014e3      888582000000   mov byte [var_82h], al
0x1400014e9      0f114570       movups xmmword [var_70h], xmm0
0x1400014ed      ff151d1d0000   call qword [sym.imp.api_ms_win_crt_string_l1_1_0.dll_strlen]
0x1400014f3      488d4d70       lea rcx, [var_70h]
0x1400014f7      ff15131d0000   call qword [sym.imp.api_ms_win_crt_string_l1_1_0.dll_strlen]
0x1400014fd      410f1136       movups xmmword [r14], xmm6
0x140001501      41895e10       mov dword [r14 + 0x10], ebx
0x140001505      4c8d4c2468     lea r9, [var_68h]
0x14000150a      6641897e14     mov word [r14 + 0x14], di
0x14000150f      ba17000000     mov edx, 0x17
0x140001514      41887616       mov byte [r14 + 0x16], sil
0x140001518      498bce         mov rcx, r14
0x14000151b      448b442468     mov r8d, dword [var_68h]
0x140001520      4c8be0         mov r12, rax
0x140001523      ff15e71a0000   call qword [sym.imp.KERNEL32.dll_VirtualProtect]
0x140001529      0f28b424e003.  movaps xmm6, xmmword [var_3e0h]
0x140001531      4585e4         test r12d, r12d
0x140001534      0f8e33010000   jle 0x14000166d
0x14000153a      418bcf         mov ecx, r15d
0x14000153d      49c7c2ffffff.  mov r10, 0xffffffffffffffff
0x140001544      49ffc2         inc r10
0x140001547      43380c2a       cmp byte [r10 + r13], cl
0x14000154b      75f7           jne 0x140001544
0x14000154d      410fb6fc       movzx edi, r12b
0x140001551      4c8d9dd10000.  lea r11, [var_d1h]
0x140001558      498bf7         mov rsi, r15
0x14000155b      41be13000000   mov r14d, 0x13
0x140001561      468d0c3f       lea r9d, [rdi + r15]
0x140001565      4181e1ff0000.  and r9d, 0x800000ff
0x14000156c      7d0d           jge 0x14000157b
0x14000156e      41ffc9         dec r9d
0x140001571      4181c900ffff.  or r9d, 0xffffff00
0x140001578      41ffc1         inc r9d
0x14000157b      4963c1         movsxd rax, r9d
0x14000157e      488d542470     lea rdx, [var_sp_70h]
0x140001583      4803d0         add rdx, rax
0x140001586      0fb61a         movzx ebx, byte [rdx]
0x140001589      448d0419       lea r8d, [rcx + rbx]
0x14000158d      4181e0ff0000.  and r8d, 0x800000ff
0x140001594      7d0d           jge 0x1400015a3
0x140001596      41ffc8         dec r8d
0x140001599      4181c800ffff.  or r8d, 0xffffff00
0x1400015a0      41ffc0         inc r8d
0x1400015a3      4963c0         movsxd rax, r8d
0x1400015a6      488d4c2470     lea rcx, [var_sp_70h]
0x1400015ab      4803c8         add rcx, rax
0x1400015ae      0fb601         movzx eax, byte [rcx]
0x1400015b1      8802           mov byte [rdx], al
0x1400015b3      488bc6         mov rax, rsi
0x1400015b6      8819           mov byte [rcx], bl
0x1400015b8      0fb60a         movzx ecx, byte [rdx]
0x1400015bb      33d2           xor edx, edx
0x1400015bd      49f7f2         div r10
0x1400015c0      4803cb         add rcx, rbx
0x1400015c3      400fb6c7       movzx eax, dil
0x1400015c7      410243ff       add al, byte [r11 - 1]
0x1400015cb      0fb6c9         movzx ecx, cl
0x1400015ce      0fb64c0c70     movzx ecx, byte [rsp + rcx + 0x70]
0x1400015d3      42320c2a       xor cl, byte [rdx + r13]
0x1400015d7      32c8           xor cl, al
0x1400015d9      418d0439       lea eax, [r9 + rdi]
0x1400015dd      41884bff       mov byte [r11 - 1], cl
0x1400015e1      25ff000080     and eax, 0x800000ff
0x1400015e6      7d09           jge 0x1400015f1
0x1400015e8      ffc8           dec eax
0x1400015ea      0d00ffffff     or eax, 0xffffff00
0x1400015ef      ffc0           inc eax
0x1400015f1      4c63f8         movsxd r15, eax
0x1400015f4      4c8d4c2470     lea r9, [var_sp_70h]
0x1400015f9      430fb61c39     movzx ebx, byte [r9 + r15]
0x1400015fe      418d0c18       lea ecx, [r8 + rbx]
0x140001602      81e1ff000080   and ecx, 0x800000ff
0x140001608      7d0a           jge 0x140001614
0x14000160a      ffc9           dec ecx
0x14000160c      81c900ffffff   or ecx, 0xffffff00
0x140001612      ffc1           inc ecx
0x140001614      4863c1         movsxd rax, ecx
0x140001617      488d542470     lea rdx, [var_sp_70h]
0x14000161c      4803d0         add rdx, rax
0x14000161f      0fb602         movzx eax, byte [rdx]
0x140001622      43880439       mov byte [r9 + r15], al
0x140001626      488d4601       lea rax, [rsi + 1]
0x14000162a      881a           mov byte [rdx], bl
0x14000162c      4883c602       add rsi, 2
0x140001630      430fb61439     movzx edx, byte [r9 + r15]
0x140001635      4803d3         add rdx, rbx
0x140001638      440fb6c2       movzx r8d, dl
0x14000163c      33d2           xor edx, edx
0x14000163e      49f7f2         div r10
0x140001641      460fb6440470   movzx r8d, byte [rsp + r8 + 0x70]
0x140001647      400fb6c7       movzx eax, dil
0x14000164b      410203         add al, byte [r11]
0x14000164e      4632042a       xor r8b, byte [rdx + r13]
0x140001652      4432c0         xor r8b, al
0x140001655      458803         mov byte [r11], r8b
0x140001658      4983c302       add r11, 2
0x14000165c      4983ee01       sub r14, 1
0x140001660      0f85fbfeffff   jne 0x140001561
0x140001666      4488b5f60000.  mov byte [s], r14b
0x14000166d      488d15241d00.  lea rdx, str._flare_on.com
0x140001674      488d8dd00000.  lea rcx, [var_d0h]
0x14000167b      ff15671a0000   call qword [sym.imp.VCRUNTIME140.dll_strstr]
0x140001681      4c8bb424f003.  mov r14, qword [var_3f0h]
0x140001689      4c8bac24f803.  mov r13, qword [var_3f8h]
0x140001691      4c8ba4243004.  mov r12, qword [var_430h]
0x140001699      488bb4242004.  mov rsi, qword [var_420h]
0x1400016a1      4885c0         test rax, rax
0x1400016a4      744e           je 0x1400016f4
0x1400016a6      488d95d00000.  lea rdx, [var_d0h]
0x1400016ad      488d0df41c00.  lea rcx, str._n_SUCCESS__Decrypted_Flag:__s_n
0x1400016b4      e857f9ffff     call fcn.140001010
0x1400016b9      eb45           jmp 0x140001700
0x1400016bb      488d0d6e1c00.  lea rcx, str._Partner__Pipe_timeout._n
0x1400016c2      e849f9ffff     call fcn.140001010
0x1400016c7      b801000000     mov eax, 1
0x1400016cc      eb49           jmp 0x140001717
0x1400016ce      ff1564190000   call qword [sym.imp.KERNEL32.dll_GetLastError]
0x1400016d4      8bd0           mov edx, eax
0x1400016d6      488d0d231c00.  lea rcx, str._Partner__Could_not_open_pipe._Error:__lu_n
0x1400016dd      e82ef9ffff     call fcn.140001010
0x1400016e2      b9d0070000     mov ecx, 0x7d0
0x1400016e7      ff1543190000   call qword [sym.imp.KERNEL32.dll_Sleep]
0x1400016ed      b801000000     mov eax, 1
0x1400016f2      eb23           jmp 0x140001717
0x1400016f4      488d0dcd1c00.  lea rcx, str._n_FAILED__Try_again_with_better_debugging_n
0x1400016fb      e810f9ffff     call fcn.140001010
0x140001700      488d0ded1c00.  lea rcx, str.pause
0x140001707      ff15731a0000   call qword [sym.imp.api_ms_win_crt_runtime_l1_1_0.dll_system]
0x14000170d      488bbc242804.  mov rdi, qword [var_428h]
0x140001715      33c0           xor eax, eax
0x140001717      488b8dd00200.  mov rcx, qword [var_2d0h]
0x14000171e      4833cc         xor rcx, rsp
0x140001721      e82a000000     call fcn.140001750
0x140001726      4881c4000400.  add rsp, 0x400
0x14000172d      415f           pop r15
0x14000172f      5b             pop rbx
0x140001730      5d             pop rbp
0x140001731      c3             ret
0x140001732      e841010000     call fcn.140001878
0x140001737      cc             int3
0x140001738      cc             int3
0x140001739      cc             int3
0x14000173a      cc             int3
0x14000173b      cc             int3
0x14000173c      cc             int3
0x14000173d      cc             int3
0x14000173e      cc             int3
0x14000173f      cc             int3
0x140001740      cc             int3
0x140001741      cc             int3
0x140001742      cc             int3
0x140001743      cc             int3
0x140001744      cc             int3
0x140001745      cc             int3
0x140001746      66660f1f8400.  nop word [rax + rax]
30: fcn.140001750 (uint32_t arg1);
; var int64_t var_38h @ rsp+0x38
; var int64_t var_8h @ rsp+0x40
; arg uint32_t arg1 @ rcx
0x140001750      483b0da93800.  cmp rcx, qword [section..data]
0x140001757      7510           jne 0x140001769
0x140001759      48c1c110       rol rcx, 0x10
0x14000175d      66f7c1ffff     test cx, 0xffff
0x140001762      7501           jne 0x140001765
0x140001764      c3             ret
0x140001765      48c1c910       ror rcx, 0x10
0x140001769      e936000000     jmp loc.1400017a4
0x14000176e      cc             int3
0x14000176f      cc             int3
52: fcn.140001770 (int64_t arg1);
; arg int64_t arg1 @ rcx
0x140001770      4053           push rbx
0x140001772      4883ec20       sub rsp, 0x20
0x140001776      488bd9         mov rbx, rcx
0x140001779      33c9           xor ecx, ecx
0x14000177b      ff15ff180000   call qword [sym.imp.KERNEL32.dll_SetUnhandledExceptionFilter]
0x140001781      488bcb         mov rcx, rbx
0x140001784      ff15ee180000   call qword [sym.imp.KERNEL32.dll_UnhandledExceptionFilter]
0x14000178a      ff1500190000   call qword [sym.imp.KERNEL32.dll_GetCurrentProcess]
0x140001790      488bc8         mov rcx, rax
0x140001793      ba090400c0     mov edx, 0xc0000409
0x140001798      4883c420       add rsp, 0x20
0x14000179c      5b             pop rbx
0x14000179d      48ff25f41800.  jmp qword [sym.imp.KERNEL32.dll_TerminateProcess]
├ 211: loc.1400017a4 (int64_t arg1);
; var int64_t var_38h @ rsp+0x38
; var int64_t var_8h @ rsp+0x40
; arg int64_t arg1 @ rcx
0x1400017a4      48894c2408     mov qword [var_8h], rcx
0x1400017a9      4883ec38       sub rsp, 0x38
0x1400017ad      b917000000     mov ecx, 0x17
0x1400017b2      ff1518190000   call qword [sym.imp.KERNEL32.dll_IsProcessorFeaturePresent]
0x1400017b8      85c0           test eax, eax
0x1400017ba      7407           je 0x1400017c3
0x1400017bc      b902000000     mov ecx, 2
0x1400017c1      cd29           int 0x29
0x1400017c3      488d0d663900.  lea rcx, [0x140005130]
0x1400017ca      e8cd010000     call fcn.14000199c
0x1400017cf      488b442438     mov rax, qword [var_38h]
0x1400017d4      4889054d3a00.  mov qword [0x140005228], rax
0x1400017db      488d442438     lea rax, [var_38h]
0x1400017e0      4883c008       add rax, 8
0x1400017e4      488905dd3900.  mov qword [0x1400051c8], rax
0x1400017eb      488b05363a00.  mov rax, qword [0x140005228]
0x1400017f2      488905a73800.  mov qword [0x1400050a0], rax
0x1400017f9      488b442440     mov rax, qword [var_8h]
0x1400017fe      488905ab3900.  mov qword [0x1400051b0], rax
0x140001805      c70581380000.  mov dword [0x140005090], 0xc0000409
0x14000180f      c7057b380000.  mov dword [0x140005094], 1
0x140001819      c70585380000.  mov dword [0x1400050a8], 1
0x140001823      b808000000     mov eax, 8
0x140001828      486bc000       imul rax, rax, 0
0x14000182c      488d0d7d3800.  lea rcx, [0x1400050b0]
0x140001833      48c704010200.  mov qword [rcx + rax], 2
0x14000183b      b808000000     mov eax, 8
0x140001840      486bc000       imul rax, rax, 0
0x140001844      488b0db53700.  mov rcx, qword [section..data]
0x14000184b      48894c0420     mov qword [rsp + rax + 0x20], rcx
0x140001850      b808000000     mov eax, 8
0x140001855      486bc001       imul rax, rax, 1
0x140001859      488b0de03700.  mov rcx, qword [0x140005040]
0x140001860      48894c0420     mov qword [rsp + rax + 0x20], rcx
0x140001865      488d0d541a00.  lea rcx, [0x1400032c0]
0x14000186c      e8fffeffff     call fcn.140001770
0x140001871      90             nop
0x140001872      4883c438       add rsp, 0x38
0x140001876      c3             ret
0x140001877      cc             int3
20: fcn.140001878 ();
0x140001878      4883ec28       sub rsp, 0x28
0x14000187c      b908000000     mov ecx, 8
0x140001881      e806000000     call fcn.14000188c
0x140001886      90             nop
0x140001887      4883c428       add rsp, 0x28
0x14000188b      c3             ret
157: fcn.14000188c (int64_t arg1);
; var int64_t var_28h @ rsp+0x28
; var int64_t var_8h @ rsp+0x30
; arg int64_t arg1 @ rcx
0x14000188c      894c2408       mov dword [var_8h], ecx
0x140001890      4883ec28       sub rsp, 0x28
0x140001894      b917000000     mov ecx, 0x17
0x140001899      ff1531180000   call qword [sym.imp.KERNEL32.dll_IsProcessorFeaturePresent]
0x14000189f      85c0           test eax, eax
0x1400018a1      7408           je 0x1400018ab
0x1400018a3      8b442430       mov eax, dword [var_8h]
0x1400018a7      8bc8           mov ecx, eax
0x1400018a9      cd29           int 0x29
0x1400018ab      488d0d7e3800.  lea rcx, [0x140005130]
0x1400018b2      e875000000     call fcn.14000192c
0x1400018b7      488b442428     mov rax, qword [var_28h]
0x1400018bc      488905653900.  mov qword [0x140005228], rax
0x1400018c3      488d442428     lea rax, [var_28h]
0x1400018c8      4883c008       add rax, 8
0x1400018cc      488905f53800.  mov qword [0x1400051c8], rax
0x1400018d3      488b054e3900.  mov rax, qword [0x140005228]
0x1400018da      488905bf3700.  mov qword [0x1400050a0], rax
0x1400018e1      c705a5370000.  mov dword [0x140005090], 0xc0000409
0x1400018eb      c7059f370000.  mov dword [0x140005094], 1
0x1400018f5      c705a9370000.  mov dword [0x1400050a8], 1
0x1400018ff      b808000000     mov eax, 8
0x140001904      486bc000       imul rax, rax, 0
0x140001908      488d0da13700.  lea rcx, [0x1400050b0]
0x14000190f      8b542430       mov edx, dword [var_8h]
0x140001913      48891401       mov qword [rcx + rax], rdx
0x140001917      488d0da21900.  lea rcx, [0x1400032c0]
0x14000191e      e84dfeffff     call fcn.140001770
0x140001923      90             nop
0x140001924      4883c428       add rsp, 0x28
0x140001928      c3             ret
0x140001929      cc             int3
0x14000192a      cc             int3
0x14000192b      cc             int3
112: fcn.14000192c (int64_t arg1);
; var int64_t var_20h_2 @ rsp+0x20
; var int64_t var_28h @ rsp+0x28
; var int64_t var_30h @ rsp+0x30
; var int64_t var_38h @ rsp+0x38
; var int64_t var_50h @ rsp+0x50
; var int64_t var_58h @ rsp+0x58
; var int64_t var_60h @ rsp+0x60
; var int64_t var_20h @ rsp+0x68
; arg int64_t arg1 @ rcx
0x14000192c      48895c2420     mov qword [var_20h], rbx
0x140001931      57             push rdi
0x140001932      4883ec40       sub rsp, 0x40
0x140001936      488bd9         mov rbx, rcx
0x140001939      ff1549170000   call qword [sym.imp.KERNEL32.dll_RtlCaptureContext]
0x14000193f      488bbbf80000.  mov rdi, qword [rbx + 0xf8]
0x140001946      488d542450     lea rdx, [var_50h]
0x14000194b      488bcf         mov rcx, rdi
0x14000194e      4533c0         xor r8d, r8d
0x140001951      ff1511170000   call qword [sym.imp.KERNEL32.dll_RtlLookupFunctionEntry]
