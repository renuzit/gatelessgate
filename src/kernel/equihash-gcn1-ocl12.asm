/* Disassembling 'equihash-Tahiti-32.bin' */
.amd
.gpu Tahiti
.32bit
.compile_options "-DAMD -DWORKSIZE=256 -DAMD_GCN_ASM -DAMD_LEGEACY  -I \"Z:\\GitHub\\gatelessgate\\src\\kernel\" -fbin-as -fbin-amdil -fbin-source"
.driver_info "@(#) OpenCL 1.2 AMD-APP (2117.14).  Driver version: 2117.14 (VM)"
.kernel kernel_init_ht
    .config
        .dims x
        .sgprsnum 22
        .vgprsnum 7
        .hwlocal 4
        .floatmode 0xc0
        .uavid 11
        .uavprivate 0
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x00008098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg round, "uint", uint
        .arg hash_table, "uint*", uint*, global, , 11, unused
        .arg row_counters_src, "uint*", uint*, global, , 11, unused
        .arg row_counters_dst, "uint*", uint*, global, , 11, unused
        .arg sols, "sols_t*", structure*, 32768, global, , 12
        .arg potential_sols, "potential_sols_t*", structure*, 65536, global, , 13
        .arg sync_flags, "uint*", uint*, global, , 14
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c2000504         */ s_buffer_load_dword s0, s[4:7], 0x4
/*c2008518         */ s_buffer_load_dword s1, s[4:7], 0x18
/*c2020900         */ s_buffer_load_dword s4, s[8:11], 0x0
/*c2028904         */ s_buffer_load_dword s5, s[8:11], 0x4
/*c2030914         */ s_buffer_load_dword s6, s[8:11], 0x14
/*c2038918         */ s_buffer_load_dword s7, s[8:11], 0x18
/*c204091c         */ s_buffer_load_dword s8, s[8:11], 0x1c
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8380ff00 0000ffff*/ s_min_u32       s0, s0, 0xffff
/*9300000c         */ s_mul_i32       s0, s12, s0
/*80000100         */ s_add_u32       s0, s0, s1
/*4a000000         */ v_add_i32       v0, vcc, s0, v0
/*8f008104         */ s_lshl_b32      s0, s4, 1
/*87018105         */ s_and_b32       s1, s5, 1
/*8700c200         */ s_and_b32       s0, s0, -2
/*88000001         */ s_or_b32        s0, s1, s0
/*8f008b00         */ s_lshl_b32      s0, s0, 11
/*7d040080         */ v_cmp_eq_i32    vcc, 0, v0
/*be84246a         */ s_and_saveexec_b64 s[4:5], vcc
/*7e020208         */ v_mov_b32       v1, s8
/*bf880015         */ s_cbranch_execz .L180_0
/*d2c20002 00010080*/ v_lshl_b64      v[2:3], 0, 0
/*7e080207         */ v_mov_b32       v4, s7
/*7e0a0280         */ v_mov_b32       v5, 0
/*7e0c0206         */ v_mov_b32       v6, s6
/*4a000000         */ v_add_i32       v0, vcc, s0, v0
/*34000082         */ v_lshlrev_b32   v0, 2, v0
/*c0840370         */ s_load_dwordx4  s[8:11], s[2:3], 0x70
/*c0860368         */ s_load_dwordx4  s[12:15], s[2:3], 0x68
/*c0880360         */ s_load_dwordx4  s[16:19], s[2:3], 0x60
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebdd1000 80020201*/ tbuffer_store_format_xy v[2:3], v1, s[8:11], 0 offen format:[32_32,float]
/*eba41000 80030504*/ tbuffer_store_format_x v5, v4, s[12:15], 0 offen format:[32,float]
/*ebdd1000 80040206*/ tbuffer_store_format_xy v[2:3], v6, s[16:19], 0 offen format:[32_32,float]
/*bf8c0f00         */ s_waitcnt       vmcnt(0) & expcnt(0)
/*d8340000 00000500*/ ds_write_b32    v0, v5 gds
/*bf8c007f         */ s_waitcnt       expcnt(0)
.L180_0:
/*8afe7e04         */ s_andn2_b64     exec, s[4:5], exec
/*bf88000a         */ s_cbranch_execz .L228_0
/*b0010800         */ s_movk_i32      s1, 0x800
/*7d880001         */ v_cmp_gt_u32    vcc, s1, v0
/*be82246a         */ s_and_saveexec_b64 s[2:3], vcc
/*4a000000         */ v_add_i32       v0, vcc, s0, v0
/*bf880005         */ s_cbranch_execz .L228_0
/*34000082         */ v_lshlrev_b32   v0, 2, v0
/*7e020280         */ v_mov_b32       v1, 0
/*d8340000 00000100*/ ds_write_b32    v0, v1 gds
/*bf8c007f         */ s_waitcnt      expcnt(0)
.L228_0:
/*bf810000         */ s_endpgm
.kernel kernel_round0
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 70
        .vgprsnum 51
        .hwlocal 4
        .floatmode 0xc0
        .uavid 11
        .uavprivate 0
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x00008098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg blake_state, "ulong*", ulong*, constant, , 0, 12
        .arg ht, "char*", char*, global, , 13
        .arg row_counters, "uint*", uint*, global, , 11, unused
        .arg sync_flags, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c2000904         */ s_buffer_load_dword s0, s[8:11], 0x4
/*c0880360         */ s_load_dwordx4  s[16:19], s[2:3], 0x60
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8001a000         */ s_add_u32       s1, s0, 32
/*c2ca1000         */ s_buffer_load_dwordx8 s[20:27], s[16:19], s0
/*c2ce1001         */ s_buffer_load_dwordx8 s[28:35], s[16:19], s1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000221a         */ s_add_u32       s0, s26, s34
/*8201231b         */ s_addc_u32      s1, s27, s35
/*893700ff 137e2179*/ s_xor_b32       s55, 0x137e2179, s0
/*893601ff 5be0cd19*/ s_xor_b32       s54, 0x5be0cd19, s1
/*be9003ff 5f1d36f1*/ s_mov_b32       s16, 0x5f1d36f1
/*be9103ff a54ff53a*/ s_mov_b32       s17, 0xa54ff53a
/*80101036         */ s_add_u32       s16, s54, s16
/*82111137         */ s_addc_u32      s17, s55, s17
/*890e1022         */ s_xor_b32       s14, s34, s16
/*890f1123         */ s_xor_b32       s15, s35, s17
/*80221e16         */ s_add_u32       s34, s22, s30
/*82231f17         */ s_addc_u32      s35, s23, s31
/*893f22ff 2b3e6c1f*/ s_xor_b32       s63, 0x2b3e6c1f, s34
/*893e23ff 9b05688c*/ s_xor_b32       s62, 0x9b05688c, s35
/*beb003ff 84caa73b*/ s_mov_b32       s48, 0x84caa73b
/*beb103ff bb67ae85*/ s_mov_b32       s49, 0xbb67ae85
/*90a8980e         */ s_lshr_b64      s[40:41], s[14:15], 24
/*8f0f880e         */ s_lshl_b32      s15, s14, 8
/*802a2018         */ s_add_u32       s42, s24, s32
/*822b2119         */ s_addc_u32      s43, s25, s33
/*802c141c         */ s_add_u32       s44, s28, s20
/*822d151d         */ s_addc_u32      s45, s29, s21
/*880f0f29         */ s_or_b32        s15, s41, s15
/*89412aff 04be4294*/ s_xor_b32       s65, 0x4be4294, s42
/*89402bff e07c2654*/ s_xor_b32       s64, 0xe07c2654, s43
/*beb403ff fe94f82b*/ s_mov_b32       s52, 0xfe94f82b
/*beb503ff 3c6ef372*/ s_mov_b32       s53, 0x3c6ef372
/*c2020518         */ s_buffer_load_dword s4, s[4:7], 0x18
/*8006303e         */ s_add_u32       s6, s62, s48
/*8207313f         */ s_addc_u32      s7, s63, s49
/*89432cff ade68241*/ s_xor_b32       s67, 0xade68241, s44
/*89422dff 510e527f*/ s_xor_b32       s66, 0x510e527f, s45
/*beae03ff f3bcc908*/ s_mov_b32       s46, 0xf3bcc908
/*beaf03ff 6a09e667*/ s_mov_b32       s47, 0x6a09e667
/*8912061e         */ s_xor_b32       s18, s30, s6
/*8913071f         */ s_xor_b32       s19, s31, s7
/*be8e0328         */ s_mov_b32       s14, s40
/*8000000e         */ s_add_u32       s0, s14, s0
/*8201010f         */ s_addc_u32      s1, s15, s1
/*80323440         */ s_add_u32       s50, s64, s52
/*82333541         */ s_addc_u32      s51, s65, s53
/*802e2e42         */ s_add_u32       s46, s66, s46
/*822f2f43         */ s_addc_u32      s47, s67, s47
/*89240036         */ s_xor_b32       s36, s54, s0
/*89250137         */ s_xor_b32       s37, s55, s1
/*89263220         */ s_xor_b32       s38, s32, s50
/*89273321         */ s_xor_b32       s39, s33, s51
/*90b49812         */ s_lshr_b64      s[52:53], s[18:19], 24
/*8f308812         */ s_lshl_b32      s48, s18, 8
/*89122e1c         */ s_xor_b32       s18, s28, s46
/*89132f1d         */ s_xor_b32       s19, s29, s47
/*8f0c880c         */ s_lshl_b32      s12, s12, 8
/*883d3035         */ s_or_b32        s61, s53, s48
/*90b89024         */ s_lshr_b64      s[56:57], s[36:37], 16
/*8f0d9024         */ s_lshl_b32      s13, s36, 16
/*90ba9826         */ s_lshr_b64      s[58:59], s[38:39], 24
/*8f0e8826         */ s_lshl_b32      s14, s38, 8
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8004040c         */ s_add_u32       s4, s12, s4
/*90b69812         */ s_lshr_b64      s[54:55], s[18:19], 24
/*8f0c8812         */ s_lshl_b32      s12, s18, 8
/*88390d39         */ s_or_b32        s57, s57, s13
/*88310e3b         */ s_or_b32        s49, s59, s14
/*4a000004         */ v_add_i32       v0, vcc, s4, v0
/*bebc0334         */ s_mov_b32       s60, s52
/*80223c22         */ s_add_u32       s34, s34, s60
/*82233d23         */ s_addc_u32      s35, s35, s61
/*88040c37         */ s_or_b32        s4, s55, s12
/*beea0480         */ s_mov_b64       vcc, 0
/*7e02022d         */ v_mov_b32       v1, s45
/*7e040236         */ v_mov_b32       v2, s54
/*890c223e         */ s_xor_b32       s12, s62, s34
/*890d233f         */ s_xor_b32       s13, s63, s35
/*50020300         */ v_addc_u32      v1, vcc, v0, v1, vcc
/*4a04042c         */ v_add_i32       v2, vcc, s44, v2
/*7e060204         */ v_mov_b32       v3, s4
/*50020701         */ v_addc_u32      v1, vcc, v1, v3, vcc
/*beb0033a         */ s_mov_b32       s48, s58
/*802a302a         */ s_add_u32       s42, s42, s48
/*822b312b         */ s_addc_u32      s43, s43, s49
/*80101038         */ s_add_u32       s16, s56, s16
/*82111139         */ s_addc_u32      s17, s57, s17
/*89242a40         */ s_xor_b32       s36, s64, s42
/*89252b41         */ s_xor_b32       s37, s65, s43
/*89261028         */ s_xor_b32       s38, s40, s16
/*8927110f         */ s_xor_b32       s39, s15, s17
/*90a8900c         */ s_lshr_b64      s[40:41], s[12:13], 16
/*8f0c900c         */ s_lshl_b32      s12, s12, 16
/*3a060442         */ v_xor_b32       v3, s66, v2
/*3a080243         */ v_xor_b32       v4, s67, v1
/*88290c29         */ s_or_b32        s41, s41, s12
/*90929024         */ s_lshr_b64      s[18:19], s[36:37], 16
/*8f0c9024         */ s_lshl_b32      s12, s36, 16
/*90249f27         */ s_lshr_b32      s36, s39, 31
/*8fa68126         */ s_lshl_b64      s[38:39], s[38:39], 1
/*880d0c13         */ s_or_b32        s13, s19, s12
/*883c2624         */ s_or_b32        s60, s36, s38
/*d2c40004 00012103*/ v_lshr_b64      v[4:5], v[3:4], 16
/*34060690         */ v_lshlrev_b32   v3, 16, v3
/*80060628         */ s_add_u32       s6, s40, s6
/*82070729         */ s_addc_u32      s7, s41, s7
/*38060705         */ v_or_b32        v3, v5, v3
/*d24a6a05 00005d04*/ v_add_i32       v5, vcc, v4, s46
/*7e0c022f         */ v_mov_b32       v6, s47
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*892e0634         */ s_xor_b32       s46, s52, s6
/*892f073d         */ s_xor_b32       s47, s61, s7
/*be8c0312         */ s_mov_b32       s12, s18
/*802c320c         */ s_add_u32       s44, s12, s50
/*822d330d         */ s_addc_u32      s45, s13, s51
/*bebd0327         */ s_mov_b32       s61, s39
/*802a3c2a         */ s_add_u32       s42, s42, s60
/*822b3d2b         */ s_addc_u32      s43, s43, s61
/*89252a28         */ s_xor_b32       s37, s40, s42
/*89052b29         */ s_xor_b32       s5, s41, s43
/*3a0e0a36         */ v_xor_b32       v7, s54, v5
/*3a100c04         */ v_xor_b32       v8, s4, v6
/*890e2c3a         */ s_xor_b32       s14, s58, s44
/*890f2d31         */ s_xor_b32       s15, s49, s45
/*90269f2f         */ s_lshr_b32      s38, s47, 31
/*8fa8812e         */ s_lshl_b64      s[40:41], s[46:47], 1
/*4a0a0a05         */ v_add_i32       v5, vcc, s5, v5
/*7e120225         */ v_mov_b32       v9, s37
/*500c0d09         */ v_addc_u32      v6, vcc, v9, v6, vcc
/*88132826         */ s_or_b32        s19, s38, s40
/*2c12109f         */ v_lshrrev_b32   v9, 31, v8
/*d2c20007 00010307*/ v_lshl_b64      v[7:8], v[7:8], 1
/*90249f0f         */ s_lshr_b32      s36, s15, 31
/*8fae810e         */ s_lshl_b64      s[46:47], s[14:15], 1
/*d24a6a02 00002702*/ v_add_i32       v2, vcc, v2, s19
/*7e140229         */ v_mov_b32       v10, s41
/*50021501         */ v_addc_u32      v1, vcc, v1, v10, vcc
/*3a140a3c         */ v_xor_b32       v10, s60, v5
/*3a160c27         */ v_xor_b32       v11, s39, v6
/*380e0f09         */ v_or_b32        v7, v9, v7
/*880e2e24         */ s_or_b32        s14, s36, s46
/*d24a6a09 00000107*/ v_add_i32       v9, vcc, v7, s0
/*7e180201         */ v_mov_b32       v12, s1
/*50181908         */ v_addc_u32      v12, vcc, v8, v12, vcc
/*3a1a0239         */ v_xor_b32       v13, s57, v1
/*d2c4000e 0001310a*/ v_lshr_b64      v[14:15], v[10:11], 24
/*34141488         */ v_lshlrev_b32   v10, 8, v10
/*be8f032f         */ s_mov_b32       s15, s47
/*8000220e         */ s_add_u32       s0, s14, s34
/*8201230f         */ s_addc_u32      s1, s15, s35
/*3a160438         */ v_xor_b32       v11, s56, v2
/*d24a6a10 0000590d*/ v_add_i32       v16, vcc, v13, s44
/*7e22022d         */ v_mov_b32       v17, s45
/*5022230b         */ v_addc_u32      v17, vcc, v11, v17, vcc
/*3814150f         */ v_or_b32        v10, v15, v10
/*4a1e1c2a         */ v_add_i32       v15, vcc, s42, v14
/*7e24022b         */ v_mov_b32       v18, s43
/*50241512         */ v_addc_u32      v18, vcc, v18, v10, vcc
/*3a26180d         */ v_xor_b32       v19, s13, v12
/*3a060601         */ v_xor_b32       v3, s1, v3
/*3a281212         */ v_xor_b32       v20, s18, v9
/*d24a6a15 00000d13*/ v_add_i32       v21, vcc, v19, s6
/*7e2c0207         */ v_mov_b32       v22, s7
/*502c2d14         */ v_addc_u32      v22, vcc, v20, v22, vcc
/*3a080800         */ v_xor_b32       v4, s0, v4
/*d24a6a17 00002103*/ v_add_i32       v23, vcc, v3, s16
/*7e300211         */ v_mov_b32       v24, s17
/*50303104         */ v_addc_u32      v24, vcc, v4, v24, vcc
/*3a322013         */ v_xor_b32       v25, s19, v16
/*3a342229         */ v_xor_b32       v26, s41, v17
/*3a361e05         */ v_xor_b32       v27, s5, v15
/*3a382425         */ v_xor_b32       v28, s37, v18
/*3a0e2b07         */ v_xor_b32       v7, v7, v21
/*3a102d08         */ v_xor_b32       v8, v8, v22
/*3a3a2e0e         */ v_xor_b32       v29, s14, v23
/*3a3c302f         */ v_xor_b32       v30, s47, v24
/*d2c4001f 00013119*/ v_lshr_b64      v[31:32], v[25:26], 24
/*34323288         */ v_lshlrev_b32   v25, 8, v25
/*d2c40021 0001211b*/ v_lshr_b64      v[33:34], v[27:28], 16
/*34343690         */ v_lshlrev_b32   v26, 16, v27
/*38323320         */ v_or_b32        v25, v32, v25
/*4a043f02         */ v_add_i32       v2, vcc, v2, v31
/*50023301         */ v_addc_u32      v1, vcc, v1, v25, vcc
/*38343522         */ v_or_b32        v26, v34, v26
/*4a0a0b21         */ v_add_i32       v5, vcc, v33, v5
/*500c0d1a         */ v_addc_u32      v6, vcc, v26, v6, vcc
/*d2c4001b 00013107*/ v_lshr_b64      v[27:28], v[7:8], 24
/*340e0e88         */ v_lshlrev_b32   v7, 8, v7
/*d2c40022 0001311d*/ v_lshr_b64      v[34:35], v[29:30], 24
/*34103a88         */ v_lshlrev_b32   v8, 8, v29
/*380e0f1c         */ v_or_b32        v7, v28, v7
/*4a12131b         */ v_add_i32       v9, vcc, v27, v9
/*50181907         */ v_addc_u32      v12, vcc, v7, v12, vcc
/*38101123         */ v_or_b32        v8, v35, v8
/*d24a6a1c 00000122*/ v_add_i32       v28, vcc, v34, s0
/*7e3a0201         */ v_mov_b32       v29, s1
/*503a3b08         */ v_addc_u32      v29, vcc, v8, v29, vcc
/*3a4a050d         */ v_xor_b32       v37, v13, v2
/*3a4c030b         */ v_xor_b32       v38, v11, v1
/*3a4e0b0e         */ v_xor_b32       v39, v14, v5
/*3a500d0a         */ v_xor_b32       v40, v10, v6
/*3a261313         */ v_xor_b32       v19, v19, v9
/*3a281914         */ v_xor_b32       v20, v20, v12
/*3a063903         */ v_xor_b32       v3, v3, v28
/*3a083b04         */ v_xor_b32       v4, v4, v29
/*d2c40023 00012125*/ v_lshr_b64      v[35:36], v[37:38], 16
/*34164a90         */ v_lshlrev_b32   v11, 16, v37
/*2c1a509f         */ v_lshrrev_b32   v13, 31, v40
/*d2c20025 00010327*/ v_lshl_b64      v[37:38], v[39:40], 1
/*38141724         */ v_or_b32        v10, v36, v11
/*4a162123         */ v_add_i32       v11, vcc, v35, v16
/*501c230a         */ v_addc_u32      v14, vcc, v10, v17, vcc
/*381a4b0d         */ v_or_b32        v13, v13, v37
/*d2c40010 00012113*/ v_lshr_b64      v[16:17], v[19:20], 16
/*34262690         */ v_lshlrev_b32   v19, 16, v19
/*d2c40024 00012103*/ v_lshr_b64      v[36:37], v[3:4], 16
/*34060690         */ v_lshlrev_b32   v3, 16, v3
/*38082711         */ v_or_b32        v4, v17, v19
/*4a222b10         */ v_add_i32       v17, vcc, v16, v21
/*50262d04         */ v_addc_u32      v19, vcc, v4, v22, vcc
/*38060725         */ v_or_b32        v3, v37, v3
/*4a282f24         */ v_add_i32       v20, vcc, v36, v23
/*502a3103         */ v_addc_u32      v21, vcc, v3, v24, vcc
/*4a121b09         */ v_add_i32       v9, vcc, v9, v13
/*50184d0c         */ v_addc_u32      v12, vcc, v12, v38, vcc
/*3a2c171f         */ v_xor_b32       v22, v31, v11
/*3a2e1d19         */ v_xor_b32       v23, v25, v14
/*3a3e231b         */ v_xor_b32       v31, v27, v17
/*3a402707         */ v_xor_b32       v32, v7, v19
/*3a302922         */ v_xor_b32       v24, v34, v20
/*3a322b08         */ v_xor_b32       v25, v8, v21
/*3a14190a         */ v_xor_b32       v10, v10, v12
/*2c362e9f         */ v_lshrrev_b32   v27, 31, v23
/*d2c20016 00010316*/ v_lshl_b64      v[22:23], v[22:23], 1
/*3a3c1323         */ v_xor_b32       v30, v35, v9
/*4a28290a         */ v_add_i32       v20, vcc, v10, v20
/*502a2b1e         */ v_addc_u32      v21, vcc, v30, v21, vcc
/*382c2d1b         */ v_or_b32        v22, v27, v22
/*2c36409f         */ v_lshrrev_b32   v27, 31, v32
/*d2c2001f 0001031f*/ v_lshl_b64      v[31:32], v[31:32], 1
/*2c0e329f         */ v_lshrrev_b32   v7, 31, v25
/*d2c20018 00010318*/ v_lshl_b64      v[24:25], v[24:25], 1
/*38103f1b         */ v_or_b32        v8, v27, v31
/*380e3107         */ v_or_b32        v7, v7, v24
/*4a302d1c         */ v_add_i32       v24, vcc, v28, v22
/*50362f1d         */ v_addc_u32      v27, vcc, v29, v23, vcc
/*3a44290d         */ v_xor_b32       v34, v13, v20
/*3a462b26         */ v_xor_b32       v35, v38, v21
/*4a040508         */ v_add_i32       v2, vcc, v8, v2
/*50020320         */ v_addc_u32      v1, vcc, v32, v1, vcc
/*4a1e0f0f         */ v_add_i32       v15, vcc, v15, v7
/*50243312         */ v_addc_u32      v18, vcc, v18, v25, vcc
/*3a34371a         */ v_xor_b32       v26, v26, v27
/*d2c4001c 00013122*/ v_lshr_b64      v[28:29], v[34:35], 24
/*341a4488         */ v_lshlrev_b32   v13, 8, v34
/*3a3e3121         */ v_xor_b32       v31, v33, v24
/*4a22231a         */ v_add_i32       v17, vcc, v26, v17
/*5026271f         */ v_addc_u32      v19, vcc, v31, v19, vcc
/*3a060303         */ v_xor_b32       v3, v3, v1
/*381a1b1d         */ v_or_b32        v13, v29, v13
/*4a12131c         */ v_add_i32       v9, vcc, v28, v9
/*5018190d         */ v_addc_u32      v12, vcc, v13, v12, vcc
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a3a0524         */ v_xor_b32       v29, v36, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1d         */ v_addc_u32      v6, vcc, v29, v6, vcc
/*3a201f10         */ v_xor_b32       v16, v16, v15
/*4a161704         */ v_add_i32       v11, vcc, v4, v11
/*501c1d10         */ v_addc_u32      v14, vcc, v16, v14, vcc
/*3a2c2316         */ v_xor_b32       v22, v22, v17
/*3a2e2717         */ v_xor_b32       v23, v23, v19
/*3a4a130a         */ v_xor_b32       v37, v10, v9
/*3a4c191e         */ v_xor_b32       v38, v30, v12
/*3a4e0b08         */ v_xor_b32       v39, v8, v5
/*3a500d20         */ v_xor_b32       v40, v32, v6
/*3a521707         */ v_xor_b32       v41, v7, v11
/*3a541d19         */ v_xor_b32       v42, v25, v14
/*d2c40021 00013116*/ v_lshr_b64      v[33:34], v[22:23], 24
/*342c2c88         */ v_lshlrev_b32   v22, 8, v22
/*d2c40023 00012125*/ v_lshr_b64      v[35:36], v[37:38], 16
/*34144a90         */ v_lshlrev_b32   v10, 16, v37
/*382c2d22         */ v_or_b32        v22, v34, v22
/*4a2e4318         */ v_add_i32       v23, vcc, v24, v33
/*50302d1b         */ v_addc_u32      v24, vcc, v27, v22, vcc
/*d2c40025 00013127*/ v_lshr_b64      v[37:38], v[39:40], 24
/*34104e88         */ v_lshlrev_b32   v8, 8, v39
/*38141524         */ v_or_b32        v10, v36, v10
/*d2c40027 00013129*/ v_lshr_b64      v[39:40], v[41:42], 24
/*340e5288         */ v_lshlrev_b32   v7, 8, v41
/*4a282923         */ v_add_i32       v20, vcc, v35, v20
/*502a2b0a         */ v_addc_u32      v21, vcc, v10, v21, vcc
/*38101126         */ v_or_b32        v8, v38, v8
/*4a044b02         */ v_add_i32       v2, vcc, v2, v37
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*380e0f28         */ v_or_b32        v7, v40, v7
/*4a1e4f0f         */ v_add_i32       v15, vcc, v15, v39
/*50240f12         */ v_addc_u32      v18, vcc, v18, v7, vcc
/*3a322f1a         */ v_xor_b32       v25, v26, v23
/*3a34311f         */ v_xor_b32       v26, v31, v24
/*3a3e291c         */ v_xor_b32       v31, v28, v20
/*3a402b0d         */ v_xor_b32       v32, v13, v21
/*3a541f04         */ v_xor_b32       v42, v4, v15
/*3a562510         */ v_xor_b32       v43, v16, v18
/*3a360503         */ v_xor_b32       v27, v3, v2
/*3a38031d         */ v_xor_b32       v28, v29, v1
/*d2c4001d 00012119*/ v_lshr_b64      v[29:30], v[25:26], 16
/*34323290         */ v_lshlrev_b32   v25, 16, v25
/*2c34409f         */ v_lshrrev_b32   v26, 31, v32
/*d2c2001f 0001031f*/ v_lshl_b64      v[31:32], v[31:32], 1
/*381a331e         */ v_or_b32        v13, v30, v25
/*4a22231d         */ v_add_i32       v17, vcc, v29, v17
/*5026270d         */ v_addc_u32      v19, vcc, v13, v19, vcc
/*d2c40028 0001212a*/ v_lshr_b64      v[40:41], v[42:43], 16
/*34085490         */ v_lshlrev_b32   v4, 16, v42
/*38203f1a         */ v_or_b32        v16, v26, v31
/*d2c40019 0001211b*/ v_lshr_b64      v[25:26], v[27:28], 16
/*34063690         */ v_lshlrev_b32   v3, 16, v27
/*38080929         */ v_or_b32        v4, v41, v4
/*4a161728         */ v_add_i32       v11, vcc, v40, v11
/*501c1d04         */ v_addc_u32      v14, vcc, v4, v14, vcc
/*4a1e210f         */ v_add_i32       v15, vcc, v15, v16
/*50244112         */ v_addc_u32      v18, vcc, v18, v32, vcc
/*3806071a         */ v_or_b32        v3, v26, v3
/*4a0a0b19         */ v_add_i32       v5, vcc, v25, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*3a422321         */ v_xor_b32       v33, v33, v17
/*3a442716         */ v_xor_b32       v34, v22, v19
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*3a480b25         */ v_xor_b32       v36, v37, v5
/*3a4a0d08         */ v_xor_b32       v37, v8, v6
/*3a361727         */ v_xor_b32       v27, v39, v11
/*3a381d07         */ v_xor_b32       v28, v7, v14
/*2c3c449f         */ v_lshrrev_b32   v30, 31, v34
/*d2c20021 00010321*/ v_lshl_b64      v[33:34], v[33:34], 1
/*3a2c1f1d         */ v_xor_b32       v22, v29, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d16         */ v_addc_u32      v6, vcc, v22, v6, vcc
/*3834431e         */ v_or_b32        v26, v30, v33
/*beea0480         */ s_mov_b64       vcc, 0
/*2c3a4a9f         */ v_lshrrev_b32   v29, 31, v37
/*d2c2001e 00010324*/ v_lshl_b64      v[30:31], v[36:37], 1
/*2c10389f         */ v_lshrrev_b32   v8, 31, v28
/*d2c2001b 0001031b*/ v_lshl_b64      v[27:28], v[27:28], 1
/*50020101         */ v_addc_u32      v1, vcc, v1, v0, vcc
/*4a043502         */ v_add_i32       v2, vcc, v2, v26
/*50024501         */ v_addc_u32      v1, vcc, v1, v34, vcc
/*3a480b10         */ v_xor_b32       v36, v16, v5
/*3a4a0d20         */ v_xor_b32       v37, v32, v6
/*383a3d1d         */ v_or_b32        v29, v29, v30
/*38103708         */ v_or_b32        v8, v8, v27
/*4a12131d         */ v_add_i32       v9, vcc, v29, v9
/*5018191f         */ v_addc_u32      v12, vcc, v31, v12, vcc
/*4a2e2f08         */ v_add_i32       v23, vcc, v8, v23
/*5030311c         */ v_addc_u32      v24, vcc, v28, v24, vcc
/*3a141501         */ v_xor_b32       v10, v1, v10
/*d2c40020 00013124*/ v_lshr_b64      v[32:33], v[36:37], 24
/*340e4888         */ v_lshlrev_b32   v7, 8, v36
/*3a204702         */ v_xor_b32       v16, v2, v35
/*4a16170a         */ v_add_i32       v11, vcc, v10, v11
/*501c1d10         */ v_addc_u32      v14, vcc, v16, v14, vcc
/*380e0f21         */ v_or_b32        v7, v33, v7
/*4a1e410f         */ v_add_i32       v15, vcc, v15, v32
/*50240f12         */ v_addc_u32      v18, vcc, v18, v7, vcc
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a063103         */ v_xor_b32       v3, v3, v24
/*3a361328         */ v_xor_b32       v27, v40, v9
/*4a222304         */ v_add_i32       v17, vcc, v4, v17
/*5026271b         */ v_addc_u32      v19, vcc, v27, v19, vcc
/*3a322f19         */ v_xor_b32       v25, v25, v23
/*4a282903         */ v_add_i32       v20, vcc, v3, v20
/*502a2b19         */ v_addc_u32      v21, vcc, v25, v21, vcc
/*3a46171a         */ v_xor_b32       v35, v26, v11
/*3a481d22         */ v_xor_b32       v36, v34, v14
/*3a4a1f0d         */ v_xor_b32       v37, v13, v15
/*3a4c2516         */ v_xor_b32       v38, v22, v18
/*3a3a231d         */ v_xor_b32       v29, v29, v17
/*3a3c271f         */ v_xor_b32       v30, v31, v19
/*3a4e2908         */ v_xor_b32       v39, v8, v20
/*3a502b1c         */ v_xor_b32       v40, v28, v21
/*d2c40021 00013123*/ v_lshr_b64      v[33:34], v[35:36], 24
/*34344688         */ v_lshlrev_b32   v26, 8, v35
/*d2c40023 00012125*/ v_lshr_b64      v[35:36], v[37:38], 16
/*341a4a90         */ v_lshlrev_b32   v13, 16, v37
/*382c3522         */ v_or_b32        v22, v34, v26
/*4a044302         */ v_add_i32       v2, vcc, v2, v33
/*50022d01         */ v_addc_u32      v1, vcc, v1, v22, vcc
/*381a1b24         */ v_or_b32        v13, v36, v13
/*4a0a0b23         */ v_add_i32       v5, vcc, v35, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*d2c4001e 0001311d*/ v_lshr_b64      v[30:31], v[29:30], 24
/*34343a88         */ v_lshlrev_b32   v26, 8, v29
/*d2c4001c 00013127*/ v_lshr_b64      v[28:29], v[39:40], 24
/*34104e88         */ v_lshlrev_b32   v8, 8, v39
/*3834351f         */ v_or_b32        v26, v31, v26
/*4a12131e         */ v_add_i32       v9, vcc, v30, v9
/*5018191a         */ v_addc_u32      v12, vcc, v26, v12, vcc
/*3810111d         */ v_or_b32        v8, v29, v8
/*4a2e2f1c         */ v_add_i32       v23, vcc, v28, v23
/*50303108         */ v_addc_u32      v24, vcc, v8, v24, vcc
/*3a48050a         */ v_xor_b32       v36, v10, v2
/*3a4a0310         */ v_xor_b32       v37, v16, v1
/*3a4c0b20         */ v_xor_b32       v38, v32, v5
/*3a4e0d07         */ v_xor_b32       v39, v7, v6
/*3a501304         */ v_xor_b32       v40, v4, v9
/*3a52191b         */ v_xor_b32       v41, v27, v12
/*3a542f03         */ v_xor_b32       v42, v3, v23
/*3a563119         */ v_xor_b32       v43, v25, v24
/*d2c4001f 00012124*/ v_lshr_b64      v[31:32], v[36:37], 16
/*34144890         */ v_lshlrev_b32   v10, 16, v36
/*2c204e9f         */ v_lshrrev_b32   v16, 31, v39
/*d2c20024 00010326*/ v_lshl_b64      v[36:37], v[38:39], 1
/*380e1520         */ v_or_b32        v7, v32, v10
/*4a14171f         */ v_add_i32       v10, vcc, v31, v11
/*50161d07         */ v_addc_u32      v11, vcc, v7, v14, vcc
/*381c4910         */ v_or_b32        v14, v16, v36
/*d2c40026 00012128*/ v_lshr_b64      v[38:39], v[40:41], 16
/*34085090         */ v_lshlrev_b32   v4, 16, v40
/*d2c40028 0001212a*/ v_lshr_b64      v[40:41], v[42:43], 16
/*34065490         */ v_lshlrev_b32   v3, 16, v42
/*38080927         */ v_or_b32        v4, v39, v4
/*4a202326         */ v_add_i32       v16, vcc, v38, v17
/*50222704         */ v_addc_u32      v17, vcc, v4, v19, vcc
/*38060729         */ v_or_b32        v3, v41, v3
/*4a262928         */ v_add_i32       v19, vcc, v40, v20
/*50282b03         */ v_addc_u32      v20, vcc, v3, v21, vcc
/*4a121d09         */ v_add_i32       v9, vcc, v9, v14
/*50184b0c         */ v_addc_u32      v12, vcc, v12, v37, vcc
/*3a2a1521         */ v_xor_b32       v21, v33, v10
/*3a2c1716         */ v_xor_b32       v22, v22, v11
/*3a32211e         */ v_xor_b32       v25, v30, v16
/*3a34231a         */ v_xor_b32       v26, v26, v17
/*3a40271c         */ v_xor_b32       v32, v28, v19
/*3a422908         */ v_xor_b32       v33, v8, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*2c382c9f         */ v_lshrrev_b32   v28, 31, v22
/*d2c20015 00010315*/ v_lshl_b64      v[21:22], v[21:22], 1
/*3a3a131f         */ v_xor_b32       v29, v31, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*5028291d         */ v_addc_u32      v20, vcc, v29, v20, vcc
/*382a2b1c         */ v_or_b32        v21, v28, v21
/*2c38349f         */ v_lshrrev_b32   v28, 31, v26
/*d2c20019 00010319*/ v_lshl_b64      v[25:26], v[25:26], 1
/*2c3c429f         */ v_lshrrev_b32   v30, 31, v33
/*d2c2001f 00010320*/ v_lshl_b64      v[31:32], v[32:33], 1
/*3810331c         */ v_or_b32        v8, v28, v25
/*38323f1e         */ v_or_b32        v25, v30, v31
/*4a2e2b17         */ v_add_i32       v23, vcc, v23, v21
/*50302d18         */ v_addc_u32      v24, vcc, v24, v22, vcc
/*3a3c270e         */ v_xor_b32       v30, v14, v19
/*3a3e2925         */ v_xor_b32       v31, v37, v20
/*4a040508         */ v_add_i32       v2, vcc, v8, v2
/*5002031a         */ v_addc_u32      v1, vcc, v26, v1, vcc
/*4a1e330f         */ v_add_i32       v15, vcc, v15, v25
/*50244112         */ v_addc_u32      v18, vcc, v18, v32, vcc
/*3a1a310d         */ v_xor_b32       v13, v13, v24
/*d2c4001b 0001311e*/ v_lshr_b64      v[27:28], v[30:31], 24
/*341c3c88         */ v_lshlrev_b32   v14, 8, v30
/*3a3c2f23         */ v_xor_b32       v30, v35, v23
/*4a20210d         */ v_add_i32       v16, vcc, v13, v16
/*5022231e         */ v_addc_u32      v17, vcc, v30, v17, vcc
/*3a060303         */ v_xor_b32       v3, v3, v1
/*381c1d1c         */ v_or_b32        v14, v28, v14
/*4a12131b         */ v_add_i32       v9, vcc, v27, v9
/*5018190e         */ v_addc_u32      v12, vcc, v14, v12, vcc
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a380528         */ v_xor_b32       v28, v40, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1c         */ v_addc_u32      v6, vcc, v28, v6, vcc
/*3a3e1f26         */ v_xor_b32       v31, v38, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*5016171f         */ v_addc_u32      v11, vcc, v31, v11, vcc
/*3a2a2115         */ v_xor_b32       v21, v21, v16
/*3a2c2316         */ v_xor_b32       v22, v22, v17
/*3a4a1307         */ v_xor_b32       v37, v7, v9
/*3a4c191d         */ v_xor_b32       v38, v29, v12
/*3a4e0b08         */ v_xor_b32       v39, v8, v5
/*3a500d1a         */ v_xor_b32       v40, v26, v6
/*3a321519         */ v_xor_b32       v25, v25, v10
/*3a341720         */ v_xor_b32       v26, v32, v11
/*d2c40021 00013115*/ v_lshr_b64      v[33:34], v[21:22], 24
/*342a2a88         */ v_lshlrev_b32   v21, 8, v21
/*d2c40023 00012125*/ v_lshr_b64      v[35:36], v[37:38], 16
/*340e4a90         */ v_lshlrev_b32   v7, 16, v37
/*382a2b22         */ v_or_b32        v21, v34, v21
/*4a2c4317         */ v_add_i32       v22, vcc, v23, v33
/*502e2b18         */ v_addc_u32      v23, vcc, v24, v21, vcc
/*d2c40025 00013127*/ v_lshr_b64      v[37:38], v[39:40], 24
/*34104e88         */ v_lshlrev_b32   v8, 8, v39
/*380e0f24         */ v_or_b32        v7, v36, v7
/*d2c40027 00013119*/ v_lshr_b64      v[39:40], v[25:26], 24
/*34303288         */ v_lshlrev_b32   v24, 8, v25
/*4a262723         */ v_add_i32       v19, vcc, v35, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*38101126         */ v_or_b32        v8, v38, v8
/*4a044b02         */ v_add_i32       v2, vcc, v2, v37
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*38303128         */ v_or_b32        v24, v40, v24
/*4a1e4f0f         */ v_add_i32       v15, vcc, v15, v39
/*50243112         */ v_addc_u32      v18, vcc, v18, v24, vcc
/*3a502d0d         */ v_xor_b32       v40, v13, v22
/*3a522f1e         */ v_xor_b32       v41, v30, v23
/*3a54271b         */ v_xor_b32       v42, v27, v19
/*3a56290e         */ v_xor_b32       v43, v14, v20
/*3a581f04         */ v_xor_b32       v44, v4, v15
/*3a5a251f         */ v_xor_b32       v45, v31, v18
/*3a5c0503         */ v_xor_b32       v46, v3, v2
/*3a5e031c         */ v_xor_b32       v47, v28, v1
/*d2c4001d 00012128*/ v_lshr_b64      v[29:30], v[40:41], 16
/*341a5090         */ v_lshlrev_b32   v13, 16, v40
/*2c32569f         */ v_lshrrev_b32   v25, 31, v43
/*d2c2001f 0001032a*/ v_lshl_b64      v[31:32], v[42:43], 1
/*381a1b1e         */ v_or_b32        v13, v30, v13
/*4a1c211d         */ v_add_i32       v14, vcc, v29, v16
/*5020230d         */ v_addc_u32      v16, vcc, v13, v17, vcc
/*d2c4001a 0001212c*/ v_lshr_b64      v[26:27], v[44:45], 16
/*34085890         */ v_lshlrev_b32   v4, 16, v44
/*38223f19         */ v_or_b32        v17, v25, v31
/*d2c4001e 0001212e*/ v_lshr_b64      v[30:31], v[46:47], 16
/*34065c90         */ v_lshlrev_b32   v3, 16, v46
/*3808091b         */ v_or_b32        v4, v27, v4
/*4a14151a         */ v_add_i32       v10, vcc, v26, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244112         */ v_addc_u32      v18, vcc, v18, v32, vcc
/*3806071f         */ v_or_b32        v3, v31, v3
/*4a0a0b1e         */ v_add_i32       v5, vcc, v30, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*3a421d21         */ v_xor_b32       v33, v33, v14
/*3a442115         */ v_xor_b32       v34, v21, v16
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*3a480b25         */ v_xor_b32       v36, v37, v5
/*3a4a0d08         */ v_xor_b32       v37, v8, v6
/*3a361527         */ v_xor_b32       v27, v39, v10
/*3a381718         */ v_xor_b32       v28, v24, v11
/*2c3e449f         */ v_lshrrev_b32   v31, 31, v34
/*d2c20021 00010321*/ v_lshl_b64      v[33:34], v[33:34], 1
/*3a2a1f1d         */ v_xor_b32       v21, v29, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d15         */ v_addc_u32      v6, vcc, v21, v6, vcc
/*3832431f         */ v_or_b32        v25, v31, v33
/*2c3a4a9f         */ v_lshrrev_b32   v29, 31, v37
/*d2c20024 00010324*/ v_lshl_b64      v[36:37], v[36:37], 1
/*2c10389f         */ v_lshrrev_b32   v8, 31, v28
/*d2c2001b 0001031b*/ v_lshl_b64      v[27:28], v[27:28], 1
/*4a043302         */ v_add_i32       v2, vcc, v2, v25
/*50024501         */ v_addc_u32      v1, vcc, v1, v34, vcc
/*3a4c0b11         */ v_xor_b32       v38, v17, v5
/*3a4e0d20         */ v_xor_b32       v39, v32, v6
/*383a491d         */ v_or_b32        v29, v29, v36
/*38103708         */ v_or_b32        v8, v8, v27
/*4a12131d         */ v_add_i32       v9, vcc, v29, v9
/*50181925         */ v_addc_u32      v12, vcc, v37, v12, vcc
/*4a2c2d08         */ v_add_i32       v22, vcc, v8, v22
/*502e2f1c         */ v_addc_u32      v23, vcc, v28, v23, vcc
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*d2c4001f 00013126*/ v_lshr_b64      v[31:32], v[38:39], 24
/*34224c88         */ v_lshlrev_b32   v17, 8, v38
/*be800480         */ s_mov_b64       s[0:1], 0
/*3a304702         */ v_xor_b32       v24, v2, v35
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*50161718         */ v_addc_u32      v11, vcc, v24, v11, vcc
/*38222320         */ v_or_b32        v17, v32, v17
/*d2506a12 00020112*/ v_addc_u32      v18, vcc, v18, v0, s[0:1]
/*4a1e3f0f         */ v_add_i32       v15, vcc, v15, v31
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a34131a         */ v_xor_b32       v26, v26, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*5020211a         */ v_addc_u32      v16, vcc, v26, v16, vcc
/*3a362d1e         */ v_xor_b32       v27, v30, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*5028291b         */ v_addc_u32      v20, vcc, v27, v20, vcc
/*3a461519         */ v_xor_b32       v35, v25, v10
/*3a481722         */ v_xor_b32       v36, v34, v11
/*3a4c1f0d         */ v_xor_b32       v38, v13, v15
/*3a4e2515         */ v_xor_b32       v39, v21, v18
/*3a3a1d1d         */ v_xor_b32       v29, v29, v14
/*3a3c2125         */ v_xor_b32       v30, v37, v16
/*3a502708         */ v_xor_b32       v40, v8, v19
/*3a52291c         */ v_xor_b32       v41, v28, v20
/*d2c40021 00013123*/ v_lshr_b64      v[33:34], v[35:36], 24
/*34324688         */ v_lshlrev_b32   v25, 8, v35
/*d2c40023 00012126*/ v_lshr_b64      v[35:36], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*382a3322         */ v_or_b32        v21, v34, v25
/*4a044302         */ v_add_i32       v2, vcc, v2, v33
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*381a1b24         */ v_or_b32        v13, v36, v13
/*4a0a0b23         */ v_add_i32       v5, vcc, v35, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*d2c40024 0001311d*/ v_lshr_b64      v[36:37], v[29:30], 24
/*34323a88         */ v_lshlrev_b32   v25, 8, v29
/*d2c4001c 00013128*/ v_lshr_b64      v[28:29], v[40:41], 24
/*34105088         */ v_lshlrev_b32   v8, 8, v40
/*38323325         */ v_or_b32        v25, v37, v25
/*4a121324         */ v_add_i32       v9, vcc, v36, v9
/*50181919         */ v_addc_u32      v12, vcc, v25, v12, vcc
/*3810111d         */ v_or_b32        v8, v29, v8
/*4a2c2d1c         */ v_add_i32       v22, vcc, v28, v22
/*502e2f08         */ v_addc_u32      v23, vcc, v8, v23, vcc
/*3a4a0507         */ v_xor_b32       v37, v7, v2
/*3a4c0318         */ v_xor_b32       v38, v24, v1
/*3a4e0b1f         */ v_xor_b32       v39, v31, v5
/*3a500d11         */ v_xor_b32       v40, v17, v6
/*3a521304         */ v_xor_b32       v41, v4, v9
/*3a54191a         */ v_xor_b32       v42, v26, v12
/*3a562d03         */ v_xor_b32       v43, v3, v22
/*3a582f1b         */ v_xor_b32       v44, v27, v23
/*d2c4001e 00012125*/ v_lshr_b64      v[30:31], v[37:38], 16
/*340e4a90         */ v_lshlrev_b32   v7, 16, v37
/*2c30509f         */ v_lshrrev_b32   v24, 31, v40
/*d2c20025 00010327*/ v_lshl_b64      v[37:38], v[39:40], 1
/*380e0f1f         */ v_or_b32        v7, v31, v7
/*4a14151e         */ v_add_i32       v10, vcc, v30, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*38224b18         */ v_or_b32        v17, v24, v37
/*d2c4001f 00012129*/ v_lshr_b64      v[31:32], v[41:42], 16
/*34085290         */ v_lshlrev_b32   v4, 16, v41
/*d2c4001a 0001212b*/ v_lshr_b64      v[26:27], v[43:44], 16
/*34065690         */ v_lshlrev_b32   v3, 16, v43
/*38080920         */ v_or_b32        v4, v32, v4
/*4a1c1d1f         */ v_add_i32       v14, vcc, v31, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*3806071b         */ v_or_b32        v3, v27, v3
/*4a26271a         */ v_add_i32       v19, vcc, v26, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*50184d0c         */ v_addc_u32      v12, vcc, v12, v38, vcc
/*3a401521         */ v_xor_b32       v32, v33, v10
/*3a421715         */ v_xor_b32       v33, v21, v11
/*3a481d24         */ v_xor_b32       v36, v36, v14
/*3a4a2119         */ v_xor_b32       v37, v25, v16
/*3a36271c         */ v_xor_b32       v27, v28, v19
/*3a382908         */ v_xor_b32       v28, v8, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*2c3a429f         */ v_lshrrev_b32   v29, 31, v33
/*d2c20020 00010320*/ v_lshl_b64      v[32:33], v[32:33], 1
/*3a2a131e         */ v_xor_b32       v21, v30, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*50282915         */ v_addc_u32      v20, vcc, v21, v20, vcc
/*3830411d         */ v_or_b32        v24, v29, v32
/*2c3a4a9f         */ v_lshrrev_b32   v29, 31, v37
/*d2c20024 00010324*/ v_lshl_b64      v[36:37], v[36:37], 1
/*2c32389f         */ v_lshrrev_b32   v25, 31, v28
/*d2c2001b 0001031b*/ v_lshl_b64      v[27:28], v[27:28], 1
/*3810491d         */ v_or_b32        v8, v29, v36
/*38323719         */ v_or_b32        v25, v25, v27
/*4a2c3116         */ v_add_i32       v22, vcc, v22, v24
/*502e4317         */ v_addc_u32      v23, vcc, v23, v33, vcc
/*3a4e2711         */ v_xor_b32       v39, v17, v19
/*3a502926         */ v_xor_b32       v40, v38, v20
/*4a040508         */ v_add_i32       v2, vcc, v8, v2
/*50020325         */ v_addc_u32      v1, vcc, v37, v1, vcc
/*4a1e330f         */ v_add_i32       v15, vcc, v15, v25
/*50243912         */ v_addc_u32      v18, vcc, v18, v28, vcc
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*d2c4001d 00013127*/ v_lshr_b64      v[29:30], v[39:40], 24
/*34224e88         */ v_lshlrev_b32   v17, 8, v39
/*3a362d23         */ v_xor_b32       v27, v35, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211b         */ v_addc_u32      v16, vcc, v27, v16, vcc
/*3a060303         */ v_xor_b32       v3, v3, v1
/*3822231e         */ v_or_b32        v17, v30, v17
/*4a12131d         */ v_add_i32       v9, vcc, v29, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a34051a         */ v_xor_b32       v26, v26, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1a         */ v_addc_u32      v6, vcc, v26, v6, vcc
/*3a3c1f1f         */ v_xor_b32       v30, v31, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*5016171e         */ v_addc_u32      v11, vcc, v30, v11, vcc
/*3a461d18         */ v_xor_b32       v35, v24, v14
/*3a482121         */ v_xor_b32       v36, v33, v16
/*3a4c1307         */ v_xor_b32       v38, v7, v9
/*3a4e1915         */ v_xor_b32       v39, v21, v12
/*3a500b08         */ v_xor_b32       v40, v8, v5
/*3a520d25         */ v_xor_b32       v41, v37, v6
/*3a541519         */ v_xor_b32       v42, v25, v10
/*3a56171c         */ v_xor_b32       v43, v28, v11
/*d2c40021 00013123*/ v_lshr_b64      v[33:34], v[35:36], 24
/*34304688         */ v_lshlrev_b32   v24, 8, v35
/*beea0480         */ s_mov_b64       vcc, 0
/*d2c40023 00012126*/ v_lshr_b64      v[35:36], v[38:39], 16
/*340e4c90         */ v_lshlrev_b32   v7, 16, v38
/*382a3122         */ v_or_b32        v21, v34, v24
/*502e0117         */ v_addc_u32      v23, vcc, v23, v0, vcc
/*4a2c4316         */ v_add_i32       v22, vcc, v22, v33
/*502e2b17         */ v_addc_u32      v23, vcc, v23, v21, vcc
/*d2c4001f 00013128*/ v_lshr_b64      v[31:32], v[40:41], 24
/*34105088         */ v_lshlrev_b32   v8, 8, v40
/*380e0f24         */ v_or_b32        v7, v36, v7
/*d2c40024 0001312a*/ v_lshr_b64      v[36:37], v[42:43], 24
/*34305488         */ v_lshlrev_b32   v24, 8, v42
/*4a262723         */ v_add_i32       v19, vcc, v35, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*38101120         */ v_or_b32        v8, v32, v8
/*4a043f02         */ v_add_i32       v2, vcc, v2, v31
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*38303125         */ v_or_b32        v24, v37, v24
/*4a1e490f         */ v_add_i32       v15, vcc, v15, v36
/*50243112         */ v_addc_u32      v18, vcc, v18, v24, vcc
/*3a4a2d0d         */ v_xor_b32       v37, v13, v22
/*3a4c2f1b         */ v_xor_b32       v38, v27, v23
/*3a4e271d         */ v_xor_b32       v39, v29, v19
/*3a502911         */ v_xor_b32       v40, v17, v20
/*3a521f04         */ v_xor_b32       v41, v4, v15
/*3a54251e         */ v_xor_b32       v42, v30, v18
/*3a560503         */ v_xor_b32       v43, v3, v2
/*3a58031a         */ v_xor_b32       v44, v26, v1
/*d2c4001d 00012125*/ v_lshr_b64      v[29:30], v[37:38], 16
/*341a4a90         */ v_lshlrev_b32   v13, 16, v37
/*2c32509f         */ v_lshrrev_b32   v25, 31, v40
/*d2c20025 00010327*/ v_lshl_b64      v[37:38], v[39:40], 1
/*381a1b1e         */ v_or_b32        v13, v30, v13
/*4a1c1d1d         */ v_add_i32       v14, vcc, v29, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*d2c4001b 00012129*/ v_lshr_b64      v[27:28], v[41:42], 16
/*34085290         */ v_lshlrev_b32   v4, 16, v41
/*38224b19         */ v_or_b32        v17, v25, v37
/*d2c40019 0001212b*/ v_lshr_b64      v[25:26], v[43:44], 16
/*34065690         */ v_lshlrev_b32   v3, 16, v43
/*3808091c         */ v_or_b32        v4, v28, v4
/*4a14151b         */ v_add_i32       v10, vcc, v27, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244d12         */ v_addc_u32      v18, vcc, v18, v38, vcc
/*3806071a         */ v_or_b32        v3, v26, v3
/*4a0a0b19         */ v_add_i32       v5, vcc, v25, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*3a401d21         */ v_xor_b32       v32, v33, v14
/*3a422115         */ v_xor_b32       v33, v21, v16
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*3a4e0b1f         */ v_xor_b32       v39, v31, v5
/*3a500d08         */ v_xor_b32       v40, v8, v6
/*3a481524         */ v_xor_b32       v36, v36, v10
/*3a4a1718         */ v_xor_b32       v37, v24, v11
/*2c3e429f         */ v_lshrrev_b32   v31, 31, v33
/*d2c20020 00010320*/ v_lshl_b64      v[32:33], v[32:33], 1
/*3a2a1f1d         */ v_xor_b32       v21, v29, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d15         */ v_addc_u32      v6, vcc, v21, v6, vcc
/*3834411f         */ v_or_b32        v26, v31, v32
/*2c3a509f         */ v_lshrrev_b32   v29, 31, v40
/*d2c2001f 00010327*/ v_lshl_b64      v[31:32], v[39:40], 1
/*2c104a9f         */ v_lshrrev_b32   v8, 31, v37
/*d2c20024 00010324*/ v_lshl_b64      v[36:37], v[36:37], 1
/*4a043502         */ v_add_i32       v2, vcc, v2, v26
/*50024301         */ v_addc_u32      v1, vcc, v1, v33, vcc
/*3a4e0b11         */ v_xor_b32       v39, v17, v5
/*3a500d26         */ v_xor_b32       v40, v38, v6
/*38383f1d         */ v_or_b32        v28, v29, v31
/*38104908         */ v_or_b32        v8, v8, v36
/*4a12131c         */ v_add_i32       v9, vcc, v28, v9
/*50181920         */ v_addc_u32      v12, vcc, v32, v12, vcc
/*4a2c2d08         */ v_add_i32       v22, vcc, v8, v22
/*502e2f25         */ v_addc_u32      v23, vcc, v37, v23, vcc
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*d2c4001d 00013127*/ v_lshr_b64      v[29:30], v[39:40], 24
/*34224e88         */ v_lshlrev_b32   v17, 8, v39
/*3a304702         */ v_xor_b32       v24, v2, v35
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*50161718         */ v_addc_u32      v11, vcc, v24, v11, vcc
/*3822231e         */ v_or_b32        v17, v30, v17
/*4a1e3b0f         */ v_add_i32       v15, vcc, v15, v29
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a36131b         */ v_xor_b32       v27, v27, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*5020211b         */ v_addc_u32      v16, vcc, v27, v16, vcc
/*3a322d19         */ v_xor_b32       v25, v25, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*50282919         */ v_addc_u32      v20, vcc, v25, v20, vcc
/*3a46151a         */ v_xor_b32       v35, v26, v10
/*3a481721         */ v_xor_b32       v36, v33, v11
/*3a4c1f0d         */ v_xor_b32       v38, v13, v15
/*3a4e2515         */ v_xor_b32       v39, v21, v18
/*3a501d1c         */ v_xor_b32       v40, v28, v14
/*3a522120         */ v_xor_b32       v41, v32, v16
/*3a542708         */ v_xor_b32       v42, v8, v19
/*3a562925         */ v_xor_b32       v43, v37, v20
/*d2c40021 00013123*/ v_lshr_b64      v[33:34], v[35:36], 24
/*34344688         */ v_lshlrev_b32   v26, 8, v35
/*d2c40023 00012126*/ v_lshr_b64      v[35:36], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*382a3522         */ v_or_b32        v21, v34, v26
/*4a044302         */ v_add_i32       v2, vcc, v2, v33
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*381a1b24         */ v_or_b32        v13, v36, v13
/*4a0a0b23         */ v_add_i32       v5, vcc, v35, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*d2c4001e 00013128*/ v_lshr_b64      v[30:31], v[40:41], 24
/*34345088         */ v_lshlrev_b32   v26, 8, v40
/*d2c40024 0001312a*/ v_lshr_b64      v[36:37], v[42:43], 24
/*34105488         */ v_lshlrev_b32   v8, 8, v42
/*3834351f         */ v_or_b32        v26, v31, v26
/*4a12131e         */ v_add_i32       v9, vcc, v30, v9
/*5018191a         */ v_addc_u32      v12, vcc, v26, v12, vcc
/*38101125         */ v_or_b32        v8, v37, v8
/*4a2c2d24         */ v_add_i32       v22, vcc, v36, v22
/*502e2f08         */ v_addc_u32      v23, vcc, v8, v23, vcc
/*3a4a0507         */ v_xor_b32       v37, v7, v2
/*3a4c0318         */ v_xor_b32       v38, v24, v1
/*3a380b1d         */ v_xor_b32       v28, v29, v5
/*3a3a0d11         */ v_xor_b32       v29, v17, v6
/*3a4e1304         */ v_xor_b32       v39, v4, v9
/*3a50191b         */ v_xor_b32       v40, v27, v12
/*3a522d03         */ v_xor_b32       v41, v3, v22
/*3a542f19         */ v_xor_b32       v42, v25, v23
/*d2c4001f 00012125*/ v_lshr_b64      v[31:32], v[37:38], 16
/*340e4a90         */ v_lshlrev_b32   v7, 16, v37
/*2c303a9f         */ v_lshrrev_b32   v24, 31, v29
/*d2c2001c 0001031c*/ v_lshl_b64      v[28:29], v[28:29], 1
/*380e0f20         */ v_or_b32        v7, v32, v7
/*4a14151f         */ v_add_i32       v10, vcc, v31, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*38223918         */ v_or_b32        v17, v24, v28
/*d2c4001b 00012127*/ v_lshr_b64      v[27:28], v[39:40], 16
/*34084e90         */ v_lshlrev_b32   v4, 16, v39
/*d2c40018 00012129*/ v_lshr_b64      v[24:25], v[41:42], 16
/*34065290         */ v_lshlrev_b32   v3, 16, v41
/*3808091c         */ v_or_b32        v4, v28, v4
/*4a1c1d1b         */ v_add_i32       v14, vcc, v27, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*38060719         */ v_or_b32        v3, v25, v3
/*4a262718         */ v_add_i32       v19, vcc, v24, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*50183b0c         */ v_addc_u32      v12, vcc, v12, v29, vcc
/*3a421521         */ v_xor_b32       v33, v33, v10
/*3a441715         */ v_xor_b32       v34, v21, v11
/*3a4a1d1e         */ v_xor_b32       v37, v30, v14
/*3a4c211a         */ v_xor_b32       v38, v26, v16
/*3a4e2724         */ v_xor_b32       v39, v36, v19
/*3a502908         */ v_xor_b32       v40, v8, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*2c40449f         */ v_lshrrev_b32   v32, 31, v34
/*d2c20021 00010321*/ v_lshl_b64      v[33:34], v[33:34], 1
/*3a2a131f         */ v_xor_b32       v21, v31, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*50282915         */ v_addc_u32      v20, vcc, v21, v20, vcc
/*38324320         */ v_or_b32        v25, v32, v33
/*2c3e4c9f         */ v_lshrrev_b32   v31, 31, v38
/*d2c20020 00010325*/ v_lshl_b64      v[32:33], v[37:38], 1
/*2c34509f         */ v_lshrrev_b32   v26, 31, v40
/*d2c20024 00010327*/ v_lshl_b64      v[36:37], v[39:40], 1
/*3810411f         */ v_or_b32        v8, v31, v32
/*3834491a         */ v_or_b32        v26, v26, v36
/*4a2c3316         */ v_add_i32       v22, vcc, v22, v25
/*502e4517         */ v_addc_u32      v23, vcc, v23, v34, vcc
/*3a3c2711         */ v_xor_b32       v30, v17, v19
/*3a3e291d         */ v_xor_b32       v31, v29, v20
/*4a040508         */ v_add_i32       v2, vcc, v8, v2
/*50020321         */ v_addc_u32      v1, vcc, v33, v1, vcc
/*4a1e350f         */ v_add_i32       v15, vcc, v15, v26
/*50244b12         */ v_addc_u32      v18, vcc, v18, v37, vcc
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*d2c4001c 0001311e*/ v_lshr_b64      v[28:29], v[30:31], 24
/*34223c88         */ v_lshlrev_b32   v17, 8, v30
/*3a3c2d23         */ v_xor_b32       v30, v35, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211e         */ v_addc_u32      v16, vcc, v30, v16, vcc
/*3a060303         */ v_xor_b32       v3, v3, v1
/*3822231d         */ v_or_b32        v17, v29, v17
/*4a12131c         */ v_add_i32       v9, vcc, v28, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a300518         */ v_xor_b32       v24, v24, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d18         */ v_addc_u32      v6, vcc, v24, v6, vcc
/*3a361f1b         */ v_xor_b32       v27, v27, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*5016171b         */ v_addc_u32      v11, vcc, v27, v11, vcc
/*3a461d19         */ v_xor_b32       v35, v25, v14
/*3a482122         */ v_xor_b32       v36, v34, v16
/*3a4c1307         */ v_xor_b32       v38, v7, v9
/*3a4e1915         */ v_xor_b32       v39, v21, v12
/*3a500b08         */ v_xor_b32       v40, v8, v5
/*3a520d21         */ v_xor_b32       v41, v33, v6
/*3a54151a         */ v_xor_b32       v42, v26, v10
/*3a561725         */ v_xor_b32       v43, v37, v11
/*d2c40021 00013123*/ v_lshr_b64      v[33:34], v[35:36], 24
/*34324688         */ v_lshlrev_b32   v25, 8, v35
/*d2c40023 00012126*/ v_lshr_b64      v[35:36], v[38:39], 16
/*340e4c90         */ v_lshlrev_b32   v7, 16, v38
/*382a3322         */ v_or_b32        v21, v34, v25
/*4a2c4316         */ v_add_i32       v22, vcc, v22, v33
/*502e2b17         */ v_addc_u32      v23, vcc, v23, v21, vcc
/*d2c40025 00013128*/ v_lshr_b64      v[37:38], v[40:41], 24
/*34105088         */ v_lshlrev_b32   v8, 8, v40
/*380e0f24         */ v_or_b32        v7, v36, v7
/*d2c4001f 0001312a*/ v_lshr_b64      v[31:32], v[42:43], 24
/*34325488         */ v_lshlrev_b32   v25, 8, v42
/*4a262723         */ v_add_i32       v19, vcc, v35, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*38101126         */ v_or_b32        v8, v38, v8
/*4a044b02         */ v_add_i32       v2, vcc, v2, v37
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*38323320         */ v_or_b32        v25, v32, v25
/*4a1e3f0f         */ v_add_i32       v15, vcc, v15, v31
/*50243312         */ v_addc_u32      v18, vcc, v18, v25, vcc
/*3a4c2d0d         */ v_xor_b32       v38, v13, v22
/*3a4e2f1e         */ v_xor_b32       v39, v30, v23
/*3a50271c         */ v_xor_b32       v40, v28, v19
/*3a522911         */ v_xor_b32       v41, v17, v20
/*3a541f04         */ v_xor_b32       v42, v4, v15
/*3a56251b         */ v_xor_b32       v43, v27, v18
/*3a580503         */ v_xor_b32       v44, v3, v2
/*3a5a0318         */ v_xor_b32       v45, v24, v1
/*d2c4001d 00012126*/ v_lshr_b64      v[29:30], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*2c34529f         */ v_lshrrev_b32   v26, 31, v41
/*d2c20026 00010328*/ v_lshl_b64      v[38:39], v[40:41], 1
/*381a1b1e         */ v_or_b32        v13, v30, v13
/*4a1c1d1d         */ v_add_i32       v14, vcc, v29, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*d2c4001b 0001212a*/ v_lshr_b64      v[27:28], v[42:43], 16
/*34085490         */ v_lshlrev_b32   v4, 16, v42
/*38224d1a         */ v_or_b32        v17, v26, v38
/*d2c40028 0001212c*/ v_lshr_b64      v[40:41], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*3808091c         */ v_or_b32        v4, v28, v4
/*4a14151b         */ v_add_i32       v10, vcc, v27, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244f12         */ v_addc_u32      v18, vcc, v18, v39, vcc
/*38060729         */ v_or_b32        v3, v41, v3
/*4a0a0b28         */ v_add_i32       v5, vcc, v40, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*3a401d21         */ v_xor_b32       v32, v33, v14
/*3a422115         */ v_xor_b32       v33, v21, v16
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*3a480b25         */ v_xor_b32       v36, v37, v5
/*3a4a0d08         */ v_xor_b32       v37, v8, v6
/*3a52151f         */ v_xor_b32       v41, v31, v10
/*3a541719         */ v_xor_b32       v42, v25, v11
/*2c3c429f         */ v_lshrrev_b32   v30, 31, v33
/*d2c2001f 00010320*/ v_lshl_b64      v[31:32], v[32:33], 1
/*3a2a1f1d         */ v_xor_b32       v21, v29, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d15         */ v_addc_u32      v6, vcc, v21, v6, vcc
/*38303f1e         */ v_or_b32        v24, v30, v31
/*2c3a4a9f         */ v_lshrrev_b32   v29, 31, v37
/*d2c2001e 00010324*/ v_lshl_b64      v[30:31], v[36:37], 1
/*2c10549f         */ v_lshrrev_b32   v8, 31, v42
/*d2c20019 00010329*/ v_lshl_b64      v[25:26], v[41:42], 1
/*4a043102         */ v_add_i32       v2, vcc, v2, v24
/*50024101         */ v_addc_u32      v1, vcc, v1, v32, vcc
/*3a480b11         */ v_xor_b32       v36, v17, v5
/*3a4a0d27         */ v_xor_b32       v37, v39, v6
/*383a3d1d         */ v_or_b32        v29, v29, v30
/*38103308         */ v_or_b32        v8, v8, v25
/*4a12131d         */ v_add_i32       v9, vcc, v29, v9
/*5018191f         */ v_addc_u32      v12, vcc, v31, v12, vcc
/*4a2c2d08         */ v_add_i32       v22, vcc, v8, v22
/*502e2f1a         */ v_addc_u32      v23, vcc, v26, v23, vcc
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*d2c40021 00013124*/ v_lshr_b64      v[33:34], v[36:37], 24
/*34224888         */ v_lshlrev_b32   v17, 8, v36
/*3a324702         */ v_xor_b32       v25, v2, v35
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*50161719         */ v_addc_u32      v11, vcc, v25, v11, vcc
/*38222322         */ v_or_b32        v17, v34, v17
/*4a1e430f         */ v_add_i32       v15, vcc, v15, v33
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a36131b         */ v_xor_b32       v27, v27, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*5020211b         */ v_addc_u32      v16, vcc, v27, v16, vcc
/*3a382d28         */ v_xor_b32       v28, v40, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*5028291c         */ v_addc_u32      v20, vcc, v28, v20, vcc
/*3a481518         */ v_xor_b32       v36, v24, v10
/*3a4a1720         */ v_xor_b32       v37, v32, v11
/*3a4c1f0d         */ v_xor_b32       v38, v13, v15
/*3a4e2515         */ v_xor_b32       v39, v21, v18
/*3a3a1d1d         */ v_xor_b32       v29, v29, v14
/*3a3c211f         */ v_xor_b32       v30, v31, v16
/*3a502708         */ v_xor_b32       v40, v8, v19
/*3a52291a         */ v_xor_b32       v41, v26, v20
/*d2c40022 00013124*/ v_lshr_b64      v[34:35], v[36:37], 24
/*34304888         */ v_lshlrev_b32   v24, 8, v36
/*beea0480         */ s_mov_b64       vcc, 0
/*d2c40024 00012126*/ v_lshr_b64      v[36:37], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*382a3123         */ v_or_b32        v21, v35, v24
/*50020101         */ v_addc_u32      v1, vcc, v1, v0, vcc
/*4a044502         */ v_add_i32       v2, vcc, v2, v34
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*381a1b25         */ v_or_b32        v13, v37, v13
/*4a0a0b24         */ v_add_i32       v5, vcc, v36, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*d2c4001e 0001311d*/ v_lshr_b64      v[30:31], v[29:30], 24
/*34303a88         */ v_lshlrev_b32   v24, 8, v29
/*d2c40025 00013128*/ v_lshr_b64      v[37:38], v[40:41], 24
/*34105088         */ v_lshlrev_b32   v8, 8, v40
/*3830311f         */ v_or_b32        v24, v31, v24
/*4a12131e         */ v_add_i32       v9, vcc, v30, v9
/*50181918         */ v_addc_u32      v12, vcc, v24, v12, vcc
/*38101126         */ v_or_b32        v8, v38, v8
/*4a2c2d25         */ v_add_i32       v22, vcc, v37, v22
/*502e2f08         */ v_addc_u32      v23, vcc, v8, v23, vcc
/*3a4c0507         */ v_xor_b32       v38, v7, v2
/*3a4e0319         */ v_xor_b32       v39, v25, v1
/*3a500b21         */ v_xor_b32       v40, v33, v5
/*3a520d11         */ v_xor_b32       v41, v17, v6
/*3a541304         */ v_xor_b32       v42, v4, v9
/*3a56191b         */ v_xor_b32       v43, v27, v12
/*3a582d03         */ v_xor_b32       v44, v3, v22
/*3a5a2f1c         */ v_xor_b32       v45, v28, v23
/*d2c4001f 00012126*/ v_lshr_b64      v[31:32], v[38:39], 16
/*340e4c90         */ v_lshlrev_b32   v7, 16, v38
/*2c32529f         */ v_lshrrev_b32   v25, 31, v41
/*d2c20026 00010328*/ v_lshl_b64      v[38:39], v[40:41], 1
/*380e0f20         */ v_or_b32        v7, v32, v7
/*4a14151f         */ v_add_i32       v10, vcc, v31, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*38224d19         */ v_or_b32        v17, v25, v38
/*d2c40019 0001212a*/ v_lshr_b64      v[25:26], v[42:43], 16
/*34085490         */ v_lshlrev_b32   v4, 16, v42
/*d2c4001b 0001212c*/ v_lshr_b64      v[27:28], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*3808091a         */ v_or_b32        v4, v26, v4
/*4a1c1d19         */ v_add_i32       v14, vcc, v25, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*3806071c         */ v_or_b32        v3, v28, v3
/*4a26271b         */ v_add_i32       v19, vcc, v27, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*50184f0c         */ v_addc_u32      v12, vcc, v12, v39, vcc
/*3a401522         */ v_xor_b32       v32, v34, v10
/*3a421715         */ v_xor_b32       v33, v21, v11
/*3a441d1e         */ v_xor_b32       v34, v30, v14
/*3a462118         */ v_xor_b32       v35, v24, v16
/*3a382725         */ v_xor_b32       v28, v37, v19
/*3a3a2908         */ v_xor_b32       v29, v8, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*2c3c429f         */ v_lshrrev_b32   v30, 31, v33
/*d2c20020 00010320*/ v_lshl_b64      v[32:33], v[32:33], 1
/*3a2a131f         */ v_xor_b32       v21, v31, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*50282915         */ v_addc_u32      v20, vcc, v21, v20, vcc
/*3834411e         */ v_or_b32        v26, v30, v32
/*2c3c469f         */ v_lshrrev_b32   v30, 31, v35
/*d2c2001f 00010322*/ v_lshl_b64      v[31:32], v[34:35], 1
/*2c303a9f         */ v_lshrrev_b32   v24, 31, v29
/*d2c2001c 0001031c*/ v_lshl_b64      v[28:29], v[28:29], 1
/*38103f1e         */ v_or_b32        v8, v30, v31
/*38303918         */ v_or_b32        v24, v24, v28
/*4a2c3516         */ v_add_i32       v22, vcc, v22, v26
/*502e4317         */ v_addc_u32      v23, vcc, v23, v33, vcc
/*3a442711         */ v_xor_b32       v34, v17, v19
/*3a462927         */ v_xor_b32       v35, v39, v20
/*4a040508         */ v_add_i32       v2, vcc, v8, v2
/*50020320         */ v_addc_u32      v1, vcc, v32, v1, vcc
/*4a1e310f         */ v_add_i32       v15, vcc, v15, v24
/*50243b12         */ v_addc_u32      v18, vcc, v18, v29, vcc
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*d2c4001e 00013122*/ v_lshr_b64      v[30:31], v[34:35], 24
/*34224488         */ v_lshlrev_b32   v17, 8, v34
/*3a382d24         */ v_xor_b32       v28, v36, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211c         */ v_addc_u32      v16, vcc, v28, v16, vcc
/*3a060303         */ v_xor_b32       v3, v3, v1
/*3822231f         */ v_or_b32        v17, v31, v17
/*4a12131e         */ v_add_i32       v9, vcc, v30, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a36051b         */ v_xor_b32       v27, v27, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1b         */ v_addc_u32      v6, vcc, v27, v6, vcc
/*3a321f19         */ v_xor_b32       v25, v25, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*50161719         */ v_addc_u32      v11, vcc, v25, v11, vcc
/*3a461d1a         */ v_xor_b32       v35, v26, v14
/*3a482121         */ v_xor_b32       v36, v33, v16
/*3a4a1307         */ v_xor_b32       v37, v7, v9
/*3a4c1915         */ v_xor_b32       v38, v21, v12
/*3a4e0b08         */ v_xor_b32       v39, v8, v5
/*3a500d20         */ v_xor_b32       v40, v32, v6
/*3a521518         */ v_xor_b32       v41, v24, v10
/*3a54171d         */ v_xor_b32       v42, v29, v11
/*d2c40021 00013123*/ v_lshr_b64      v[33:34], v[35:36], 24
/*34344688         */ v_lshlrev_b32   v26, 8, v35
/*d2c40023 00012125*/ v_lshr_b64      v[35:36], v[37:38], 16
/*340e4a90         */ v_lshlrev_b32   v7, 16, v37
/*382a3522         */ v_or_b32        v21, v34, v26
/*4a2c4316         */ v_add_i32       v22, vcc, v22, v33
/*502e2b17         */ v_addc_u32      v23, vcc, v23, v21, vcc
/*d2c4001f 00013127*/ v_lshr_b64      v[31:32], v[39:40], 24
/*34104e88         */ v_lshlrev_b32   v8, 8, v39
/*380e0f24         */ v_or_b32        v7, v36, v7
/*d2c40024 00013129*/ v_lshr_b64      v[36:37], v[41:42], 24
/*34305288         */ v_lshlrev_b32   v24, 8, v41
/*4a262723         */ v_add_i32       v19, vcc, v35, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*38101120         */ v_or_b32        v8, v32, v8
/*4a043f02         */ v_add_i32       v2, vcc, v2, v31
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*38303125         */ v_or_b32        v24, v37, v24
/*4a1e490f         */ v_add_i32       v15, vcc, v15, v36
/*50243112         */ v_addc_u32      v18, vcc, v18, v24, vcc
/*3a4a2d0d         */ v_xor_b32       v37, v13, v22
/*3a4c2f1c         */ v_xor_b32       v38, v28, v23
/*3a4e271e         */ v_xor_b32       v39, v30, v19
/*3a502911         */ v_xor_b32       v40, v17, v20
/*3a521f04         */ v_xor_b32       v41, v4, v15
/*3a542519         */ v_xor_b32       v42, v25, v18
/*3a560503         */ v_xor_b32       v43, v3, v2
/*3a58031b         */ v_xor_b32       v44, v27, v1
/*d2c4001d 00012125*/ v_lshr_b64      v[29:30], v[37:38], 16
/*341a4a90         */ v_lshlrev_b32   v13, 16, v37
/*2c34509f         */ v_lshrrev_b32   v26, 31, v40
/*d2c20025 00010327*/ v_lshl_b64      v[37:38], v[39:40], 1
/*381a1b1e         */ v_or_b32        v13, v30, v13
/*4a1c1d1d         */ v_add_i32       v14, vcc, v29, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*d2c40027 00012129*/ v_lshr_b64      v[39:40], v[41:42], 16
/*34085290         */ v_lshlrev_b32   v4, 16, v41
/*38224b1a         */ v_or_b32        v17, v26, v37
/*d2c40019 0001212b*/ v_lshr_b64      v[25:26], v[43:44], 16
/*34065690         */ v_lshlrev_b32   v3, 16, v43
/*38080928         */ v_or_b32        v4, v40, v4
/*4a141527         */ v_add_i32       v10, vcc, v39, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244d12         */ v_addc_u32      v18, vcc, v18, v38, vcc
/*3806071a         */ v_or_b32        v3, v26, v3
/*4a0a0b19         */ v_add_i32       v5, vcc, v25, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*3a401d21         */ v_xor_b32       v32, v33, v14
/*3a422115         */ v_xor_b32       v33, v21, v16
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*3a500b1f         */ v_xor_b32       v40, v31, v5
/*3a520d08         */ v_xor_b32       v41, v8, v6
/*3a361524         */ v_xor_b32       v27, v36, v10
/*3a381718         */ v_xor_b32       v28, v24, v11
/*2c3c429f         */ v_lshrrev_b32   v30, 31, v33
/*d2c2001f 00010320*/ v_lshl_b64      v[31:32], v[32:33], 1
/*3a2a1f1d         */ v_xor_b32       v21, v29, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d15         */ v_addc_u32      v6, vcc, v21, v6, vcc
/*38343f1e         */ v_or_b32        v26, v30, v31
/*2c3a529f         */ v_lshrrev_b32   v29, 31, v41
/*d2c2001e 00010328*/ v_lshl_b64      v[30:31], v[40:41], 1
/*2c10389f         */ v_lshrrev_b32   v8, 31, v28
/*d2c2001b 0001031b*/ v_lshl_b64      v[27:28], v[27:28], 1
/*4a043502         */ v_add_i32       v2, vcc, v2, v26
/*50024101         */ v_addc_u32      v1, vcc, v1, v32, vcc
/*3a480b11         */ v_xor_b32       v36, v17, v5
/*3a4a0d26         */ v_xor_b32       v37, v38, v6
/*383a3d1d         */ v_or_b32        v29, v29, v30
/*beea0480         */ s_mov_b64       vcc, 0
/*38103708         */ v_or_b32        v8, v8, v27
/*5036011f         */ v_addc_u32      v27, vcc, v31, v0, vcc
/*4a12131d         */ v_add_i32       v9, vcc, v29, v9
/*5018191b         */ v_addc_u32      v12, vcc, v27, v12, vcc
/*4a2c2d08         */ v_add_i32       v22, vcc, v8, v22
/*502e2f1c         */ v_addc_u32      v23, vcc, v28, v23, vcc
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*d2c40021 00013124*/ v_lshr_b64      v[33:34], v[36:37], 24
/*34224888         */ v_lshlrev_b32   v17, 8, v36
/*3a304702         */ v_xor_b32       v24, v2, v35
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*50161718         */ v_addc_u32      v11, vcc, v24, v11, vcc
/*38222322         */ v_or_b32        v17, v34, v17
/*4a1e430f         */ v_add_i32       v15, vcc, v15, v33
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a361327         */ v_xor_b32       v27, v39, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*5020211b         */ v_addc_u32      v16, vcc, v27, v16, vcc
/*3a322d19         */ v_xor_b32       v25, v25, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*50282919         */ v_addc_u32      v20, vcc, v25, v20, vcc
/*3a48151a         */ v_xor_b32       v36, v26, v10
/*3a4a1720         */ v_xor_b32       v37, v32, v11
/*3a4c1f0d         */ v_xor_b32       v38, v13, v15
/*3a4e2515         */ v_xor_b32       v39, v21, v18
/*3a3a1d1d         */ v_xor_b32       v29, v29, v14
/*3a3c211f         */ v_xor_b32       v30, v31, v16
/*3a502708         */ v_xor_b32       v40, v8, v19
/*3a52291c         */ v_xor_b32       v41, v28, v20
/*d2c40022 00013124*/ v_lshr_b64      v[34:35], v[36:37], 24
/*34344888         */ v_lshlrev_b32   v26, 8, v36
/*d2c40024 00012126*/ v_lshr_b64      v[36:37], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*382a3523         */ v_or_b32        v21, v35, v26
/*4a044502         */ v_add_i32       v2, vcc, v2, v34
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*381a1b25         */ v_or_b32        v13, v37, v13
/*4a0a0b24         */ v_add_i32       v5, vcc, v36, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*d2c4001e 0001311d*/ v_lshr_b64      v[30:31], v[29:30], 24
/*34343a88         */ v_lshlrev_b32   v26, 8, v29
/*d2c4001c 00013128*/ v_lshr_b64      v[28:29], v[40:41], 24
/*34105088         */ v_lshlrev_b32   v8, 8, v40
/*3834351f         */ v_or_b32        v26, v31, v26
/*4a12131e         */ v_add_i32       v9, vcc, v30, v9
/*5018191a         */ v_addc_u32      v12, vcc, v26, v12, vcc
/*3810111d         */ v_or_b32        v8, v29, v8
/*4a2c2d1c         */ v_add_i32       v22, vcc, v28, v22
/*502e2f08         */ v_addc_u32      v23, vcc, v8, v23, vcc
/*3a4a0507         */ v_xor_b32       v37, v7, v2
/*3a4c0318         */ v_xor_b32       v38, v24, v1
/*3a4e0b21         */ v_xor_b32       v39, v33, v5
/*3a500d11         */ v_xor_b32       v40, v17, v6
/*3a521304         */ v_xor_b32       v41, v4, v9
/*3a54191b         */ v_xor_b32       v42, v27, v12
/*3a562d03         */ v_xor_b32       v43, v3, v22
/*3a582f19         */ v_xor_b32       v44, v25, v23
/*d2c4001f 00012125*/ v_lshr_b64      v[31:32], v[37:38], 16
/*340e4a90         */ v_lshlrev_b32   v7, 16, v37
/*2c30509f         */ v_lshrrev_b32   v24, 31, v40
/*d2c20025 00010327*/ v_lshl_b64      v[37:38], v[39:40], 1
/*380e0f20         */ v_or_b32        v7, v32, v7
/*4a14151f         */ v_add_i32       v10, vcc, v31, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*38224b18         */ v_or_b32        v17, v24, v37
/*d2c40020 00012129*/ v_lshr_b64      v[32:33], v[41:42], 16
/*34085290         */ v_lshlrev_b32   v4, 16, v41
/*d2c40018 0001212b*/ v_lshr_b64      v[24:25], v[43:44], 16
/*34065690         */ v_lshlrev_b32   v3, 16, v43
/*38080921         */ v_or_b32        v4, v33, v4
/*4a1c1d20         */ v_add_i32       v14, vcc, v32, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*38060719         */ v_or_b32        v3, v25, v3
/*4a262718         */ v_add_i32       v19, vcc, v24, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*50184d0c         */ v_addc_u32      v12, vcc, v12, v38, vcc
/*3a421522         */ v_xor_b32       v33, v34, v10
/*3a441715         */ v_xor_b32       v34, v21, v11
/*3a4e1d1e         */ v_xor_b32       v39, v30, v14
/*3a50211a         */ v_xor_b32       v40, v26, v16
/*3a52271c         */ v_xor_b32       v41, v28, v19
/*3a542908         */ v_xor_b32       v42, v8, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*2c3a449f         */ v_lshrrev_b32   v29, 31, v34
/*d2c20021 00010321*/ v_lshl_b64      v[33:34], v[33:34], 1
/*3a2a131f         */ v_xor_b32       v21, v31, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*50282915         */ v_addc_u32      v20, vcc, v21, v20, vcc
/*3832431d         */ v_or_b32        v25, v29, v33
/*2c3a509f         */ v_lshrrev_b32   v29, 31, v40
/*d2c2001a 00010327*/ v_lshl_b64      v[26:27], v[39:40], 1
/*2c3c549f         */ v_lshrrev_b32   v30, 31, v42
/*d2c20027 00010329*/ v_lshl_b64      v[39:40], v[41:42], 1
/*3810351d         */ v_or_b32        v8, v29, v26
/*38344f1e         */ v_or_b32        v26, v30, v39
/*4a2c3316         */ v_add_i32       v22, vcc, v22, v25
/*502e4517         */ v_addc_u32      v23, vcc, v23, v34, vcc
/*3a3c2711         */ v_xor_b32       v30, v17, v19
/*3a3e2926         */ v_xor_b32       v31, v38, v20
/*be800480         */ s_mov_b64       s[0:1], 0
/*4a040508         */ v_add_i32       v2, vcc, v8, v2
/*5002031b         */ v_addc_u32      v1, vcc, v27, v1, vcc
/*4a1e350f         */ v_add_i32       v15, vcc, v15, v26
/*50245112         */ v_addc_u32      v18, vcc, v18, v40, vcc
/*d2506a17 00020117*/ v_addc_u32      v23, vcc, v23, v0, s[0:1]
/*d2c4001c 0001311e*/ v_lshr_b64      v[28:29], v[30:31], 24
/*34223c88         */ v_lshlrev_b32   v17, 8, v30
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*3a060303         */ v_xor_b32       v3, v3, v1
/*3822231d         */ v_or_b32        v17, v29, v17
/*4a12131c         */ v_add_i32       v9, vcc, v28, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a3a2d24         */ v_xor_b32       v29, v36, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211d         */ v_addc_u32      v16, vcc, v29, v16, vcc
/*3a300518         */ v_xor_b32       v24, v24, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d18         */ v_addc_u32      v6, vcc, v24, v6, vcc
/*3a3c1f20         */ v_xor_b32       v30, v32, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*5016171e         */ v_addc_u32      v11, vcc, v30, v11, vcc
/*3a461307         */ v_xor_b32       v35, v7, v9
/*3a481915         */ v_xor_b32       v36, v21, v12
/*3a4a1d19         */ v_xor_b32       v37, v25, v14
/*3a4c2122         */ v_xor_b32       v38, v34, v16
/*3a520b08         */ v_xor_b32       v41, v8, v5
/*3a540d1b         */ v_xor_b32       v42, v27, v6
/*3a32151a         */ v_xor_b32       v25, v26, v10
/*3a341728         */ v_xor_b32       v26, v40, v11
/*d2c40021 00012123*/ v_lshr_b64      v[33:34], v[35:36], 16
/*340e4690         */ v_lshlrev_b32   v7, 16, v35
/*d2c40023 00013125*/ v_lshr_b64      v[35:36], v[37:38], 24
/*342a4a88         */ v_lshlrev_b32   v21, 8, v37
/*d2c40025 00013129*/ v_lshr_b64      v[37:38], v[41:42], 24
/*34105288         */ v_lshlrev_b32   v8, 8, v41
/*380e0f22         */ v_or_b32        v7, v34, v7
/*d2c4001f 00013119*/ v_lshr_b64      v[31:32], v[25:26], 24
/*34323288         */ v_lshlrev_b32   v25, 8, v25
/*4a262721         */ v_add_i32       v19, vcc, v33, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*382a2b24         */ v_or_b32        v21, v36, v21
/*4a2c4716         */ v_add_i32       v22, vcc, v22, v35
/*502e2b17         */ v_addc_u32      v23, vcc, v23, v21, vcc
/*38101126         */ v_or_b32        v8, v38, v8
/*4a044b02         */ v_add_i32       v2, vcc, v2, v37
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*38323320         */ v_or_b32        v25, v32, v25
/*4a1e3f0f         */ v_add_i32       v15, vcc, v15, v31
/*50243312         */ v_addc_u32      v18, vcc, v18, v25, vcc
/*3a4c271c         */ v_xor_b32       v38, v28, v19
/*3a4e2911         */ v_xor_b32       v39, v17, v20
/*3a502d0d         */ v_xor_b32       v40, v13, v22
/*3a522f1d         */ v_xor_b32       v41, v29, v23
/*3a541f04         */ v_xor_b32       v42, v4, v15
/*3a56251e         */ v_xor_b32       v43, v30, v18
/*3a580503         */ v_xor_b32       v44, v3, v2
/*3a5a0318         */ v_xor_b32       v45, v24, v1
/*2c3a4e9f         */ v_lshrrev_b32   v29, 31, v39
/*d2c20026 00010326*/ v_lshl_b64      v[38:39], v[38:39], 1
/*d2c4001a 00012128*/ v_lshr_b64      v[26:27], v[40:41], 16
/*341a5090         */ v_lshlrev_b32   v13, 16, v40
/*d2c40028 0001212a*/ v_lshr_b64      v[40:41], v[42:43], 16
/*34085490         */ v_lshlrev_b32   v4, 16, v42
/*38224d1d         */ v_or_b32        v17, v29, v38
/*d2c4001c 0001212c*/ v_lshr_b64      v[28:29], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*381a1b1b         */ v_or_b32        v13, v27, v13
/*4a1c1d1a         */ v_add_i32       v14, vcc, v26, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*38080929         */ v_or_b32        v4, v41, v4
/*4a141528         */ v_add_i32       v10, vcc, v40, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244f12         */ v_addc_u32      v18, vcc, v18, v39, vcc
/*3806071d         */ v_or_b32        v3, v29, v3
/*4a0a0b1c         */ v_add_i32       v5, vcc, v28, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*3a441d23         */ v_xor_b32       v34, v35, v14
/*3a462115         */ v_xor_b32       v35, v21, v16
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*3a480b25         */ v_xor_b32       v36, v37, v5
/*3a4a0d08         */ v_xor_b32       v37, v8, v6
/*3a30151f         */ v_xor_b32       v24, v31, v10
/*3a321719         */ v_xor_b32       v25, v25, v11
/*3a341f1a         */ v_xor_b32       v26, v26, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d1a         */ v_addc_u32      v6, vcc, v26, v6, vcc
/*2c3c469f         */ v_lshrrev_b32   v30, 31, v35
/*d2c2001f 00010322*/ v_lshl_b64      v[31:32], v[34:35], 1
/*2c2a4a9f         */ v_lshrrev_b32   v21, 31, v37
/*d2c20022 00010324*/ v_lshl_b64      v[34:35], v[36:37], 1
/*2c10329f         */ v_lshrrev_b32   v8, 31, v25
/*d2c20018 00010318*/ v_lshl_b64      v[24:25], v[24:25], 1
/*38363f1e         */ v_or_b32        v27, v30, v31
/*3a480b11         */ v_xor_b32       v36, v17, v5
/*3a4a0d27         */ v_xor_b32       v37, v39, v6
/*382a4515         */ v_or_b32        v21, v21, v34
/*38103108         */ v_or_b32        v8, v8, v24
/*4a043702         */ v_add_i32       v2, vcc, v2, v27
/*50024101         */ v_addc_u32      v1, vcc, v1, v32, vcc
/*4a121315         */ v_add_i32       v9, vcc, v21, v9
/*50181923         */ v_addc_u32      v12, vcc, v35, v12, vcc
/*4a2c2d08         */ v_add_i32       v22, vcc, v8, v22
/*502e2f19         */ v_addc_u32      v23, vcc, v25, v23, vcc
/*d2c4001d 00013124*/ v_lshr_b64      v[29:30], v[36:37], 24
/*34224888         */ v_lshlrev_b32   v17, 8, v36
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*3822231e         */ v_or_b32        v17, v30, v17
/*4a1e3b0f         */ v_add_i32       v15, vcc, v15, v29
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a304302         */ v_xor_b32       v24, v2, v33
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*50161718         */ v_addc_u32      v11, vcc, v24, v11, vcc
/*3a3c1328         */ v_xor_b32       v30, v40, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*5020211e         */ v_addc_u32      v16, vcc, v30, v16, vcc
/*3a382d1c         */ v_xor_b32       v28, v28, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*5028291c         */ v_addc_u32      v20, vcc, v28, v20, vcc
/*3a481f0d         */ v_xor_b32       v36, v13, v15
/*3a4a251a         */ v_xor_b32       v37, v26, v18
/*3a34151b         */ v_xor_b32       v26, v27, v10
/*3a361720         */ v_xor_b32       v27, v32, v11
/*3a4c1d15         */ v_xor_b32       v38, v21, v14
/*3a4e2123         */ v_xor_b32       v39, v35, v16
/*3a502708         */ v_xor_b32       v40, v8, v19
/*3a522919         */ v_xor_b32       v41, v25, v20
/*d2c40021 00012124*/ v_lshr_b64      v[33:34], v[36:37], 16
/*341a4890         */ v_lshlrev_b32   v13, 16, v36
/*d2c40023 0001311a*/ v_lshr_b64      v[35:36], v[26:27], 24
/*34343488         */ v_lshlrev_b32   v26, 8, v26
/*381a1b22         */ v_or_b32        v13, v34, v13
/*4a0a0b21         */ v_add_i32       v5, vcc, v33, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*d2c4001f 00013126*/ v_lshr_b64      v[31:32], v[38:39], 24
/*342a4c88         */ v_lshlrev_b32   v21, 8, v38
/*d2c40025 00013128*/ v_lshr_b64      v[37:38], v[40:41], 24
/*34105088         */ v_lshlrev_b32   v8, 8, v40
/*38323524         */ v_or_b32        v25, v36, v26
/*4a044702         */ v_add_i32       v2, vcc, v2, v35
/*50023301         */ v_addc_u32      v1, vcc, v1, v25, vcc
/*382a2b20         */ v_or_b32        v21, v32, v21
/*4a12131f         */ v_add_i32       v9, vcc, v31, v9
/*50181915         */ v_addc_u32      v12, vcc, v21, v12, vcc
/*38101126         */ v_or_b32        v8, v38, v8
/*4a2c2d25         */ v_add_i32       v22, vcc, v37, v22
/*502e2f08         */ v_addc_u32      v23, vcc, v8, v23, vcc
/*3a4c0b1d         */ v_xor_b32       v38, v29, v5
/*3a4e0d11         */ v_xor_b32       v39, v17, v6
/*3a540507         */ v_xor_b32       v42, v7, v2
/*3a560318         */ v_xor_b32       v43, v24, v1
/*3a581304         */ v_xor_b32       v44, v4, v9
/*3a5a191e         */ v_xor_b32       v45, v30, v12
/*3a5c2d03         */ v_xor_b32       v46, v3, v22
/*3a5e2f1c         */ v_xor_b32       v47, v28, v23
/*2c3a4e9f         */ v_lshrrev_b32   v29, 31, v39
/*d2c20026 00010326*/ v_lshl_b64      v[38:39], v[38:39], 1
/*d2c40028 0001212a*/ v_lshr_b64      v[40:41], v[42:43], 16
/*340e5490         */ v_lshlrev_b32   v7, 16, v42
/*38224d1d         */ v_or_b32        v17, v29, v38
/*d2c4001a 0001212c*/ v_lshr_b64      v[26:27], v[44:45], 16
/*34085890         */ v_lshlrev_b32   v4, 16, v44
/*d2c4001c 0001212e*/ v_lshr_b64      v[28:29], v[46:47], 16
/*34065c90         */ v_lshlrev_b32   v3, 16, v46
/*380e0f29         */ v_or_b32        v7, v41, v7
/*4a141528         */ v_add_i32       v10, vcc, v40, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*3808091b         */ v_or_b32        v4, v27, v4
/*4a1c1d1a         */ v_add_i32       v14, vcc, v26, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*3806071d         */ v_or_b32        v3, v29, v3
/*4a26271c         */ v_add_i32       v19, vcc, v28, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*50184f0c         */ v_addc_u32      v12, vcc, v12, v39, vcc
/*3a301523         */ v_xor_b32       v24, v35, v10
/*3a321719         */ v_xor_b32       v25, v25, v11
/*3a441d1f         */ v_xor_b32       v34, v31, v14
/*3a462115         */ v_xor_b32       v35, v21, v16
/*3a482725         */ v_xor_b32       v36, v37, v19
/*3a4a2908         */ v_xor_b32       v37, v8, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*3a3c1328         */ v_xor_b32       v30, v40, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*5028291e         */ v_addc_u32      v20, vcc, v30, v20, vcc
/*2c3e329f         */ v_lshrrev_b32   v31, 31, v25
/*d2c20018 00010318*/ v_lshl_b64      v[24:25], v[24:25], 1
/*2c40469f         */ v_lshrrev_b32   v32, 31, v35
/*d2c20022 00010322*/ v_lshl_b64      v[34:35], v[34:35], 1
/*2c2a4a9f         */ v_lshrrev_b32   v21, 31, v37
/*d2c20024 00010324*/ v_lshl_b64      v[36:37], v[36:37], 1
/*3810311f         */ v_or_b32        v8, v31, v24
/*38304520         */ v_or_b32        v24, v32, v34
/*382a4915         */ v_or_b32        v21, v21, v36
/*3a4c2711         */ v_xor_b32       v38, v17, v19
/*3a4e2927         */ v_xor_b32       v39, v39, v20
/*4a2c1116         */ v_add_i32       v22, vcc, v22, v8
/*502e3317         */ v_addc_u32      v23, vcc, v23, v25, vcc
/*4a040518         */ v_add_i32       v2, vcc, v24, v2
/*50020323         */ v_addc_u32      v1, vcc, v35, v1, vcc
/*4a1e2b0f         */ v_add_i32       v15, vcc, v15, v21
/*50244b12         */ v_addc_u32      v18, vcc, v18, v37, vcc
/*d2c4001f 00013126*/ v_lshr_b64      v[31:32], v[38:39], 24
/*34224c88         */ v_lshlrev_b32   v17, 8, v38
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*3a060303         */ v_xor_b32       v3, v3, v1
/*38222320         */ v_or_b32        v17, v32, v17
/*4a12131f         */ v_add_i32       v9, vcc, v31, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a362d21         */ v_xor_b32       v27, v33, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211b         */ v_addc_u32      v16, vcc, v27, v16, vcc
/*3a38051c         */ v_xor_b32       v28, v28, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1c         */ v_addc_u32      v6, vcc, v28, v6, vcc
/*3a341f1a         */ v_xor_b32       v26, v26, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*5016171a         */ v_addc_u32      v11, vcc, v26, v11, vcc
/*3a4c1307         */ v_xor_b32       v38, v7, v9
/*3a4e191e         */ v_xor_b32       v39, v30, v12
/*3a501d08         */ v_xor_b32       v40, v8, v14
/*3a522119         */ v_xor_b32       v41, v25, v16
/*3a300b18         */ v_xor_b32       v24, v24, v5
/*3a320d23         */ v_xor_b32       v25, v35, v6
/*3a541515         */ v_xor_b32       v42, v21, v10
/*3a561725         */ v_xor_b32       v43, v37, v11
/*d2c40021 00012126*/ v_lshr_b64      v[33:34], v[38:39], 16
/*340e4c90         */ v_lshlrev_b32   v7, 16, v38
/*d2c40023 00013128*/ v_lshr_b64      v[35:36], v[40:41], 24
/*34105088         */ v_lshlrev_b32   v8, 8, v40
/*d2c4001d 00013118*/ v_lshr_b64      v[29:30], v[24:25], 24
/*34303088         */ v_lshlrev_b32   v24, 8, v24
/*380e0f22         */ v_or_b32        v7, v34, v7
/*d2c40025 0001312a*/ v_lshr_b64      v[37:38], v[42:43], 24
/*342a5488         */ v_lshlrev_b32   v21, 8, v42
/*be800480         */ s_mov_b64       s[0:1], 0
/*4a262721         */ v_add_i32       v19, vcc, v33, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*38101124         */ v_or_b32        v8, v36, v8
/*4a2c4716         */ v_add_i32       v22, vcc, v22, v35
/*502e1117         */ v_addc_u32      v23, vcc, v23, v8, vcc
/*3830311e         */ v_or_b32        v24, v30, v24
/*4a043b02         */ v_add_i32       v2, vcc, v2, v29
/*50023101         */ v_addc_u32      v1, vcc, v1, v24, vcc
/*382a2b26         */ v_or_b32        v21, v38, v21
/*d2506a12 00020112*/ v_addc_u32      v18, vcc, v18, v0, s[0:1]
/*4a1e4b0f         */ v_add_i32       v15, vcc, v15, v37
/*50242b12         */ v_addc_u32      v18, vcc, v18, v21, vcc
/*3a3e271f         */ v_xor_b32       v31, v31, v19
/*3a402911         */ v_xor_b32       v32, v17, v20
/*3a502d0d         */ v_xor_b32       v40, v13, v22
/*3a522f1b         */ v_xor_b32       v41, v27, v23
/*3a541f04         */ v_xor_b32       v42, v4, v15
/*3a56251a         */ v_xor_b32       v43, v26, v18
/*3a580503         */ v_xor_b32       v44, v3, v2
/*3a5a031c         */ v_xor_b32       v45, v28, v1
/*2c3c409f         */ v_lshrrev_b32   v30, 31, v32
/*d2c2001f 0001031f*/ v_lshl_b64      v[31:32], v[31:32], 1
/*d2c40026 00012128*/ v_lshr_b64      v[38:39], v[40:41], 16
/*341a5090         */ v_lshlrev_b32   v13, 16, v40
/*d2c40019 0001212a*/ v_lshr_b64      v[25:26], v[42:43], 16
/*34085490         */ v_lshlrev_b32   v4, 16, v42
/*38223f1e         */ v_or_b32        v17, v30, v31
/*d2c4001b 0001212c*/ v_lshr_b64      v[27:28], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*381a1b27         */ v_or_b32        v13, v39, v13
/*4a1c1d26         */ v_add_i32       v14, vcc, v38, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*3808091a         */ v_or_b32        v4, v26, v4
/*4a141519         */ v_add_i32       v10, vcc, v25, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244112         */ v_addc_u32      v18, vcc, v18, v32, vcc
/*3806071c         */ v_or_b32        v3, v28, v3
/*4a0a0b1b         */ v_add_i32       v5, vcc, v27, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*3a441d23         */ v_xor_b32       v34, v35, v14
/*3a462108         */ v_xor_b32       v35, v8, v16
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*3a4e0b1d         */ v_xor_b32       v39, v29, v5
/*3a500d18         */ v_xor_b32       v40, v24, v6
/*3a381525         */ v_xor_b32       v28, v37, v10
/*3a3a1715         */ v_xor_b32       v29, v21, v11
/*3a3c1f26         */ v_xor_b32       v30, v38, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d1e         */ v_addc_u32      v6, vcc, v30, v6, vcc
/*2c3e469f         */ v_lshrrev_b32   v31, 31, v35
/*d2c20022 00010322*/ v_lshl_b64      v[34:35], v[34:35], 1
/*2c10509f         */ v_lshrrev_b32   v8, 31, v40
/*d2c20024 00010327*/ v_lshl_b64      v[36:37], v[39:40], 1
/*2c303a9f         */ v_lshrrev_b32   v24, 31, v29
/*d2c2001c 0001031c*/ v_lshl_b64      v[28:29], v[28:29], 1
/*382a451f         */ v_or_b32        v21, v31, v34
/*3a4c0b11         */ v_xor_b32       v38, v17, v5
/*3a4e0d20         */ v_xor_b32       v39, v32, v6
/*38104908         */ v_or_b32        v8, v8, v36
/*38303918         */ v_or_b32        v24, v24, v28
/*4a042b02         */ v_add_i32       v2, vcc, v2, v21
/*50024701         */ v_addc_u32      v1, vcc, v1, v35, vcc
/*4a121308         */ v_add_i32       v9, vcc, v8, v9
/*50181925         */ v_addc_u32      v12, vcc, v37, v12, vcc
/*4a2c2d18         */ v_add_i32       v22, vcc, v24, v22
/*502e2f1d         */ v_addc_u32      v23, vcc, v29, v23, vcc
/*d2c4001f 00013126*/ v_lshr_b64      v[31:32], v[38:39], 24
/*34224c88         */ v_lshlrev_b32   v17, 8, v38
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*38222320         */ v_or_b32        v17, v32, v17
/*4a1e3f0f         */ v_add_i32       v15, vcc, v15, v31
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a344302         */ v_xor_b32       v26, v2, v33
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*5016171a         */ v_addc_u32      v11, vcc, v26, v11, vcc
/*3a321319         */ v_xor_b32       v25, v25, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*50202119         */ v_addc_u32      v16, vcc, v25, v16, vcc
/*3a362d1b         */ v_xor_b32       v27, v27, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*5028291b         */ v_addc_u32      v20, vcc, v27, v20, vcc
/*3a4c1f0d         */ v_xor_b32       v38, v13, v15
/*3a4e251e         */ v_xor_b32       v39, v30, v18
/*3a501515         */ v_xor_b32       v40, v21, v10
/*3a521723         */ v_xor_b32       v41, v35, v11
/*3a541d08         */ v_xor_b32       v42, v8, v14
/*3a562125         */ v_xor_b32       v43, v37, v16
/*3a582718         */ v_xor_b32       v44, v24, v19
/*3a5a291d         */ v_xor_b32       v45, v29, v20
/*d2c40021 00012126*/ v_lshr_b64      v[33:34], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*d2c40023 00013128*/ v_lshr_b64      v[35:36], v[40:41], 24
/*342a5088         */ v_lshlrev_b32   v21, 8, v40
/*381a1b22         */ v_or_b32        v13, v34, v13
/*4a0a0b21         */ v_add_i32       v5, vcc, v33, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*d2c40025 0001312a*/ v_lshr_b64      v[37:38], v[42:43], 24
/*34105488         */ v_lshlrev_b32   v8, 8, v42
/*d2c4001c 0001312c*/ v_lshr_b64      v[28:29], v[44:45], 24
/*34305888         */ v_lshlrev_b32   v24, 8, v44
/*382a2b24         */ v_or_b32        v21, v36, v21
/*4a044702         */ v_add_i32       v2, vcc, v2, v35
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*38101126         */ v_or_b32        v8, v38, v8
/*4a121325         */ v_add_i32       v9, vcc, v37, v9
/*50181908         */ v_addc_u32      v12, vcc, v8, v12, vcc
/*3830311d         */ v_or_b32        v24, v29, v24
/*4a2c2d1c         */ v_add_i32       v22, vcc, v28, v22
/*502e2f18         */ v_addc_u32      v23, vcc, v24, v23, vcc
/*3a3e0b1f         */ v_xor_b32       v31, v31, v5
/*3a400d11         */ v_xor_b32       v32, v17, v6
/*3a500507         */ v_xor_b32       v40, v7, v2
/*3a52031a         */ v_xor_b32       v41, v26, v1
/*3a541304         */ v_xor_b32       v42, v4, v9
/*3a561919         */ v_xor_b32       v43, v25, v12
/*3a582d03         */ v_xor_b32       v44, v3, v22
/*3a5a2f1b         */ v_xor_b32       v45, v27, v23
/*2c3c409f         */ v_lshrrev_b32   v30, 31, v32
/*d2c2001f 0001031f*/ v_lshl_b64      v[31:32], v[31:32], 1
/*d2c40026 00012128*/ v_lshr_b64      v[38:39], v[40:41], 16
/*340e5090         */ v_lshlrev_b32   v7, 16, v40
/*38223f1e         */ v_or_b32        v17, v30, v31
/*d2c40019 0001212a*/ v_lshr_b64      v[25:26], v[42:43], 16
/*34085490         */ v_lshlrev_b32   v4, 16, v42
/*d2c4001d 0001212c*/ v_lshr_b64      v[29:30], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*380e0f27         */ v_or_b32        v7, v39, v7
/*4a141526         */ v_add_i32       v10, vcc, v38, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*3808091a         */ v_or_b32        v4, v26, v4
/*4a1c1d19         */ v_add_i32       v14, vcc, v25, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*3806071e         */ v_or_b32        v3, v30, v3
/*4a26271d         */ v_add_i32       v19, vcc, v29, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*5018410c         */ v_addc_u32      v12, vcc, v12, v32, vcc
/*3a441523         */ v_xor_b32       v34, v35, v10
/*3a461715         */ v_xor_b32       v35, v21, v11
/*3a341d25         */ v_xor_b32       v26, v37, v14
/*3a362108         */ v_xor_b32       v27, v8, v16
/*3a48271c         */ v_xor_b32       v36, v28, v19
/*3a4a2918         */ v_xor_b32       v37, v24, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*3a3c1326         */ v_xor_b32       v30, v38, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*5028291e         */ v_addc_u32      v20, vcc, v30, v20, vcc
/*2c3e469f         */ v_lshrrev_b32   v31, 31, v35
/*d2c20022 00010322*/ v_lshl_b64      v[34:35], v[34:35], 1
/*2c2a369f         */ v_lshrrev_b32   v21, 31, v27
/*d2c2001a 0001031a*/ v_lshl_b64      v[26:27], v[26:27], 1
/*2c104a9f         */ v_lshrrev_b32   v8, 31, v37
/*d2c20024 00010324*/ v_lshl_b64      v[36:37], v[36:37], 1
/*3830451f         */ v_or_b32        v24, v31, v34
/*382a3515         */ v_or_b32        v21, v21, v26
/*38104908         */ v_or_b32        v8, v8, v36
/*3a4c2711         */ v_xor_b32       v38, v17, v19
/*3a4e2920         */ v_xor_b32       v39, v32, v20
/*4a2c3116         */ v_add_i32       v22, vcc, v22, v24
/*502e4717         */ v_addc_u32      v23, vcc, v23, v35, vcc
/*4a040515         */ v_add_i32       v2, vcc, v21, v2
/*5002031b         */ v_addc_u32      v1, vcc, v27, v1, vcc
/*4a1e110f         */ v_add_i32       v15, vcc, v15, v8
/*50244b12         */ v_addc_u32      v18, vcc, v18, v37, vcc
/*d2c4001f 00013126*/ v_lshr_b64      v[31:32], v[38:39], 24
/*34224c88         */ v_lshlrev_b32   v17, 8, v38
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*3a060303         */ v_xor_b32       v3, v3, v1
/*38222320         */ v_or_b32        v17, v32, v17
/*4a12131f         */ v_add_i32       v9, vcc, v31, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a342d21         */ v_xor_b32       v26, v33, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211a         */ v_addc_u32      v16, vcc, v26, v16, vcc
/*3a38051d         */ v_xor_b32       v28, v29, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1c         */ v_addc_u32      v6, vcc, v28, v6, vcc
/*3a321f19         */ v_xor_b32       v25, v25, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*50161719         */ v_addc_u32      v11, vcc, v25, v11, vcc
/*3a4c1307         */ v_xor_b32       v38, v7, v9
/*3a4e191e         */ v_xor_b32       v39, v30, v12
/*3a501d18         */ v_xor_b32       v40, v24, v14
/*3a522123         */ v_xor_b32       v41, v35, v16
/*3a540b15         */ v_xor_b32       v42, v21, v5
/*3a560d1b         */ v_xor_b32       v43, v27, v6
/*3a581508         */ v_xor_b32       v44, v8, v10
/*3a5a1725         */ v_xor_b32       v45, v37, v11
/*d2c40021 00012126*/ v_lshr_b64      v[33:34], v[38:39], 16
/*340e4c90         */ v_lshlrev_b32   v7, 16, v38
/*d2c4001d 00013128*/ v_lshr_b64      v[29:30], v[40:41], 24
/*34305088         */ v_lshlrev_b32   v24, 8, v40
/*d2c40023 0001312a*/ v_lshr_b64      v[35:36], v[42:43], 24
/*342a5488         */ v_lshlrev_b32   v21, 8, v42
/*380e0f22         */ v_or_b32        v7, v34, v7
/*d2c40025 0001312c*/ v_lshr_b64      v[37:38], v[44:45], 24
/*34105888         */ v_lshlrev_b32   v8, 8, v44
/*4a262721         */ v_add_i32       v19, vcc, v33, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*3830311e         */ v_or_b32        v24, v30, v24
/*4a2c3b16         */ v_add_i32       v22, vcc, v22, v29
/*502e3117         */ v_addc_u32      v23, vcc, v23, v24, vcc
/*382a2b24         */ v_or_b32        v21, v36, v21
/*4a044702         */ v_add_i32       v2, vcc, v2, v35
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*38101126         */ v_or_b32        v8, v38, v8
/*4a1e4b0f         */ v_add_i32       v15, vcc, v15, v37
/*50241112         */ v_addc_u32      v18, vcc, v18, v8, vcc
/*3a3e271f         */ v_xor_b32       v31, v31, v19
/*3a402911         */ v_xor_b32       v32, v17, v20
/*3a4c2d0d         */ v_xor_b32       v38, v13, v22
/*3a4e2f1a         */ v_xor_b32       v39, v26, v23
/*3a501f04         */ v_xor_b32       v40, v4, v15
/*3a522519         */ v_xor_b32       v41, v25, v18
/*3a540503         */ v_xor_b32       v42, v3, v2
/*3a56031c         */ v_xor_b32       v43, v28, v1
/*2c3c409f         */ v_lshrrev_b32   v30, 31, v32
/*d2c2001f 0001031f*/ v_lshl_b64      v[31:32], v[31:32], 1
/*d2c4001a 00012126*/ v_lshr_b64      v[26:27], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*d2c40026 00012128*/ v_lshr_b64      v[38:39], v[40:41], 16
/*34085090         */ v_lshlrev_b32   v4, 16, v40
/*38223f1e         */ v_or_b32        v17, v30, v31
/*be800480         */ s_mov_b64       s[0:1], 0
/*d2c4001e 0001212a*/ v_lshr_b64      v[30:31], v[42:43], 16
/*34065490         */ v_lshlrev_b32   v3, 16, v42
/*381a1b1b         */ v_or_b32        v13, v27, v13
/*4a1c1d1a         */ v_add_i32       v14, vcc, v26, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*38080927         */ v_or_b32        v4, v39, v4
/*4a141526         */ v_add_i32       v10, vcc, v38, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*d2506a12 00020112*/ v_addc_u32      v18, vcc, v18, v0, s[0:1]
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244112         */ v_addc_u32      v18, vcc, v18, v32, vcc
/*3806071f         */ v_or_b32        v3, v31, v3
/*4a0a0b1e         */ v_add_i32       v5, vcc, v30, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*3a4e1d1d         */ v_xor_b32       v39, v29, v14
/*3a502118         */ v_xor_b32       v40, v24, v16
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*3a440b23         */ v_xor_b32       v34, v35, v5
/*3a460d15         */ v_xor_b32       v35, v21, v6
/*3a361525         */ v_xor_b32       v27, v37, v10
/*3a381708         */ v_xor_b32       v28, v8, v11
/*3a341f1a         */ v_xor_b32       v26, v26, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d1a         */ v_addc_u32      v6, vcc, v26, v6, vcc
/*2c3a509f         */ v_lshrrev_b32   v29, 31, v40
/*d2c20018 00010327*/ v_lshl_b64      v[24:25], v[39:40], 1
/*2c3e469f         */ v_lshrrev_b32   v31, 31, v35
/*d2c20022 00010322*/ v_lshl_b64      v[34:35], v[34:35], 1
/*2c2a389f         */ v_lshrrev_b32   v21, 31, v28
/*d2c2001b 0001031b*/ v_lshl_b64      v[27:28], v[27:28], 1
/*3810311d         */ v_or_b32        v8, v29, v24
/*3a480b11         */ v_xor_b32       v36, v17, v5
/*3a4a0d20         */ v_xor_b32       v37, v32, v6
/*383a451f         */ v_or_b32        v29, v31, v34
/*382a3715         */ v_or_b32        v21, v21, v27
/*4a041102         */ v_add_i32       v2, vcc, v2, v8
/*50023301         */ v_addc_u32      v1, vcc, v1, v25, vcc
/*4a12131d         */ v_add_i32       v9, vcc, v29, v9
/*50181923         */ v_addc_u32      v12, vcc, v35, v12, vcc
/*4a2c2d15         */ v_add_i32       v22, vcc, v21, v22
/*502e2f1c         */ v_addc_u32      v23, vcc, v28, v23, vcc
/*d2c4001f 00013124*/ v_lshr_b64      v[31:32], v[36:37], 24
/*34224888         */ v_lshlrev_b32   v17, 8, v36
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*38222320         */ v_or_b32        v17, v32, v17
/*4a1e3f0f         */ v_add_i32       v15, vcc, v15, v31
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a304302         */ v_xor_b32       v24, v2, v33
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*50161718         */ v_addc_u32      v11, vcc, v24, v11, vcc
/*3a361326         */ v_xor_b32       v27, v38, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*5020211b         */ v_addc_u32      v16, vcc, v27, v16, vcc
/*3a3c2d1e         */ v_xor_b32       v30, v30, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*5028291e         */ v_addc_u32      v20, vcc, v30, v20, vcc
/*3a481f0d         */ v_xor_b32       v36, v13, v15
/*3a4a251a         */ v_xor_b32       v37, v26, v18
/*3a4c1508         */ v_xor_b32       v38, v8, v10
/*3a4e1719         */ v_xor_b32       v39, v25, v11
/*3a501d1d         */ v_xor_b32       v40, v29, v14
/*3a522123         */ v_xor_b32       v41, v35, v16
/*3a542715         */ v_xor_b32       v42, v21, v19
/*3a56291c         */ v_xor_b32       v43, v28, v20
/*d2c40021 00012124*/ v_lshr_b64      v[33:34], v[36:37], 16
/*341a4890         */ v_lshlrev_b32   v13, 16, v36
/*d2c40019 00013126*/ v_lshr_b64      v[25:26], v[38:39], 24
/*34104c88         */ v_lshlrev_b32   v8, 8, v38
/*381a1b22         */ v_or_b32        v13, v34, v13
/*4a0a0b21         */ v_add_i32       v5, vcc, v33, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*d2c40022 00013128*/ v_lshr_b64      v[34:35], v[40:41], 24
/*343a5088         */ v_lshlrev_b32   v29, 8, v40
/*d2c40024 0001312a*/ v_lshr_b64      v[36:37], v[42:43], 24
/*342a5488         */ v_lshlrev_b32   v21, 8, v42
/*3810111a         */ v_or_b32        v8, v26, v8
/*4a043302         */ v_add_i32       v2, vcc, v2, v25
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*38343b23         */ v_or_b32        v26, v35, v29
/*4a121322         */ v_add_i32       v9, vcc, v34, v9
/*5018191a         */ v_addc_u32      v12, vcc, v26, v12, vcc
/*382a2b25         */ v_or_b32        v21, v37, v21
/*4a2c2d24         */ v_add_i32       v22, vcc, v36, v22
/*502e2f15         */ v_addc_u32      v23, vcc, v21, v23, vcc
/*3a3e0b1f         */ v_xor_b32       v31, v31, v5
/*3a400d11         */ v_xor_b32       v32, v17, v6
/*3a4e0507         */ v_xor_b32       v39, v7, v2
/*3a500318         */ v_xor_b32       v40, v24, v1
/*3a521304         */ v_xor_b32       v41, v4, v9
/*3a54191b         */ v_xor_b32       v42, v27, v12
/*3a562d03         */ v_xor_b32       v43, v3, v22
/*3a582f1e         */ v_xor_b32       v44, v30, v23
/*2c3c409f         */ v_lshrrev_b32   v30, 31, v32
/*d2c2001f 0001031f*/ v_lshl_b64      v[31:32], v[31:32], 1
/*d2c40025 00012127*/ v_lshr_b64      v[37:38], v[39:40], 16
/*340e4e90         */ v_lshlrev_b32   v7, 16, v39
/*38223f1e         */ v_or_b32        v17, v30, v31
/*d2c4001b 00012129*/ v_lshr_b64      v[27:28], v[41:42], 16
/*34085290         */ v_lshlrev_b32   v4, 16, v41
/*d2c4001d 0001212b*/ v_lshr_b64      v[29:30], v[43:44], 16
/*34065690         */ v_lshlrev_b32   v3, 16, v43
/*380e0f26         */ v_or_b32        v7, v38, v7
/*4a141525         */ v_add_i32       v10, vcc, v37, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*3808091c         */ v_or_b32        v4, v28, v4
/*4a1c1d1b         */ v_add_i32       v14, vcc, v27, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*3806071e         */ v_or_b32        v3, v30, v3
/*4a26271d         */ v_add_i32       v19, vcc, v29, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*5018410c         */ v_addc_u32      v12, vcc, v12, v32, vcc
/*beea0480         */ s_mov_b64       vcc, 0
/*3a4c1519         */ v_xor_b32       v38, v25, v10
/*3a4e1708         */ v_xor_b32       v39, v8, v11
/*3a301d22         */ v_xor_b32       v24, v34, v14
/*3a32211a         */ v_xor_b32       v25, v26, v16
/*3a502724         */ v_xor_b32       v40, v36, v19
/*3a522915         */ v_xor_b32       v41, v21, v20
/*5018010c         */ v_addc_u32      v12, vcc, v12, v0, vcc
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*2c3c4e9f         */ v_lshrrev_b32   v30, 31, v39
/*d2c20022 00010326*/ v_lshl_b64      v[34:35], v[38:39], 1
/*2c10329f         */ v_lshrrev_b32   v8, 31, v25
/*d2c20018 00010318*/ v_lshl_b64      v[24:25], v[24:25], 1
/*2c34529f         */ v_lshrrev_b32   v26, 31, v41
/*d2c20026 00010328*/ v_lshl_b64      v[38:39], v[40:41], 1
/*3a2a1325         */ v_xor_b32       v21, v37, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*50282915         */ v_addc_u32      v20, vcc, v21, v20, vcc
/*3838451e         */ v_or_b32        v28, v30, v34
/*38103108         */ v_or_b32        v8, v8, v24
/*38304d1a         */ v_or_b32        v24, v26, v38
/*4a2c3916         */ v_add_i32       v22, vcc, v22, v28
/*502e4717         */ v_addc_u32      v23, vcc, v23, v35, vcc
/*4a040508         */ v_add_i32       v2, vcc, v8, v2
/*50020319         */ v_addc_u32      v1, vcc, v25, v1, vcc
/*3a482711         */ v_xor_b32       v36, v17, v19
/*3a4a2920         */ v_xor_b32       v37, v32, v20
/*4a1e310f         */ v_add_i32       v15, vcc, v15, v24
/*50244f12         */ v_addc_u32      v18, vcc, v18, v39, vcc
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*3a060303         */ v_xor_b32       v3, v3, v1
/*d2c4001e 00013124*/ v_lshr_b64      v[30:31], v[36:37], 24
/*34224888         */ v_lshlrev_b32   v17, 8, v36
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a342d21         */ v_xor_b32       v26, v33, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211a         */ v_addc_u32      v16, vcc, v26, v16, vcc
/*3a3a051d         */ v_xor_b32       v29, v29, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1d         */ v_addc_u32      v6, vcc, v29, v6, vcc
/*3822231f         */ v_or_b32        v17, v31, v17
/*4a12131e         */ v_add_i32       v9, vcc, v30, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a361f1b         */ v_xor_b32       v27, v27, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*5016171b         */ v_addc_u32      v11, vcc, v27, v11, vcc
/*3a481d1c         */ v_xor_b32       v36, v28, v14
/*3a4a2123         */ v_xor_b32       v37, v35, v16
/*3a500b08         */ v_xor_b32       v40, v8, v5
/*3a520d19         */ v_xor_b32       v41, v25, v6
/*3a541307         */ v_xor_b32       v42, v7, v9
/*3a561915         */ v_xor_b32       v43, v21, v12
/*3a301518         */ v_xor_b32       v24, v24, v10
/*3a321727         */ v_xor_b32       v25, v39, v11
/*d2c40021 00013124*/ v_lshr_b64      v[33:34], v[36:37], 24
/*34384888         */ v_lshlrev_b32   v28, 8, v36
/*d2c40023 00013128*/ v_lshr_b64      v[35:36], v[40:41], 24
/*34105088         */ v_lshlrev_b32   v8, 8, v40
/*d2c40025 0001212a*/ v_lshr_b64      v[37:38], v[42:43], 16
/*340e5490         */ v_lshlrev_b32   v7, 16, v42
/*d2c4001f 00013118*/ v_lshr_b64      v[31:32], v[24:25], 24
/*342a3088         */ v_lshlrev_b32   v21, 8, v24
/*38303922         */ v_or_b32        v24, v34, v28
/*4a2c4316         */ v_add_i32       v22, vcc, v22, v33
/*502e3117         */ v_addc_u32      v23, vcc, v23, v24, vcc
/*38101124         */ v_or_b32        v8, v36, v8
/*4a044702         */ v_add_i32       v2, vcc, v2, v35
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*380e0f26         */ v_or_b32        v7, v38, v7
/*382a2b20         */ v_or_b32        v21, v32, v21
/*4a1e3f0f         */ v_add_i32       v15, vcc, v15, v31
/*50242b12         */ v_addc_u32      v18, vcc, v18, v21, vcc
/*4a262725         */ v_add_i32       v19, vcc, v37, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*3a4c2d0d         */ v_xor_b32       v38, v13, v22
/*3a4e2f1a         */ v_xor_b32       v39, v26, v23
/*3a501f04         */ v_xor_b32       v40, v4, v15
/*3a52251b         */ v_xor_b32       v41, v27, v18
/*3a54271e         */ v_xor_b32       v42, v30, v19
/*3a562911         */ v_xor_b32       v43, v17, v20
/*3a580503         */ v_xor_b32       v44, v3, v2
/*3a5a031d         */ v_xor_b32       v45, v29, v1
/*d2c4001d 00012126*/ v_lshr_b64      v[29:30], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*d2c40019 00012128*/ v_lshr_b64      v[25:26], v[40:41], 16
/*34085090         */ v_lshlrev_b32   v4, 16, v40
/*2c40569f         */ v_lshrrev_b32   v32, 31, v43
/*d2c20026 0001032a*/ v_lshl_b64      v[38:39], v[42:43], 1
/*d2c4001b 0001212c*/ v_lshr_b64      v[27:28], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*381a1b1e         */ v_or_b32        v13, v30, v13
/*4a1c1d1d         */ v_add_i32       v14, vcc, v29, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*3808091a         */ v_or_b32        v4, v26, v4
/*4a141519         */ v_add_i32       v10, vcc, v25, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*38224d20         */ v_or_b32        v17, v32, v38
/*3806071c         */ v_or_b32        v3, v28, v3
/*4a0a0b1b         */ v_add_i32       v5, vcc, v27, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244f12         */ v_addc_u32      v18, vcc, v18, v39, vcc
/*3a401d21         */ v_xor_b32       v32, v33, v14
/*3a422118         */ v_xor_b32       v33, v24, v16
/*3a440b23         */ v_xor_b32       v34, v35, v5
/*3a460d08         */ v_xor_b32       v35, v8, v6
/*3a50151f         */ v_xor_b32       v40, v31, v10
/*3a521715         */ v_xor_b32       v41, v21, v11
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*2c3e429f         */ v_lshrrev_b32   v31, 31, v33
/*d2c20020 00010320*/ v_lshl_b64      v[32:33], v[32:33], 1
/*3a301f1d         */ v_xor_b32       v24, v29, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d18         */ v_addc_u32      v6, vcc, v24, v6, vcc
/*2c34469f         */ v_lshrrev_b32   v26, 31, v35
/*d2c2001c 00010322*/ v_lshl_b64      v[28:29], v[34:35], 1
/*2c10529f         */ v_lshrrev_b32   v8, 31, v41
/*d2c20022 00010328*/ v_lshl_b64      v[34:35], v[40:41], 1
/*382a411f         */ v_or_b32        v21, v31, v32
/*3834391a         */ v_or_b32        v26, v26, v28
/*38104508         */ v_or_b32        v8, v8, v34
/*4a042b02         */ v_add_i32       v2, vcc, v2, v21
/*50024301         */ v_addc_u32      v1, vcc, v1, v33, vcc
/*3a4c0b11         */ v_xor_b32       v38, v17, v5
/*3a4e0d27         */ v_xor_b32       v39, v39, v6
/*4a12131a         */ v_add_i32       v9, vcc, v26, v9
/*5018191d         */ v_addc_u32      v12, vcc, v29, v12, vcc
/*4a2c2d08         */ v_add_i32       v22, vcc, v8, v22
/*502e2f23         */ v_addc_u32      v23, vcc, v35, v23, vcc
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*d2c4001e 00013126*/ v_lshr_b64      v[30:31], v[38:39], 24
/*34224c88         */ v_lshlrev_b32   v17, 8, v38
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a384b02         */ v_xor_b32       v28, v2, v37
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*5016171c         */ v_addc_u32      v11, vcc, v28, v11, vcc
/*3822231f         */ v_or_b32        v17, v31, v17
/*4a1e3d0f         */ v_add_i32       v15, vcc, v15, v30
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a321319         */ v_xor_b32       v25, v25, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*50202119         */ v_addc_u32      v16, vcc, v25, v16, vcc
/*3a362d1b         */ v_xor_b32       v27, v27, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*5028291b         */ v_addc_u32      v20, vcc, v27, v20, vcc
/*3a481515         */ v_xor_b32       v36, v21, v10
/*3a4a1721         */ v_xor_b32       v37, v33, v11
/*3a4c1f0d         */ v_xor_b32       v38, v13, v15
/*3a4e2518         */ v_xor_b32       v39, v24, v18
/*3a501d1a         */ v_xor_b32       v40, v26, v14
/*3a52211d         */ v_xor_b32       v41, v29, v16
/*3a542708         */ v_xor_b32       v42, v8, v19
/*3a562923         */ v_xor_b32       v43, v35, v20
/*d2c40021 00013124*/ v_lshr_b64      v[33:34], v[36:37], 24
/*342a4888         */ v_lshlrev_b32   v21, 8, v36
/*d2c40023 00012126*/ v_lshr_b64      v[35:36], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*d2c40025 00013128*/ v_lshr_b64      v[37:38], v[40:41], 24
/*34305088         */ v_lshlrev_b32   v24, 8, v40
/*d2c4001f 0001312a*/ v_lshr_b64      v[31:32], v[42:43], 24
/*34105488         */ v_lshlrev_b32   v8, 8, v42
/*382a2b22         */ v_or_b32        v21, v34, v21
/*4a044302         */ v_add_i32       v2, vcc, v2, v33
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*381a1b24         */ v_or_b32        v13, v36, v13
/*4a0a0b23         */ v_add_i32       v5, vcc, v35, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*38303126         */ v_or_b32        v24, v38, v24
/*4a121325         */ v_add_i32       v9, vcc, v37, v9
/*50181918         */ v_addc_u32      v12, vcc, v24, v12, vcc
/*38101120         */ v_or_b32        v8, v32, v8
/*4a2c2d1f         */ v_add_i32       v22, vcc, v31, v22
/*502e2f08         */ v_addc_u32      v23, vcc, v8, v23, vcc
/*3a4c0507         */ v_xor_b32       v38, v7, v2
/*3a4e031c         */ v_xor_b32       v39, v28, v1
/*3a500b1e         */ v_xor_b32       v40, v30, v5
/*3a520d11         */ v_xor_b32       v41, v17, v6
/*3a541304         */ v_xor_b32       v42, v4, v9
/*3a561919         */ v_xor_b32       v43, v25, v12
/*3a582d03         */ v_xor_b32       v44, v3, v22
/*3a5a2f1b         */ v_xor_b32       v45, v27, v23
/*d2c4001d 00012126*/ v_lshr_b64      v[29:30], v[38:39], 16
/*340e4c90         */ v_lshlrev_b32   v7, 16, v38
/*2c34529f         */ v_lshrrev_b32   v26, 31, v41
/*d2c20026 00010328*/ v_lshl_b64      v[38:39], v[40:41], 1
/*d2c40028 0001212a*/ v_lshr_b64      v[40:41], v[42:43], 16
/*34085490         */ v_lshlrev_b32   v4, 16, v42
/*d2c4001b 0001212c*/ v_lshr_b64      v[27:28], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*380e0f1e         */ v_or_b32        v7, v30, v7
/*4a14151d         */ v_add_i32       v10, vcc, v29, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*38224d1a         */ v_or_b32        v17, v26, v38
/*38080929         */ v_or_b32        v4, v41, v4
/*4a1c1d28         */ v_add_i32       v14, vcc, v40, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*3806071c         */ v_or_b32        v3, v28, v3
/*4a26271b         */ v_add_i32       v19, vcc, v27, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*50184f0c         */ v_addc_u32      v12, vcc, v12, v39, vcc
/*3a401521         */ v_xor_b32       v32, v33, v10
/*3a421715         */ v_xor_b32       v33, v21, v11
/*3a321d25         */ v_xor_b32       v25, v37, v14
/*3a342118         */ v_xor_b32       v26, v24, v16
/*3a48271f         */ v_xor_b32       v36, v31, v19
/*3a4a2908         */ v_xor_b32       v37, v8, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*2c3c429f         */ v_lshrrev_b32   v30, 31, v33
/*d2c2001f 00010320*/ v_lshl_b64      v[31:32], v[32:33], 1
/*2c2a349f         */ v_lshrrev_b32   v21, 31, v26
/*d2c20018 00010319*/ v_lshl_b64      v[24:25], v[25:26], 1
/*2c344a9f         */ v_lshrrev_b32   v26, 31, v37
/*d2c20021 00010324*/ v_lshl_b64      v[33:34], v[36:37], 1
/*3a10131d         */ v_xor_b32       v8, v29, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*50282908         */ v_addc_u32      v20, vcc, v8, v20, vcc
/*38383f1e         */ v_or_b32        v28, v30, v31
/*382a3115         */ v_or_b32        v21, v21, v24
/*3830431a         */ v_or_b32        v24, v26, v33
/*4a2c3916         */ v_add_i32       v22, vcc, v22, v28
/*502e4117         */ v_addc_u32      v23, vcc, v23, v32, vcc
/*4a040515         */ v_add_i32       v2, vcc, v21, v2
/*50020319         */ v_addc_u32      v1, vcc, v25, v1, vcc
/*3a482711         */ v_xor_b32       v36, v17, v19
/*3a4a2927         */ v_xor_b32       v37, v39, v20
/*4a1e310f         */ v_add_i32       v15, vcc, v15, v24
/*50244512         */ v_addc_u32      v18, vcc, v18, v34, vcc
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*3a060303         */ v_xor_b32       v3, v3, v1
/*d2c4001d 00013124*/ v_lshr_b64      v[29:30], v[36:37], 24
/*34224888         */ v_lshlrev_b32   v17, 8, v36
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a342d23         */ v_xor_b32       v26, v35, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211a         */ v_addc_u32      v16, vcc, v26, v16, vcc
/*3a36051b         */ v_xor_b32       v27, v27, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1b         */ v_addc_u32      v6, vcc, v27, v6, vcc
/*3822231e         */ v_or_b32        v17, v30, v17
/*4a12131d         */ v_add_i32       v9, vcc, v29, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a3c1f28         */ v_xor_b32       v30, v40, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*5016171e         */ v_addc_u32      v11, vcc, v30, v11, vcc
/*3a461d1c         */ v_xor_b32       v35, v28, v14
/*3a482120         */ v_xor_b32       v36, v32, v16
/*3a4a0b15         */ v_xor_b32       v37, v21, v5
/*3a4c0d19         */ v_xor_b32       v38, v25, v6
/*3a0e1307         */ v_xor_b32       v7, v7, v9
/*3a101908         */ v_xor_b32       v8, v8, v12
/*3a301518         */ v_xor_b32       v24, v24, v10
/*3a321722         */ v_xor_b32       v25, v34, v11
/*d2c40021 00013123*/ v_lshr_b64      v[33:34], v[35:36], 24
/*34384688         */ v_lshlrev_b32   v28, 8, v35
/*d2c40023 00013125*/ v_lshr_b64      v[35:36], v[37:38], 24
/*342a4a88         */ v_lshlrev_b32   v21, 8, v37
/*be800480         */ s_mov_b64       s[0:1], 0
/*d2c40025 00012107*/ v_lshr_b64      v[37:38], v[7:8], 16
/*340e0e90         */ v_lshlrev_b32   v7, 16, v7
/*d2c4001f 00013118*/ v_lshr_b64      v[31:32], v[24:25], 24
/*34103088         */ v_lshlrev_b32   v8, 8, v24
/*38303922         */ v_or_b32        v24, v34, v28
/*4a2c4316         */ v_add_i32       v22, vcc, v22, v33
/*502e3117         */ v_addc_u32      v23, vcc, v23, v24, vcc
/*382a2b24         */ v_or_b32        v21, v36, v21
/*d2506a01 00020300*/ v_addc_u32      v1, vcc, v0, v1, s[0:1]
/*4a044702         */ v_add_i32       v2, vcc, v2, v35
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*380e0f26         */ v_or_b32        v7, v38, v7
/*38101120         */ v_or_b32        v8, v32, v8
/*4a1e3f0f         */ v_add_i32       v15, vcc, v15, v31
/*50241112         */ v_addc_u32      v18, vcc, v18, v8, vcc
/*4a262725         */ v_add_i32       v19, vcc, v37, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*3a4c2d0d         */ v_xor_b32       v38, v13, v22
/*3a4e2f1a         */ v_xor_b32       v39, v26, v23
/*3a501f04         */ v_xor_b32       v40, v4, v15
/*3a52251e         */ v_xor_b32       v41, v30, v18
/*3a54271d         */ v_xor_b32       v42, v29, v19
/*3a562911         */ v_xor_b32       v43, v17, v20
/*3a580503         */ v_xor_b32       v44, v3, v2
/*3a5a031b         */ v_xor_b32       v45, v27, v1
/*d2c4001d 00012126*/ v_lshr_b64      v[29:30], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*d2c40019 00012128*/ v_lshr_b64      v[25:26], v[40:41], 16
/*34085090         */ v_lshlrev_b32   v4, 16, v40
/*2c40569f         */ v_lshrrev_b32   v32, 31, v43
/*d2c20026 0001032a*/ v_lshl_b64      v[38:39], v[42:43], 1
/*d2c4001b 0001212c*/ v_lshr_b64      v[27:28], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*381a1b1e         */ v_or_b32        v13, v30, v13
/*4a1c1d1d         */ v_add_i32       v14, vcc, v29, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*3808091a         */ v_or_b32        v4, v26, v4
/*4a141519         */ v_add_i32       v10, vcc, v25, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*38224d20         */ v_or_b32        v17, v32, v38
/*3806071c         */ v_or_b32        v3, v28, v3
/*4a0a0b1b         */ v_add_i32       v5, vcc, v27, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244f12         */ v_addc_u32      v18, vcc, v18, v39, vcc
/*3a401d21         */ v_xor_b32       v32, v33, v14
/*3a422118         */ v_xor_b32       v33, v24, v16
/*3a440b23         */ v_xor_b32       v34, v35, v5
/*3a460d15         */ v_xor_b32       v35, v21, v6
/*3a50151f         */ v_xor_b32       v40, v31, v10
/*3a521708         */ v_xor_b32       v41, v8, v11
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*2c3e429f         */ v_lshrrev_b32   v31, 31, v33
/*d2c20020 00010320*/ v_lshl_b64      v[32:33], v[32:33], 1
/*3a301f1d         */ v_xor_b32       v24, v29, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d18         */ v_addc_u32      v6, vcc, v24, v6, vcc
/*2c34469f         */ v_lshrrev_b32   v26, 31, v35
/*d2c2001c 00010322*/ v_lshl_b64      v[28:29], v[34:35], 1
/*2c2a529f         */ v_lshrrev_b32   v21, 31, v41
/*d2c20022 00010328*/ v_lshl_b64      v[34:35], v[40:41], 1
/*3810411f         */ v_or_b32        v8, v31, v32
/*3834391a         */ v_or_b32        v26, v26, v28
/*382a4515         */ v_or_b32        v21, v21, v34
/*4a041102         */ v_add_i32       v2, vcc, v2, v8
/*50024301         */ v_addc_u32      v1, vcc, v1, v33, vcc
/*3a4c0b11         */ v_xor_b32       v38, v17, v5
/*3a4e0d27         */ v_xor_b32       v39, v39, v6
/*4a12131a         */ v_add_i32       v9, vcc, v26, v9
/*5018191d         */ v_addc_u32      v12, vcc, v29, v12, vcc
/*4a2c2d15         */ v_add_i32       v22, vcc, v21, v22
/*502e2f23         */ v_addc_u32      v23, vcc, v35, v23, vcc
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*d2c4001e 00013126*/ v_lshr_b64      v[30:31], v[38:39], 24
/*34224c88         */ v_lshlrev_b32   v17, 8, v38
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a384b02         */ v_xor_b32       v28, v2, v37
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*5016171c         */ v_addc_u32      v11, vcc, v28, v11, vcc
/*3822231f         */ v_or_b32        v17, v31, v17
/*4a1e3d0f         */ v_add_i32       v15, vcc, v15, v30
/*50242312         */ v_addc_u32      v18, vcc, v18, v17, vcc
/*3a321319         */ v_xor_b32       v25, v25, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*50202119         */ v_addc_u32      v16, vcc, v25, v16, vcc
/*3a362d1b         */ v_xor_b32       v27, v27, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*5028291b         */ v_addc_u32      v20, vcc, v27, v20, vcc
/*3a481508         */ v_xor_b32       v36, v8, v10
/*3a4a1721         */ v_xor_b32       v37, v33, v11
/*3a4c1f0d         */ v_xor_b32       v38, v13, v15
/*3a4e2518         */ v_xor_b32       v39, v24, v18
/*3a501d1a         */ v_xor_b32       v40, v26, v14
/*3a52211d         */ v_xor_b32       v41, v29, v16
/*3a542715         */ v_xor_b32       v42, v21, v19
/*3a562923         */ v_xor_b32       v43, v35, v20
/*d2c40021 00013124*/ v_lshr_b64      v[33:34], v[36:37], 24
/*34104888         */ v_lshlrev_b32   v8, 8, v36
/*d2c40023 00012126*/ v_lshr_b64      v[35:36], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*d2c40025 00013128*/ v_lshr_b64      v[37:38], v[40:41], 24
/*34305088         */ v_lshlrev_b32   v24, 8, v40
/*d2c4001f 0001312a*/ v_lshr_b64      v[31:32], v[42:43], 24
/*342a5488         */ v_lshlrev_b32   v21, 8, v42
/*38101122         */ v_or_b32        v8, v34, v8
/*4a044302         */ v_add_i32       v2, vcc, v2, v33
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*381a1b24         */ v_or_b32        v13, v36, v13
/*4a0a0b23         */ v_add_i32       v5, vcc, v35, v5
/*500c0d0d         */ v_addc_u32      v6, vcc, v13, v6, vcc
/*38303126         */ v_or_b32        v24, v38, v24
/*4a121325         */ v_add_i32       v9, vcc, v37, v9
/*50181918         */ v_addc_u32      v12, vcc, v24, v12, vcc
/*382a2b20         */ v_or_b32        v21, v32, v21
/*4a2c2d1f         */ v_add_i32       v22, vcc, v31, v22
/*502e2f15         */ v_addc_u32      v23, vcc, v21, v23, vcc
/*3a4c0507         */ v_xor_b32       v38, v7, v2
/*3a4e031c         */ v_xor_b32       v39, v28, v1
/*3a500b1e         */ v_xor_b32       v40, v30, v5
/*3a520d11         */ v_xor_b32       v41, v17, v6
/*3a541304         */ v_xor_b32       v42, v4, v9
/*3a561919         */ v_xor_b32       v43, v25, v12
/*3a582d03         */ v_xor_b32       v44, v3, v22
/*3a5a2f1b         */ v_xor_b32       v45, v27, v23
/*d2c4001d 00012126*/ v_lshr_b64      v[29:30], v[38:39], 16
/*340e4c90         */ v_lshlrev_b32   v7, 16, v38
/*2c34529f         */ v_lshrrev_b32   v26, 31, v41
/*d2c20026 00010328*/ v_lshl_b64      v[38:39], v[40:41], 1
/*d2c40028 0001212a*/ v_lshr_b64      v[40:41], v[42:43], 16
/*34085490         */ v_lshlrev_b32   v4, 16, v42
/*d2c4001b 0001212c*/ v_lshr_b64      v[27:28], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*380e0f1e         */ v_or_b32        v7, v30, v7
/*4a14151d         */ v_add_i32       v10, vcc, v29, v10
/*50161707         */ v_addc_u32      v11, vcc, v7, v11, vcc
/*38224d1a         */ v_or_b32        v17, v26, v38
/*38080929         */ v_or_b32        v4, v41, v4
/*4a1c1d28         */ v_add_i32       v14, vcc, v40, v14
/*50202104         */ v_addc_u32      v16, vcc, v4, v16, vcc
/*3806071c         */ v_or_b32        v3, v28, v3
/*4a26271b         */ v_add_i32       v19, vcc, v27, v19
/*50282903         */ v_addc_u32      v20, vcc, v3, v20, vcc
/*4a122309         */ v_add_i32       v9, vcc, v9, v17
/*50184f0c         */ v_addc_u32      v12, vcc, v12, v39, vcc
/*3a401521         */ v_xor_b32       v32, v33, v10
/*3a421708         */ v_xor_b32       v33, v8, v11
/*3a321d25         */ v_xor_b32       v25, v37, v14
/*3a342118         */ v_xor_b32       v26, v24, v16
/*3a48271f         */ v_xor_b32       v36, v31, v19
/*3a4a2915         */ v_xor_b32       v37, v21, v20
/*3a0e1907         */ v_xor_b32       v7, v7, v12
/*2c3c429f         */ v_lshrrev_b32   v30, 31, v33
/*d2c2001f 00010320*/ v_lshl_b64      v[31:32], v[32:33], 1
/*2c10349f         */ v_lshrrev_b32   v8, 31, v26
/*d2c20018 00010319*/ v_lshl_b64      v[24:25], v[25:26], 1
/*2c344a9f         */ v_lshrrev_b32   v26, 31, v37
/*d2c20021 00010324*/ v_lshl_b64      v[33:34], v[36:37], 1
/*3a2a131d         */ v_xor_b32       v21, v29, v9
/*4a262707         */ v_add_i32       v19, vcc, v7, v19
/*50282915         */ v_addc_u32      v20, vcc, v21, v20, vcc
/*38383f1e         */ v_or_b32        v28, v30, v31
/*38103108         */ v_or_b32        v8, v8, v24
/*3830431a         */ v_or_b32        v24, v26, v33
/*4a2c3916         */ v_add_i32       v22, vcc, v22, v28
/*502e4117         */ v_addc_u32      v23, vcc, v23, v32, vcc
/*4a040508         */ v_add_i32       v2, vcc, v8, v2
/*50020319         */ v_addc_u32      v1, vcc, v25, v1, vcc
/*3a482711         */ v_xor_b32       v36, v17, v19
/*3a4a2927         */ v_xor_b32       v37, v39, v20
/*4a1e310f         */ v_add_i32       v15, vcc, v15, v24
/*50244512         */ v_addc_u32      v18, vcc, v18, v34, vcc
/*3a1a2f0d         */ v_xor_b32       v13, v13, v23
/*3a060303         */ v_xor_b32       v3, v3, v1
/*d2c4001d 00013124*/ v_lshr_b64      v[29:30], v[36:37], 24
/*34224888         */ v_lshlrev_b32   v17, 8, v36
/*3a082504         */ v_xor_b32       v4, v4, v18
/*3a342d23         */ v_xor_b32       v26, v35, v22
/*4a1c1d0d         */ v_add_i32       v14, vcc, v13, v14
/*5020211a         */ v_addc_u32      v16, vcc, v26, v16, vcc
/*3a36051b         */ v_xor_b32       v27, v27, v2
/*4a0a0b03         */ v_add_i32       v5, vcc, v3, v5
/*500c0d1b         */ v_addc_u32      v6, vcc, v27, v6, vcc
/*3822231e         */ v_or_b32        v17, v30, v17
/*4a12131d         */ v_add_i32       v9, vcc, v29, v9
/*50181911         */ v_addc_u32      v12, vcc, v17, v12, vcc
/*3a3c1f28         */ v_xor_b32       v30, v40, v15
/*4a141504         */ v_add_i32       v10, vcc, v4, v10
/*5016171e         */ v_addc_u32      v11, vcc, v30, v11, vcc
/*3a461d1c         */ v_xor_b32       v35, v28, v14
/*3a482120         */ v_xor_b32       v36, v32, v16
/*3a4a0b08         */ v_xor_b32       v37, v8, v5
/*3a4c0d19         */ v_xor_b32       v38, v25, v6
/*3a4e1307         */ v_xor_b32       v39, v7, v9
/*3a501915         */ v_xor_b32       v40, v21, v12
/*3a301518         */ v_xor_b32       v24, v24, v10
/*3a321722         */ v_xor_b32       v25, v34, v11
/*d2c40021 00013123*/ v_lshr_b64      v[33:34], v[35:36], 24
/*34384688         */ v_lshlrev_b32   v28, 8, v35
/*d2c40023 00013125*/ v_lshr_b64      v[35:36], v[37:38], 24
/*34104a88         */ v_lshlrev_b32   v8, 8, v37
/*d2c40025 00012127*/ v_lshr_b64      v[37:38], v[39:40], 16
/*340e4e90         */ v_lshlrev_b32   v7, 16, v39
/*d2c4001f 00013118*/ v_lshr_b64      v[31:32], v[24:25], 24
/*342a3088         */ v_lshlrev_b32   v21, 8, v24
/*38303922         */ v_or_b32        v24, v34, v28
/*4a2c4316         */ v_add_i32       v22, vcc, v22, v33
/*502e3117         */ v_addc_u32      v23, vcc, v23, v24, vcc
/*38101124         */ v_or_b32        v8, v36, v8
/*4a044702         */ v_add_i32       v2, vcc, v2, v35
/*50021101         */ v_addc_u32      v1, vcc, v1, v8, vcc
/*380e0f26         */ v_or_b32        v7, v38, v7
/*382a2b20         */ v_or_b32        v21, v32, v21
/*4a1e3f0f         */ v_add_i32       v15, vcc, v15, v31
/*50242b12         */ v_addc_u32      v18, vcc, v18, v21, vcc
/*4a262725         */ v_add_i32       v19, vcc, v37, v19
/*50282907         */ v_addc_u32      v20, vcc, v7, v20, vcc
/*3a4c2d0d         */ v_xor_b32       v38, v13, v22
/*3a4e2f1a         */ v_xor_b32       v39, v26, v23
/*3a501f04         */ v_xor_b32       v40, v4, v15
/*3a52251e         */ v_xor_b32       v41, v30, v18
/*3a54271d         */ v_xor_b32       v42, v29, v19
/*3a562911         */ v_xor_b32       v43, v17, v20
/*3a580503         */ v_xor_b32       v44, v3, v2
/*3a5a031b         */ v_xor_b32       v45, v27, v1
/*d2c4001d 00012126*/ v_lshr_b64      v[29:30], v[38:39], 16
/*341a4c90         */ v_lshlrev_b32   v13, 16, v38
/*d2c40019 00012128*/ v_lshr_b64      v[25:26], v[40:41], 16
/*34085090         */ v_lshlrev_b32   v4, 16, v40
/*2c40569f         */ v_lshrrev_b32   v32, 31, v43
/*d2c20026 0001032a*/ v_lshl_b64      v[38:39], v[42:43], 1
/*d2c4001b 0001212c*/ v_lshr_b64      v[27:28], v[44:45], 16
/*34065890         */ v_lshlrev_b32   v3, 16, v44
/*381a1b1e         */ v_or_b32        v13, v30, v13
/*4a1c1d1d         */ v_add_i32       v14, vcc, v29, v14
/*5020210d         */ v_addc_u32      v16, vcc, v13, v16, vcc
/*3808091a         */ v_or_b32        v4, v26, v4
/*4a141519         */ v_add_i32       v10, vcc, v25, v10
/*50161704         */ v_addc_u32      v11, vcc, v4, v11, vcc
/*38224d20         */ v_or_b32        v17, v32, v38
/*3806071c         */ v_or_b32        v3, v28, v3
/*4a0a0b1b         */ v_add_i32       v5, vcc, v27, v5
/*500c0d03         */ v_addc_u32      v6, vcc, v3, v6, vcc
/*4a1e230f         */ v_add_i32       v15, vcc, v15, v17
/*50244f12         */ v_addc_u32      v18, vcc, v18, v39, vcc
/*3a401d21         */ v_xor_b32       v32, v33, v14
/*3a422118         */ v_xor_b32       v33, v24, v16
/*3a440b23         */ v_xor_b32       v34, v35, v5
/*3a460d08         */ v_xor_b32       v35, v8, v6
/*3a50151f         */ v_xor_b32       v40, v31, v10
/*3a521715         */ v_xor_b32       v41, v21, v11
/*3a1a250d         */ v_xor_b32       v13, v13, v18
/*2c3e429f         */ v_lshrrev_b32   v31, 31, v33
/*d2c20020 00010320*/ v_lshl_b64      v[32:33], v[32:33], 1
/*3a301f1d         */ v_xor_b32       v24, v29, v15
/*4a0a0b0d         */ v_add_i32       v5, vcc, v13, v5
/*500c0d18         */ v_addc_u32      v6, vcc, v24, v6, vcc
/*2c34469f         */ v_lshrrev_b32   v26, 31, v35
/*d2c2001c 00010322*/ v_lshl_b64      v[28:29], v[34:35], 1
/*2c10529f         */ v_lshrrev_b32   v8, 31, v41
/*d2c20022 00010328*/ v_lshl_b64      v[34:35], v[40:41], 1
/*382a411f         */ v_or_b32        v21, v31, v32
/*beea0480         */ s_mov_b64       vcc, 0
/*3834391a         */ v_or_b32        v26, v26, v28
/*38104508         */ v_or_b32        v8, v8, v34
/*50020101         */ v_addc_u32      v1, vcc, v1, v0, vcc
/*4a042b02         */ v_add_i32       v2, vcc, v2, v21
/*50024301         */ v_addc_u32      v1, vcc, v1, v33, vcc
/*3a4c0b11         */ v_xor_b32       v38, v17, v5
/*3a4e0d27         */ v_xor_b32       v39, v39, v6
/*4a12131a         */ v_add_i32       v9, vcc, v26, v9
/*5018191d         */ v_addc_u32      v12, vcc, v29, v12, vcc
/*4a2c2d08         */ v_add_i32       v22, vcc, v8, v22
/*502e2f23         */ v_addc_u32      v23, vcc, v35, v23, vcc
/*3a0e0f01         */ v_xor_b32       v7, v1, v7
/*d2c4001e 00013126*/ v_lshr_b64      v[30:31], v[38:39], 24
/*34224c88         */ v_lshlrev_b32   v17, 8, v38
/*3a081904         */ v_xor_b32       v4, v4, v12
/*3a062f03         */ v_xor_b32       v3, v3, v23
/*3a384b02         */ v_xor_b32       v28, v2, v37
/*4a141507         */ v_add_i32       v10, vcc, v7, v10
/*5016171c         */ v_addc_u32      v11, vcc, v28, v11, vcc
/*3822231f         */ v_or_b32        v17, v31, v17
/*4a1e3d0f         */ v_add_i32       v15, vcc, v15, v30
/*50222312         */ v_addc_u32      v17, vcc, v18, v17, vcc
/*3a241319         */ v_xor_b32       v18, v25, v9
/*4a1c1d04         */ v_add_i32       v14, vcc, v4, v14
/*50202112         */ v_addc_u32      v16, vcc, v18, v16, vcc
/*3a322d1b         */ v_xor_b32       v25, v27, v22
/*4a262703         */ v_add_i32       v19, vcc, v3, v19
/*50282919         */ v_addc_u32      v20, vcc, v25, v20, vcc
/*3a481515         */ v_xor_b32       v36, v21, v10
/*3a4a1721         */ v_xor_b32       v37, v33, v11
/*3a501f0d         */ v_xor_b32       v40, v13, v15
/*3a522318         */ v_xor_b32       v41, v24, v17
/*3a341d1a         */ v_xor_b32       v26, v26, v14
/*3a36211d         */ v_xor_b32       v27, v29, v16
/*3a3a2708         */ v_xor_b32       v29, v8, v19
/*3a3c2923         */ v_xor_b32       v30, v35, v20
/*c2000900         */ s_buffer_load_dword s0, s[8:11], 0x0
/*d2c4001f 00013124*/ v_lshr_b64      v[31:32], v[36:37], 24
/*342a4888         */ v_lshlrev_b32   v21, 8, v36
/*d2c40021 00012128*/ v_lshr_b64      v[33:34], v[40:41], 16
/*d2c40023 0001311a*/ v_lshr_b64      v[35:36], v[26:27], 24
/*34303488         */ v_lshlrev_b32   v24, 8, v26
/*d2c4001a 0001311d*/ v_lshr_b64      v[26:27], v[29:30], 24
/*34103a88         */ v_lshlrev_b32   v8, 8, v29
/*382a2b20         */ v_or_b32        v21, v32, v21
/*4a043f02         */ v_add_i32       v2, vcc, v2, v31
/*50022b01         */ v_addc_u32      v1, vcc, v1, v21, vcc
/*d24a0405 00020b21*/ v_add_i32       v5, s[4:5], v33, v5
/*38303124         */ v_or_b32        v24, v36, v24
/*4a121323         */ v_add_i32       v9, vcc, v35, v9
/*50181918         */ v_addc_u32      v12, vcc, v24, v12, vcc
/*3810111b         */ v_or_b32        v8, v27, v8
/*4a2c2d1a         */ v_add_i32       v22, vcc, v26, v22
/*502e2f08         */ v_addc_u32      v23, vcc, v8, v23, vcc
/*3a0a0505         */ v_xor_b32       v5, v5, v2
/*3a480507         */ v_xor_b32       v36, v7, v2
/*3a4a031c         */ v_xor_b32       v37, v28, v1
/*3a4c1304         */ v_xor_b32       v38, v4, v9
/*3a4e1912         */ v_xor_b32       v39, v18, v12
/*3a522d03         */ v_xor_b32       v41, v3, v22
/*3a542f19         */ v_xor_b32       v42, v25, v23
/*3a5a0a14         */ v_xor_b32       v45, s20, v5
/*36365aff 00000fff*/ v_and_b32       v27, 0xfff, v45
/*d2c4001c 00012124*/ v_lshr_b64      v[28:29], v[36:37], 16
/*34044890         */ v_lshlrev_b32   v2, 16, v36
/*d2c40024 00012126*/ v_lshr_b64      v[36:37], v[38:39], 16
/*34084c90         */ v_lshlrev_b32   v4, 16, v38
/*d2c40026 00012129*/ v_lshr_b64      v[38:39], v[41:42], 16
/*34065290         */ v_lshlrev_b32   v3, 16, v41
/*340e5a84         */ v_lshlrev_b32   v7, 4, v45
/*2c243681         */ v_lshrrev_b32   v18, 1, v27
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8f008c00         */ s_lshl_b32      s0, s0, 12
/*3804051d         */ v_or_b32        v2, v29, v2
/*4a14151c         */ v_add_i32       v10, vcc, v28, v10
/*50041702         */ v_addc_u32      v2, vcc, v2, v11, vcc
/*38080925         */ v_or_b32        v4, v37, v4
/*4a161d24         */ v_add_i32       v11, vcc, v36, v14
/*501c2104         */ v_addc_u32      v14, vcc, v4, v16, vcc
/*38060727         */ v_or_b32        v3, v39, v3
/*4a202726         */ v_add_i32       v16, vcc, v38, v19
/*50262903         */ v_addc_u32      v19, vcc, v3, v20, vcc
/*360e0e90         */ v_and_b32       v7, 16, v7
/*38242400         */ v_or_b32        v18, s0, v18
/*341a5090         */ v_lshlrev_b32   v13, 16, v40
/*32280e81         */ v_lshl_b32      v20, 1, v7
/*34242482         */ v_lshlrev_b32   v18, 2, v18
/*3a3a151f         */ v_xor_b32       v29, v31, v10
/*3a3c0515         */ v_xor_b32       v30, v21, v2
/*381a1b22         */ v_or_b32        v13, v34, v13
/*3a3e1723         */ v_xor_b32       v31, v35, v11
/*3a401d18         */ v_xor_b32       v32, v24, v14
/*3a44211a         */ v_xor_b32       v34, v26, v16
/*3a462708         */ v_xor_b32       v35, v8, v19
/*3a121310         */ v_xor_b32       v9, v16, v9
/*3a181913         */ v_xor_b32       v12, v19, v12
/*d8800000 10001412*/ ds_add_rtn_u32  v16, v18, v20 gds
/*d2506a06 00120d0d*/ v_addc_u32      v6, vcc, v13, v6, s[4:5]
/*3a56121a         */ v_xor_b32       v43, s26, v9
/*3a58181b         */ v_xor_b32       v44, s27, v12
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a0e0f10         */ v_lshr_b32      v7, v16, v7
/*2c203c9f         */ v_lshrrev_b32   v16, 31, v30
/*d2c20012 0001031d*/ v_lshl_b64      v[18:19], v[29:30], 1
/*2c28409f         */ v_lshrrev_b32   v20, 31, v32
/*d2c20018 0001031f*/ v_lshl_b64      v[24:25], v[31:32], 1
/*2c2a469f         */ v_lshrrev_b32   v21, 31, v35
/*d2c2001c 00010322*/ v_lshl_b64      v[28:29], v[34:35], 1
/*3a020306         */ v_xor_b32       v1, v6, v1
/*360c0eff 0000ffff*/ v_and_b32       v6, 0xffff, v7
/*b00102ab         */ s_movk_i32      s1, 0x2ab
/*c2020908         */ s_buffer_load_dword s4, s[8:11], 0x8
/*380e2510         */ v_or_b32        v7, v16, v18
/*38103114         */ v_or_b32        v8, v20, v24
/*38203915         */ v_or_b32        v16, v21, v28
/*d2c4001e 0001112b*/ v_lshr_b64      v[30:31], v[43:44], 8
/*3a5c0215         */ v_xor_b32       v46, s21, v1
/*7d8c0c01         */ v_cmp_ge_u32    vcc, s1, v6
/*34620081         */ v_lshlrev_b32   v49, 1, v0
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*bf88002f         */ s_cbranch_execz .L11384_1
/*b00102ac         */ s_movk_i32      s1, 0x2ac
/*d2d60012 0000031b*/ v_mul_lo_i32    v18, v27, s1
/*3a141f0a         */ v_xor_b32       v10, v10, v15
/*3a042302         */ v_xor_b32       v2, v2, v17
/*4a0c2506         */ v_add_i32       v6, vcc, v6, v18
/*c0840368         */ s_load_dwordx4  s[8:11], s[2:3], 0x68
/*3a162d0b         */ v_xor_b32       v11, v11, v22
/*3a1c2f0e         */ v_xor_b32       v14, v14, v23
/*3a281418         */ v_xor_b32       v20, s24, v10
/*3a2a0419         */ v_xor_b32       v21, s25, v2
/*340c0c85         */ v_lshlrev_b32   v6, 5, v6
/*3a161616         */ v_xor_b32       v11, s22, v11
/*3a181c17         */ v_xor_b32       v12, s23, v14
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*4a0c0c04         */ v_add_i32       v6, vcc, s4, v6
/*2c1e2a88         */ v_lshrrev_b32   v15, 8, v21
/*34125698         */ v_lshlrev_b32   v9, 24, v43
/*2c222888         */ v_lshrrev_b32   v17, 8, v20
/*d2c40016 00011114*/ v_lshr_b64      v[22:23], v[20:21], 8
/*be8103ff ff000000*/ s_mov_b32       s1, 0xff000000
/*3860130f         */ v_or_b32        v48, v15, v9
/*d294002f 04462c01*/ v_bfi_b32       v47, s1, v22, v17
/*34142898         */ v_lshlrev_b32   v10, 24, v20
/*2c1e1888         */ v_lshrrev_b32   v15, 8, v12
/*2c225a88         */ v_lshrrev_b32   v17, 8, v45
/*d2c40016 0001112d*/ v_lshr_b64      v[22:23], v[45:46], 8
/*2c0a1688         */ v_lshrrev_b32   v5, 8, v11
/*d2c40017 0001110b*/ v_lshr_b64      v[23:24], v[11:12], 8
/*34161698         */ v_lshlrev_b32   v11, 24, v11
/*2c025c88         */ v_lshrrev_b32   v1, 8, v46
/*38541f0a         */ v_or_b32        v42, v10, v15
/*d2940027 04462c01*/ v_bfi_b32       v39, s1, v22, v17
/*d2940029 04162e01*/ v_bfi_b32       v41, s1, v23, v5
/*3850030b         */ v_or_b32        v40, v11, v1
/*7e64032f         */ v_mov_b32       v50, v47
/*ebf71010 80022f06*/ tbuffer_store_format_xyzw v[47:50], v6, s[8:11], 0 offen offset:16 format:[32_32_32_32,float]
/*ebf71000 80022706*/ tbuffer_store_format_xyzw v[39:42], v6, s[8:11], 0 offen format:[32_32_32_32,float]
.L11384_1:
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*36023cff 00000fff*/ v_and_b32       v1, 0xfff, v30
/*34043c84         */ v_lshlrev_b32   v2, 4, v30
/*36040490         */ v_and_b32       v2, 16, v2
/*320a0481         */ v_lshl_b32      v5, 1, v2
/*2c0c0281         */ v_lshrrev_b32   v6, 1, v1
/*380c0c00         */ v_or_b32        v6, s0, v6
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*d8800000 05000506*/ ds_add_rtn_u32  v5, v6, v5 gds
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a040505         */ v_lshr_b32      v2, v5, v2
/*360404ff 0000ffff*/ v_and_b32       v2, 0xffff, v2
/*b00002ab         */ s_movk_i32      s0, 0x2ab
/*7d8c0400         */ v_cmp_ge_u32    vcc, s0, v2
/*be80246a         */ s_and_saveexec_b64 s[0:1], vcc
/*3a0a0f21         */ v_xor_b32       v5, v33, v7
/*bf880043         */ s_cbranch_execz .L11732_1
/*3a0c270d         */ v_xor_b32       v6, v13, v19
/*b00502ac         */ s_movk_i32      s5, 0x2ac
/*3a0e1126         */ v_xor_b32       v7, v38, v8
/*3a063303         */ v_xor_b32       v3, v3, v25
/*3a102124         */ v_xor_b32       v8, v36, v16
/*3a083b04         */ v_xor_b32       v4, v4, v29
/*3a120a1e         */ v_xor_b32       v9, s30, v5
/*3a140c1f         */ v_xor_b32       v10, s31, v6
/*d2d60001 00000b01*/ v_mul_lo_i32    v1, v1, s5
/*3a1e0e1c         */ v_xor_b32       v15, s28, v7
/*3a20061d         */ v_xor_b32       v16, s29, v3
/*3a0e1020         */ v_xor_b32       v7, s32, v8
/*3a100821         */ v_xor_b32       v8, s33, v4
/*4a020302         */ v_add_i32       v1, vcc, v2, v1
/*c0840368         */ s_load_dwordx4  s[8:11], s[2:3], 0x68
/*34040e98         */ v_lshlrev_b32   v2, 24, v7
/*d2c4000d 00011109*/ v_lshr_b64      v[13:14], v[9:10], 8
/*34020285         */ v_lshlrev_b32   v1, 5, v1
/*34161e98         */ v_lshlrev_b32   v11, 24, v15
/*d2c40011 0001110f*/ v_lshr_b64      v[17:18], v[15:16], 8
/*340a1298         */ v_lshlrev_b32   v5, 24, v9
/*38041d02         */ v_or_b32        v2, v2, v14
/*d2c40007 00011107*/ v_lshr_b64      v[7:8], v[7:8], 8
/*2c081488         */ v_lshrrev_b32   v4, 8, v10
/*d2c40008 00012109*/ v_lshr_b64      v[8:9], v[9:10], 16
/*4a020204         */ v_add_i32       v1, vcc, s4, v1
/*380c171f         */ v_or_b32        v6, v31, v11
/*380a0b12         */ v_or_b32        v5, v18, v5
/*2c125888         */ v_lshrrev_b32   v9, 8, v44
/*2c062088         */ v_lshrrev_b32   v3, 8, v16
/*2c040488         */ v_lshrrev_b32   v2, 8, v2
/*340e0e98         */ v_lshlrev_b32   v7, 24, v7
/*34080898         */ v_lshlrev_b32   v4, 24, v4
/*361010ff 00ffffff*/ v_and_b32       v8, 0xffffff, v8
/*d2c4000a 0001212b*/ v_lshr_b64      v[10:11], v[43:44], 16
/*d2c4000b 0001210f*/ v_lshr_b64      v[11:12], v[15:16], 16
/*381e0f02         */ v_or_b32        v15, v2, v7
/*381c1104         */ v_or_b32        v14, v4, v8
/*4a206281         */ v_add_i32       v16, vcc, 1, v49
/*2c0a0a88         */ v_lshrrev_b32   v5, 8, v5
/*340e1a98         */ v_lshlrev_b32   v7, 24, v13
/*34101298         */ v_lshlrev_b32   v8, 24, v9
/*361214ff 00ffffff*/ v_and_b32       v9, 0xffffff, v10
/*34060698         */ v_lshlrev_b32   v3, 24, v3
/*361416ff 00ffffff*/ v_and_b32       v10, 0xffffff, v11
/*34162298         */ v_lshlrev_b32   v11, 24, v17
/*2c0c0c88         */ v_lshrrev_b32   v6, 8, v6
/*380a0f05         */ v_or_b32        v5, v5, v7
/*38041308         */ v_or_b32        v2, v8, v9
/*38081503         */ v_or_b32        v4, v3, v10
/*38060d0b         */ v_or_b32        v3, v11, v6
/*7e22030e         */ v_mov_b32       v17, v14
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebf71010 80020e01*/ tbuffer_store_format_xyzw v[14:17], v1, s[8:11], 0 offen offset:16 format:[32_32_32_32,float]
/*ebf71000 80020201*/ tbuffer_store_format_xyzw v[2:5], v1, s[8:11], 0 offen format:[32_32_32_32,float]
.L11732_1:
/*bf810000         */ s_endpgm
.kernel kernel_round1
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 37 /*36*/
        .vgprsnum 44
        .hwlocal 22304
        .floatmode 0xc0
        .uavid 11
        .uavprivate 64
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x002b8098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg ht_dst, "char*", char*, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
        .arg rowCountersDst, "uint*", uint*, global, , 14
        .arg debug, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c200051c         */ s_buffer_load_dword s0, s[4:7], 0x1c
/*7e020280         */ v_mov_b32       v1, 0
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*c2030910         */ s_buffer_load_dword s6, s[8:11], 0x10
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000000c         */ s_add_u32       s0, s12, s0
/*7e380280         */ v_mov_b32       v28, 0
/*bf0bff00 00000fff*/ s_cmp_le_u32    s0, 0xfff
/*bf8401e9         */ s_cbranch_scc0  .L2012_2
/*b00700ff         */ s_movk_i32      s7, 0xff
/*7d8c0007         */ v_cmp_ge_u32    vcc, s7, v0
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880015         */ s_cbranch_execz .L160_2
/*4a0202ff 00004cc0*/ v_add_i32       v1, vcc, 0x4cc0, v1
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e040300         */ v_mov_b32       v2, v0
.L96_2:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d8340000 00000301*/ ds_write_b32    v1, v3
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b0070100         */ s_movk_i32      s7, 0x100
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L160_2
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82fff0         */ s_branch        .L96_2
.L160_2:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*8f018c01         */ s_lshl_b32      s1, s1, 12
/*b00702ab         */ s_movk_i32      s7, 0x2ab
/*d1880008 00000f00*/ v_cmp_gt_u32    s[8:9], v0, s7
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*8afe080a         */ s_andn2_b64     exec, s[10:11], s[8:9]
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880031         */ s_cbranch_execz .L392_2
/*4a0202ff 000050c0*/ v_add_i32       v1, vcc, 0x50c0, v1
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*be94047e         */ s_mov_b64       s[20:21], exec
/*7e040300         */ v_mov_b32       v2, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L224_2:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d87c0000 00000301*/ ds_write_b16    v1, v3
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00702ac         */ s_movk_i32      s7, 0x2ac
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be96047e         */ s_mov_b64       s[22:23], exec
/*8afe6a16         */ s_andn2_b64     exec, s[22:23], vcc
/*8a947e14         */ s_andn2_b64     s[20:21], s[20:21], exec
/*bf840002         */ s_cbranch_scc0  .L288_2
/*87fe1416         */ s_and_b64       exec, s[22:23], s[20:21]
/*bf82fff0         */ s_branch        .L224_2
.L288_2:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040080         */ v_cmp_eq_i32    vcc, 0, v0
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf880012         */ s_cbranch_execz .L376_2
/*90078100         */ s_lshr_b32      s7, s0, 1
/*80070701         */ s_add_u32       s7, s1, s7
/*8f078207         */ s_lshl_b32      s7, s7, 2
/*7e020207         */ v_mov_b32       v1, s7

/*d8d80000 01000001*/ ds_read_b32     v1, v1 gds

/*8f078400         */ s_lshl_b32      s7, s0, 4
/*87079007         */ s_and_b32       s7, s7, 16
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c020207         */ v_lshrrev_b32   v1, s7, v1
/*d2900001 02410101*/ v_bfe_u32       v1, v1, 0, 16
/*260802ff 000002ac*/ v_min_u32       v4, 0x2ac, v1
/*7e040280         */ v_mov_b32       v2, 0
/*d8344cb0 00000402*/ ds_write_b32    v2, v4 offset:19632
/*7e020281         */ v_mov_b32       v1, 1
.L376_2:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040e         */ s_mov_b64       exec, s[14:15]
.L392_2:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e060280         */ v_mov_b32       v3, 0
/*d8d84cb0 03000003*/ ds_read_b32     v3, v3 offset:19632
/*d2920001 02050101*/ v_bfe_i32       v1, v1, 0, 1
/*7d0a0280         */ v_cmp_lg_i32    vcc, 0, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*00040903         */ v_cndmask_b32   v2, v3, v4, vcc
/*bf8a0000         */ s_barrier
/*7d8a0280         */ v_cmp_lg_u32    vcc, 0, v1
/*be8a246a         */ s_and_saveexec_b64 s[10:11], vcc
/*7e020280         */ v_mov_b32       v1, 0
/*bf880002         */ s_cbranch_execz .L476_2
/*d8344cb0 00000101*/ ds_write_b32    v1, v1 offset:19632
.L476_2:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7d820500         */ v_cmp_lt_u32    vcc, v0, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf88004a         */ s_cbranch_execz .L800_2
/*4a0202ff 000050c0*/ v_add_i32       v1, vcc, 0x50c0, v1
/*9307ff00 000002ac*/ s_mul_i32       s7, s0, 0x2ac
/*4a060007         */ v_add_i32       v3, vcc, s7, v0
/*34060685         */ v_lshlrev_b32   v3, 5, v3
/*4a060604         */ v_add_i32       v3, vcc, s4, v3
/*34080082         */ v_lshlrev_b32   v4, 2, v0
/*4a0808ff 00003580*/ v_add_i32       v4, vcc, 0x3580, v4
/*c08a0360         */ s_load_dwordx4  s[20:23], s[2:3], 0x60
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e320300         */ v_mov_b32       v25, v0
.L556_2:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebf31000 80050e03*/ tbuffer_load_format_xyzw v[14:17], v3, s[20:23], 0 offen format:[32_32_32_32,float]
/*ebd91010 80050a03*/ tbuffer_load_format_xy v[10:11], v3, s[20:23], 0 offen offset:16 format:[32_32,float]
/*4a1808ff ffffca90*/ v_add_i32       v12, vcc, 0xffffca90, v4
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*bf800000         */ s_nop           0x0
/*d8340000 00000e0c*/ ds_write_b32    v12, v14
/*4a1808ff ffffd540*/ v_add_i32       v12, vcc, 0xffffd540, v4
/*d8340000 00000f0c*/ ds_write_b32    v12, v15
/*4a0e08ff ffffdff0*/ v_add_i32       v7, vcc, 0xffffdff0, v4
/*d8340000 00001007*/ ds_write_b32    v7, v16
/*4a0e08ff ffffeaa0*/ v_add_i32       v7, vcc, 0xffffeaa0, v4
/*36181cff 000000f0*/ v_and_b32       v12, 0xf0, v14
/*d2900006 0211190e*/ v_bfe_u32       v6, v14, 12, 4
/*d8340000 00001107*/ ds_write_b32    v7, v17
/*4a0e08ff fffff550*/ v_add_i32       v7, vcc, 0xfffff550, v4
/*380c0d0c         */ v_or_b32        v6, v12, v6
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000a07*/ ds_write_b32    v7, v10
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*d8340000 00000b04*/ ds_write_b32    v4, v11
/*4a0c0cff 00004cc0*/ v_add_i32       v6, vcc, 0x4cc0, v6
/*d8b40000 06001906*/ ds_wrxchg_rtn_b32 v6, v6, v25
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900006 02410106*/ v_bfe_u32       v6, v6, 0, 16
/*4a3232ff 00000100*/ v_add_i32       v25, vcc, 0x100, v25
/*d87c0000 00000601*/ ds_write_b16    v1, v6
/*4a0606ff 00002000*/ v_add_i32       v3, vcc, 0x2000, v3
/*4a0808ff 00000400*/ v_add_i32       v4, vcc, 0x400, v4
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*7d883302         */ v_cmp_gt_u32    vcc, v2, v25
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffc8         */ s_cbranch_execnz .L556_2
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7e3402ff 00000200*/ v_mov_b32       v26, 0x200
/*7e0402ff 00000100*/ v_mov_b32       v2, 0x100
.L800_2:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf880004         */ s_cbranch_execz .L824_2
/*7e340301         */ v_mov_b32       v26, v1
/*7e040301         */ v_mov_b32       v2, v1
/*7e320301         */ v_mov_b32       v25, v1
/*7e200301         */ v_mov_b32       v16, v1
.L824_2:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe080a         */ s_and_b64       exec, s[10:11], s[8:9]
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf88003d         */ s_cbranch_execz .L1088_2
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e0a0300         */ v_mov_b32       v5, v0
.L856_2:
/*be94047e         */ s_mov_b64       s[20:21], exec
/*be96047e         */ s_mov_b64       s[22:23], exec
/*7e060305         */ v_mov_b32       v3, v5
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L896_2:
/*340c0681         */ v_lshlrev_b32   v6, 1, v3
/*4a0c0cff 000050c0*/ v_add_i32       v6, vcc, 0x50c0, v6
/*b00402ab         */ s_movk_i32      s4, 0x2ab
/*d8f00000 06000006*/ ds_read_u16     v6, v6
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900003 02410106*/ v_bfe_u32       v3, v6, 0, 16
/*7d820604         */ v_cmp_lt_u32    vcc, s4, v3
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf840018         */ s_cbranch_scc0  .L1044_2
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*7e0c0280         */ v_mov_b32       v6, 0
/*7e1002c1         */ v_mov_b32       v8, -1
/*d88c4cb0 06000806*/ ds_inc_rtn_u32  v6, v6, v8 offset:19632
/*b0040318         */ s_movk_i32      s4, 0x318
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*7d820c04         */ v_cmp_lt_u32    vcc, s4, v6
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf84000d         */ s_cbranch_scc0  .L1044_2
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*340c0c81         */ v_lshlrev_b32   v6, 1, v6
/*4a100cff 00004030*/ v_add_i32       v8, vcc, 0x4030, v6
/*d2900009 02410105*/ v_bfe_u32       v9, v5, 0, 16
/*d87c0000 00000908*/ ds_write_b16    v8, v9
/*4a0c0cff 00004670*/ v_add_i32       v6, vcc, 0x4670, v6
/*d87c0000 00000306*/ ds_write_b16    v6, v3
/*bf82ffdb         */ s_branch        .L896_2
.L1044_2:
/*befe0414         */ s_mov_b64       exec, s[20:21]
/*4a0a0aff 00000100*/ v_add_i32       v5, vcc, 0x100, v5
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*7d880a04         */ v_cmp_gt_u32    vcc, s4, v5
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L1088_2
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82ffc6         */ s_branch        .L856_2
.L1088_2:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8d84cb0 05000005*/ ds_read_b32     v5, v5 offset:19632
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*260a0aff 00000319*/ v_min_u32       v5, 0x319, v5
/*7e0c0280         */ v_mov_b32       v6, 0
/*7d0a0d05         */ v_cmp_lg_i32    vcc, v5, v6
/*bf8600db         */ s_cbranch_vccz  .L2012_2
/*8001ff01 00000800*/ s_add_u32       s1, s1, 0x800
/*360c0081         */ v_and_b32       v6, 1, v0
/*340e0c84         */ v_lshlrev_b32   v7, 4, v6
/*38100ea0         */ v_or_b32        v8, 32, v7
/*2c120081         */ v_lshrrev_b32   v9, 1, v0
/*360000c2         */ v_and_b32       v0, -2, v0
/*8f009400         */ s_lshl_b32      s0, s0, 20
/*7e146f09         */ v_not_b32       v10, v9
/*c0840370         */ s_load_dwordx4  s[8:11], s[2:3], 0x70
/*c08a0368         */ s_load_dwordx4  s[20:23], s[2:3], 0x68
/*7e040505         */ v_readfirstlane_b32 s2, v5
.L1184_2:
/*7d881202         */ v_cmp_gt_u32    vcc, s2, v9
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a021402         */ v_add_i32       v1, vcc, s2, v10
/*bf880012         */ s_cbranch_execz .L1272_2
/*34020281         */ v_lshlrev_b32   v1, 1, v1
/*4a0402ff 00004670*/ v_add_i32       v2, vcc, 0x4670, v1
/*4a0202ff 00004030*/ v_add_i32       v1, vcc, 0x4030, v1
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*d8f00000 01000001*/ ds_read_u16     v1, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*363404ff 0000ffff*/ v_and_b32       v26, 0xffff, v2
/*360202ff 0000ffff*/ v_and_b32       v1, 0xffff, v1
/*34063482         */ v_lshlrev_b32   v3, 2, v26
/*340a0282         */ v_lshlrev_b32   v5, 2, v1
/*4a040690         */ v_add_i32       v2, vcc, 16, v3
/*4a320a90         */ v_add_i32       v25, vcc, 16, v5
.L1272_2:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e0202ff 000002ac*/ v_mov_b32       v1, 0x2ac
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040c80         */ v_cmp_eq_i32    vcc, 0, v6
/*87fe6a0e         */ s_and_b64       exec, s[14:15], vcc
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*7e1602ff 000002ac*/ v_mov_b32       v11, 0x2ac
/*bf880002         */ s_cbranch_execz .L1320_2
/*d87c5620 00000b00*/ ds_write_b16    v0, v11 offset:22048
.L1320_2:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*7d880203         */ v_cmp_gt_u32    vcc, s3, v1
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a0832ff 00000ab0*/ v_add_i32       v4, vcc, 0xab0, v25
/*bf880076         */ s_cbranch_execz .L1820_2
/*bf800000         */ s_nop           0x0
/*4a1604ff 00000ab0*/ v_add_i32       v11, vcc, 0xab0, v2
/*4a1804ff 00001560*/ v_add_i32       v12, vcc, 0x1560, v2
/*4a1a32ff 00001560*/ v_add_i32       v13, vcc, 0x1560, v25
/*d8d80000 0e000019*/ ds_read_b32     v14, v25
/*d8d80000 0f000002*/ ds_read_b32     v15, v2
/*d8d80000 04000004*/ ds_read_b32     v4, v4
/*d8d80000 0b00000b*/ ds_read_b32     v11, v11
/*4a2004ff 00002010*/ v_add_i32       v16, vcc, 0x2010, v2
/*4a2232ff 00002010*/ v_add_i32       v17, vcc, 0x2010, v25
/*d8d80000 0c00000c*/ ds_read_b32     v12, v12
/*d8d80000 0d00000d*/ ds_read_b32     v13, v13
/*4a2404ff 00002ac0*/ v_add_i32       v18, vcc, 0x2ac0, v2
/*4a2632ff 00002ac0*/ v_add_i32       v19, vcc, 0x2ac0, v25
/*d8d80000 10000010*/ ds_read_b32     v16, v16
/*d8d80000 11000011*/ ds_read_b32     v17, v17
/*4a2804ff 00003570*/ v_add_i32       v20, vcc, 0x3570, v2
/*4a2a32ff 00003570*/ v_add_i32       v21, vcc, 0x3570, v25
/*d8d80000 12000012*/ ds_read_b32     v18, v18
/*d8d80000 13000013*/ ds_read_b32     v19, v19
/*d8d80000 14000014*/ ds_read_b32     v20, v20
/*d8d80000 15000015*/ ds_read_b32     v21, v21
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*3a2c1f0e         */ v_xor_b32       v22, v14, v15
/*3a2e1704         */ v_xor_b32       v23, v4, v11
/*d29c0018 02222d17*/ v_alignbit_b32  v24, v23, v22, 8
/*3a181b0c         */ v_xor_b32       v12, v12, v13
/*d29c000d 02222f0c*/ v_alignbit_b32  v13, v12, v23, 8
/*3a202310         */ v_xor_b32       v16, v16, v17
/*d29c000c 02221910*/ v_alignbit_b32  v12, v16, v12, 8
/*3a222712         */ v_xor_b32       v17, v18, v19
/*d29c0010 02222111*/ v_alignbit_b32  v16, v17, v16, 8
/*3a242b14         */ v_xor_b32       v18, v20, v21
/*3426348a         */ v_lshlrev_b32   v19, 10, v26
/*d1040018 00021f0e*/ v_cmp_eq_i32    s[24:25], v14, v15
/*7d041704         */ v_cmp_eq_i32    vcc, v4, v11
/*7e480318         */ v_mov_b32       v36, v24
/*d29c0004 02222312*/ v_alignbit_b32  v4, v18, v17, 8
/*361626ff 000ffc00*/ v_and_b32       v11, 0xffc00, v19
/*7e4a030d         */ v_mov_b32       v37, v13
/*2c1a2488         */ v_lshrrev_b32   v13, 8, v18
/*38161600         */ v_or_b32        v11, s0, v11
/*360a02ff 000003ff*/ v_and_b32       v5, 0x3ff, v1
/*7e4c030c         */ v_mov_b32       v38, v12
/*380a0b0b         */ v_or_b32        v5, v11, v5
/*7e4e0310         */ v_mov_b32       v39, v16
/*87ea6a18         */ s_and_b64       vcc, s[24:25], vcc
/*7e500304         */ v_mov_b32       v40, v4
/*2c082c98         */ v_lshrrev_b32   v4, 24, v22
/*d200000b 01a98280*/ v_cndmask_b32   v11, 0, -1, vcc
/*7e52030d         */ v_mov_b32       v41, v13
/*2c182c88         */ v_lshrrev_b32   v12, 8, v22
/*360808ff 000000f0*/ v_and_b32       v4, 0xf0, v4
/*b0030f0f         */ s_movk_i32      s3, 0xf0f
/*38161706         */ v_or_b32        v11, v6, v11
/*7e540305         */ v_mov_b32       v42, v5
/*d2940010 04121803*/ v_bfi_b32       v16, s3, v12, v4
/*d2920005 0205010b*/ v_bfe_i32       v5, v11, 0, 1
/*7d840a80         */ v_cmp_eq_u32    vcc, 0, v5
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*2c0a2c84         */ v_lshrrev_b32   v5, 4, v22
/*bf880017         */ s_cbranch_execz .L1820_2
/*2c162081         */ v_lshrrev_b32   v11, 1, v16
/*360a0a90         */ v_and_b32       v5, 16, v5
/*34181682         */ v_lshlrev_b32   v12, 2, v11
/*321a0a81         */ v_lshl_b32      v13, 1, v5
/*4a181806         */ v_add_i32       v12, vcc, s6, v12
/*38161601         */ v_or_b32        v11, s1, v11
/*34161682         */ v_lshlrev_b32   v11, 2, v11

/*d8800000 0b000d0b*/ ds_add_rtn_u32  v11, v11, v13 gds

/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a160b0b         */ v_lshr_b32      v11, v11, v5
/*d290000b 0241010b*/ v_bfe_u32       v11, v11, 0, 16
/*d87c5620 00000b00*/ ds_write_b16    v0, v11 offset:22048
.L1820_2:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*d8f05620 05000000*/ ds_read_u16     v5, v0 offset:22048
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*360a0aff 0000ffff*/ v_and_b32       v5, 0xffff, v5
/*b00302ab         */ s_movk_i32      s3, 0x2ab
/*7d8c0a03         */ v_cmp_ge_u32    vcc, s3, v5
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf88001c         */ s_cbranch_execz .L1980_2
/*2c361082         */ v_lshrrev_b32   v27, 2, v8
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*bf880010         */ s_cbranch_execz .L1944_2
/*be9b037c         */ s_mov_b32       s27, m0
/*be9c047e         */ s_mov_b64       s[28:29], exec
.L1888_2:
/*7e34051b         */ v_readfirstlane_b32 s26, v27
/*befc031a         */ s_mov_b32       m0, s26
/*be9e047e         */ s_mov_b64       s[30:31], exec
/*d1240020 0002361a*/ v_cmpx_eq_i32   s[32:33], s26, v27
/*8a9e201e         */ s_andn2_b64     s[30:31], s[30:31], s[32:33]
/*7e16871c         */ v_movrels_b32   v11, v28
/*7e18871d         */ v_movrels_b32   v12, v29
/*7e1a871e         */ v_movrels_b32   v13, v30
/*7e1c871f         */ v_movrels_b32   v14, v31
/*befe041e         */ s_mov_b64       exec, s[30:31]
/*bf89fff4         */ s_cbranch_execnz .L1888_2
/*befe041c         */ s_mov_b64       exec, s[28:29]
/*befc031b         */ s_mov_b32       m0, s27
.L1944_2:
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*d2d6000f 00000710*/ v_mul_lo_i32    v15, v16, s3
/*4a0a1f05         */ v_add_i32       v5, vcc, v5, v15
/*340a0a85         */ v_lshlrev_b32   v5, 5, v5
/*4a0a0a05         */ v_add_i32       v5, vcc, s5, v5
/*4a0a0b07         */ v_add_i32       v5, vcc, v7, v5
/*ebf71000 80050b05*/ tbuffer_store_format_xyzw v[11:14], v5, s[20:23], 0 offen format:[32_32_32_32,float]
.L1980_2:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*8383ff02 00000080*/ s_min_u32       s3, s2, 0x80
/*80840302         */ s_sub_u32       s4, s2, s3
/*bf000302         */ s_cmp_eq_i32    s2, s3
/*bf850002         */ s_cbranch_scc1  .L2012_2
/*be820304         */ s_mov_b32       s2, s4
/*bf82ff31         */ s_branch        .L1184_2
.L2012_2:
/*bf810000         */ s_endpgm
.kernel kernel_round2
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 37 /*36*/
        .vgprsnum 42
        .hwlocal 22304
        .floatmode 0xc0
        .uavid 11
        .uavprivate 64
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x002b8098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg ht_dst, "char*", char*, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
        .arg rowCountersDst, "uint*", uint*, global, , 14
        .arg debug, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c200051c         */ s_buffer_load_dword s0, s[4:7], 0x1c
/*7e020280         */ v_mov_b32       v1, 0
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*c2030910         */ s_buffer_load_dword s6, s[8:11], 0x10
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000000c         */ s_add_u32       s0, s12, s0
/*7e340280         */ v_mov_b32       v26, 0
/*bf0bff00 00000fff*/ s_cmp_le_u32    s0, 0xfff
/*bf8401da         */ s_cbranch_scc0  .L1952_3
/*b00700ff         */ s_movk_i32      s7, 0xff
/*7d8c0007         */ v_cmp_ge_u32    vcc, s7, v0
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880015         */ s_cbranch_execz .L160_3
/*4a0202ff 00004cc0*/ v_add_i32       v1, vcc, 0x4cc0, v1
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e040300         */ v_mov_b32       v2, v0
.L96_3:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d8340000 00000301*/ ds_write_b32    v1, v3
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b0070100         */ s_movk_i32      s7, 0x100
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L160_3
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82fff0         */ s_branch        .L96_3
.L160_3:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*8f018c01         */ s_lshl_b32      s1, s1, 12
/*b00702ab         */ s_movk_i32      s7, 0x2ab
/*d1880008 00000f00*/ v_cmp_gt_u32    s[8:9], v0, s7
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*8afe080a         */ s_andn2_b64     exec, s[10:11], s[8:9]
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880033         */ s_cbranch_execz .L400_3
/*4a0202ff 000050c0*/ v_add_i32       v1, vcc, 0x50c0, v1
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*be94047e         */ s_mov_b64       s[20:21], exec
/*7e040300         */ v_mov_b32       v2, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L224_3:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d87c0000 00000301*/ ds_write_b16    v1, v3
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00702ac         */ s_movk_i32      s7, 0x2ac
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be96047e         */ s_mov_b64       s[22:23], exec
/*8afe6a16         */ s_andn2_b64     exec, s[22:23], vcc
/*8a947e14         */ s_andn2_b64     s[20:21], s[20:21], exec
/*bf840002         */ s_cbranch_scc0  .L288_3
/*87fe1416         */ s_and_b64       exec, s[22:23], s[20:21]
/*bf82fff0         */ s_branch        .L224_3
.L288_3:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040080         */ v_cmp_eq_i32    vcc, 0, v0
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf880014         */ s_cbranch_execz .L384_3
/*90078100         */ s_lshr_b32      s7, s0, 1
/*80070701         */ s_add_u32       s7, s1, s7
/*8f078207         */ s_lshl_b32      s7, s7, 2
/*7e020207         */ v_mov_b32       v1, s7
/*4a0202ff 00002000*/ v_add_i32       v1, vcc, 0x2000, v1

/*d8d80000 01000001*/ ds_read_b32     v1, v1 gds

/*8f078400         */ s_lshl_b32      s7, s0, 4
/*87079007         */ s_and_b32       s7, s7, 16
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c020207         */ v_lshrrev_b32   v1, s7, v1
/*d2900001 02410101*/ v_bfe_u32       v1, v1, 0, 16
/*260802ff 000002ac*/ v_min_u32       v4, 0x2ac, v1
/*7e040280         */ v_mov_b32       v2, 0
/*d8344cb0 00000402*/ ds_write_b32    v2, v4 offset:19632
/*7e020281         */ v_mov_b32       v1, 1
.L384_3:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040e         */ s_mov_b64       exec, s[14:15]
.L400_3:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e060280         */ v_mov_b32       v3, 0
/*d8d84cb0 03000003*/ ds_read_b32     v3, v3 offset:19632
/*d2920001 02050101*/ v_bfe_i32       v1, v1, 0, 1
/*7d0a0280         */ v_cmp_lg_i32    vcc, 0, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*00040903         */ v_cndmask_b32   v2, v3, v4, vcc
/*bf8a0000         */ s_barrier
/*7d8a0280         */ v_cmp_lg_u32    vcc, 0, v1
/*be8a246a         */ s_and_saveexec_b64 s[10:11], vcc
/*7e020280         */ v_mov_b32       v1, 0
/*bf880002         */ s_cbranch_execz .L484_3
/*d8344cb0 00000101*/ ds_write_b32    v1, v1 offset:19632
.L484_3:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7d820500         */ v_cmp_lt_u32    vcc, v0, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf88004d         */ s_cbranch_execz .L820_3
/*4a0202ff 000050c0*/ v_add_i32       v1, vcc, 0x50c0, v1
/*9307ff00 000002ac*/ s_mul_i32       s7, s0, 0x2ac
/*4a060007         */ v_add_i32       v3, vcc, s7, v0
/*34060685         */ v_lshlrev_b32   v3, 5, v3
/*4a060604         */ v_add_i32       v3, vcc, s4, v3
/*34080082         */ v_lshlrev_b32   v4, 2, v0
/*4a0808ff 00003580*/ v_add_i32       v4, vcc, 0x3580, v4
/*c08a0360         */ s_load_dwordx4  s[20:23], s[2:3], 0x60
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e2e0300         */ v_mov_b32       v23, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L576_3:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebf31000 80050603*/ tbuffer_load_format_xyzw v[6:9], v3, s[20:23], 0 offen format:[32_32_32_32,float]
/*ebd91010 80051003*/ tbuffer_load_format_xy v[16:17], v3, s[20:23], 0 offen offset:16 format:[32_32,float]
/*4a1808ff ffffca90*/ v_add_i32       v12, vcc, 0xffffca90, v4
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 0000060c*/ ds_write_b32    v12, v6
/*4a1808ff ffffd540*/ v_add_i32       v12, vcc, 0xffffd540, v4
/*d8340000 0000070c*/ ds_write_b32    v12, v7
/*4a0e08ff ffffdff0*/ v_add_i32       v7, vcc, 0xffffdff0, v4
/*2c180c88         */ v_lshrrev_b32   v12, 8, v6
/*d8340000 00000807*/ ds_write_b32    v7, v8
/*4a0e08ff ffffeaa0*/ v_add_i32       v7, vcc, 0xffffeaa0, v4
/*d2900006 02112106*/ v_bfe_u32       v6, v6, 16, 4
/*361018ff 000000f0*/ v_and_b32       v8, 0xf0, v12
/*d8340000 00000907*/ ds_write_b32    v7, v9
/*4a0e08ff fffff550*/ v_add_i32       v7, vcc, 0xfffff550, v4
/*380c1106         */ v_or_b32        v6, v6, v8
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00001007*/ ds_write_b32    v7, v16
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*d8340000 00001104*/ ds_write_b32    v4, v17
/*4a0c0cff 00004cc0*/ v_add_i32       v6, vcc, 0x4cc0, v6
/*d8b40000 06001706*/ ds_wrxchg_rtn_b32 v6, v6, v23
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900006 02410106*/ v_bfe_u32       v6, v6, 0, 16
/*4a2e2eff 00000100*/ v_add_i32       v23, vcc, 0x100, v23
/*d87c0000 00000601*/ ds_write_b16    v1, v6
/*4a0606ff 00002000*/ v_add_i32       v3, vcc, 0x2000, v3
/*4a0808ff 00000400*/ v_add_i32       v4, vcc, 0x400, v4
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*7d882f02         */ v_cmp_gt_u32    vcc, v2, v23
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffc8         */ s_cbranch_execnz .L576_3
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7e3002ff 00000200*/ v_mov_b32       v24, 0x200
/*7e0402ff 00000100*/ v_mov_b32       v2, 0x100
.L820_3:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf880004         */ s_cbranch_execz .L844_3
/*7e300301         */ v_mov_b32       v24, v1
/*7e040301         */ v_mov_b32       v2, v1
/*7e2e0301         */ v_mov_b32       v23, v1
/*7e200301         */ v_mov_b32       v16, v1
.L844_3:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe080a         */ s_and_b64       exec, s[10:11], s[8:9]
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf880038         */ s_cbranch_execz .L1088_3
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e0a0300         */ v_mov_b32       v5, v0
.L876_3:
/*be94047e         */ s_mov_b64       s[20:21], exec
/*be96047e         */ s_mov_b64       s[22:23], exec
/*7e060305         */ v_mov_b32       v3, v5
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L896_3:
/*340c0681         */ v_lshlrev_b32   v6, 1, v3
/*4a0c0cff 000050c0*/ v_add_i32       v6, vcc, 0x50c0, v6
/*b00402ab         */ s_movk_i32      s4, 0x2ab
/*d8f00000 06000006*/ ds_read_u16     v6, v6
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900003 02410106*/ v_bfe_u32       v3, v6, 0, 16
/*7d820604         */ v_cmp_lt_u32    vcc, s4, v3
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf840018         */ s_cbranch_scc0  .L1044_3
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*7e0c0280         */ v_mov_b32       v6, 0
/*7e1002c1         */ v_mov_b32       v8, -1
/*d88c4cb0 06000806*/ ds_inc_rtn_u32  v6, v6, v8 offset:19632
/*b0040318         */ s_movk_i32      s4, 0x318
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*7d820c04         */ v_cmp_lt_u32    vcc, s4, v6
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf84000d         */ s_cbranch_scc0  .L1044_3
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*340c0c81         */ v_lshlrev_b32   v6, 1, v6
/*4a100cff 00004030*/ v_add_i32       v8, vcc, 0x4030, v6
/*d2900009 02410105*/ v_bfe_u32       v9, v5, 0, 16
/*d87c0000 00000908*/ ds_write_b16    v8, v9
/*4a0c0cff 00004670*/ v_add_i32       v6, vcc, 0x4670, v6
/*d87c0000 00000306*/ ds_write_b16    v6, v3
/*bf82ffdb         */ s_branch        .L896_3
.L1044_3:
/*befe0414         */ s_mov_b64       exec, s[20:21]
/*4a0a0aff 00000100*/ v_add_i32       v5, vcc, 0x100, v5
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*7d880a04         */ v_cmp_gt_u32    vcc, s4, v5
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L1088_3
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82ffcb         */ s_branch        .L876_3
.L1088_3:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8d84cb0 05000005*/ ds_read_b32     v5, v5 offset:19632
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*260a0aff 00000319*/ v_min_u32       v5, 0x319, v5
/*7e0c0280         */ v_mov_b32       v6, 0
/*7d0a0d05         */ v_cmp_lg_i32    vcc, v5, v6
/*bf8600cc         */ s_cbranch_vccz  .L1952_3
/*360c0081         */ v_and_b32       v6, 1, v0
/*340e0c84         */ v_lshlrev_b32   v7, 4, v6
/*38100ea0         */ v_or_b32        v8, 32, v7
/*2c120081         */ v_lshrrev_b32   v9, 1, v0
/*360000c2         */ v_and_b32       v0, -2, v0
/*8f009400         */ s_lshl_b32      s0, s0, 20
/*7e146f09         */ v_not_b32       v10, v9
/*c0840370         */ s_load_dwordx4  s[8:11], s[2:3], 0x70
/*c08a0368         */ s_load_dwordx4  s[20:23], s[2:3], 0x68
/*7e040505         */ v_readfirstlane_b32 s2, v5
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L1184_3:
/*7d881202         */ v_cmp_gt_u32    vcc, s2, v9
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a021402         */ v_add_i32       v1, vcc, s2, v10
/*bf880012         */ s_cbranch_execz .L1272_3
/*34020281         */ v_lshlrev_b32   v1, 1, v1
/*4a0402ff 00004670*/ v_add_i32       v2, vcc, 0x4670, v1
/*4a0202ff 00004030*/ v_add_i32       v1, vcc, 0x4030, v1
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*d8f00000 01000001*/ ds_read_u16     v1, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*363004ff 0000ffff*/ v_and_b32       v24, 0xffff, v2
/*360202ff 0000ffff*/ v_and_b32       v1, 0xffff, v1
/*34063082         */ v_lshlrev_b32   v3, 2, v24
/*340a0282         */ v_lshlrev_b32   v5, 2, v1
/*4a040690         */ v_add_i32       v2, vcc, 16, v3
/*4a2e0a90         */ v_add_i32       v23, vcc, 16, v5
.L1272_3:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e0202ff 000002ac*/ v_mov_b32       v1, 0x2ac
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040c80         */ v_cmp_eq_i32    vcc, 0, v6
/*87fe6a0e         */ s_and_b64       exec, s[14:15], vcc
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*7e1602ff 000002ac*/ v_mov_b32       v11, 0x2ac
/*bf880002         */ s_cbranch_execz .L1320_3
/*d87c5620 00000b00*/ ds_write_b16    v0, v11 offset:22048
.L1320_3:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*7d880203         */ v_cmp_gt_u32    vcc, s3, v1
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a082eff 00000ab0*/ v_add_i32       v4, vcc, 0xab0, v23
/*bf880067         */ s_cbranch_execz .L1760_3
/*bf800000         */ s_nop           0x0
/*4a1604ff 00000ab0*/ v_add_i32       v11, vcc, 0xab0, v2
/*4a1804ff 00001560*/ v_add_i32       v12, vcc, 0x1560, v2
/*4a1a2eff 00001560*/ v_add_i32       v13, vcc, 0x1560, v23
/*d8d80000 04000004*/ ds_read_b32     v4, v4
/*d8d80000 0b00000b*/ ds_read_b32     v11, v11
/*d8d80000 0e000002*/ ds_read_b32     v14, v2
/*d8d80000 0f000017*/ ds_read_b32     v15, v23
/*4a2004ff 00002010*/ v_add_i32       v16, vcc, 0x2010, v2
/*4a222eff 00002010*/ v_add_i32       v17, vcc, 0x2010, v23
/*d8d80000 0c00000c*/ ds_read_b32     v12, v12
/*d8d80000 0d00000d*/ ds_read_b32     v13, v13
/*4a2404ff 00002ac0*/ v_add_i32       v18, vcc, 0x2ac0, v2
/*4a262eff 00002ac0*/ v_add_i32       v19, vcc, 0x2ac0, v23
/*d8d80000 10000010*/ ds_read_b32     v16, v16
/*d8d80000 11000011*/ ds_read_b32     v17, v17
/*4a2804ff 00003570*/ v_add_i32       v20, vcc, 0x3570, v2
/*4a2a2eff 00003570*/ v_add_i32       v21, vcc, 0x3570, v23
/*d8d80000 12000012*/ ds_read_b32     v18, v18
/*d8d80000 13000013*/ ds_read_b32     v19, v19
/*d8d80000 14000014*/ ds_read_b32     v20, v20
/*d8d80000 15000015*/ ds_read_b32     v21, v21
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*3a2c1704         */ v_xor_b32       v22, v4, v11
/*3a1c1f0e         */ v_xor_b32       v14, v14, v15
/*3a181b0c         */ v_xor_b32       v12, v12, v13
/*d29c000d 02621d16*/ v_alignbit_b32  v13, v22, v14, 24
/*3a1c2310         */ v_xor_b32       v14, v16, v17
/*341e308a         */ v_lshlrev_b32   v15, 10, v24
/*d1040018 0001010d*/ v_cmp_eq_i32    s[24:25], v13, 0
/*7d041704         */ v_cmp_eq_i32    vcc, v4, v11
/*3a082712         */ v_xor_b32       v4, v18, v19
/*36161eff 000ffc00*/ v_and_b32       v11, 0xffc00, v15
/*7e440316         */ v_mov_b32       v34, v22
/*3a1e2b14         */ v_xor_b32       v15, v20, v21
/*38161600         */ v_or_b32        v11, s0, v11
/*360a02ff 000003ff*/ v_and_b32       v5, 0x3ff, v1
/*7e46030c         */ v_mov_b32       v35, v12
/*380a0b0b         */ v_or_b32        v5, v11, v5
/*7e48030e         */ v_mov_b32       v36, v14
/*87ea6a18         */ s_and_b64       vcc, s[24:25], vcc
/*7e4a0304         */ v_mov_b32       v37, v4
/*d2000004 01a98280*/ v_cndmask_b32   v4, 0, -1, vcc
/*7e4c030f         */ v_mov_b32       v38, v15
/*38080906         */ v_or_b32        v4, v6, v4
/*7e4e0305         */ v_mov_b32       v39, v5
/*36201aff 00000fff*/ v_and_b32       v16, 0xfff, v13
/*d2920004 02050104*/ v_bfe_i32       v4, v4, 0, 1
/*7d840880         */ v_cmp_eq_u32    vcc, 0, v4
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*34081a84         */ v_lshlrev_b32   v4, 4, v13
/*bf880017         */ s_cbranch_execz .L1760_3
/*2c162081         */ v_lshrrev_b32   v11, 1, v16
/*36080890         */ v_and_b32       v4, 16, v4
/*34181682         */ v_lshlrev_b32   v12, 2, v11
/*321a0881         */ v_lshl_b32      v13, 1, v4
/*4a181806         */ v_add_i32       v12, vcc, s6, v12
/*38161601         */ v_or_b32        v11, s1, v11
/*34161682         */ v_lshlrev_b32   v11, 2, v11

/*d8800000 0b000d0b*/ ds_add_rtn_u32  v11, v11, v13 gds

/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a16090b         */ v_lshr_b32      v11, v11, v4
/*d290000b 0241010b*/ v_bfe_u32       v11, v11, 0, 16
/*d87c5620 00000b00*/ ds_write_b16    v0, v11 offset:22048
.L1760_3:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*d8f05620 05000000*/ ds_read_u16     v5, v0 offset:22048
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*360a0aff 0000ffff*/ v_and_b32       v5, 0xffff, v5
/*b00302ab         */ s_movk_i32      s3, 0x2ab
/*7d8c0a03         */ v_cmp_ge_u32    vcc, s3, v5
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf88001c         */ s_cbranch_execz .L1920_3
/*2c321082         */ v_lshrrev_b32   v25, 2, v8
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*bf880010         */ s_cbranch_execz .L1884_3
/*be9b037c         */ s_mov_b32       s27, m0
/*be9c047e         */ s_mov_b64       s[28:29], exec
.L1828_3:
/*7e340519         */ v_readfirstlane_b32 s26, v25
/*befc031a         */ s_mov_b32       m0, s26
/*be9e047e         */ s_mov_b64       s[30:31], exec
/*d1240020 0002321a*/ v_cmpx_eq_i32   s[32:33], s26, v25
/*8a9e201e         */ s_andn2_b64     s[30:31], s[30:31], s[32:33]
/*7e16871a         */ v_movrels_b32   v11, v26
/*7e18871b         */ v_movrels_b32   v12, v27
/*7e1a871c         */ v_movrels_b32   v13, v28
/*7e1c871d         */ v_movrels_b32   v14, v29
/*befe041e         */ s_mov_b64       exec, s[30:31]
/*bf89fff4         */ s_cbranch_execnz .L1828_3
/*befe041c         */ s_mov_b64       exec, s[28:29]
/*befc031b         */ s_mov_b32       m0, s27
.L1884_3:
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*d2d6000f 00000710*/ v_mul_lo_i32    v15, v16, s3
/*4a0a1f05         */ v_add_i32       v5, vcc, v5, v15
/*340a0a85         */ v_lshlrev_b32   v5, 5, v5
/*4a0a0a05         */ v_add_i32       v5, vcc, s5, v5
/*4a0a0b07         */ v_add_i32       v5, vcc, v7, v5
/*ebf71000 80050b05*/ tbuffer_store_format_xyzw v[11:14], v5, s[20:23], 0 offen format:[32_32_32_32,float]
.L1920_3:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*8383ff02 00000080*/ s_min_u32       s3, s2, 0x80
/*80840302         */ s_sub_u32       s4, s2, s3
/*bf000302         */ s_cmp_eq_i32    s2, s3
/*bf850002         */ s_cbranch_scc1  .L1952_3
/*be820304         */ s_mov_b32       s2, s4
/*bf82ff40         */ s_branch        .L1184_3
.L1952_3:
/*bf810000         */ s_endpgm
.kernel kernel_round3
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 37 /*36*/
        .vgprsnum 42
        .hwlocal 19568
        .floatmode 0xc0
        .uavid 11
        .uavprivate 64
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x00268098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg ht_dst, "char*", char*, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
        .arg rowCountersDst, "uint*", uint*, global, , 14
        .arg debug, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c200051c         */ s_buffer_load_dword s0, s[4:7], 0x1c
/*7e020280         */ v_mov_b32       v1, 0
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*c2030910         */ s_buffer_load_dword s6, s[8:11], 0x10
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000000c         */ s_add_u32       s0, s12, s0
/*7e340280         */ v_mov_b32       v26, 0
/*bf0bff00 00000fff*/ s_cmp_le_u32    s0, 0xfff
/*bf8401d5         */ s_cbranch_scc0  .L1932_4
/*b00700ff         */ s_movk_i32      s7, 0xff
/*7d8c0007         */ v_cmp_ge_u32    vcc, s7, v0
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880015         */ s_cbranch_execz .L160_4
/*4a0202ff 00004210*/ v_add_i32       v1, vcc, 0x4210, v1
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e040300         */ v_mov_b32       v2, v0
.L96_4:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d8340000 00000301*/ ds_write_b32    v1, v3
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b0070100         */ s_movk_i32      s7, 0x100
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L160_4
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82fff0         */ s_branch        .L96_4
.L160_4:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*8f018c01         */ s_lshl_b32      s1, s1, 12
/*b00702ab         */ s_movk_i32      s7, 0x2ab
/*d1880008 00000f00*/ v_cmp_gt_u32    s[8:9], v0, s7
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*8afe080a         */ s_andn2_b64     exec, s[10:11], s[8:9]
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880031         */ s_cbranch_execz .L392_4
/*4a0202ff 00004610*/ v_add_i32       v1, vcc, 0x4610, v1
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*be94047e         */ s_mov_b64       s[20:21], exec
/*7e040300         */ v_mov_b32       v2, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L224_4:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d87c0000 00000301*/ ds_write_b16    v1, v3
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00702ac         */ s_movk_i32      s7, 0x2ac
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be96047e         */ s_mov_b64       s[22:23], exec
/*8afe6a16         */ s_andn2_b64     exec, s[22:23], vcc
/*8a947e14         */ s_andn2_b64     s[20:21], s[20:21], exec
/*bf840002         */ s_cbranch_scc0  .L288_4
/*87fe1416         */ s_and_b64       exec, s[22:23], s[20:21]
/*bf82fff0         */ s_branch        .L224_4
.L288_4:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040080         */ v_cmp_eq_i32    vcc, 0, v0
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf880012         */ s_cbranch_execz .L376_4
/*90078100         */ s_lshr_b32      s7, s0, 1
/*80070701         */ s_add_u32       s7, s1, s7
/*8f078207         */ s_lshl_b32      s7, s7, 2
/*7e020207         */ v_mov_b32       v1, s7

/*d8d80000 01000001*/ ds_read_b32     v1, v1 gds

/*8f078400         */ s_lshl_b32      s7, s0, 4
/*87079007         */ s_and_b32       s7, s7, 16
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c020207         */ v_lshrrev_b32   v1, s7, v1
/*d2900001 02410101*/ v_bfe_u32       v1, v1, 0, 16
/*260802ff 000002ac*/ v_min_u32       v4, 0x2ac, v1
/*7e040280         */ v_mov_b32       v2, 0
/*d8344200 00000402*/ ds_write_b32    v2, v4 offset:16896
/*7e020281         */ v_mov_b32       v1, 1
.L376_4:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040e         */ s_mov_b64       exec, s[14:15]
.L392_4:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e060280         */ v_mov_b32       v3, 0
/*d8d84200 03000003*/ ds_read_b32     v3, v3 offset:16896
/*d2920001 02050101*/ v_bfe_i32       v1, v1, 0, 1
/*7d0a0280         */ v_cmp_lg_i32    vcc, 0, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*00040903         */ v_cndmask_b32   v2, v3, v4, vcc
/*bf8a0000         */ s_barrier
/*7d8a0280         */ v_cmp_lg_u32    vcc, 0, v1
/*be8a246a         */ s_and_saveexec_b64 s[10:11], vcc
/*7e020280         */ v_mov_b32       v1, 0
/*bf880002         */ s_cbranch_execz .L476_4
/*d8344200 00000101*/ ds_write_b32    v1, v1 offset:16896
.L476_4:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7d820500         */ v_cmp_lt_u32    vcc, v0, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880045         */ s_cbranch_execz .L780_4
/*4a0202ff 00004610*/ v_add_i32       v1, vcc, 0x4610, v1
/*9307ff00 000002ac*/ s_mul_i32       s7, s0, 0x2ac
/*4a060007         */ v_add_i32       v3, vcc, s7, v0
/*34060685         */ v_lshlrev_b32   v3, 5, v3
/*4a060604         */ v_add_i32       v3, vcc, s4, v3
/*34080082         */ v_lshlrev_b32   v4, 2, v0
/*4a0808ff 00002ad0*/ v_add_i32       v4, vcc, 0x2ad0, v4
/*c08a0360         */ s_load_dwordx4  s[20:23], s[2:3], 0x60
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e2e0300         */ v_mov_b32       v23, v0
.L556_4:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebf31000 80050e03*/ tbuffer_load_format_xyzw v[14:17], v3, s[20:23], 0 offen format:[32_32_32_32,float]
/*eba01010 80050a03*/ tbuffer_load_format_x v10, v3, s[20:23], 0 offen offset:16 format:[32,float]
/*4a1608ff ffffd540*/ v_add_i32       v11, vcc, 0xffffd540, v4
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 00000e0b*/ ds_write_b32    v11, v14
/*4a1608ff ffffdff0*/ v_add_i32       v11, vcc, 0xffffdff0, v4
/*d8340000 00000f0b*/ ds_write_b32    v11, v15
/*4a0e08ff ffffeaa0*/ v_add_i32       v7, vcc, 0xffffeaa0, v4
/*36161cff 000000f0*/ v_and_b32       v11, 0xf0, v14
/*d2900006 0211190e*/ v_bfe_u32       v6, v14, 12, 4
/*d8340000 00001007*/ ds_write_b32    v7, v16
/*4a0e08ff fffff550*/ v_add_i32       v7, vcc, 0xfffff550, v4
/*380c0d0b         */ v_or_b32        v6, v11, v6
/*d8340000 00001107*/ ds_write_b32    v7, v17
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000a04*/ ds_write_b32    v4, v10
/*4a0c0cff 00004210*/ v_add_i32       v6, vcc, 0x4210, v6
/*d8b40000 06001706*/ ds_wrxchg_rtn_b32 v6, v6, v23
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900006 02410106*/ v_bfe_u32       v6, v6, 0, 16
/*4a2e2eff 00000100*/ v_add_i32       v23, vcc, 0x100, v23
/*d87c0000 00000601*/ ds_write_b16    v1, v6
/*4a0606ff 00002000*/ v_add_i32       v3, vcc, 0x2000, v3
/*4a0808ff 00000400*/ v_add_i32       v4, vcc, 0x400, v4
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*7d882f02         */ v_cmp_gt_u32    vcc, v2, v23
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffcd         */ s_cbranch_execnz .L556_4
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7e3002ff 00000200*/ v_mov_b32       v24, 0x200
/*7e0402ff 00000100*/ v_mov_b32       v2, 0x100
.L780_4:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf880004         */ s_cbranch_execz .L804_4
/*7e300301         */ v_mov_b32       v24, v1
/*7e040301         */ v_mov_b32       v2, v1
/*7e2e0301         */ v_mov_b32       v23, v1
/*7e200301         */ v_mov_b32       v16, v1
.L804_4:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe080a         */ s_and_b64       exec, s[10:11], s[8:9]
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf88003a         */ s_cbranch_execz .L1056_4
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e0a0300         */ v_mov_b32       v5, v0
.L836_4:
/*be94047e         */ s_mov_b64       s[20:21], exec
/*be96047e         */ s_mov_b64       s[22:23], exec
/*7e060305         */ v_mov_b32       v3, v5
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L864_4:
/*340c0681         */ v_lshlrev_b32   v6, 1, v3
/*4a0c0cff 00004610*/ v_add_i32       v6, vcc, 0x4610, v6
/*b00402ab         */ s_movk_i32      s4, 0x2ab
/*d8f00000 06000006*/ ds_read_u16     v6, v6
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900003 02410106*/ v_bfe_u32       v3, v6, 0, 16
/*7d820604         */ v_cmp_lt_u32    vcc, s4, v3
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf840018         */ s_cbranch_scc0  .L1012_4
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*7e0c0280         */ v_mov_b32       v6, 0
/*7e1002c1         */ v_mov_b32       v8, -1
/*d88c4200 06000806*/ ds_inc_rtn_u32  v6, v6, v8 offset:16896
/*b0040318         */ s_movk_i32      s4, 0x318
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*7d820c04         */ v_cmp_lt_u32    vcc, s4, v6
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf84000d         */ s_cbranch_scc0  .L1012_4
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*340c0c81         */ v_lshlrev_b32   v6, 1, v6
/*4a100cff 00003580*/ v_add_i32       v8, vcc, 0x3580, v6
/*d2900009 02410105*/ v_bfe_u32       v9, v5, 0, 16
/*d87c0000 00000908*/ ds_write_b16    v8, v9
/*4a0c0cff 00003bc0*/ v_add_i32       v6, vcc, 0x3bc0, v6
/*d87c0000 00000306*/ ds_write_b16    v6, v3
/*bf82ffdb         */ s_branch        .L864_4
.L1012_4:
/*befe0414         */ s_mov_b64       exec, s[20:21]
/*4a0a0aff 00000100*/ v_add_i32       v5, vcc, 0x100, v5
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*7d880a04         */ v_cmp_gt_u32    vcc, s4, v5
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L1056_4
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82ffc9         */ s_branch        .L836_4
.L1056_4:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8d84200 05000005*/ ds_read_b32     v5, v5 offset:16896
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*260a0aff 00000319*/ v_min_u32       v5, 0x319, v5
/*7e0c0280         */ v_mov_b32       v6, 0
/*7d0a0d05         */ v_cmp_lg_i32    vcc, v5, v6
/*bf8600cf         */ s_cbranch_vccz  .L1932_4
/*8001ff01 00000800*/ s_add_u32       s1, s1, 0x800
/*360c0081         */ v_and_b32       v6, 1, v0
/*340e0c84         */ v_lshlrev_b32   v7, 4, v6
/*38100ea0         */ v_or_b32        v8, 32, v7
/*2c120081         */ v_lshrrev_b32   v9, 1, v0
/*360000c2         */ v_and_b32       v0, -2, v0
/*8f009400         */ s_lshl_b32      s0, s0, 20
/*7e146f09         */ v_not_b32       v10, v9
/*c0840370         */ s_load_dwordx4  s[8:11], s[2:3], 0x70
/*c08a0368         */ s_load_dwordx4  s[20:23], s[2:3], 0x68
/*7e040505         */ v_readfirstlane_b32 s2, v5
.L1152_4:
/*7d881202         */ v_cmp_gt_u32    vcc, s2, v9
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a021402         */ v_add_i32       v1, vcc, s2, v10
/*bf880012         */ s_cbranch_execz .L1240_4
/*34020281         */ v_lshlrev_b32   v1, 1, v1
/*4a0402ff 00003bc0*/ v_add_i32       v2, vcc, 0x3bc0, v1
/*4a0202ff 00003580*/ v_add_i32       v1, vcc, 0x3580, v1
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*d8f00000 01000001*/ ds_read_u16     v1, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*363004ff 0000ffff*/ v_and_b32       v24, 0xffff, v2
/*360202ff 0000ffff*/ v_and_b32       v1, 0xffff, v1
/*34063082         */ v_lshlrev_b32   v3, 2, v24
/*340a0282         */ v_lshlrev_b32   v5, 2, v1
/*4a040690         */ v_add_i32       v2, vcc, 16, v3
/*4a2e0a90         */ v_add_i32       v23, vcc, 16, v5
.L1240_4:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e0202ff 000002ac*/ v_mov_b32       v1, 0x2ac
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040c80         */ v_cmp_eq_i32    vcc, 0, v6
/*87fe6a0e         */ s_and_b64       exec, s[14:15], vcc
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*7e1602ff 000002ac*/ v_mov_b32       v11, 0x2ac
/*bf880002         */ s_cbranch_execz .L1288_4
/*d87c4b70 00000b00*/ ds_write_b16    v0, v11 offset:19312
.L1288_4:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*7d880203         */ v_cmp_gt_u32    vcc, s3, v1
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a082eff 00000ab0*/ v_add_i32       v4, vcc, 0xab0, v23
/*bf88006a         */ s_cbranch_execz .L1740_4
/*bf800000         */ s_nop           0x0
/*4a1604ff 00000ab0*/ v_add_i32       v11, vcc, 0xab0, v2
/*4a1804ff 00001560*/ v_add_i32       v12, vcc, 0x1560, v2
/*4a1a2eff 00001560*/ v_add_i32       v13, vcc, 0x1560, v23
/*d8d80000 0e000017*/ ds_read_b32     v14, v23
/*d8d80000 0f000002*/ ds_read_b32     v15, v2
/*d8d80000 04000004*/ ds_read_b32     v4, v4
/*d8d80000 0b00000b*/ ds_read_b32     v11, v11
/*4a2004ff 00002010*/ v_add_i32       v16, vcc, 0x2010, v2
/*4a222eff 00002010*/ v_add_i32       v17, vcc, 0x2010, v23
/*d8d80000 0c00000c*/ ds_read_b32     v12, v12
/*d8d80000 0d00000d*/ ds_read_b32     v13, v13
/*4a2404ff 00002ac0*/ v_add_i32       v18, vcc, 0x2ac0, v2
/*4a262eff 00002ac0*/ v_add_i32       v19, vcc, 0x2ac0, v23
/*d8d80000 10000010*/ ds_read_b32     v16, v16
/*d8d80000 11000011*/ ds_read_b32     v17, v17
/*d8d80000 12000012*/ ds_read_b32     v18, v18
/*d8d80000 13000013*/ ds_read_b32     v19, v19
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*3a281f0e         */ v_xor_b32       v20, v14, v15
/*3a2a1704         */ v_xor_b32       v21, v4, v11
/*d29c0016 02222915*/ v_alignbit_b32  v22, v21, v20, 8
/*3a181b0c         */ v_xor_b32       v12, v12, v13
/*d29c000d 02222b0c*/ v_alignbit_b32  v13, v12, v21, 8
/*3a202310         */ v_xor_b32       v16, v16, v17
/*d29c000c 02221910*/ v_alignbit_b32  v12, v16, v12, 8
/*3a222712         */ v_xor_b32       v17, v18, v19
/*3424308a         */ v_lshlrev_b32   v18, 10, v24
/*d1040018 00021f0e*/ v_cmp_eq_i32    s[24:25], v14, v15
/*7d041704         */ v_cmp_eq_i32    vcc, v4, v11
/*d29c0004 02222111*/ v_alignbit_b32  v4, v17, v16, 8
/*361624ff 000ffc00*/ v_and_b32       v11, 0xffc00, v18
/*7e440316         */ v_mov_b32       v34, v22
/*2c1c2288         */ v_lshrrev_b32   v14, 8, v17
/*38161600         */ v_or_b32        v11, s0, v11
/*360a02ff 000003ff*/ v_and_b32       v5, 0x3ff, v1
/*7e46030d         */ v_mov_b32       v35, v13
/*380a0b0b         */ v_or_b32        v5, v11, v5
/*7e48030c         */ v_mov_b32       v36, v12
/*87ea6a18         */ s_and_b64       vcc, s[24:25], vcc
/*7e4a0304         */ v_mov_b32       v37, v4
/*2c082898         */ v_lshrrev_b32   v4, 24, v20
/*d200000b 01a98280*/ v_cndmask_b32   v11, 0, -1, vcc
/*7e4c030e         */ v_mov_b32       v38, v14
/*2c182888         */ v_lshrrev_b32   v12, 8, v20
/*360808ff 000000f0*/ v_and_b32       v4, 0xf0, v4
/*b0030f0f         */ s_movk_i32      s3, 0xf0f
/*38161706         */ v_or_b32        v11, v6, v11
/*7e4e0305         */ v_mov_b32       v39, v5
/*d2940010 04121803*/ v_bfi_b32       v16, s3, v12, v4
/*d2920005 0205010b*/ v_bfe_i32       v5, v11, 0, 1
/*7d840a80         */ v_cmp_eq_u32    vcc, 0, v5
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*2c0a2884         */ v_lshrrev_b32   v5, 4, v20
/*bf880017         */ s_cbranch_execz .L1740_4
/*2c162081         */ v_lshrrev_b32   v11, 1, v16
/*360a0a90         */ v_and_b32       v5, 16, v5
/*34181682         */ v_lshlrev_b32   v12, 2, v11
/*321a0a81         */ v_lshl_b32      v13, 1, v5
/*4a181806         */ v_add_i32       v12, vcc, s6, v12
/*38161601         */ v_or_b32        v11, s1, v11
/*34161682         */ v_lshlrev_b32   v11, 2, v11

/*d8800000 0b000d0b*/ ds_add_rtn_u32  v11, v11, v13 gds

/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a160b0b         */ v_lshr_b32      v11, v11, v5
/*d290000b 0241010b*/ v_bfe_u32       v11, v11, 0, 16
/*d87c4b70 00000b00*/ ds_write_b16    v0, v11 offset:19312
.L1740_4:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*d8f04b70 05000000*/ ds_read_u16     v5, v0 offset:19312
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*360a0aff 0000ffff*/ v_and_b32       v5, 0xffff, v5
/*b00302ab         */ s_movk_i32      s3, 0x2ab
/*7d8c0a03         */ v_cmp_ge_u32    vcc, s3, v5
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf88001c         */ s_cbranch_execz .L1900_4
/*2c321082         */ v_lshrrev_b32   v25, 2, v8
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*bf880010         */ s_cbranch_execz .L1864_4
/*be9b037c         */ s_mov_b32       s27, m0
/*be9c047e         */ s_mov_b64       s[28:29], exec
.L1808_4:
/*7e340519         */ v_readfirstlane_b32 s26, v25
/*befc031a         */ s_mov_b32       m0, s26
/*be9e047e         */ s_mov_b64       s[30:31], exec
/*d1240020 0002321a*/ v_cmpx_eq_i32   s[32:33], s26, v25
/*8a9e201e         */ s_andn2_b64     s[30:31], s[30:31], s[32:33]
/*7e16871a         */ v_movrels_b32   v11, v26
/*7e18871b         */ v_movrels_b32   v12, v27
/*7e1a871c         */ v_movrels_b32   v13, v28
/*7e1c871d         */ v_movrels_b32   v14, v29
/*befe041e         */ s_mov_b64       exec, s[30:31]
/*bf89fff4         */ s_cbranch_execnz .L1808_4
/*befe041c         */ s_mov_b64       exec, s[28:29]
/*befc031b         */ s_mov_b32       m0, s27
.L1864_4:
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*d2d6000f 00000710*/ v_mul_lo_i32    v15, v16, s3
/*4a0a1f05         */ v_add_i32       v5, vcc, v5, v15
/*340a0a85         */ v_lshlrev_b32   v5, 5, v5
/*4a0a0a05         */ v_add_i32       v5, vcc, s5, v5
/*4a0a0b07         */ v_add_i32       v5, vcc, v7, v5
/*ebf71000 80050b05*/ tbuffer_store_format_xyzw v[11:14], v5, s[20:23], 0 offen format:[32_32_32_32,float]
.L1900_4:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*8383ff02 00000080*/ s_min_u32       s3, s2, 0x80
/*80840302         */ s_sub_u32       s4, s2, s3
/*bf000302         */ s_cmp_eq_i32    s2, s3
/*bf850002         */ s_cbranch_scc1  .L1932_4
/*be820304         */ s_mov_b32       s2, s4
/*bf82ff3d         */ s_branch        .L1152_4
.L1932_4:
/*bf810000         */ s_endpgm
.kernel kernel_round4
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 37 /*36*/
        .vgprsnum 40
        .hwlocal 19568
        .floatmode 0xc0
        .uavid 11
        .uavprivate 64
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x00268098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg ht_dst, "char*", char*, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
        .arg rowCountersDst, "uint*", uint*, global, , 14
        .arg debug, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c200051c         */ s_buffer_load_dword s0, s[4:7], 0x1c
/*7e020280         */ v_mov_b32       v1, 0
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*c2030910         */ s_buffer_load_dword s6, s[8:11], 0x10
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000000c         */ s_add_u32       s0, s12, s0
/*7e300280         */ v_mov_b32       v24, 0
/*bf0bff00 00000fff*/ s_cmp_le_u32    s0, 0xfff
/*bf8401d0         */ s_cbranch_scc0  .L1912_5
/*b00700ff         */ s_movk_i32      s7, 0xff
/*7d8c0007         */ v_cmp_ge_u32    vcc, s7, v0
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880015         */ s_cbranch_execz .L160_5
/*4a0202ff 00004210*/ v_add_i32       v1, vcc, 0x4210, v1
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e040300         */ v_mov_b32       v2, v0
.L96_5:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d8340000 00000301*/ ds_write_b32    v1, v3
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b0070100         */ s_movk_i32      s7, 0x100
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L160_5
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82fff0         */ s_branch        .L96_5
.L160_5:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*8f018c01         */ s_lshl_b32      s1, s1, 12
/*b00702ab         */ s_movk_i32      s7, 0x2ab
/*d1880008 00000f00*/ v_cmp_gt_u32    s[8:9], v0, s7
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*8afe080a         */ s_andn2_b64     exec, s[10:11], s[8:9]
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880033         */ s_cbranch_execz .L400_5
/*4a0202ff 00004610*/ v_add_i32       v1, vcc, 0x4610, v1
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*be94047e         */ s_mov_b64       s[20:21], exec
/*7e040300         */ v_mov_b32       v2, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L224_5:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d87c0000 00000301*/ ds_write_b16    v1, v3
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00702ac         */ s_movk_i32      s7, 0x2ac
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be96047e         */ s_mov_b64       s[22:23], exec
/*8afe6a16         */ s_andn2_b64     exec, s[22:23], vcc
/*8a947e14         */ s_andn2_b64     s[20:21], s[20:21], exec
/*bf840002         */ s_cbranch_scc0  .L288_5
/*87fe1416         */ s_and_b64       exec, s[22:23], s[20:21]
/*bf82fff0         */ s_branch        .L224_5
.L288_5:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040080         */ v_cmp_eq_i32    vcc, 0, v0
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf880014         */ s_cbranch_execz .L384_5
/*90078100         */ s_lshr_b32      s7, s0, 1
/*80070701         */ s_add_u32       s7, s1, s7
/*8f078207         */ s_lshl_b32      s7, s7, 2
/*7e020207         */ v_mov_b32       v1, s7
/*4a0202ff 00002000*/ v_add_i32       v1, vcc, 0x2000, v1

/*d8d80000 01000001*/ ds_read_b32     v1, v1 gds

/*8f078400         */ s_lshl_b32      s7, s0, 4
/*87079007         */ s_and_b32       s7, s7, 16
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c020207         */ v_lshrrev_b32   v1, s7, v1
/*d2900001 02410101*/ v_bfe_u32       v1, v1, 0, 16
/*260802ff 000002ac*/ v_min_u32       v4, 0x2ac, v1
/*7e040280         */ v_mov_b32       v2, 0
/*d8344200 00000402*/ ds_write_b32    v2, v4 offset:16896
/*7e020281         */ v_mov_b32       v1, 1
.L384_5:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040e         */ s_mov_b64       exec, s[14:15]
.L400_5:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e060280         */ v_mov_b32       v3, 0
/*d8d84200 03000003*/ ds_read_b32     v3, v3 offset:16896
/*d2920001 02050101*/ v_bfe_i32       v1, v1, 0, 1
/*7d0a0280         */ v_cmp_lg_i32    vcc, 0, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*00040903         */ v_cndmask_b32   v2, v3, v4, vcc
/*bf8a0000         */ s_barrier
/*7d8a0280         */ v_cmp_lg_u32    vcc, 0, v1
/*be8a246a         */ s_and_saveexec_b64 s[10:11], vcc
/*7e020280         */ v_mov_b32       v1, 0
/*bf880002         */ s_cbranch_execz .L484_5
/*d8344200 00000101*/ ds_write_b32    v1, v1 offset:16896
.L484_5:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7d820500         */ v_cmp_lt_u32    vcc, v0, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880049         */ s_cbranch_execz .L804_5
/*4a0202ff 00004610*/ v_add_i32       v1, vcc, 0x4610, v1
/*9307ff00 000002ac*/ s_mul_i32       s7, s0, 0x2ac
/*4a060007         */ v_add_i32       v3, vcc, s7, v0
/*34060685         */ v_lshlrev_b32   v3, 5, v3
/*4a060604         */ v_add_i32       v3, vcc, s4, v3
/*34080082         */ v_lshlrev_b32   v4, 2, v0
/*4a0808ff 00002ad0*/ v_add_i32       v4, vcc, 0x2ad0, v4
/*c08a0360         */ s_load_dwordx4  s[20:23], s[2:3], 0x60
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e2a0300         */ v_mov_b32       v21, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L576_5:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebf31000 80050d03*/ tbuffer_load_format_xyzw v[13:16], v3, s[20:23], 0 offen format:[32_32_32_32,float]
/*eba01010 80050a03*/ tbuffer_load_format_x v10, v3, s[20:23], 0 offen offset:16 format:[32,float]
/*4a1608ff ffffd540*/ v_add_i32       v11, vcc, 0xffffd540, v4
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 00000d0b*/ ds_write_b32    v11, v13
/*4a1608ff ffffdff0*/ v_add_i32       v11, vcc, 0xffffdff0, v4
/*2c181a88         */ v_lshrrev_b32   v12, 8, v13
/*d8340000 00000e0b*/ ds_write_b32    v11, v14
/*4a0e08ff ffffeaa0*/ v_add_i32       v7, vcc, 0xffffeaa0, v4
/*d2900006 0211210d*/ v_bfe_u32       v6, v13, 16, 4
/*361618ff 000000f0*/ v_and_b32       v11, 0xf0, v12
/*d8340000 00000f07*/ ds_write_b32    v7, v15
/*4a0e08ff fffff550*/ v_add_i32       v7, vcc, 0xfffff550, v4
/*380c1706         */ v_or_b32        v6, v6, v11
/*d8340000 00001007*/ ds_write_b32    v7, v16
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000a04*/ ds_write_b32    v4, v10
/*4a0c0cff 00004210*/ v_add_i32       v6, vcc, 0x4210, v6
/*d8b40000 06001506*/ ds_wrxchg_rtn_b32 v6, v6, v21
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900006 02410106*/ v_bfe_u32       v6, v6, 0, 16
/*4a2a2aff 00000100*/ v_add_i32       v21, vcc, 0x100, v21
/*d87c0000 00000601*/ ds_write_b16    v1, v6
/*4a0606ff 00002000*/ v_add_i32       v3, vcc, 0x2000, v3
/*4a0808ff 00000400*/ v_add_i32       v4, vcc, 0x400, v4
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*7d882b02         */ v_cmp_gt_u32    vcc, v2, v21
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffcc         */ s_cbranch_execnz .L576_5
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7e2c02ff 00000200*/ v_mov_b32       v22, 0x200
/*7e0402ff 00000100*/ v_mov_b32       v2, 0x100
.L804_5:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf880004         */ s_cbranch_execz .L828_5
/*7e2c0301         */ v_mov_b32       v22, v1
/*7e040301         */ v_mov_b32       v2, v1
/*7e2a0301         */ v_mov_b32       v21, v1
/*7e200301         */ v_mov_b32       v16, v1
.L828_5:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe080a         */ s_and_b64       exec, s[10:11], s[8:9]
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf88003c         */ s_cbranch_execz .L1088_5
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e0a0300         */ v_mov_b32       v5, v0
.L860_5:
/*be94047e         */ s_mov_b64       s[20:21], exec
/*be96047e         */ s_mov_b64       s[22:23], exec
/*7e060305         */ v_mov_b32       v3, v5
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L896_5:
/*340c0681         */ v_lshlrev_b32   v6, 1, v3
/*4a0c0cff 00004610*/ v_add_i32       v6, vcc, 0x4610, v6
/*b00402ab         */ s_movk_i32      s4, 0x2ab
/*d8f00000 06000006*/ ds_read_u16     v6, v6
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900003 02410106*/ v_bfe_u32       v3, v6, 0, 16
/*7d820604         */ v_cmp_lt_u32    vcc, s4, v3
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf840018         */ s_cbranch_scc0  .L1044_5
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*7e0c0280         */ v_mov_b32       v6, 0
/*7e1002c1         */ v_mov_b32       v8, -1
/*d88c4200 06000806*/ ds_inc_rtn_u32  v6, v6, v8 offset:16896
/*b0040318         */ s_movk_i32      s4, 0x318
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*7d820c04         */ v_cmp_lt_u32    vcc, s4, v6
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf84000d         */ s_cbranch_scc0  .L1044_5
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*340c0c81         */ v_lshlrev_b32   v6, 1, v6
/*4a100cff 00003580*/ v_add_i32       v8, vcc, 0x3580, v6
/*d2900009 02410105*/ v_bfe_u32       v9, v5, 0, 16
/*d87c0000 00000908*/ ds_write_b16    v8, v9
/*4a0c0cff 00003bc0*/ v_add_i32       v6, vcc, 0x3bc0, v6
/*d87c0000 00000306*/ ds_write_b16    v6, v3
/*bf82ffdb         */ s_branch        .L896_5
.L1044_5:
/*befe0414         */ s_mov_b64       exec, s[20:21]
/*4a0a0aff 00000100*/ v_add_i32       v5, vcc, 0x100, v5
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*7d880a04         */ v_cmp_gt_u32    vcc, s4, v5
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L1088_5
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82ffc7         */ s_branch        .L860_5
.L1088_5:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8d84200 05000005*/ ds_read_b32     v5, v5 offset:16896
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*260a0aff 00000319*/ v_min_u32       v5, 0x319, v5
/*7e0c0280         */ v_mov_b32       v6, 0
/*7d0a0d05         */ v_cmp_lg_i32    vcc, v5, v6
/*bf8600c2         */ s_cbranch_vccz  .L1912_5
/*360c0081         */ v_and_b32       v6, 1, v0
/*340e0c84         */ v_lshlrev_b32   v7, 4, v6
/*38100ea0         */ v_or_b32        v8, 32, v7
/*2c120081         */ v_lshrrev_b32   v9, 1, v0
/*360000c2         */ v_and_b32       v0, -2, v0
/*8f009400         */ s_lshl_b32      s0, s0, 20
/*7e146f09         */ v_not_b32       v10, v9
/*c0840370         */ s_load_dwordx4  s[8:11], s[2:3], 0x70
/*c08a0368         */ s_load_dwordx4  s[20:23], s[2:3], 0x68
/*7e040505         */ v_readfirstlane_b32 s2, v5
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L1184_5:
/*7d881202         */ v_cmp_gt_u32    vcc, s2, v9
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a021402         */ v_add_i32       v1, vcc, s2, v10
/*bf880012         */ s_cbranch_execz .L1272_5
/*34020281         */ v_lshlrev_b32   v1, 1, v1
/*4a0402ff 00003bc0*/ v_add_i32       v2, vcc, 0x3bc0, v1
/*4a0202ff 00003580*/ v_add_i32       v1, vcc, 0x3580, v1
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*d8f00000 01000001*/ ds_read_u16     v1, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*362c04ff 0000ffff*/ v_and_b32       v22, 0xffff, v2
/*360202ff 0000ffff*/ v_and_b32       v1, 0xffff, v1
/*34062c82         */ v_lshlrev_b32   v3, 2, v22
/*340a0282         */ v_lshlrev_b32   v5, 2, v1
/*4a040690         */ v_add_i32       v2, vcc, 16, v3
/*4a2a0a90         */ v_add_i32       v21, vcc, 16, v5
.L1272_5:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e0202ff 000002ac*/ v_mov_b32       v1, 0x2ac
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040c80         */ v_cmp_eq_i32    vcc, 0, v6
/*87fe6a0e         */ s_and_b64       exec, s[14:15], vcc
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*7e1602ff 000002ac*/ v_mov_b32       v11, 0x2ac
/*bf880002         */ s_cbranch_execz .L1320_5
/*d87c4b70 00000b00*/ ds_write_b16    v0, v11 offset:19312
.L1320_5:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*7d880203         */ v_cmp_gt_u32    vcc, s3, v1
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a082aff 00000ab0*/ v_add_i32       v4, vcc, 0xab0, v21
/*bf88005d         */ s_cbranch_execz .L1720_5
/*bf800000         */ s_nop           0x0
/*4a1604ff 00000ab0*/ v_add_i32       v11, vcc, 0xab0, v2
/*d8d80000 04000004*/ ds_read_b32     v4, v4
/*d8d80000 0b00000b*/ ds_read_b32     v11, v11
/*d8d80000 0c000002*/ ds_read_b32     v12, v2
/*d8d80000 0d000015*/ ds_read_b32     v13, v21
/*4a1c04ff 00001560*/ v_add_i32       v14, vcc, 0x1560, v2
/*4a1e2aff 00001560*/ v_add_i32       v15, vcc, 0x1560, v21
/*4a2004ff 00002010*/ v_add_i32       v16, vcc, 0x2010, v2
/*4a222aff 00002010*/ v_add_i32       v17, vcc, 0x2010, v21
/*d8d80000 0e00000e*/ ds_read_b32     v14, v14
/*d8d80000 0f00000f*/ ds_read_b32     v15, v15
/*4a2404ff 00002ac0*/ v_add_i32       v18, vcc, 0x2ac0, v2
/*4a262aff 00002ac0*/ v_add_i32       v19, vcc, 0x2ac0, v21
/*d8d80000 10000010*/ ds_read_b32     v16, v16
/*d8d80000 11000011*/ ds_read_b32     v17, v17
/*d8d80000 12000012*/ ds_read_b32     v18, v18
/*d8d80000 13000013*/ ds_read_b32     v19, v19
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*3a281704         */ v_xor_b32       v20, v4, v11
/*3a181b0c         */ v_xor_b32       v12, v12, v13
/*d29c000c 02621914*/ v_alignbit_b32  v12, v20, v12, 24
/*3a1a1f0e         */ v_xor_b32       v13, v14, v15
/*341c2c8a         */ v_lshlrev_b32   v14, 10, v22
/*d1040018 0001010c*/ v_cmp_eq_i32    s[24:25], v12, 0
/*7d041704         */ v_cmp_eq_i32    vcc, v4, v11
/*3a082310         */ v_xor_b32       v4, v16, v17
/*36161cff 000ffc00*/ v_and_b32       v11, 0xffc00, v14
/*3a1c2712         */ v_xor_b32       v14, v18, v19
/*38161600         */ v_or_b32        v11, s0, v11
/*360a02ff 000003ff*/ v_and_b32       v5, 0x3ff, v1
/*7e400314         */ v_mov_b32       v32, v20
/*380a0b0b         */ v_or_b32        v5, v11, v5
/*7e42030d         */ v_mov_b32       v33, v13
/*87ea6a18         */ s_and_b64       vcc, s[24:25], vcc
/*7e440304         */ v_mov_b32       v34, v4
/*d2000004 01a98280*/ v_cndmask_b32   v4, 0, -1, vcc
/*7e46030e         */ v_mov_b32       v35, v14
/*38080906         */ v_or_b32        v4, v6, v4
/*7e480305         */ v_mov_b32       v36, v5
/*362018ff 00000fff*/ v_and_b32       v16, 0xfff, v12
/*d2920004 02050104*/ v_bfe_i32       v4, v4, 0, 1
/*7d840880         */ v_cmp_eq_u32    vcc, 0, v4
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*34081884         */ v_lshlrev_b32   v4, 4, v12
/*bf880017         */ s_cbranch_execz .L1720_5
/*2c162081         */ v_lshrrev_b32   v11, 1, v16
/*36080890         */ v_and_b32       v4, 16, v4
/*34181682         */ v_lshlrev_b32   v12, 2, v11
/*321a0881         */ v_lshl_b32      v13, 1, v4
/*4a181806         */ v_add_i32       v12, vcc, s6, v12
/*38161601         */ v_or_b32        v11, s1, v11
/*34161682         */ v_lshlrev_b32   v11, 2, v11

/*d8800000 0b000d0b*/ ds_add_rtn_u32  v11, v11, v13 gds

/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a16090b         */ v_lshr_b32      v11, v11, v4
/*d290000b 0241010b*/ v_bfe_u32       v11, v11, 0, 16
/*d87c4b70 00000b00*/ ds_write_b16    v0, v11 offset:19312
.L1720_5:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*d8f04b70 05000000*/ ds_read_u16     v5, v0 offset:19312
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*360a0aff 0000ffff*/ v_and_b32       v5, 0xffff, v5
/*b00302ab         */ s_movk_i32      s3, 0x2ab
/*7d8c0a03         */ v_cmp_ge_u32    vcc, s3, v5
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf88001c         */ s_cbranch_execz .L1880_5
/*2c2e1082         */ v_lshrrev_b32   v23, 2, v8
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*bf880010         */ s_cbranch_execz .L1844_5
/*be9b037c         */ s_mov_b32       s27, m0
/*be9c047e         */ s_mov_b64       s[28:29], exec
.L1788_5:
/*7e340517         */ v_readfirstlane_b32 s26, v23
/*befc031a         */ s_mov_b32       m0, s26
/*be9e047e         */ s_mov_b64       s[30:31], exec
/*d1240020 00022e1a*/ v_cmpx_eq_i32   s[32:33], s26, v23
/*8a9e201e         */ s_andn2_b64     s[30:31], s[30:31], s[32:33]
/*7e168718         */ v_movrels_b32   v11, v24
/*7e188719         */ v_movrels_b32   v12, v25
/*7e1a871a         */ v_movrels_b32   v13, v26
/*7e1c871b         */ v_movrels_b32   v14, v27
/*befe041e         */ s_mov_b64       exec, s[30:31]
/*bf89fff4         */ s_cbranch_execnz .L1788_5
/*befe041c         */ s_mov_b64       exec, s[28:29]
/*befc031b         */ s_mov_b32       m0, s27
.L1844_5:
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*d2d6000f 00000710*/ v_mul_lo_i32    v15, v16, s3
/*4a0a1f05         */ v_add_i32       v5, vcc, v5, v15
/*340a0a85         */ v_lshlrev_b32   v5, 5, v5
/*4a0a0a05         */ v_add_i32       v5, vcc, s5, v5
/*4a0a0b07         */ v_add_i32       v5, vcc, v7, v5
/*ebf71000 80050b05*/ tbuffer_store_format_xyzw v[11:14], v5, s[20:23], 0 offen format:[32_32_32_32,float]
.L1880_5:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*8383ff02 00000080*/ s_min_u32       s3, s2, 0x80
/*80840302         */ s_sub_u32       s4, s2, s3
/*bf000302         */ s_cmp_eq_i32    s2, s3
/*bf850002         */ s_cbranch_scc1  .L1912_5
/*be820304         */ s_mov_b32       s2, s4
/*bf82ff4a         */ s_branch        .L1184_5
.L1912_5:
/*bf810000         */ s_endpgm
.kernel kernel_round5
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 37 /*36*/
        .vgprsnum 40
        .hwlocal 16832
        .floatmode 0xc0
        .uavid 11
        .uavprivate 64
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x00210098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg ht_dst, "char*", char*, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
        .arg rowCountersDst, "uint*", uint*, global, , 14
        .arg debug, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c200051c         */ s_buffer_load_dword s0, s[4:7], 0x1c
/*7e020280         */ v_mov_b32       v1, 0
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*c2030910         */ s_buffer_load_dword s6, s[8:11], 0x10
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000000c         */ s_add_u32       s0, s12, s0
/*7e300280         */ v_mov_b32       v24, 0
/*bf0bff00 00000fff*/ s_cmp_le_u32    s0, 0xfff
/*bf8401c1         */ s_cbranch_scc0  .L1852_6
/*b00700ff         */ s_movk_i32      s7, 0xff
/*7d8c0007         */ v_cmp_ge_u32    vcc, s7, v0
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880015         */ s_cbranch_execz .L160_6
/*4a0202ff 00003760*/ v_add_i32       v1, vcc, 0x3760, v1
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e040300         */ v_mov_b32       v2, v0
.L96_6:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d8340000 00000301*/ ds_write_b32    v1, v3
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b0070100         */ s_movk_i32      s7, 0x100
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L160_6
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82fff0         */ s_branch        .L96_6
.L160_6:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*8f018c01         */ s_lshl_b32      s1, s1, 12
/*b00702ab         */ s_movk_i32      s7, 0x2ab
/*d1880008 00000f00*/ v_cmp_gt_u32    s[8:9], v0, s7
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*8afe080a         */ s_andn2_b64     exec, s[10:11], s[8:9]
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880031         */ s_cbranch_execz .L392_6
/*4a0202ff 00003b60*/ v_add_i32       v1, vcc, 0x3b60, v1
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*be94047e         */ s_mov_b64       s[20:21], exec
/*7e040300         */ v_mov_b32       v2, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L224_6:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d87c0000 00000301*/ ds_write_b16    v1, v3
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00702ac         */ s_movk_i32      s7, 0x2ac
/*7d880407         */ v_cmp_gt_u32    vcc, s7, v2
/*be96047e         */ s_mov_b64       s[22:23], exec
/*8afe6a16         */ s_andn2_b64     exec, s[22:23], vcc
/*8a947e14         */ s_andn2_b64     s[20:21], s[20:21], exec
/*bf840002         */ s_cbranch_scc0  .L288_6
/*87fe1416         */ s_and_b64       exec, s[22:23], s[20:21]
/*bf82fff0         */ s_branch        .L224_6
.L288_6:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040080         */ v_cmp_eq_i32    vcc, 0, v0
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf880012         */ s_cbranch_execz .L376_6
/*90078100         */ s_lshr_b32      s7, s0, 1
/*80070701         */ s_add_u32       s7, s1, s7
/*8f078207         */ s_lshl_b32      s7, s7, 2
/*7e020207         */ v_mov_b32       v1, s7

/*d8d80000 01000001*/ ds_read_b32     v1, v1 gds

/*8f078400         */ s_lshl_b32      s7, s0, 4
/*87079007         */ s_and_b32       s7, s7, 16
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c020207         */ v_lshrrev_b32   v1, s7, v1
/*d2900001 02410101*/ v_bfe_u32       v1, v1, 0, 16
/*260802ff 000002ac*/ v_min_u32       v4, 0x2ac, v1
/*7e040280         */ v_mov_b32       v2, 0
/*d8343750 00000402*/ ds_write_b32    v2, v4 offset:14160
/*7e020281         */ v_mov_b32       v1, 1
.L376_6:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040e         */ s_mov_b64       exec, s[14:15]
.L392_6:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e060280         */ v_mov_b32       v3, 0
/*d8d83750 03000003*/ ds_read_b32     v3, v3 offset:14160
/*d2920001 02050101*/ v_bfe_i32       v1, v1, 0, 1
/*7d0a0280         */ v_cmp_lg_i32    vcc, 0, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*00040903         */ v_cndmask_b32   v2, v3, v4, vcc
/*bf8a0000         */ s_barrier
/*7d8a0280         */ v_cmp_lg_u32    vcc, 0, v1
/*be8a246a         */ s_and_saveexec_b64 s[10:11], vcc
/*7e020280         */ v_mov_b32       v1, 0
/*bf880002         */ s_cbranch_execz .L476_6
/*d8343750 00000101*/ ds_write_b32    v1, v1 offset:14160
.L476_6:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7d820500         */ v_cmp_lt_u32    vcc, v0, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf88003e         */ s_cbranch_execz .L752_6
/*4a0202ff 00003b60*/ v_add_i32       v1, vcc, 0x3b60, v1
/*9307ff00 000002ac*/ s_mul_i32       s7, s0, 0x2ac
/*4a060007         */ v_add_i32       v3, vcc, s7, v0
/*34060685         */ v_lshlrev_b32   v3, 5, v3
/*4a060604         */ v_add_i32       v3, vcc, s4, v3
/*34080082         */ v_lshlrev_b32   v4, 2, v0
/*4a0808ff 00001570*/ v_add_i32       v4, vcc, 0x1570, v4
/*c08a0360         */ s_load_dwordx4  s[20:23], s[2:3], 0x60
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e2a0300         */ v_mov_b32       v21, v0
.L556_6:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebf31000 80050f03*/ tbuffer_load_format_xyzw v[15:18], v3, s[20:23], 0 offen format:[32_32_32_32,float]
/*4a1408ff ffffeaa0*/ v_add_i32       v10, vcc, 0xffffeaa0, v4
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000f0a*/ ds_write_b32    v10, v15
/*4a1408ff fffff550*/ v_add_i32       v10, vcc, 0xfffff550, v4
/*36161eff 000000f0*/ v_and_b32       v11, 0xf0, v15
/*d2900006 0211190f*/ v_bfe_u32       v6, v15, 12, 4
/*d8340000 0000100a*/ ds_write_b32    v10, v16
/*380c0d0b         */ v_or_b32        v6, v11, v6
/*d8340000 00001104*/ ds_write_b32    v4, v17
/*4a1008ff 00000ab0*/ v_add_i32       v8, vcc, 0xab0, v4
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*d8340000 00001208*/ ds_write_b32    v8, v18
/*4a0c0cff 00003760*/ v_add_i32       v6, vcc, 0x3760, v6
/*d8b40000 06001506*/ ds_wrxchg_rtn_b32 v6, v6, v21
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900006 02410106*/ v_bfe_u32       v6, v6, 0, 16
/*4a2a2aff 00000100*/ v_add_i32       v21, vcc, 0x100, v21
/*d87c0000 00000601*/ ds_write_b16    v1, v6
/*4a0606ff 00002000*/ v_add_i32       v3, vcc, 0x2000, v3
/*4a0808ff 00000400*/ v_add_i32       v4, vcc, 0x400, v4
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*7d882b02         */ v_cmp_gt_u32    vcc, v2, v21
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffd4         */ s_cbranch_execnz .L556_6
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7e2c02ff 00000200*/ v_mov_b32       v22, 0x200
/*7e0402ff 00000100*/ v_mov_b32       v2, 0x100
.L752_6:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf880004         */ s_cbranch_execz .L776_6
/*7e2c0301         */ v_mov_b32       v22, v1
/*7e040301         */ v_mov_b32       v2, v1
/*7e2a0301         */ v_mov_b32       v21, v1
/*7e200301         */ v_mov_b32       v16, v1
.L776_6:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe080a         */ s_and_b64       exec, s[10:11], s[8:9]
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*bf880039         */ s_cbranch_execz .L1024_6
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e0a0300         */ v_mov_b32       v5, v0
.L808_6:
/*be94047e         */ s_mov_b64       s[20:21], exec
/*be96047e         */ s_mov_b64       s[22:23], exec
/*7e060305         */ v_mov_b32       v3, v5
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L832_6:
/*340c0681         */ v_lshlrev_b32   v6, 1, v3
/*4a0c0cff 00003b60*/ v_add_i32       v6, vcc, 0x3b60, v6
/*b00402ab         */ s_movk_i32      s4, 0x2ab
/*d8f00000 06000006*/ ds_read_u16     v6, v6
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900003 02410106*/ v_bfe_u32       v3, v6, 0, 16
/*7d820604         */ v_cmp_lt_u32    vcc, s4, v3
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf840018         */ s_cbranch_scc0  .L980_6
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*7e0c0280         */ v_mov_b32       v6, 0
/*7e1002c1         */ v_mov_b32       v8, -1
/*d88c3750 06000806*/ ds_inc_rtn_u32  v6, v6, v8 offset:14160
/*b0040318         */ s_movk_i32      s4, 0x318
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*7d820c04         */ v_cmp_lt_u32    vcc, s4, v6
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*8a967e16         */ s_andn2_b64     s[22:23], s[22:23], exec
/*bf84000d         */ s_cbranch_scc0  .L980_6
/*87fe1618         */ s_and_b64       exec, s[24:25], s[22:23]
/*340c0c81         */ v_lshlrev_b32   v6, 1, v6
/*4a100cff 00002ad0*/ v_add_i32       v8, vcc, 0x2ad0, v6
/*d2900009 02410105*/ v_bfe_u32       v9, v5, 0, 16
/*d87c0000 00000908*/ ds_write_b16    v8, v9
/*4a0c0cff 00003110*/ v_add_i32       v6, vcc, 0x3110, v6
/*d87c0000 00000306*/ ds_write_b16    v6, v3
/*bf82ffdb         */ s_branch        .L832_6
.L980_6:
/*befe0414         */ s_mov_b64       exec, s[20:21]
/*4a0a0aff 00000100*/ v_add_i32       v5, vcc, 0x100, v5
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*7d880a04         */ v_cmp_gt_u32    vcc, s4, v5
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L1024_6
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82ffca         */ s_branch        .L808_6
.L1024_6:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8d83750 05000005*/ ds_read_b32     v5, v5 offset:14160
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*260a0aff 00000319*/ v_min_u32       v5, 0x319, v5
/*7e0c0280         */ v_mov_b32       v6, 0
/*7d0a0d05         */ v_cmp_lg_i32    vcc, v5, v6
/*bf8600c3         */ s_cbranch_vccz  .L1852_6
/*8001ff01 00000800*/ s_add_u32       s1, s1, 0x800
/*360c0081         */ v_and_b32       v6, 1, v0
/*340e0c84         */ v_lshlrev_b32   v7, 4, v6
/*38100ea0         */ v_or_b32        v8, 32, v7
/*2c120081         */ v_lshrrev_b32   v9, 1, v0
/*360000c2         */ v_and_b32       v0, -2, v0
/*8f009400         */ s_lshl_b32      s0, s0, 20
/*7e146f09         */ v_not_b32       v10, v9
/*c0840370         */ s_load_dwordx4  s[8:11], s[2:3], 0x70
/*c08a0368         */ s_load_dwordx4  s[20:23], s[2:3], 0x68
/*7e040505         */ v_readfirstlane_b32 s2, v5
.L1120_6:
/*7d881202         */ v_cmp_gt_u32    vcc, s2, v9
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a021402         */ v_add_i32       v1, vcc, s2, v10
/*bf880012         */ s_cbranch_execz .L1208_6
/*34020281         */ v_lshlrev_b32   v1, 1, v1
/*4a0402ff 00003110*/ v_add_i32       v2, vcc, 0x3110, v1
/*4a0202ff 00002ad0*/ v_add_i32       v1, vcc, 0x2ad0, v1
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*d8f00000 01000001*/ ds_read_u16     v1, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*362c04ff 0000ffff*/ v_and_b32       v22, 0xffff, v2
/*360202ff 0000ffff*/ v_and_b32       v1, 0xffff, v1
/*34062c82         */ v_lshlrev_b32   v3, 2, v22
/*340a0282         */ v_lshlrev_b32   v5, 2, v1
/*4a040690         */ v_add_i32       v2, vcc, 16, v3
/*4a2a0a90         */ v_add_i32       v21, vcc, 16, v5
.L1208_6:
/*8afe7e0e         */ s_andn2_b64     exec, s[14:15], exec
/*7e0202ff 000002ac*/ v_mov_b32       v1, 0x2ac
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*7d040c80         */ v_cmp_eq_i32    vcc, 0, v6
/*87fe6a0e         */ s_and_b64       exec, s[14:15], vcc
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*7e1602ff 000002ac*/ v_mov_b32       v11, 0x2ac
/*bf880002         */ s_cbranch_execz .L1256_6
/*d87c40c0 00000b00*/ ds_write_b16    v0, v11 offset:16576
.L1256_6:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*7d880203         */ v_cmp_gt_u32    vcc, s3, v1
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*4a082aff 00000ab0*/ v_add_i32       v4, vcc, 0xab0, v21
/*bf88005e         */ s_cbranch_execz .L1660_6
/*bf800000         */ s_nop           0x0
/*4a1604ff 00000ab0*/ v_add_i32       v11, vcc, 0xab0, v2
/*4a1804ff 00001560*/ v_add_i32       v12, vcc, 0x1560, v2
/*4a1a2aff 00001560*/ v_add_i32       v13, vcc, 0x1560, v21
/*d8d80000 0e000015*/ ds_read_b32     v14, v21
/*d8d80000 0f000002*/ ds_read_b32     v15, v2
/*d8d80000 04000004*/ ds_read_b32     v4, v4
/*d8d80000 0b00000b*/ ds_read_b32     v11, v11
/*4a2004ff 00002010*/ v_add_i32       v16, vcc, 0x2010, v2
/*4a222aff 00002010*/ v_add_i32       v17, vcc, 0x2010, v21
/*d8d80000 0c00000c*/ ds_read_b32     v12, v12
/*d8d80000 0d00000d*/ ds_read_b32     v13, v13
/*d8d80000 10000010*/ ds_read_b32     v16, v16
/*d8d80000 11000011*/ ds_read_b32     v17, v17
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*3a241f0e         */ v_xor_b32       v18, v14, v15
/*3a261704         */ v_xor_b32       v19, v4, v11
/*d29c0014 02222513*/ v_alignbit_b32  v20, v19, v18, 8
/*3a181b0c         */ v_xor_b32       v12, v12, v13
/*d29c000d 0222270c*/ v_alignbit_b32  v13, v12, v19, 8
/*3a202310         */ v_xor_b32       v16, v16, v17
/*34222c8a         */ v_lshlrev_b32   v17, 10, v22
/*d1040018 00021f0e*/ v_cmp_eq_i32    s[24:25], v14, v15
/*7d041704         */ v_cmp_eq_i32    vcc, v4, v11
/*d29c0004 02221910*/ v_alignbit_b32  v4, v16, v12, 8
/*361622ff 000ffc00*/ v_and_b32       v11, 0xffc00, v17
/*2c182088         */ v_lshrrev_b32   v12, 8, v16
/*38161600         */ v_or_b32        v11, s0, v11
/*360a02ff 000003ff*/ v_and_b32       v5, 0x3ff, v1
/*7e400314         */ v_mov_b32       v32, v20
/*380a0b0b         */ v_or_b32        v5, v11, v5
/*7e42030d         */ v_mov_b32       v33, v13
/*87ea6a18         */ s_and_b64       vcc, s[24:25], vcc
/*7e440304         */ v_mov_b32       v34, v4
/*2c082498         */ v_lshrrev_b32   v4, 24, v18
/*d200000b 01a98280*/ v_cndmask_b32   v11, 0, -1, vcc
/*7e46030c         */ v_mov_b32       v35, v12
/*2c182488         */ v_lshrrev_b32   v12, 8, v18
/*360808ff 000000f0*/ v_and_b32       v4, 0xf0, v4
/*b0030f0f         */ s_movk_i32      s3, 0xf0f
/*38161706         */ v_or_b32        v11, v6, v11
/*7e480305         */ v_mov_b32       v36, v5
/*d2940010 04121803*/ v_bfi_b32       v16, s3, v12, v4
/*d2920005 0205010b*/ v_bfe_i32       v5, v11, 0, 1
/*7d840a80         */ v_cmp_eq_u32    vcc, 0, v5
/*be98246a         */ s_and_saveexec_b64 s[24:25], vcc
/*2c0a2484         */ v_lshrrev_b32   v5, 4, v18
/*bf880017         */ s_cbranch_execz .L1660_6
/*2c162081         */ v_lshrrev_b32   v11, 1, v16
/*360a0a90         */ v_and_b32       v5, 16, v5
/*34181682         */ v_lshlrev_b32   v12, 2, v11
/*321a0a81         */ v_lshl_b32      v13, 1, v5
/*4a181806         */ v_add_i32       v12, vcc, s6, v12
/*38161601         */ v_or_b32        v11, s1, v11
/*34161682         */ v_lshlrev_b32   v11, 2, v11

/*d8800000 0b000d0b*/ ds_add_rtn_u32  v11, v11, v13 gds

/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a160b0b         */ v_lshr_b32      v11, v11, v5
/*d290000b 0241010b*/ v_bfe_u32       v11, v11, 0, 16
/*d87c40c0 00000b00*/ ds_write_b16    v0, v11 offset:16576
.L1660_6:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*d8f040c0 05000000*/ ds_read_u16     v5, v0 offset:16576
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*360a0aff 0000ffff*/ v_and_b32       v5, 0xffff, v5
/*b00302ab         */ s_movk_i32      s3, 0x2ab
/*7d8c0a03         */ v_cmp_ge_u32    vcc, s3, v5
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf88001c         */ s_cbranch_execz .L1820_6
/*2c2e1082         */ v_lshrrev_b32   v23, 2, v8
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*bf880010         */ s_cbranch_execz .L1784_6
/*be9b037c         */ s_mov_b32       s27, m0
/*be9c047e         */ s_mov_b64       s[28:29], exec
.L1728_6:
/*7e340517         */ v_readfirstlane_b32 s26, v23
/*befc031a         */ s_mov_b32       m0, s26
/*be9e047e         */ s_mov_b64       s[30:31], exec
/*d1240020 00022e1a*/ v_cmpx_eq_i32   s[32:33], s26, v23
/*8a9e201e         */ s_andn2_b64     s[30:31], s[30:31], s[32:33]
/*7e168718         */ v_movrels_b32   v11, v24
/*7e188719         */ v_movrels_b32   v12, v25
/*7e1a871a         */ v_movrels_b32   v13, v26
/*7e1c871b         */ v_movrels_b32   v14, v27
/*befe041e         */ s_mov_b64       exec, s[30:31]
/*bf89fff4         */ s_cbranch_execnz .L1728_6
/*befe041c         */ s_mov_b64       exec, s[28:29]
/*befc031b         */ s_mov_b32       m0, s27
.L1784_6:
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*d2d6000f 00000710*/ v_mul_lo_i32    v15, v16, s3
/*4a0a1f05         */ v_add_i32       v5, vcc, v5, v15
/*340a0a85         */ v_lshlrev_b32   v5, 5, v5
/*4a0a0a05         */ v_add_i32       v5, vcc, s5, v5
/*4a0a0b07         */ v_add_i32       v5, vcc, v7, v5
/*ebf71000 80050b05*/ tbuffer_store_format_xyzw v[11:14], v5, s[20:23], 0 offen format:[32_32_32_32,float]
.L1820_6:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*8383ff02 00000080*/ s_min_u32       s3, s2, 0x80
/*80840302         */ s_sub_u32       s4, s2, s3
/*bf000302         */ s_cmp_eq_i32    s2, s3
/*bf850002         */ s_cbranch_scc1  .L1852_6
/*be820304         */ s_mov_b32       s2, s4
/*bf82ff49         */ s_branch        .L1120_6
.L1852_6:
/*bf810000         */ s_endpgm
.kernel kernel_round6
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 23 /*22*/
        .vgprsnum 18
        .hwlocal 16568
        .floatmode 0xc0
        .uavid 11
        .uavprivate 0
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x00208098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg ht_dst, "char*", char*, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
        .arg rowCountersDst, "uint*", uint*, global, , 11, unused
        .arg debug, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c200051c         */ s_buffer_load_dword s0, s[4:7], 0x1c
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000000c         */ s_add_u32       s0, s12, s0
/*bf0bff00 00000fff*/ s_cmp_le_u32    s0, 0xfff
/*bf840191         */ s_cbranch_scc0  .L1648_7
/*b00600ff         */ s_movk_i32      s6, 0xff
/*7d8c0006         */ v_cmp_ge_u32    vcc, s6, v0
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880018         */ s_cbranch_execz .L160_7
/*4a0202ff 00003760*/ v_add_i32       v1, vcc, 0x3760, v1
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e040300         */ v_mov_b32       v2, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L96_7:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d8340000 00000301*/ ds_write_b32    v1, v3
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00c0100         */ s_movk_i32      s12, 0x100
/*7d88040c         */ v_cmp_gt_u32    vcc, s12, v2
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*8a8a7e0a         */ s_andn2_b64     s[10:11], s[10:11], exec
/*bf840002         */ s_cbranch_scc0  .L160_7
/*87fe0a0c         */ s_and_b64       exec, s[12:13], s[10:11]
/*bf82fff0         */ s_branch        .L96_7
.L160_7:
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*8f018c01         */ s_lshl_b32      s1, s1, 12
/*b00602ab         */ s_movk_i32      s6, 0x2ab
/*d1880006 00000d00*/ v_cmp_gt_u32    s[6:7], v0, s6
/*be88047e         */ s_mov_b64       s[8:9], exec
/*8afe0608         */ s_andn2_b64     exec, s[8:9], s[6:7]
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880036         */ s_cbranch_execz .L412_7
/*4a0202ff 00003b60*/ v_add_i32       v1, vcc, 0x3b60, v1
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*7e200300         */ v_mov_b32       v16, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L224_7:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d87c0000 00000301*/ ds_write_b16    v1, v3
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a2020ff 00000100*/ v_add_i32       v16, vcc, 0x100, v16
/*b00e02ac         */ s_movk_i32      s14, 0x2ac
/*7d88200e         */ v_cmp_gt_u32    vcc, s14, v16
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*8afe6a0e         */ s_andn2_b64     exec, s[14:15], vcc
/*8a8c7e0c         */ s_andn2_b64     s[12:13], s[12:13], exec
/*bf840002         */ s_cbranch_scc0  .L288_7
/*87fe0c0e         */ s_and_b64       exec, s[14:15], s[12:13]
/*bf82fff0         */ s_branch        .L224_7
.L288_7:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*d104000a 00010100*/ v_cmp_eq_i32    s[10:11], v0, 0
/*be8c240a         */ s_and_saveexec_b64 s[12:13], s[10:11]
/*bf880014         */ s_cbranch_execz .L388_7
/*900e8100         */ s_lshr_b32      s14, s0, 1
/*800e0e01         */ s_add_u32       s14, s1, s14
/*8f0e820e         */ s_lshl_b32      s14, s14, 2
/*7e02020e         */ v_mov_b32       v1, s14
/*4a0202ff 00002000*/ v_add_i32       v1, vcc, 0x2000, v1

/*d8d80000 01000001*/ ds_read_b32     v1, v1 gds

/*8f0e8400         */ s_lshl_b32      s14, s0, 4
/*870e900e         */ s_and_b32       s14, s14, 16
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c02020e         */ v_lshrrev_b32   v1, s14, v1
/*d2900001 02410101*/ v_bfe_u32       v1, v1, 0, 16
/*261e02ff 000002ac*/ v_min_u32       v15, 0x2ac, v1
/*7e060280         */ v_mov_b32       v3, 0
/*d8343750 00000f03*/ ds_write_b32    v3, v15 offset:14160
/*7e020281         */ v_mov_b32       v1, 1
.L388_7:
/*8afe7e0c         */ s_andn2_b64     exec, s[12:13], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e1e0280         */ v_mov_b32       v15, 0
/*befe040c         */ s_mov_b64       exec, s[12:13]
/*d2000011 00298280*/ v_cndmask_b32   v17, 0, -1, s[10:11]
.L412_7:
/*8afe7e08         */ s_andn2_b64     exec, s[8:9], exec
/*bf880004         */ s_cbranch_execz .L436_7
/*7e1e0280         */ v_mov_b32       v15, 0
/*7e220301         */ v_mov_b32       v17, v1
/*7e200301         */ v_mov_b32       v16, v1
/*7e020280         */ v_mov_b32       v1, 0
.L436_7:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8d83750 05000005*/ ds_read_b32     v5, v5 offset:14160
/*d2920001 02050101*/ v_bfe_i32       v1, v1, 0, 1
/*7d0a0280         */ v_cmp_lg_i32    vcc, 0, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*000a1f05         */ v_cndmask_b32   v5, v5, v15, vcc
/*bf8a0000         */ s_barrier
/*7d8a0280         */ v_cmp_lg_u32    vcc, 0, v1
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*7e020280         */ v_mov_b32       v1, 0
/*bf880004         */ s_cbranch_execz .L516_7
/*d8343750 00000101*/ ds_write_b32    v1, v1 offset:14160
/*7e1e02ff 00003750*/ v_mov_b32       v15, 0x3750
.L516_7:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*7d820b00         */ v_cmp_lt_u32    vcc, v0, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe6a08         */ s_and_b64       exec, s[8:9], vcc
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880040         */ s_cbranch_execz .L800_7
/*4a0202ff 00003b60*/ v_add_i32       v1, vcc, 0x3b60, v1
/*930aff00 000002ac*/ s_mul_i32       s10, s0, 0x2ac
/*4a04000a         */ v_add_i32       v2, vcc, s10, v0
/*34040485         */ v_lshlrev_b32   v2, 5, v2
/*4a1e0404         */ v_add_i32       v15, vcc, s4, v2
/*34060082         */ v_lshlrev_b32   v3, 2, v0
/*4a2206ff 00001570*/ v_add_i32       v17, vcc, 0x1570, v3
/*c0860360         */ s_load_dwordx4  s[12:15], s[2:3], 0x60
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e080300         */ v_mov_b32       v4, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L608_7:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebf31000 8003060f*/ tbuffer_load_format_xyzw v[6:9], v15, s[12:15], 0 offen format:[32_32_32_32,float]
/*4a1422ff ffffeaa0*/ v_add_i32       v10, vcc, 0xffffeaa0, v17
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*2c160c88         */ v_lshrrev_b32   v11, 8, v6
/*d8340000 0000060a*/ ds_write_b32    v10, v6
/*4a1422ff fffff550*/ v_add_i32       v10, vcc, 0xfffff550, v17
/*d2900006 02112106*/ v_bfe_u32       v6, v6, 16, 4
/*361616ff 000000f0*/ v_and_b32       v11, 0xf0, v11
/*d8340000 0000070a*/ ds_write_b32    v10, v7
/*380c1706         */ v_or_b32        v6, v6, v11
/*d8340000 00000811*/ ds_write_b32    v17, v8
/*4a0e22ff 00000ab0*/ v_add_i32       v7, vcc, 0xab0, v17
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*d8340000 00000907*/ ds_write_b32    v7, v9
/*4a0c0cff 00003760*/ v_add_i32       v6, vcc, 0x3760, v6
/*d8b40000 06000406*/ ds_wrxchg_rtn_b32 v6, v6, v4
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900006 02410106*/ v_bfe_u32       v6, v6, 0, 16
/*4a0808ff 00000100*/ v_add_i32       v4, vcc, 0x100, v4
/*d87c0000 00000601*/ ds_write_b16    v1, v6
/*4a1e1eff 00002000*/ v_add_i32       v15, vcc, 0x2000, v15
/*4a2222ff 00000400*/ v_add_i32       v17, vcc, 0x400, v17
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*7d880905         */ v_cmp_gt_u32    vcc, v5, v4
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffd3         */ s_cbranch_execnz .L608_7
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7e2002ff 00002000*/ v_mov_b32       v16, 0x2000
.L800_7:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe0608         */ s_and_b64       exec, s[8:9], s[6:7]
/*8afe7e08         */ s_andn2_b64     exec, s[8:9], exec
/*bf880045         */ s_cbranch_execz .L1096_7
/*be86047e         */ s_mov_b64       s[6:7], exec
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e020300         */ v_mov_b32       v1, v0
.L832_7:
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e060301         */ v_mov_b32       v3, v1
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L864_7:
/*34040681         */ v_lshlrev_b32   v2, 1, v3
/*4a0404ff 00003b60*/ v_add_i32       v2, vcc, 0x3b60, v2
/*b00402ab         */ s_movk_i32      s4, 0x2ab
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900003 02410102*/ v_bfe_u32       v3, v2, 0, 16
/*d1880010 00000903*/ v_cmp_gt_u32    s[16:17], v3, s4
/*be922410         */ s_and_saveexec_b64 s[18:19], s[16:17]
/*d200000f 00418280*/ v_cndmask_b32   v15, 0, -1, s[16:17]
/*bf880002         */ s_cbranch_execz .L932_7
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf84001e         */ s_cbranch_scc0  .L1052_7
.L932_7:
/*87fe0e12         */ s_and_b64       exec, s[18:19], s[14:15]
/*7e040280         */ v_mov_b32       v2, 0
/*7e0a02c1         */ v_mov_b32       v5, -1
/*d88c3750 0f000502*/ ds_inc_rtn_u32  v15, v2, v5 offset:14160
/*b0040318         */ s_movk_i32      s4, 0x318
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d1880010 0000090f*/ v_cmp_gt_u32    s[16:17], v15, s4
/*be922410         */ s_and_saveexec_b64 s[18:19], s[16:17]
/*d2000011 00418280*/ v_cndmask_b32   v17, 0, -1, s[16:17]
/*bf880002         */ s_cbranch_execz .L992_7
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf84000f         */ s_cbranch_scc0  .L1052_7
.L992_7:
/*87fe0e12         */ s_and_b64       exec, s[18:19], s[14:15]
/*34041e81         */ v_lshlrev_b32   v2, 1, v15
/*4a0a04ff 00002ad0*/ v_add_i32       v5, vcc, 0x2ad0, v2
/*d2900006 02410101*/ v_bfe_u32       v6, v1, 0, 16
/*d87c0000 00000605*/ ds_write_b16    v5, v6
/*4a1e04ff 00003110*/ v_add_i32       v15, vcc, 0x3110, v2
/*d87c0000 0000030f*/ ds_write_b16    v15, v3
/*7e2202ff 00003110*/ v_mov_b32       v17, 0x3110
/*bf82ffd1         */ s_branch        .L864_7
.L1052_7:
/*befe040c         */ s_mov_b64       exec, s[12:13]
/*4a0202ff 00000100*/ v_add_i32       v1, vcc, 0x100, v1
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*7d880204         */ v_cmp_gt_u32    vcc, s4, v1
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*8a8a7e0a         */ s_andn2_b64     s[10:11], s[10:11], exec
/*bf840002         */ s_cbranch_scc0  .L1096_7
/*87fe0a0c         */ s_and_b64       exec, s[12:13], s[10:11]
/*bf82ffbe         */ s_branch        .L832_7
.L1096_7:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e080280         */ v_mov_b32       v4, 0
/*d8d83750 04000004*/ ds_read_b32     v4, v4 offset:14160
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*260808ff 00000319*/ v_min_u32       v4, 0x319, v4
/*7e0a0280         */ v_mov_b32       v5, 0
/*7d0a0b04         */ v_cmp_lg_i32    vcc, v4, v5
/*bf86007e         */ s_cbranch_vccz  .L1648_7
/*8f009400         */ s_lshl_b32      s0, s0, 20
/*7e0a6f00         */ v_not_b32       v5, v0
/*c0840368         */ s_load_dwordx4  s[8:11], s[2:3], 0x68
/*7e040504         */ v_readfirstlane_b32 s2, v4
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L1184_7:
/*7d880002         */ v_cmp_gt_u32    vcc, s2, v0
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*4a020a02         */ v_add_i32       v1, vcc, s2, v5
/*bf880012         */ s_cbranch_execz .L1272_7
/*34020281         */ v_lshlrev_b32   v1, 1, v1
/*4a0402ff 00003110*/ v_add_i32       v2, vcc, 0x3110, v1
/*4a0202ff 00002ad0*/ v_add_i32       v1, vcc, 0x2ad0, v1
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*d8f00000 01000001*/ ds_read_u16     v1, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*361e04ff 0000ffff*/ v_and_b32       v15, 0xffff, v2
/*360202ff 0000ffff*/ v_and_b32       v1, 0xffff, v1
/*34061e82         */ v_lshlrev_b32   v3, 2, v15
/*34080282         */ v_lshlrev_b32   v4, 2, v1
/*4a220690         */ v_add_i32       v17, vcc, 16, v3
/*4a200890         */ v_add_i32       v16, vcc, 16, v4
.L1272_7:
/*8afe7e06         */ s_andn2_b64     exec, s[6:7], exec
/*7e0202ff 000002ac*/ v_mov_b32       v1, 0x2ac
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*7d880203         */ v_cmp_gt_u32    vcc, s3, v1
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*4a0c20ff 00000ab0*/ v_add_i32       v6, vcc, 0xab0, v16
/*bf88004c         */ s_cbranch_execz .L1616_7
/*4a0e22ff 00000ab0*/ v_add_i32       v7, vcc, 0xab0, v17
/*d8d80000 06000006*/ ds_read_b32     v6, v6
/*d8d80000 07000007*/ ds_read_b32     v7, v7
/*d8d80000 08000010*/ ds_read_b32     v8, v16
/*d8d80000 09000011*/ ds_read_b32     v9, v17
/*bf8c000f         */ s_waitcnt       expcnt(0) & lgkmcnt(0)
/*3a140f06         */ v_xor_b32       v10, v6, v7
/*3a101308         */ v_xor_b32       v8, v8, v9
/*d29c0008 0262110a*/ v_alignbit_b32  v8, v10, v8, 24
/*d104000c 00010108*/ v_cmp_eq_i32    s[12:13], v8, 0
/*7d040f06         */ v_cmp_eq_i32    vcc, v6, v7
/*87ea6a0c         */ s_and_b64       vcc, s[12:13], vcc
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*360c10ff 00000fff*/ v_and_b32       v6, 0xfff, v8
/*bf880034         */ s_cbranch_execz .L1616_7
/*340e1084         */ v_lshlrev_b32   v7, 4, v8
/*2c100c81         */ v_lshrrev_b32   v8, 1, v6
/*4a1220ff 00001560*/ v_add_i32       v9, vcc, 0x1560, v16
/*4a1622ff 00001560*/ v_add_i32       v11, vcc, 0x1560, v17
/*4a1820ff 00002010*/ v_add_i32       v12, vcc, 0x2010, v16
/*4a1a22ff 00002010*/ v_add_i32       v13, vcc, 0x2010, v17
/*360e0e90         */ v_and_b32       v7, 16, v7
/*38101001         */ v_or_b32        v8, s1, v8
/*321c0e81         */ v_lshl_b32      v14, 1, v7
/*34101082         */ v_lshlrev_b32   v8, 2, v8
/*d8d80000 09000009*/ ds_read_b32     v9, v9
/*d8d80000 0b00000b*/ ds_read_b32     v11, v11
/*d8d80000 0c00000c*/ ds_read_b32     v12, v12
/*d8d80000 0d00000d*/ ds_read_b32     v13, v13

/*d8800000 08000e08*/ ds_add_rtn_u32  v8, v8, v14 gds

/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a0e0f08         */ v_lshr_b32      v7, v8, v7
/*360e0eff 0000ffff*/ v_and_b32       v7, 0xffff, v7
/*b00302ab         */ s_movk_i32      s3, 0x2ab
/*7d8c0e03         */ v_cmp_ge_u32    vcc, s3, v7
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf880014         */ s_cbranch_execz .L1616_7
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*d2d60006 00000706*/ v_mul_lo_i32    v6, v6, s3
/*4a0c0d07         */ v_add_i32       v6, vcc, v7, v6
/*340c0c84         */ v_lshlrev_b32   v6, 4, v6
/*4a0c0c05         */ v_add_i32       v6, vcc, s5, v6
/*7d0a0c80         */ v_cmp_lg_i32    vcc, 0, v6
/*be90246a         */ s_and_saveexec_b64 s[16:17], vcc
/*3a161709         */ v_xor_b32       v11, v9, v11
/*bf88000a         */ s_cbranch_execz .L1616_7
/*3a181b0c         */ v_xor_b32       v12, v12, v13
/*34121e8a         */ v_lshlrev_b32   v9, 10, v15
/*361212ff 000ffc00*/ v_and_b32       v9, 0xffc00, v9
/*38121200         */ v_or_b32        v9, s0, v9
/*360802ff 000003ff*/ v_and_b32       v4, 0x3ff, v1
/*381a0909         */ v_or_b32        v13, v9, v4
/*ebf71000 80020a06*/ tbuffer_store_format_xyzw v[10:13], v6, s[8:11], 0 offen format:[32_32_32_32,float]
.L1616_7:
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*8383ff02 00000100*/ s_min_u32       s3, s2, 0x100
/*80840302         */ s_sub_u32       s4, s2, s3
/*bf000302         */ s_cmp_eq_i32    s2, s3
/*bf850002         */ s_cbranch_scc1  .L1648_7
/*be820304         */ s_mov_b32       s2, s4
/*bf82ff8c         */ s_branch        .L1184_7
.L1648_7:
/*bf810000         */ s_endpgm
.kernel kernel_round7
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 23 /* 22 */
        .vgprsnum 19
        .hwlocal 13832
        .floatmode 0xc0
        .uavid 11
        .uavprivate 0
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x001b0098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg ht_dst, "char*", char*, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
        .arg rowCountersDst, "uint*", uint*, global, , 11, unused
        .arg debug, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c200051c         */ s_buffer_load_dword s0, s[4:7], 0x1c
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000000c         */ s_add_u32       s0, s12, s0
/*bf0bff00 00000fff*/ s_cmp_le_u32    s0, 0xfff
/*bf84018c         */ s_cbranch_scc0  .L1628_8
/*b00600ff         */ s_movk_i32      s6, 0xff
/*7d8c0006         */ v_cmp_ge_u32    vcc, s6, v0
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880018         */ s_cbranch_execz .L160_8
/*4a0202ff 00002cb0*/ v_add_i32       v1, vcc, 0x2cb0, v1
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e040300         */ v_mov_b32       v2, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L96_8:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d8340000 00000301*/ ds_write_b32    v1, v3
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00c0100         */ s_movk_i32      s12, 0x100
/*7d88040c         */ v_cmp_gt_u32    vcc, s12, v2
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*8a8a7e0a         */ s_andn2_b64     s[10:11], s[10:11], exec
/*bf840002         */ s_cbranch_scc0  .L160_8
/*87fe0a0c         */ s_and_b64       exec, s[12:13], s[10:11]
/*bf82fff0         */ s_branch        .L96_8
.L160_8:
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*8f018c01         */ s_lshl_b32      s1, s1, 12
/*b00602ab         */ s_movk_i32      s6, 0x2ab
/*d1880006 00000d00*/ v_cmp_gt_u32    s[6:7], v0, s6
/*be88047e         */ s_mov_b64       s[8:9], exec
/*8afe0608         */ s_andn2_b64     exec, s[8:9], s[6:7]
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880035         */ s_cbranch_execz .L408_8
/*4a0202ff 000030b0*/ v_add_i32       v1, vcc, 0x30b0, v1
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*7e200300         */ v_mov_b32       v16, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L224_8:
/*7e0802ff 000002ac*/ v_mov_b32       v4, 0x2ac
/*d87c0000 00000401*/ ds_write_b16    v1, v4
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a2020ff 00000100*/ v_add_i32       v16, vcc, 0x100, v16
/*b00e02ac         */ s_movk_i32      s14, 0x2ac
/*d182000e 00001d10*/ v_cmp_lt_u32    s[14:15], v16, s14
/*be90047e         */ s_mov_b64       s[16:17], exec
/*8afe0e10         */ s_andn2_b64     exec, s[16:17], s[14:15]
/*d2000012 00398280*/ v_cndmask_b32   v18, 0, -1, s[14:15]
/*bf880002         */ s_cbranch_execz .L296_8
/*8a8c7e0c         */ s_andn2_b64     s[12:13], s[12:13], exec
/*bf840002         */ s_cbranch_scc0  .L304_8
.L296_8:
/*87fe0c10         */ s_and_b64       exec, s[16:17], s[12:13]
/*bf82ffec         */ s_branch        .L224_8
.L304_8:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7d040080         */ v_cmp_eq_i32    vcc, 0, v0
/*be8a246a         */ s_and_saveexec_b64 s[10:11], vcc
/*bf880012         */ s_cbranch_execz .L392_8
/*900c8100         */ s_lshr_b32      s12, s0, 1
/*800c0c01         */ s_add_u32       s12, s1, s12
/*8f0c820c         */ s_lshl_b32      s12, s12, 2
/*7e08020c         */ v_mov_b32       v4, s12

/*d8d80000 04000004*/ ds_read_b32     v4, v4 gds

/*8f0c8400         */ s_lshl_b32      s12, s0, 4
/*870c900c         */ s_and_b32       s12, s12, 16
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c08080c         */ v_lshrrev_b32   v4, s12, v4
/*d2900004 02410104*/ v_bfe_u32       v4, v4, 0, 16
/*261008ff 000002ac*/ v_min_u32       v8, 0x2ac, v4
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8342ca0 00000805*/ ds_write_b32    v5, v8 offset:11424
/*7e0e0281         */ v_mov_b32       v7, 1
.L392_8:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*7e0e0280         */ v_mov_b32       v7, 0
/*7e100280         */ v_mov_b32       v8, 0
/*befe040a         */ s_mov_b64       exec, s[10:11]
.L408_8:
/*8afe7e08         */ s_andn2_b64     exec, s[8:9], exec
/*7e0e0280         */ v_mov_b32       v7, 0
/*7e100280         */ v_mov_b32       v8, 0
/*7e200301         */ v_mov_b32       v16, v1
/*7e240301         */ v_mov_b32       v18, v1
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0c0280         */ v_mov_b32       v6, 0
/*d8d82ca0 06000006*/ ds_read_b32     v6, v6 offset:11424
/*d2920011 02050107*/ v_bfe_i32       v17, v7, 0, 1
/*7d0a2280         */ v_cmp_lg_i32    vcc, 0, v17
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*00061106         */ v_cndmask_b32   v3, v6, v8, vcc
/*bf8a0000         */ s_barrier
/*7d8a2280         */ v_cmp_lg_u32    vcc, 0, v17
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*7e020280         */ v_mov_b32       v1, 0
/*bf880004         */ s_cbranch_execz .L508_8
/*d8342ca0 00000101*/ ds_write_b32    v1, v1 offset:11424
/*7e2202ff 00002ca0*/ v_mov_b32       v17, 0x2ca0
.L508_8:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*7d820700         */ v_cmp_lt_u32    vcc, v0, v3
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe6a08         */ s_and_b64       exec, s[8:9], vcc
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880038         */ s_cbranch_execz .L760_8
/*4a0202ff 000030b0*/ v_add_i32       v1, vcc, 0x30b0, v1
/*930aff00 000002ac*/ s_mul_i32       s10, s0, 0x2ac
/*4a08000a         */ v_add_i32       v4, vcc, s10, v0
/*34080884         */ v_lshlrev_b32   v4, 4, v4
/*4a220804         */ v_add_i32       v17, vcc, s4, v4
/*340a0082         */ v_lshlrev_b32   v5, 2, v0
/*4a200aff 00000ac0*/ v_add_i32       v16, vcc, 0xac0, v5
/*c0860360         */ s_load_dwordx4  s[12:15], s[2:3], 0x60
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e0c0300         */ v_mov_b32       v6, v0
.L588_8:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebea1000 80030711*/ tbuffer_load_format_xyz v[7:9], v17, s[12:15], 0 offen format:[32_32_32,float]
/*4a1420ff fffff550*/ v_add_i32       v10, vcc, 0xfffff550, v16
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*36160eff 000000f0*/ v_and_b32       v11, 0xf0, v7
/*d290000c 02111907*/ v_bfe_u32       v12, v7, 12, 4
/*d8340000 0000070a*/ ds_write_b32    v10, v7
/*380e190b         */ v_or_b32        v7, v11, v12
/*d8340000 00000810*/ ds_write_b32    v16, v8
/*4a1020ff 00000ab0*/ v_add_i32       v8, vcc, 0xab0, v16
/*340e0e82         */ v_lshlrev_b32   v7, 2, v7
/*d8340000 00000908*/ ds_write_b32    v8, v9
/*4a0e0eff 00002cb0*/ v_add_i32       v7, vcc, 0x2cb0, v7
/*d8b40000 07000607*/ ds_wrxchg_rtn_b32 v7, v7, v6
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900007 02410107*/ v_bfe_u32       v7, v7, 0, 16
/*4a0c0cff 00000100*/ v_add_i32       v6, vcc, 0x100, v6
/*d87c0000 00000701*/ ds_write_b16    v1, v7
/*4a2222ff 00001000*/ v_add_i32       v17, vcc, 0x1000, v17
/*4a2020ff 00000400*/ v_add_i32       v16, vcc, 0x400, v16
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*7d880d03         */ v_cmp_gt_u32    vcc, v3, v6
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffd8         */ s_cbranch_execnz .L588_8
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7e2402ff 00001000*/ v_mov_b32       v18, 0x1000
.L760_8:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe0608         */ s_and_b64       exec, s[8:9], s[6:7]
/*8afe7e08         */ s_andn2_b64     exec, s[8:9], exec
/*bf880047         */ s_cbranch_execz .L1064_8
/*be86047e         */ s_mov_b64       s[6:7], exec
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e020300         */ v_mov_b32       v1, v0
.L792_8:
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e100301         */ v_mov_b32       v8, v1
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L832_8:
/*34061081         */ v_lshlrev_b32   v3, 1, v8
/*4a0606ff 000030b0*/ v_add_i32       v3, vcc, 0x30b0, v3
/*b00402ab         */ s_movk_i32      s4, 0x2ab
/*d8f00000 03000003*/ ds_read_u16     v3, v3
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900008 02410103*/ v_bfe_u32       v8, v3, 0, 16
/*d1880010 00000908*/ v_cmp_gt_u32    s[16:17], v8, s4
/*be922410         */ s_and_saveexec_b64 s[18:19], s[16:17]
/*d2000011 00418280*/ v_cndmask_b32   v17, 0, -1, s[16:17]
/*bf880002         */ s_cbranch_execz .L900_8
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf84001e         */ s_cbranch_scc0  .L1020_8
.L900_8:
/*87fe0e12         */ s_and_b64       exec, s[18:19], s[14:15]
/*7e060280         */ v_mov_b32       v3, 0
/*7e0c02c1         */ v_mov_b32       v6, -1
/*d88c2ca0 11000603*/ ds_inc_rtn_u32  v17, v3, v6 offset:11424
/*b0040318         */ s_movk_i32      s4, 0x318
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d1880010 00000911*/ v_cmp_gt_u32    s[16:17], v17, s4
/*be922410         */ s_and_saveexec_b64 s[18:19], s[16:17]
/*d2000010 00418280*/ v_cndmask_b32   v16, 0, -1, s[16:17]
/*bf880002         */ s_cbranch_execz .L960_8
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf84000f         */ s_cbranch_scc0  .L1020_8
.L960_8:
/*87fe0e12         */ s_and_b64       exec, s[18:19], s[14:15]
/*34062281         */ v_lshlrev_b32   v3, 1, v17
/*4a0c06ff 00002020*/ v_add_i32       v6, vcc, 0x2020, v3
/*d2900007 02410101*/ v_bfe_u32       v7, v1, 0, 16
/*d87c0000 00000706*/ ds_write_b16    v6, v7
/*4a2206ff 00002660*/ v_add_i32       v17, vcc, 0x2660, v3
/*d87c0000 00000811*/ ds_write_b16    v17, v8
/*7e2002ff 00002660*/ v_mov_b32       v16, 0x2660
/*bf82ffd1         */ s_branch        .L832_8
.L1020_8:
/*befe040c         */ s_mov_b64       exec, s[12:13]
/*4a0202ff 00000100*/ v_add_i32       v1, vcc, 0x100, v1
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*7d880204         */ v_cmp_gt_u32    vcc, s4, v1
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*8a8a7e0a         */ s_andn2_b64     s[10:11], s[10:11], exec
/*bf840002         */ s_cbranch_scc0  .L1064_8
/*87fe0a0c         */ s_and_b64       exec, s[12:13], s[10:11]
/*bf82ffbc         */ s_branch        .L792_8
.L1064_8:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8d82ca0 05000005*/ ds_read_b32     v5, v5 offset:11424
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*260a0aff 00000319*/ v_min_u32       v5, 0x319, v5
/*7e0c0280         */ v_mov_b32       v6, 0
/*7d0a0d05         */ v_cmp_lg_i32    vcc, v5, v6
/*bf860081         */ s_cbranch_vccz  .L1628_8
/*8001ff01 00000800*/ s_add_u32       s1, s1, 0x800
/*8f009400         */ s_lshl_b32      s0, s0, 20
/*7e0c6f00         */ v_not_b32       v6, v0
/*c0840368         */ s_load_dwordx4  s[8:11], s[2:3], 0x68
/*7e040505         */ v_readfirstlane_b32 s2, v5
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L1152_8:
/*7d880002         */ v_cmp_gt_u32    vcc, s2, v0
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*4a020c02         */ v_add_i32       v1, vcc, s2, v6
/*bf880012         */ s_cbranch_execz .L1240_8
/*34020281         */ v_lshlrev_b32   v1, 1, v1
/*4a0602ff 00002660*/ v_add_i32       v3, vcc, 0x2660, v1
/*4a0202ff 00002020*/ v_add_i32       v1, vcc, 0x2020, v1
/*d8f00000 03000003*/ ds_read_u16     v3, v3
/*d8f00000 01000001*/ ds_read_u16     v1, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*362206ff 0000ffff*/ v_and_b32       v17, 0xffff, v3
/*360202ff 0000ffff*/ v_and_b32       v1, 0xffff, v1
/*34082282         */ v_lshlrev_b32   v4, 2, v17
/*340a0282         */ v_lshlrev_b32   v5, 2, v1
/*4a200890         */ v_add_i32       v16, vcc, 16, v4
/*4a240a90         */ v_add_i32       v18, vcc, 16, v5
.L1240_8:
/*8afe7e06         */ s_andn2_b64     exec, s[6:7], exec
/*7e0202ff 000002ac*/ v_mov_b32       v1, 0x2ac
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*7d880203         */ v_cmp_gt_u32    vcc, s3, v1
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*4a0e24ff 00000ab0*/ v_add_i32       v7, vcc, 0xab0, v18
/*bf88004f         */ s_cbranch_execz .L1596_8
/*4a1020ff 00000ab0*/ v_add_i32       v8, vcc, 0xab0, v16
/*d8d80000 09000012*/ ds_read_b32     v9, v18
/*d8d80000 0a000010*/ ds_read_b32     v10, v16
/*d8d80000 07000007*/ ds_read_b32     v7, v7
/*d8d80000 08000008*/ ds_read_b32     v8, v8
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d104000c 00021509*/ v_cmp_eq_i32    s[12:13], v9, v10
/*7d041107         */ v_cmp_eq_i32    vcc, v7, v8
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*3416228a         */ v_lshlrev_b32   v11, 10, v17
/*361616ff 000ffc00*/ v_and_b32       v11, 0xffc00, v11
/*38161600         */ v_or_b32        v11, s0, v11
/*360a02ff 000003ff*/ v_and_b32       v5, 0x3ff, v1
/*87ea6a0c         */ s_and_b64       vcc, s[12:13], vcc
/*380a0b0b         */ v_or_b32        v5, v11, v5
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*3a121509         */ v_xor_b32       v9, v9, v10
/*bf880034         */ s_cbranch_execz .L1596_8
/*2c141298         */ v_lshrrev_b32   v10, 24, v9
/*2c161288         */ v_lshrrev_b32   v11, 8, v9
/*361414ff 000000f0*/ v_and_b32       v10, 0xf0, v10
/*b0030f0f         */ s_movk_i32      s3, 0xf0f
/*d294000a 042a1603*/ v_bfi_b32       v10, s3, v11, v10
/*2c161284         */ v_lshrrev_b32   v11, 4, v9
/*2c181481         */ v_lshrrev_b32   v12, 1, v10
/*4a1a24ff 00001560*/ v_add_i32       v13, vcc, 0x1560, v18
/*4a1c20ff 00001560*/ v_add_i32       v14, vcc, 0x1560, v16
/*36161690         */ v_and_b32       v11, 16, v11
/*38181801         */ v_or_b32        v12, s1, v12
/*321e1681         */ v_lshl_b32      v15, 1, v11
/*34181882         */ v_lshlrev_b32   v12, 2, v12
/*d8d80000 0d00000d*/ ds_read_b32     v13, v13
/*d8d80000 0e00000e*/ ds_read_b32     v14, v14

/*d8800000 0c000f0c*/ ds_add_rtn_u32  v12, v12, v15 gds

/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a16170c         */ v_lshr_b32      v11, v12, v11
/*361616ff 0000ffff*/ v_and_b32       v11, 0xffff, v11
/*b00302ab         */ s_movk_i32      s3, 0x2ab
/*7d8c1603         */ v_cmp_ge_u32    vcc, s3, v11
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf880015         */ s_cbranch_execz .L1596_8
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*d2d6000a 0000070a*/ v_mul_lo_i32    v10, v10, s3
/*4a14150b         */ v_add_i32       v10, vcc, v11, v10
/*34141484         */ v_lshlrev_b32   v10, 4, v10
/*4a141405         */ v_add_i32       v10, vcc, s5, v10
/*7d0a1480         */ v_cmp_lg_i32    vcc, 0, v10
/*be90246a         */ s_and_saveexec_b64 s[16:17], vcc
/*3a0e1107         */ v_xor_b32       v7, v7, v8
/*bf88000b         */ s_cbranch_execz .L1596_8
/*d29c0003 02221307*/ v_alignbit_b32  v3, v7, v9, 8
/*3a121d0d         */ v_xor_b32       v9, v13, v14
/*d29c0004 02220f09*/ v_alignbit_b32  v4, v9, v7, 8
/*7e1a0305         */ v_mov_b32       v13, v5
/*7e1c0302         */ v_mov_b32       v14, v2
/*7e160303         */ v_mov_b32       v11, v3
/*7e180304         */ v_mov_b32       v12, v4
/*ebf71000 80020b0a*/ tbuffer_store_format_xyzw v[11:14], v10, s[8:11], 0 offen format:[32_32_32_32,float]
.L1596_8:
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*8383ff02 00000100*/ s_min_u32       s3, s2, 0x100
/*80840302         */ s_sub_u32       s4, s2, s3
/*bf000302         */ s_cmp_eq_i32    s2, s3
/*bf850002         */ s_cbranch_scc1  .L1628_8
/*be820304         */ s_mov_b32       s2, s4
/*bf82ff89         */ s_branch        .L1152_8
.L1628_8:
/*bf810000         */ s_endpgm
.kernel kernel_round8
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 23 /* 22 */
        .vgprsnum 18
        .hwlocal 11096
        .floatmode 0xc0
        .uavid 11
        .uavprivate 0
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x00160098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg ht_dst, "char*", char*, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
        .arg rowCountersDst, "uint*", uint*, global, , 11, unused
        .arg debug, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c200051c         */ s_buffer_load_dword s0, s[4:7], 0x1c
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*8000000c         */ s_add_u32       s0, s12, s0
/*bf0bff00 00000fff*/ s_cmp_le_u32    s0, 0xfff
/*bf840171         */ s_cbranch_scc0  .L1520_9
/*b00600ff         */ s_movk_i32      s6, 0xff
/*7d8c0006         */ v_cmp_ge_u32    vcc, s6, v0
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880018         */ s_cbranch_execz .L160_9
/*4a0202ff 00002200*/ v_add_i32       v1, vcc, 0x2200, v1
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e040300         */ v_mov_b32       v2, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L96_9:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d8340000 00000301*/ ds_write_b32    v1, v3
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00c0100         */ s_movk_i32      s12, 0x100
/*7d88040c         */ v_cmp_gt_u32    vcc, s12, v2
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*8a8a7e0a         */ s_andn2_b64     s[10:11], s[10:11], exec
/*bf840002         */ s_cbranch_scc0  .L160_9
/*87fe0a0c         */ s_and_b64       exec, s[12:13], s[10:11]
/*bf82fff0         */ s_branch        .L96_9
.L160_9:
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*8f018c01         */ s_lshl_b32      s1, s1, 12
/*b00602ab         */ s_movk_i32      s6, 0x2ab
/*d1880006 00000d00*/ v_cmp_gt_u32    s[6:7], v0, s6
/*be88047e         */ s_mov_b64       s[8:9], exec
/*8afe0608         */ s_andn2_b64     exec, s[8:9], s[6:7]
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880036         */ s_cbranch_execz .L412_9
/*4a0202ff 00002600*/ v_add_i32       v1, vcc, 0x2600, v1
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*7e180300         */ v_mov_b32       v12, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L224_9:
/*7e0602ff 000002ac*/ v_mov_b32       v3, 0x2ac
/*d87c0000 00000301*/ ds_write_b16    v1, v3
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a1818ff 00000100*/ v_add_i32       v12, vcc, 0x100, v12
/*b00e02ac         */ s_movk_i32      s14, 0x2ac
/*7d88180e         */ v_cmp_gt_u32    vcc, s14, v12
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*8afe6a0e         */ s_andn2_b64     exec, s[14:15], vcc
/*8a8c7e0c         */ s_andn2_b64     s[12:13], s[12:13], exec
/*bf840002         */ s_cbranch_scc0  .L288_9
/*87fe0c0e         */ s_and_b64       exec, s[14:15], s[12:13]
/*bf82fff0         */ s_branch        .L224_9
.L288_9:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*d104000a 00010100*/ v_cmp_eq_i32    s[10:11], v0, 0
/*be8c240a         */ s_and_saveexec_b64 s[12:13], s[10:11]
/*bf880014         */ s_cbranch_execz .L388_9
/*900e8100         */ s_lshr_b32      s14, s0, 1
/*800e0e01         */ s_add_u32       s14, s1, s14
/*8f0e820e         */ s_lshl_b32      s14, s14, 2
/*7e02020e         */ v_mov_b32       v1, s14
/*4a0202ff 00002000*/ v_add_i32       v1, vcc, 0x2000, v1

/*d8d80000 01000001*/ ds_read_b32     v1, v1 gds

/*8f0e8400         */ s_lshl_b32      s14, s0, 4
/*870e900e         */ s_and_b32       s14, s14, 16
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c02020e         */ v_lshrrev_b32   v1, s14, v1
/*d2900001 02410101*/ v_bfe_u32       v1, v1, 0, 16
/*261602ff 000002ac*/ v_min_u32       v11, 0x2ac, v1
/*7e060280         */ v_mov_b32       v3, 0
/*d83421f0 00000b03*/ ds_write_b32    v3, v11 offset:8688
/*7e020281         */ v_mov_b32       v1, 1
.L388_9:
/*8afe7e0c         */ s_andn2_b64     exec, s[12:13], exec
/*7e020280         */ v_mov_b32       v1, 0
/*7e160280         */ v_mov_b32       v11, 0
/*befe040c         */ s_mov_b64       exec, s[12:13]
/*d200000d 00298280*/ v_cndmask_b32   v13, 0, -1, s[10:11]
.L412_9:
/*8afe7e08         */ s_andn2_b64     exec, s[8:9], exec
/*bf880004         */ s_cbranch_execz .L436_9
/*7e160280         */ v_mov_b32       v11, 0
/*7e1a0301         */ v_mov_b32       v13, v1
/*7e180301         */ v_mov_b32       v12, v1
/*7e020280         */ v_mov_b32       v1, 0
.L436_9:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0a0280         */ v_mov_b32       v5, 0
/*d8d821f0 05000005*/ ds_read_b32     v5, v5 offset:8688
/*d2920001 02050101*/ v_bfe_i32       v1, v1, 0, 1
/*7d0a0280         */ v_cmp_lg_i32    vcc, 0, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*000a1705         */ v_cndmask_b32   v5, v5, v11, vcc
/*bf8a0000         */ s_barrier
/*7d8a0280         */ v_cmp_lg_u32    vcc, 0, v1
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*7e020280         */ v_mov_b32       v1, 0
/*bf880004         */ s_cbranch_execz .L516_9
/*d83421f0 00000101*/ ds_write_b32    v1, v1 offset:8688
/*7e1602ff 000021f0*/ v_mov_b32       v11, 0x21f0
.L516_9:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*7d820b00         */ v_cmp_lt_u32    vcc, v0, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe6a08         */ s_and_b64       exec, s[8:9], vcc
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*bf880034         */ s_cbranch_execz .L752_9
/*4a020290         */ v_add_i32       v1, vcc, 16, v1
/*34040081         */ v_lshlrev_b32   v2, 1, v0
/*4a1604ff 00002600*/ v_add_i32       v11, vcc, 0x2600, v2
/*930aff00 000002ac*/ s_mul_i32       s10, s0, 0x2ac
/*4a06000a         */ v_add_i32       v3, vcc, s10, v0
/*34060684         */ v_lshlrev_b32   v3, 4, v3
/*4a1a0604         */ v_add_i32       v13, vcc, s4, v3
/*c0860360         */ s_load_dwordx4  s[12:15], s[2:3], 0x60
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e080300         */ v_mov_b32       v4, v0
.L592_9:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebd91000 8003060d*/ tbuffer_load_format_xy v[6:7], v13, s[12:15], 0 offen format:[32_32,float]
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000601*/ ds_write_b32    v1, v6
/*4a1002ff 00000ab0*/ v_add_i32       v8, vcc, 0xab0, v1
/*d8340000 00000708*/ ds_write_b32    v8, v7
/*d2900007 02112106*/ v_bfe_u32       v7, v6, 16, 4
/*2c0c0c88         */ v_lshrrev_b32   v6, 8, v6
/*360c0cff 000000f0*/ v_and_b32       v6, 0xf0, v6
/*380c0d07         */ v_or_b32        v6, v7, v6
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*4a0c0cff 00002200*/ v_add_i32       v6, vcc, 0x2200, v6
/*d8b40000 06000406*/ ds_wrxchg_rtn_b32 v6, v6, v4
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900006 02410106*/ v_bfe_u32       v6, v6, 0, 16
/*d87c0000 0000060b*/ ds_write_b16    v11, v6
/*4a1a1aff 00001000*/ v_add_i32       v13, vcc, 0x1000, v13
/*4a0202ff 00000400*/ v_add_i32       v1, vcc, 0x400, v1
/*4a1616ff 00000200*/ v_add_i32       v11, vcc, 0x200, v11
/*4a0808ff 00000100*/ v_add_i32       v4, vcc, 0x100, v4
/*7d880905         */ v_cmp_gt_u32    vcc, v5, v4
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffdb         */ s_cbranch_execnz .L592_9
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7e1802ff 00001000*/ v_mov_b32       v12, 0x1000
.L752_9:
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*87fe0608         */ s_and_b64       exec, s[8:9], s[6:7]
/*8afe7e08         */ s_andn2_b64     exec, s[8:9], exec
/*bf880041         */ s_cbranch_execz .L1032_9
/*be86047e         */ s_mov_b64       s[6:7], exec
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*7e020300         */ v_mov_b32       v1, v0
.L784_9:
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e060301         */ v_mov_b32       v3, v1
/*bf800000         */ s_nop           0x0
.L800_9:
/*34040681         */ v_lshlrev_b32   v2, 1, v3
/*4a0404ff 00002600*/ v_add_i32       v2, vcc, 0x2600, v2
/*b00402ab         */ s_movk_i32      s4, 0x2ab
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900003 02410102*/ v_bfe_u32       v3, v2, 0, 16
/*d1880010 00000903*/ v_cmp_gt_u32    s[16:17], v3, s4
/*be922410         */ s_and_saveexec_b64 s[18:19], s[16:17]
/*d200000b 00418280*/ v_cndmask_b32   v11, 0, -1, s[16:17]
/*bf880002         */ s_cbranch_execz .L868_9
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf84001e         */ s_cbranch_scc0  .L988_9
.L868_9:
/*87fe0e12         */ s_and_b64       exec, s[18:19], s[14:15]
/*7e040280         */ v_mov_b32       v2, 0
/*7e0a02c1         */ v_mov_b32       v5, -1
/*d88c21f0 0b000502*/ ds_inc_rtn_u32  v11, v2, v5 offset:8688
/*b0040318         */ s_movk_i32      s4, 0x318
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d1880010 0000090b*/ v_cmp_gt_u32    s[16:17], v11, s4
/*be922410         */ s_and_saveexec_b64 s[18:19], s[16:17]
/*d200000d 00418280*/ v_cndmask_b32   v13, 0, -1, s[16:17]
/*bf880002         */ s_cbranch_execz .L928_9
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf84000f         */ s_cbranch_scc0  .L988_9
.L928_9:
/*87fe0e12         */ s_and_b64       exec, s[18:19], s[14:15]
/*34041681         */ v_lshlrev_b32   v2, 1, v11
/*4a0a04ff 00001570*/ v_add_i32       v5, vcc, 0x1570, v2
/*d2900006 02410101*/ v_bfe_u32       v6, v1, 0, 16
/*d87c0000 00000605*/ ds_write_b16    v5, v6
/*4a1604ff 00001bb0*/ v_add_i32       v11, vcc, 0x1bb0, v2
/*d87c0000 0000030b*/ ds_write_b16    v11, v3
/*7e1a02ff 00001bb0*/ v_mov_b32       v13, 0x1bb0
/*bf82ffd1         */ s_branch        .L800_9
.L988_9:
/*befe040c         */ s_mov_b64       exec, s[12:13]
/*4a0202ff 00000100*/ v_add_i32       v1, vcc, 0x100, v1
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*7d880204         */ v_cmp_gt_u32    vcc, s4, v1
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*8a8a7e0a         */ s_andn2_b64     s[10:11], s[10:11], exec
/*bf840002         */ s_cbranch_scc0  .L1032_9
/*87fe0a0c         */ s_and_b64       exec, s[12:13], s[10:11]
/*bf82ffc2         */ s_branch        .L784_9
.L1032_9:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e080280         */ v_mov_b32       v4, 0
/*d8d821f0 04000004*/ ds_read_b32     v4, v4 offset:8688
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*260808ff 00000319*/ v_min_u32       v4, 0x319, v4
/*7e0a0280         */ v_mov_b32       v5, 0
/*7d0a0b04         */ v_cmp_lg_i32    vcc, v4, v5
/*bf86006e         */ s_cbranch_vccz  .L1520_9
/*8f009400         */ s_lshl_b32      s0, s0, 20
/*7e0a6f00         */ v_not_b32       v5, v0
/*c0840368         */ s_load_dwordx4  s[8:11], s[2:3], 0x68
/*7e040504         */ v_readfirstlane_b32 s2, v4
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L1120_9:
/*7d880002         */ v_cmp_gt_u32    vcc, s2, v0
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*4a020a02         */ v_add_i32       v1, vcc, s2, v5
/*bf880012         */ s_cbranch_execz .L1208_9
/*34020281         */ v_lshlrev_b32   v1, 1, v1
/*4a0402ff 00001bb0*/ v_add_i32       v2, vcc, 0x1bb0, v1
/*4a0202ff 00001570*/ v_add_i32       v1, vcc, 0x1570, v1
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*d8f00000 01000001*/ ds_read_u16     v1, v1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*361604ff 0000ffff*/ v_and_b32       v11, 0xffff, v2
/*360202ff 0000ffff*/ v_and_b32       v1, 0xffff, v1
/*34061682         */ v_lshlrev_b32   v3, 2, v11
/*34080282         */ v_lshlrev_b32   v4, 2, v1
/*4a1a0690         */ v_add_i32       v13, vcc, 16, v3
/*4a180890         */ v_add_i32       v12, vcc, 16, v4
.L1208_9:
/*8afe7e06         */ s_andn2_b64     exec, s[6:7], exec
/*7e0202ff 000002ac*/ v_mov_b32       v1, 0x2ac
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*7d880203         */ v_cmp_gt_u32    vcc, s3, v1
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*4a0c18ff 00000ab0*/ v_add_i32       v6, vcc, 0xab0, v12
/*bf88003c         */ s_cbranch_execz .L1488_9
/*4a0e1aff 00000ab0*/ v_add_i32       v7, vcc, 0xab0, v13
/*d8d80000 06000006*/ ds_read_b32     v6, v6
/*d8d80000 07000007*/ ds_read_b32     v7, v7
/*d8d80000 0800000c*/ ds_read_b32     v8, v12
/*d8d80000 0900000d*/ ds_read_b32     v9, v13
/*bf8c000f         */ s_waitcnt       expcnt(0) & lgkmcnt(0)
/*3a1c0f06         */ v_xor_b32       v14, v6, v7
/*3a101308         */ v_xor_b32       v8, v8, v9
/*d29c0008 0262110e*/ v_alignbit_b32  v8, v14, v8, 24
/*d104000c 00010108*/ v_cmp_eq_i32    s[12:13], v8, 0
/*7d040f06         */ v_cmp_eq_i32    vcc, v6, v7
/*87ea6a0c         */ s_and_b64       vcc, s[12:13], vcc
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*8afe6a0c         */ s_andn2_b64     exec, s[12:13], vcc
/*360c10ff 00000fff*/ v_and_b32       v6, 0xfff, v8
/*bf880024         */ s_cbranch_execz .L1488_9
/*340e1084         */ v_lshlrev_b32   v7, 4, v8
/*360e0e90         */ v_and_b32       v7, 16, v7
/*32100e81         */ v_lshl_b32      v8, 1, v7
/*2c120c81         */ v_lshrrev_b32   v9, 1, v6
/*38121201         */ v_or_b32        v9, s1, v9
/*34121282         */ v_lshlrev_b32   v9, 2, v9

/*d8800000 08000809*/ ds_add_rtn_u32  v8, v9, v8 gds

/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a0e0f08         */ v_lshr_b32      v7, v8, v7
/*360e0eff 0000ffff*/ v_and_b32       v7, 0xffff, v7
/*b00302ab         */ s_movk_i32      s3, 0x2ab
/*7d8c0e03         */ v_cmp_ge_u32    vcc, s3, v7
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*bf880014         */ s_cbranch_execz .L1488_9
/*b00302ac         */ s_movk_i32      s3, 0x2ac
/*d2d60006 00000706*/ v_mul_lo_i32    v6, v6, s3
/*4a0c0d07         */ v_add_i32       v6, vcc, v7, v6
/*340c0c84         */ v_lshlrev_b32   v6, 4, v6
/*4a0c0c05         */ v_add_i32       v6, vcc, s5, v6
/*7d0a0c80         */ v_cmp_lg_i32    vcc, 0, v6
/*be90246a         */ s_and_saveexec_b64 s[16:17], vcc
/*340e168a         */ v_lshlrev_b32   v7, 10, v11
/*bf88000a         */ s_cbranch_execz .L1488_9
/*360e0eff 000ffc00*/ v_and_b32       v7, 0xffc00, v7
/*380e0e00         */ v_or_b32        v7, s0, v7
/*360802ff 000003ff*/ v_and_b32       v4, 0x3ff, v1
/*381e0907         */ v_or_b32        v15, v7, v4
/*7e200280         */ v_mov_b32       v16, 0
/*7e220280         */ v_mov_b32       v17, 0
/*ebf71000 80020e06*/ tbuffer_store_format_xyzw v[14:17], v6, s[8:11], 0 offen format:[32_32_32_32,float]
.L1488_9:
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*8383ff02 00000100*/ s_min_u32       s3, s2, 0x100
/*80840302         */ s_sub_u32       s4, s2, s3
/*bf000302         */ s_cmp_eq_i32    s2, s3
/*bf850002         */ s_cbranch_scc1  .L1520_9
/*be820304         */ s_mov_b32       s2, s4
/*bf82ff9c         */ s_branch        .L1120_9
.L1520_9:
/*bf810000         */ s_endpgm
.kernel kernel_potential_sols
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 21/*20*/
        .vgprsnum 10
        .hwlocal 7892
        .floatmode 0xc0
        .uavid 11
        .uavprivate 0
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x000f8098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg device_thread, "uint", uint
        .arg ht_src, "char*", char*, global, const, 12
        .arg potential_sols, "potential_sols_t*", structure*, 65536, global, , 13
        .arg rowCountersSrc, "uint*", uint*, global, , 11, unused
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c2000518         */ s_buffer_load_dword s0, s[4:7], 0x18
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2020904         */ s_buffer_load_dword s4, s[8:11], 0x4
/*c2028908         */ s_buffer_load_dword s5, s[8:11], 0x8
/*8f06880c         */ s_lshl_b32      s6, s12, 8
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*80000006         */ s_add_u32       s0, s6, s0
/*4a120000         */ v_add_i32       v9, vcc, s0, v0
/*7d041280         */ v_cmp_eq_i32    vcc, 0, v9
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*bf880006         */ s_cbranch_execz .L76_10
/*c0840368         */ s_load_dwordx4  s[8:11], s[2:3], 0x68
/*7e040205         */ v_mov_b32       v2, s5
/*7e060280         */ v_mov_b32       v3, 0
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*eba41000 80020302*/ tbuffer_store_format_x v3, v2, s[8:11], 0 offen format:[32,float]
.L76_10:
/*befe0406         */ s_mov_b64       exec, s[6:7]
/*bf8c0f00         */ s_waitcnt       vmcnt(0) & expcnt(0)
/*bf8a0000         */ s_barrier
/*2c041288         */ v_lshrrev_b32   v2, 8, v9
/*b0000fff         */ s_movk_i32      s0, 0xfff
/*7d8c0400         */ v_cmp_ge_u32    vcc, s0, v2
/*be86246a         */ s_and_saveexec_b64 s[6:7], vcc
/*bf88010b         */ s_cbranch_execz .L1176_10
/*b00000ff         */ s_movk_i32      s0, 0xff
/*d1880008 00000100*/ v_cmp_gt_u32    s[8:9], v0, s0
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*8afe080a         */ s_andn2_b64     exec, s[10:11], s[8:9]
/*34060082         */ v_lshlrev_b32   v3, 2, v0
/*bf880017         */ s_cbranch_execz .L228_10
/*4a0606ff 00001570*/ v_add_i32       v3, vcc, 0x1570, v3
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e080300         */ v_mov_b32       v4, v0
/*bf800000         */ s_nop           0x0
.L160_10:
/*7e0a02ff 000002ac*/ v_mov_b32       v5, 0x2ac
/*d8340000 00000503*/ ds_write_b32    v3, v5
/*4a0606ff 00000400*/ v_add_i32       v3, vcc, 0x400, v3
/*4a0808ff 00000100*/ v_add_i32       v4, vcc, 0x100, v4
/*b0000100         */ s_movk_i32      s0, 0x100
/*7d880800         */ v_cmp_gt_u32    vcc, s0, v4
/*be90047e         */ s_mov_b64       s[16:17], exec
/*8afe6a10         */ s_andn2_b64     exec, s[16:17], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L224_10
/*87fe0e10         */ s_and_b64       exec, s[16:17], s[14:15]
/*bf82fff0         */ s_branch        .L160_10
.L224_10:
/*befe040c         */ s_mov_b64       exec, s[12:13]
.L228_10:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*d2000003 00218280*/ v_cndmask_b32   v3, 0, -1, s[8:9]
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*b00002ab         */ s_movk_i32      s0, 0x2ab
/*d1880008 00000100*/ v_cmp_gt_u32    s[8:9], v0, s0
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*8afe080a         */ s_andn2_b64     exec, s[10:11], s[8:9]
/*bf880038         */ s_cbranch_execz .L492_10
/*8f008c01         */ s_lshl_b32      s0, s1, 12
/*34060081         */ v_lshlrev_b32   v3, 1, v0
/*4a0606ff 00001970*/ v_add_i32       v3, vcc, 0x1970, v3
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e080300         */ v_mov_b32       v4, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L320_10:
/*7e0a02ff 000002ac*/ v_mov_b32       v5, 0x2ac
/*d87c0000 00000503*/ ds_write_b16    v3, v5
/*4a0606ff 00000200*/ v_add_i32       v3, vcc, 0x200, v3
/*4a0808ff 00000100*/ v_add_i32       v4, vcc, 0x100, v4
/*b00102ac         */ s_movk_i32      s1, 0x2ac
/*7d880801         */ v_cmp_gt_u32    vcc, s1, v4
/*be90047e         */ s_mov_b64       s[16:17], exec
/*8afe6a10         */ s_andn2_b64     exec, s[16:17], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L384_10
/*87fe0e10         */ s_and_b64       exec, s[16:17], s[14:15]
/*bf82fff0         */ s_branch        .L320_10
.L384_10:
/*befe040c         */ s_mov_b64       exec, s[12:13]
/*7d040080         */ v_cmp_eq_i32    vcc, 0, v0
/*be8c246a         */ s_and_saveexec_b64 s[12:13], vcc
/*2c061289         */ v_lshrrev_b32   v3, 9, v9
/*bf880010         */ s_cbranch_execz .L468_10
/*4a060600         */ v_add_i32       v3, vcc, s0, v3
/*34060682         */ v_lshlrev_b32   v3, 2, v3

/*d8d80000 03000003*/ ds_read_b32     v3, v3 gds

/*2c081284         */ v_lshrrev_b32   v4, 4, v9
/*36080890         */ v_and_b32       v4, 16, v4
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2a060903         */ v_lshr_b32      v3, v3, v4
/*d2900003 02410103*/ v_bfe_u32       v3, v3, 0, 16
/*260606ff 000002ac*/ v_min_u32       v3, 0x2ac, v3
/*7e080280         */ v_mov_b32       v4, 0
/*d8341ed0 00000304*/ ds_write_b32    v4, v3 offset:7888
/*7e080281         */ v_mov_b32       v4, 1
.L468_10:
/*8afe7e0c         */ s_andn2_b64     exec, s[12:13], exec
/*7e060200         */ v_mov_b32       v3, s0
/*7e080280         */ v_mov_b32       v4, 0
/*befe040c         */ s_mov_b64       exec, s[12:13]
/*7e0202ff 00000200*/ v_mov_b32       v1, 0x200
.L492_10:
/*8afe7e0a         */ s_andn2_b64     exec, s[10:11], exec
/*d2000001 00218280*/ v_cndmask_b32   v1, 0, -1, s[8:9]
/*7e080280         */ v_mov_b32       v4, 0
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0c0280         */ v_mov_b32       v6, 0
/*d8d81ed0 06000006*/ ds_read_b32     v6, v6 offset:7888
/*d2920004 02050104*/ v_bfe_i32       v4, v4, 0, 1
/*7d0a0880         */ v_cmp_lg_i32    vcc, 0, v4
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*00060706         */ v_cndmask_b32   v3, v6, v3, vcc
/*7d820700         */ v_cmp_lt_u32    vcc, v0, v3
/*bf8a0000         */ s_barrier
/*be80246a         */ s_and_saveexec_b64 s[0:1], vcc
/*34020081         */ v_lshlrev_b32   v1, 1, v0
/*bf880034         */ s_cbranch_execz .L780_10
/*4a0202ff 00001970*/ v_add_i32       v1, vcc, 0x1970, v1
/*b00802ac         */ s_movk_i32      s8, 0x2ac
/*d2d60002 00001102*/ v_mul_lo_i32    v2, v2, s8
/*4a040500         */ v_add_i32       v2, vcc, v0, v2
/*34040484         */ v_lshlrev_b32   v2, 4, v2
/*4a120404         */ v_add_i32       v9, vcc, s4, v2
/*34080082         */ v_lshlrev_b32   v4, 2, v0
/*c0840360         */ s_load_dwordx4  s[8:11], s[2:3], 0x60
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*7e0a0300         */ v_mov_b32       v5, v0
.L620_10:
/*4a0c0890         */ v_add_i32       v6, vcc, 16, v4
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*ebd91000 80020709*/ tbuffer_load_format_xy v[7:8], v9, s[8:11], 0 offen format:[32_32,float]
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000806*/ ds_write_b32    v6, v8
/*4a0c08ff 00000ac0*/ v_add_i32       v6, vcc, 0xac0, v4
/*d8340000 00000706*/ ds_write_b32    v6, v7
/*360c0eff 000000f0*/ v_and_b32       v6, 0xf0, v7
/*d2900007 02111907*/ v_bfe_u32       v7, v7, 12, 4
/*380c0f06         */ v_or_b32        v6, v6, v7
/*340c0c82         */ v_lshlrev_b32   v6, 2, v6
/*4a0c0cff 00001570*/ v_add_i32       v6, vcc, 0x1570, v6
/*d8b40000 06000506*/ ds_wrxchg_rtn_b32 v6, v6, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d2900006 02410106*/ v_bfe_u32       v6, v6, 0, 16
/*d87c0000 00000601*/ ds_write_b16    v1, v6
/*4a1212ff 00001000*/ v_add_i32       v9, vcc, 0x1000, v9
/*4a0202ff 00000200*/ v_add_i32       v1, vcc, 0x200, v1
/*4a0808ff 00000400*/ v_add_i32       v4, vcc, 0x400, v4
/*4a0a0aff 00000100*/ v_add_i32       v5, vcc, 0x100, v5
/*7d880b03         */ v_cmp_gt_u32    vcc, v3, v5
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffdb         */ s_cbranch_execnz .L620_10
/*befe040c         */ s_mov_b64       exec, s[12:13]
/*7e0202ff 00000200*/ v_mov_b32       v1, 0x200
.L780_10:
/*befe0400         */ s_mov_b64       exec, s[0:1]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*be80047e         */ s_mov_b64       s[0:1], exec
/*be88047e         */ s_mov_b64       s[8:9], exec
/*7e0c0304         */ v_mov_b32       v6, v4
/*7e080280         */ v_mov_b32       v4, 0
.L808_10:
/*34120082         */ v_lshlrev_b32   v9, 2, v0
/*d18c000a 00020700*/ v_cmp_ge_u32    s[10:11], v0, v3
/*be8c240a         */ s_and_saveexec_b64 s[12:13], s[10:11]
/*d2000009 00298280*/ v_cndmask_b32   v9, 0, -1, s[10:11]
/*bf880003         */ s_cbranch_execz .L848_10
/*7e0c0280         */ v_mov_b32       v6, 0
/*8a887e08         */ s_andn2_b64     s[8:9], s[8:9], exec
/*bf840039         */ s_cbranch_scc0  .L1076_10
.L848_10:
/*87fe080c         */ s_and_b64       exec, s[12:13], s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*4a0a12ff 00000ac0*/ v_add_i32       v5, vcc, 0xac0, v9
/*d8d80000 05000005*/ ds_read_b32     v5, v5
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8c047e         */ s_mov_b64       s[12:13], exec
/*7e040300         */ v_mov_b32       v2, v0
/*7e0c0280         */ v_mov_b32       v6, 0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L896_10:
/*34040481         */ v_lshlrev_b32   v2, 1, v2
/*4a0404ff 00001970*/ v_add_i32       v2, vcc, 0x1970, v2
/*b00402ac         */ s_movk_i32      s4, 0x2ac
/*d8f00000 02000002*/ ds_read_u16     v2, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*360404ff 0000ffff*/ v_and_b32       v2, 0xffff, v2
/*34020482         */ v_lshlrev_b32   v1, 2, v2
/*d182000e 00000902*/ v_cmp_lt_u32    s[14:15], v2, s4
/*be90047e         */ s_mov_b64       s[16:17], exec
/*8afe0e10         */ s_andn2_b64     exec, s[16:17], s[14:15]
/*d2000001 00398280*/ v_cndmask_b32   v1, 0, -1, s[14:15]
/*bf880002         */ s_cbranch_execz .L972_10
/*8a8c7e0c         */ s_andn2_b64     s[12:13], s[12:13], exec
/*bf840011         */ s_cbranch_scc0  .L1040_10
.L972_10:
/*87fe0c10         */ s_and_b64       exec, s[16:17], s[12:13]
/*4a0e02ff 00000ac0*/ v_add_i32       v7, vcc, 0xac0, v1
/*d8d80000 07000007*/ ds_read_b32     v7, v7
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*7d0a0f05         */ v_cmp_lg_i32    vcc, v5, v7
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*8afe6a0e         */ s_andn2_b64     exec, s[14:15], vcc
/*7e080281         */ v_mov_b32       v4, 1
/*bf880003         */ s_cbranch_execz .L1028_10
/*7e0c0281         */ v_mov_b32       v6, 1
/*8a8c7e0c         */ s_andn2_b64     s[12:13], s[12:13], exec
/*bf840003         */ s_cbranch_scc0  .L1040_10
.L1028_10:
/*87fe0c0e         */ s_and_b64       exec, s[14:15], s[12:13]
/*7e0c0281         */ v_mov_b32       v6, 1
/*bf82ffdc         */ s_branch        .L896_10
.L1040_10:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*7d8a0880         */ v_cmp_lg_u32    vcc, 0, v4
/*be8a246a         */ s_and_saveexec_b64 s[10:11], vcc
/*8a887e08         */ s_andn2_b64     s[8:9], s[8:9], exec
/*bf840004         */ s_cbranch_scc0  .L1076_10
/*87fe080a         */ s_and_b64       exec, s[10:11], s[8:9]
/*4a0000ff 00000100*/ v_add_i32       v0, vcc, 0x100, v0
/*bf82ffbd         */ s_branch        .L808_10
.L1076_10:
/*befe0400         */ s_mov_b64       exec, s[0:1]
/*7d0a0c80         */ v_cmp_lg_i32    vcc, 0, v6
/*be80246a         */ s_and_saveexec_b64 s[0:1], vcc
/*bf880015         */ s_cbranch_execz .L1176_10
/*c0840368         */ s_load_dwordx4  s[8:11], s[2:3], 0x68
/*4a020290         */ v_add_i32       v1, vcc, 16, v1
/*4a001290         */ v_add_i32       v0, vcc, 16, v9
/*7e040205         */ v_mov_b32       v2, s5
/*7e0602c1         */ v_mov_b32       v3, -1
/*b0020fff         */ s_movk_i32      s2, 0xfff
/*d8d80000 01000001*/ ds_read_b32     v1, v1
/*d8d80000 00000000*/ ds_read_b32     v0, v0
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*e0f05000 80020302*/ buffer_atomic_inc v3, v2, s[8:11], 0 offen glc
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*7d8c0602         */ v_cmp_ge_u32    vcc, s2, v3
/*be82246a         */ s_and_saveexec_b64 s[2:3], vcc
/*34040683         */ v_lshlrev_b32   v2, 3, v3
/*bf880003         */ s_cbranch_execz .L1176_10
/*4a040405         */ v_add_i32       v2, vcc, s5, v2
/*ebdd1004 80020002*/ tbuffer_store_format_xy v[0:1], v2, s[8:11], 0 offen offset:4 format:[32_32,float]
.L1176_10:
/*bf810000         */ s_endpgm
.kernel kernel_sols
    .config
        .dims x
        .cws 256, 1, 1
        .sgprsnum 28
        .vgprsnum 13
        .hwlocal 3092
        .floatmode 0xc0
        .uavid 0
        .uavprivate 48
        .printfid 9
        .privateid 8
        .cbid 10
        .earlyexit 0
        .condout 0
        .pgmrsrc2 0x00068098
        .userdata ptr_uav_table, 0, 2, 2
        .userdata imm_const_buffer, 0, 4, 4
        .userdata imm_const_buffer, 1, 8, 4
        .arg ht0, "char*", char*, global, , 11
        .arg ht1, "char*", char*, global, , 11
        .arg sols, "sols_t*", structure*, 32768, global, , 12
        .arg rowCountersSrc, "uint*", uint*, global, , 11
        .arg rowCountersDst, "uint*", uint*, global, , 11
        .arg ht2, "char*", char*, global, , 11
        .arg ht3, "char*", char*, global, , 11
        .arg ht4, "char*", char*, global, , 11
        .arg ht5, "char*", char*, global, , 11
        .arg ht6, "char*", char*, global, , 11
        .arg ht7, "char*", char*, global, , 11
        .arg ht8, "char*", char*, global, , 11
        .arg potential_sols, "potential_sols_t*", structure*, 65536, global, const, 13
    .text
/*befc03ff 00008000*/ s_mov_b32       m0, 0xffff
/*c2000930         */ s_buffer_load_dword s0, s[8:11], 0x30
/*c0880368         */ s_load_dwordx4  s[16:19], s[2:3], 0x68
/*c2008518         */ s_buffer_load_dword s1, s[4:7], 0x18
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*c2021000         */ s_buffer_load_dword s4, s[16:19], s0
/*8f05880c         */ s_lshl_b32      s5, s12, 8
/*80010105         */ s_add_u32       s1, s5, s1
/*4a020001         */ v_add_i32       v1, vcc, s1, v0
/*2c020288         */ v_lshrrev_b32   v1, 8, v1
/*b0011000         */ s_movk_i32      s1, 0x1000
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d1880004 00020204*/ v_cmp_gt_u32    s[4:5], s4, v1
/*d1820006 00000301*/ v_cmp_lt_u32    s[6:7], v1, s1
/*c2008900         */ s_buffer_load_dword s1, s[8:11], 0x0
/*c2060904         */ s_buffer_load_dword s12, s[8:11], 0x4
/*c2068908         */ s_buffer_load_dword s13, s[8:11], 0x8
/*c2070914         */ s_buffer_load_dword s14, s[8:11], 0x14
/*c2078918         */ s_buffer_load_dword s15, s[8:11], 0x18
/*c20a091c         */ s_buffer_load_dword s20, s[8:11], 0x1c
/*c20a8920         */ s_buffer_load_dword s21, s[8:11], 0x20
/*c20b0924         */ s_buffer_load_dword s22, s[8:11], 0x24
/*c2040928         */ s_buffer_load_dword s8, s[8:11], 0x28
/*87ea0604         */ s_and_b64       vcc, s[4:5], s[6:7]
/*be84246a         */ s_and_saveexec_b64 s[4:5], vcc
/*bf880219         */ s_cbranch_execz .L2264_11
/*d1040006 00010100*/ v_cmp_eq_i32    s[6:7], v0, 0
/*be8a2406         */ s_and_saveexec_b64 s[10:11], s[6:7]
/*34020283         */ v_lshlrev_b32   v1, 3, v1
/*bf88000c         */ s_cbranch_execz .L184_11
/*4a020200         */ v_add_i32       v1, vcc, s0, v1
/*eba01004 80040201*/ tbuffer_load_format_x v2, v1, s[16:19], 0 offen offset:4 format:[32,float]
/*eba01008 80040101*/ tbuffer_load_format_x v1, v1, s[16:19], 0 offen offset:8 format:[32,float]
/*7e060280         */ v_mov_b32       v3, 0
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d83c000c 00020303*/ ds_write2st64_b32 v3, v3, v2 offset0:12
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340004 00000103*/ ds_write_b32    v3, v1 offset:4
.L184_11:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*34020082         */ v_lshlrev_b32   v1, 2, v0
/*4a0402ff 00000800*/ v_add_i32       v2, vcc, 0x800, v1
/*34060083         */ v_lshlrev_b32   v3, 3, v0
/*4a180684         */ v_add_i32       v12, vcc, 4, v3
/*4a1606ff 00000804*/ v_add_i32       v11, vcc, 0x804, v3
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7d880082         */ v_cmp_gt_u32    vcc, 2, v0
/*be8a246a         */ s_and_saveexec_b64 s[10:11], vcc
/*bf88002a         */ s_cbranch_execz .L404_11
/*c0880358         */ s_load_dwordx4  s[16:19], s[2:3], 0x58
/*be98047e         */ s_mov_b64       s[24:25], exec
/*7e0a0301         */ v_mov_b32       v5, v1
/*7e0c030b         */ v_mov_b32       v6, v11
/*7e0e0300         */ v_mov_b32       v7, v0
.L256_11:
/*d8d80000 08000005*/ ds_read_b32     v8, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c121094         */ v_lshrrev_b32   v9, 20, v8
/*b00002ac         */ s_movk_i32      s0, 0x2ac
/*d290000a 02291508*/ v_bfe_u32       v10, v8, 10, 10
/*d2d60009 00000109*/ v_mul_lo_i32    v9, v9, s0
/*4a14130a         */ v_add_i32       v10, vcc, v10, v9
/*361010ff 000003ff*/ v_and_b32       v8, 0x3ff, v8
/*34141484         */ v_lshlrev_b32   v10, 4, v10
/*4a101109         */ v_add_i32       v8, vcc, v9, v8
/*4a121408         */ v_add_i32       v9, vcc, s8, v10
/*34101084         */ v_lshlrev_b32   v8, 4, v8
/*4a101008         */ v_add_i32       v8, vcc, s8, v8
/*eba01008 80040909*/ tbuffer_load_format_x v9, v9, s[16:19], 0 offen offset:8 format:[32,float]
/*eba01008 80040808*/ tbuffer_load_format_x v8, v8, s[16:19], 0 offen offset:8 format:[32,float]
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 00000906*/ ds_write_b32    v6, v9
/*4a120cc4         */ v_add_i32       v9, vcc, -4, v6
/*4a0e0eff 00000100*/ v_add_i32       v7, vcc, 0x100, v7
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000809*/ ds_write_b32    v9, v8
/*4a0a0aff 00000400*/ v_add_i32       v5, vcc, 0x400, v5
/*4a0c0cff 00000800*/ v_add_i32       v6, vcc, 0x800, v6
/*7d880e82         */ v_cmp_gt_u32    vcc, 2, v7
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffdb         */ s_cbranch_execnz .L256_11
.L404_11:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7d880084         */ v_cmp_gt_u32    vcc, 4, v0
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*bf88002a         */ s_cbranch_execz .L596_11
/*c0880358         */ s_load_dwordx4  s[16:19], s[2:3], 0x58
/*be88047e         */ s_mov_b64       s[8:9], exec
/*7e0a0302         */ v_mov_b32       v5, v2
/*7e0c030c         */ v_mov_b32       v6, v12
/*7e0e0300         */ v_mov_b32       v7, v0
.L448_11:
/*d8d80000 08000005*/ ds_read_b32     v8, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c121094         */ v_lshrrev_b32   v9, 20, v8
/*b00002ac         */ s_movk_i32      s0, 0x2ac
/*d290000a 02291508*/ v_bfe_u32       v10, v8, 10, 10
/*d2d60009 00000109*/ v_mul_lo_i32    v9, v9, s0
/*4a14130a         */ v_add_i32       v10, vcc, v10, v9
/*361010ff 000003ff*/ v_and_b32       v8, 0x3ff, v8
/*34141484         */ v_lshlrev_b32   v10, 4, v10
/*4a101109         */ v_add_i32       v8, vcc, v9, v8
/*4a121416         */ v_add_i32       v9, vcc, s22, v10
/*34101084         */ v_lshlrev_b32   v8, 4, v8
/*4a101016         */ v_add_i32       v8, vcc, s22, v8
/*eba0100c 80040909*/ tbuffer_load_format_x v9, v9, s[16:19], 0 offen offset:12 format:[32,float]
/*eba0100c 80040808*/ tbuffer_load_format_x v8, v8, s[16:19], 0 offen offset:12 format:[32,float]
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 00000906*/ ds_write_b32    v6, v9
/*4a120cc4         */ v_add_i32       v9, vcc, -4, v6
/*4a0e0eff 00000100*/ v_add_i32       v7, vcc, 0x100, v7
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000809*/ ds_write_b32    v9, v8
/*4a0a0aff 00000400*/ v_add_i32       v5, vcc, 0x400, v5
/*4a0c0cff 00000800*/ v_add_i32       v6, vcc, 0x800, v6
/*7d880e84         */ v_cmp_gt_u32    vcc, 4, v7
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffdb         */ s_cbranch_execnz .L448_11
.L596_11:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7d880088         */ v_cmp_gt_u32    vcc, 8, v0
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*bf88002a         */ s_cbranch_execz .L788_11
/*c0880358         */ s_load_dwordx4  s[16:19], s[2:3], 0x58
/*be88047e         */ s_mov_b64       s[8:9], exec
/*7e0a0301         */ v_mov_b32       v5, v1
/*7e0c030b         */ v_mov_b32       v6, v11
/*7e0e0300         */ v_mov_b32       v7, v0
.L640_11:
/*d8d80000 08000005*/ ds_read_b32     v8, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c121094         */ v_lshrrev_b32   v9, 20, v8
/*b00002ac         */ s_movk_i32      s0, 0x2ac
/*d290000a 02291508*/ v_bfe_u32       v10, v8, 10, 10
/*d2d60009 00000109*/ v_mul_lo_i32    v9, v9, s0
/*4a14130a         */ v_add_i32       v10, vcc, v10, v9
/*361010ff 000003ff*/ v_and_b32       v8, 0x3ff, v8
/*34141485         */ v_lshlrev_b32   v10, 5, v10
/*4a101109         */ v_add_i32       v8, vcc, v9, v8
/*4a121415         */ v_add_i32       v9, vcc, s21, v10
/*34101085         */ v_lshlrev_b32   v8, 5, v8
/*4a101015         */ v_add_i32       v8, vcc, s21, v8
/*eba01010 80040909*/ tbuffer_load_format_x v9, v9, s[16:19], 0 offen offset:16 format:[32,float]
/*eba01010 80040808*/ tbuffer_load_format_x v8, v8, s[16:19], 0 offen offset:16 format:[32,float]
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 00000906*/ ds_write_b32    v6, v9
/*4a120cc4         */ v_add_i32       v9, vcc, -4, v6
/*4a0e0eff 00000100*/ v_add_i32       v7, vcc, 0x100, v7
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000809*/ ds_write_b32    v9, v8
/*4a0a0aff 00000400*/ v_add_i32       v5, vcc, 0x400, v5
/*4a0c0cff 00000800*/ v_add_i32       v6, vcc, 0x800, v6
/*7d880e88         */ v_cmp_gt_u32    vcc, 8, v7
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffdb         */ s_cbranch_execnz .L640_11
.L788_11:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7d880090         */ v_cmp_gt_u32    vcc, 16, v0
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*bf88002a         */ s_cbranch_execz .L980_11
/*c0880358         */ s_load_dwordx4  s[16:19], s[2:3], 0x58
/*be88047e         */ s_mov_b64       s[8:9], exec
/*7e0a0302         */ v_mov_b32       v5, v2
/*7e0c030c         */ v_mov_b32       v6, v12
/*7e0e0300         */ v_mov_b32       v7, v0
.L832_11:
/*d8d80000 08000005*/ ds_read_b32     v8, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c121094         */ v_lshrrev_b32   v9, 20, v8
/*b00002ac         */ s_movk_i32      s0, 0x2ac
/*d290000a 02291508*/ v_bfe_u32       v10, v8, 10, 10
/*d2d60009 00000109*/ v_mul_lo_i32    v9, v9, s0
/*4a14130a         */ v_add_i32       v10, vcc, v10, v9
/*361010ff 000003ff*/ v_and_b32       v8, 0x3ff, v8
/*34141485         */ v_lshlrev_b32   v10, 5, v10
/*4a101109         */ v_add_i32       v8, vcc, v9, v8
/*4a121414         */ v_add_i32       v9, vcc, s20, v10
/*34101085         */ v_lshlrev_b32   v8, 5, v8
/*4a101014         */ v_add_i32       v8, vcc, s20, v8
/*eba01010 80040909*/ tbuffer_load_format_x v9, v9, s[16:19], 0 offen offset:16 format:[32,float]
/*eba01010 80040808*/ tbuffer_load_format_x v8, v8, s[16:19], 0 offen offset:16 format:[32,float]
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 00000906*/ ds_write_b32    v6, v9
/*4a120cc4         */ v_add_i32       v9, vcc, -4, v6
/*4a0e0eff 00000100*/ v_add_i32       v7, vcc, 0x100, v7
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000809*/ ds_write_b32    v9, v8
/*4a0a0aff 00000400*/ v_add_i32       v5, vcc, 0x400, v5
/*4a0c0cff 00000800*/ v_add_i32       v6, vcc, 0x800, v6
/*7d880e90         */ v_cmp_gt_u32    vcc, 16, v7
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffdb         */ s_cbranch_execnz .L832_11
.L980_11:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7d8800a0         */ v_cmp_gt_u32    vcc, 32, v0
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*bf88002a         */ s_cbranch_execz .L1172_11
/*c0880358         */ s_load_dwordx4  s[16:19], s[2:3], 0x58
/*be88047e         */ s_mov_b64       s[8:9], exec
/*7e0a0301         */ v_mov_b32       v5, v1
/*7e0c030b         */ v_mov_b32       v6, v11
/*7e0e0300         */ v_mov_b32       v7, v0
.L1024_11:
/*d8d80000 08000005*/ ds_read_b32     v8, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c121094         */ v_lshrrev_b32   v9, 20, v8
/*b00002ac         */ s_movk_i32      s0, 0x2ac
/*d290000a 02291508*/ v_bfe_u32       v10, v8, 10, 10
/*d2d60009 00000109*/ v_mul_lo_i32    v9, v9, s0
/*4a14130a         */ v_add_i32       v10, vcc, v10, v9
/*361010ff 000003ff*/ v_and_b32       v8, 0x3ff, v8
/*34141485         */ v_lshlrev_b32   v10, 5, v10
/*4a101109         */ v_add_i32       v8, vcc, v9, v8
/*4a12140f         */ v_add_i32       v9, vcc, s15, v10
/*34101085         */ v_lshlrev_b32   v8, 5, v8
/*4a10100f         */ v_add_i32       v8, vcc, s15, v8
/*eba01014 80040909*/ tbuffer_load_format_x v9, v9, s[16:19], 0 offen offset:20 format:[32,float]
/*eba01014 80040808*/ tbuffer_load_format_x v8, v8, s[16:19], 0 offen offset:20 format:[32,float]
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 00000906*/ ds_write_b32    v6, v9
/*4a120cc4         */ v_add_i32       v9, vcc, -4, v6
/*4a0e0eff 00000100*/ v_add_i32       v7, vcc, 0x100, v7
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000809*/ ds_write_b32    v9, v8
/*4a0a0aff 00000400*/ v_add_i32       v5, vcc, 0x400, v5
/*4a0c0cff 00000800*/ v_add_i32       v6, vcc, 0x800, v6
/*7d880ea0         */ v_cmp_gt_u32    vcc, 32, v7
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffdb         */ s_cbranch_execnz .L1024_11
.L1172_11:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7d8800c0         */ v_cmp_gt_u32    vcc, 64, v0
/*87fe6a0a         */ s_and_b64       exec, s[10:11], vcc
/*bf88002a         */ s_cbranch_execz .L1364_11
/*c0880358         */ s_load_dwordx4  s[16:19], s[2:3], 0x58
/*be88047e         */ s_mov_b64       s[8:9], exec
/*7e0a0302         */ v_mov_b32       v5, v2
/*7e0c030c         */ v_mov_b32       v6, v12
/*7e0e0300         */ v_mov_b32       v7, v0
.L1216_11:
/*d8d80000 08000005*/ ds_read_b32     v8, v5
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c121094         */ v_lshrrev_b32   v9, 20, v8
/*b00002ac         */ s_movk_i32      s0, 0x2ac
/*d290000a 02291508*/ v_bfe_u32       v10, v8, 10, 10
/*d2d60009 00000109*/ v_mul_lo_i32    v9, v9, s0
/*4a14130a         */ v_add_i32       v10, vcc, v10, v9
/*361010ff 000003ff*/ v_and_b32       v8, 0x3ff, v8
/*34141485         */ v_lshlrev_b32   v10, 5, v10
/*4a101109         */ v_add_i32       v8, vcc, v9, v8
/*4a12140e         */ v_add_i32       v9, vcc, s14, v10
/*34101085         */ v_lshlrev_b32   v8, 5, v8
/*4a10100e         */ v_add_i32       v8, vcc, s14, v8
/*eba01014 80040909*/ tbuffer_load_format_x v9, v9, s[16:19], 0 offen offset:20 format:[32,float]
/*eba01014 80040808*/ tbuffer_load_format_x v8, v8, s[16:19], 0 offen offset:20 format:[32,float]
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 00000906*/ ds_write_b32    v6, v9
/*4a120cc4         */ v_add_i32       v9, vcc, -4, v6
/*4a0e0eff 00000100*/ v_add_i32       v7, vcc, 0x100, v7
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000809*/ ds_write_b32    v9, v8
/*4a0a0aff 00000400*/ v_add_i32       v5, vcc, 0x400, v5
/*4a0c0cff 00000800*/ v_add_i32       v6, vcc, 0x800, v6
/*7d880ec0         */ v_cmp_gt_u32    vcc, 64, v7
/*87fe6a7e         */ s_and_b64       exec, exec, vcc
/*bf89ffdb         */ s_cbranch_execnz .L1216_11
.L1364_11:
/*befe040a         */ s_mov_b64       exec, s[10:11]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*b0000080         */ s_movk_i32      s0, 0x80
/*7d880000         */ v_cmp_gt_u32    vcc, s0, v0
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*bf88002f         */ s_cbranch_execz .L1580_11
/*c0880358         */ s_load_dwordx4  s[16:19], s[2:3], 0x58
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e060301         */ v_mov_b32       v3, v1
/*7e0c0300         */ v_mov_b32       v6, v0
.L1412_11:
/*d8d80000 07000003*/ ds_read_b32     v7, v3
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c100e94         */ v_lshrrev_b32   v8, 20, v7
/*b00002ac         */ s_movk_i32      s0, 0x2ac
/*d2900009 02291507*/ v_bfe_u32       v9, v7, 10, 10
/*d2d60008 00000108*/ v_mul_lo_i32    v8, v8, s0
/*4a121109         */ v_add_i32       v9, vcc, v9, v8
/*360e0eff 000003ff*/ v_and_b32       v7, 0x3ff, v7
/*34121285         */ v_lshlrev_b32   v9, 5, v9
/*4a0e0f08         */ v_add_i32       v7, vcc, v8, v7
/*4a10120c         */ v_add_i32       v8, vcc, s12, v9
/*340e0e85         */ v_lshlrev_b32   v7, 5, v7
/*4a0e0e0c         */ v_add_i32       v7, vcc, s12, v7
/*eba01018 80040808*/ tbuffer_load_format_x v8, v8, s[16:19], 0 offen offset:24 format:[32,float]
/*eba01018 80040707*/ tbuffer_load_format_x v7, v7, s[16:19], 0 offen offset:24 format:[32,float]
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 0000080b*/ ds_write_b32    v11, v8
/*4a1016c4         */ v_add_i32       v8, vcc, -4, v11
/*4a0c0cff 00000100*/ v_add_i32       v6, vcc, 0x100, v6
/*b0000080         */ s_movk_i32      s0, 0x80
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000708*/ ds_write_b32    v8, v7
/*4a0606ff 00000400*/ v_add_i32       v3, vcc, 0x400, v3
/*4a1616ff 00000800*/ v_add_i32       v11, vcc, 0x800, v11
/*7d880c00         */ v_cmp_gt_u32    vcc, s0, v6
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L1580_11
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82ffd6         */ s_branch        .L1412_11
.L1580_11:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*b0000100         */ s_movk_i32      s0, 0x100
/*7d880000         */ v_cmp_gt_u32    vcc, s0, v0
/*be88246a         */ s_and_saveexec_b64 s[8:9], vcc
/*bf880030         */ s_cbranch_execz .L1800_11
/*c0880358         */ s_load_dwordx4  s[16:19], s[2:3], 0x58
/*be8a047e         */ s_mov_b64       s[10:11], exec
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*7e080300         */ v_mov_b32       v4, v0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L1632_11:
/*d8d80000 05000002*/ ds_read_b32     v5, v2
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*2c0c0a94         */ v_lshrrev_b32   v6, 20, v5
/*b00002ac         */ s_movk_i32      s0, 0x2ac
/*d2900007 02291505*/ v_bfe_u32       v7, v5, 10, 10
/*d2d60006 00000106*/ v_mul_lo_i32    v6, v6, s0
/*4a0e0d07         */ v_add_i32       v7, vcc, v7, v6
/*360a0aff 000003ff*/ v_and_b32       v5, 0x3ff, v5
/*340e0e85         */ v_lshlrev_b32   v7, 5, v7
/*4a0a0b06         */ v_add_i32       v5, vcc, v6, v5
/*4a0c0e01         */ v_add_i32       v6, vcc, s1, v7
/*340a0a85         */ v_lshlrev_b32   v5, 5, v5
/*4a0a0a01         */ v_add_i32       v5, vcc, s1, v5
/*eba01018 80040606*/ tbuffer_load_format_x v6, v6, s[16:19], 0 offen offset:24 format:[32,float]
/*eba01018 80040505*/ tbuffer_load_format_x v5, v5, s[16:19], 0 offen offset:24 format:[32,float]
/*bf8c0f71         */ s_waitcnt       vmcnt(1)
/*d8340000 0000060c*/ ds_write_b32    v12, v6
/*4a0c18c4         */ v_add_i32       v6, vcc, -4, v12
/*4a0808ff 00000100*/ v_add_i32       v4, vcc, 0x100, v4
/*b0000100         */ s_movk_i32      s0, 0x100
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340000 00000506*/ ds_write_b32    v6, v5
/*4a0404ff 00000400*/ v_add_i32       v2, vcc, 0x400, v2
/*4a1818ff 00000800*/ v_add_i32       v12, vcc, 0x800, v12
/*7d880800         */ v_cmp_gt_u32    vcc, s0, v4
/*be94047e         */ s_mov_b64       s[20:21], exec
/*8afe6a14         */ s_andn2_b64     exec, s[20:21], vcc
/*8a8e7e0e         */ s_andn2_b64     s[14:15], s[14:15], exec
/*bf840002         */ s_cbranch_scc0  .L1800_11
/*87fe0e14         */ s_and_b64       exec, s[20:21], s[14:15]
/*bf82ffd6         */ s_branch        .L1632_11
.L1800_11:
/*befe0408         */ s_mov_b64       exec, s[8:9]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*4a040083         */ v_add_i32       v2, vcc, 3, v0
/*b00001fd         */ s_movk_i32      s0, 0x1fd
/*7d8c0400         */ v_cmp_ge_u32    vcc, s0, v2
/*be80246a         */ s_and_saveexec_b64 s[0:1], vcc
/*7e060280         */ v_mov_b32       v3, 0
/*bf88001c         */ s_cbranch_execz .L1948_11
/*4a08028c         */ v_add_i32       v4, vcc, 12, v1
/*d8d807fc 03000003*/ ds_read_b32     v3, v3 offset:2044
/*be88047e         */ s_mov_b64       s[8:9], exec
/*be8a047e         */ s_mov_b64       s[10:11], exec
.L1856_11:
/*d8d80000 05000004*/ ds_read_b32     v5, v4
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*7d040b03         */ v_cmp_eq_i32    vcc, v3, v5
/*be8e246a         */ s_and_saveexec_b64 s[14:15], vcc
/*7e0a0280         */ v_mov_b32       v5, 0
/*bf880003         */ s_cbranch_execz .L1896_11
/*7e0c02c1         */ v_mov_b32       v6, -1
/*d80c0c00 00000605*/ ds_inc_u32      v5, v6 offset:3072
.L1896_11:
/*befe040e         */ s_mov_b64       exec, s[14:15]
/*4a0808ff 00000400*/ v_add_i32       v4, vcc, 0x400, v4
/*4a0404ff 00000100*/ v_add_i32       v2, vcc, 0x100, v2
/*b00c01fe         */ s_movk_i32      s12, 0x1fe
/*7d88040c         */ v_cmp_gt_u32    vcc, s12, v2
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*8afe6a0e         */ s_andn2_b64     exec, s[14:15], vcc
/*8a8a7e0a         */ s_andn2_b64     s[10:11], s[10:11], exec
/*bf840002         */ s_cbranch_scc0  .L1948_11
/*87fe0a0e         */ s_and_b64       exec, s[14:15], s[10:11]
/*bf82ffe9         */ s_branch        .L1856_11
.L1948_11:
/*befe0400         */ s_mov_b64       exec, s[0:1]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e040280         */ v_mov_b32       v2, 0
/*d8d80c00 02000002*/ ds_read_b32     v2, v2 offset:3072
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*38040500         */ v_or_b32        v2, v0, v2
/*7d040480         */ v_cmp_eq_i32    vcc, 0, v2
/*be80246a         */ s_and_saveexec_b64 s[0:1], vcc
/*bf88000a         */ s_cbranch_execz .L2032_11
/*c0840360         */ s_load_dwordx4  s[8:11], s[2:3], 0x60
/*7e04020d         */ v_mov_b32       v2, s13
/*7e0602c1         */ v_mov_b32       v3, -1
/*7e080280         */ v_mov_b32       v4, 0
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*e0f05000 80020302*/ buffer_atomic_inc v3, v2, s[8:11], 0 offen glc
/*bf8c0f70         */ s_waitcnt       vmcnt(0)
/*d8340c10 00000304*/ ds_write_b32    v4, v3 offset:3088
.L2032_11:
/*befe0400         */ s_mov_b64       exec, s[0:1]
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*bf8a0000         */ s_barrier
/*7e0402ff 00000c00*/ v_mov_b32       v2, 0xc00
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*d8dc0400 02000002*/ ds_read2_b32    v[2:3], v2 offset1:4
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*d1040000 00010102*/ v_cmp_eq_i32    s[0:1], v2, 0
/*7d88068b         */ v_cmp_gt_u32    vcc, 11, v3
/*87ea6a00         */ s_and_b64       vcc, s[0:1], vcc
/*87ea7e6a         */ s_and_b64       vcc, vcc, exec
/*bf86002a         */ s_cbranch_vccz  .L2260_11
/*b00001ff         */ s_movk_i32      s0, 0x1ff
/*7d8c0000         */ v_cmp_ge_u32    vcc, s0, v0
/*be80246a         */ s_and_saveexec_b64 s[0:1], vcc
/*4a04020d         */ v_add_i32       v2, vcc, s13, v1
/*bf88001d         */ s_cbranch_execz .L2228_11
/*c0840360         */ s_load_dwordx4  s[8:11], s[2:3], 0x60
/*be8e047e         */ s_mov_b64       s[14:15], exec
/*be90047e         */ s_mov_b64       s[16:17], exec
/*7e080280         */ v_mov_b32       v4, 0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
/*bf800000         */ s_nop           0x0
.L2144_11:
/*bf8c0f0f         */ s_waitcnt       expcnt(0)
/*4a0a0901         */ v_add_i32       v5, vcc, v1, v4
/*340c068b         */ v_lshlrev_b32   v6, 11, v3
/*d8d80000 05000005*/ ds_read_b32     v5, v5
/*4a0c0d04         */ v_add_i32       v6, vcc, v4, v6
/*4a0c0d02         */ v_add_i32       v6, vcc, v2, v6
/*4a0000ff 00000100*/ v_add_i32       v0, vcc, 0x100, v0
/*b00c01ff         */ s_movk_i32      s12, 0x1ff
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*eba41014 80020506*/ tbuffer_store_format_x v5, v6, s[8:11], 0 offen offset:20 format:[32,float]
/*7d82000c         */ v_cmp_lt_u32    vcc, s12, v0
/*be92246a         */ s_and_saveexec_b64 s[18:19], vcc
/*8a907e10         */ s_andn2_b64     s[16:17], s[16:17], exec
/*bf840004         */ s_cbranch_scc0  .L2228_11
/*87fe1012         */ s_and_b64       exec, s[18:19], s[16:17]
/*4a0808ff 00000400*/ v_add_i32       v4, vcc, 0x400, v4
/*bf82ffeb         */ s_branch        .L2144_11
.L2228_11:
/*87fe0600         */ s_and_b64       exec, s[0:1], s[6:7]
/*4a00060d         */ v_add_i32       v0, vcc, s13, v3
/*bf880005         */ s_cbranch_execz .L2260_11
/*c0840360         */ s_load_dwordx4  s[8:11], s[2:3], 0x60
/*7e020281         */ v_mov_b32       v1, 1
/*bf8c007f         */ s_waitcnt       lgkmcnt(0)
/*e0605008 80020100*/ buffer_store_byte v1, v0, s[8:11], 0 offen offset:8 glc
.L2260_11:
/*bf8a0000         */ s_barrier
.L2264_11:
/*bf810000         */ s_endpgm
