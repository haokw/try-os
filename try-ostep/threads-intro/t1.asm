
t1:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100003a64 <_GetTime>:
100003a64: ff c3 00 d1 	sub	sp, sp, #48
100003a68: fd 7b 02 a9 	stp	x29, x30, [sp, #32]
100003a6c: fd 83 00 91 	add	x29, sp, #32
100003a70: e0 43 00 91 	add	x0, sp, #16
100003a74: 01 00 80 d2 	mov	x1, #0
100003a78: e8 00 00 94 	bl	0x100003e18 <_pthread_join+0x100003e18>
100003a7c: e0 0f 00 b9 	str	w0, [sp, #12]
100003a80: e8 0f 40 b9 	ldr	w8, [sp, #12]
100003a84: 08 01 00 71 	subs	w8, w8, #0
100003a88: e8 07 9f 1a 	cset	w8, ne
100003a8c: 48 01 00 36 	tbz	w8, #0, 0x100003ab4 <_GetTime+0x50>
100003a90: 01 00 00 14 	b	0x100003a94 <_GetTime+0x30>
100003a94: 00 00 00 90 	adrp	x0, 0x100003000 <_GetTime+0x30>
100003a98: 00 40 39 91 	add	x0, x0, #3664
100003a9c: 01 00 00 90 	adrp	x1, 0x100003000 <_GetTime+0x38>
100003aa0: 21 60 39 91 	add	x1, x1, #3672
100003aa4: 62 01 80 52 	mov	w2, #11
100003aa8: 03 00 00 90 	adrp	x3, 0x100003000 <_GetTime+0x44>
100003aac: 63 84 39 91 	add	x3, x3, #3681
100003ab0: ce 00 00 94 	bl	0x100003de8 <_pthread_join+0x100003de8>
100003ab4: 01 00 00 14 	b	0x100003ab8 <_GetTime+0x54>
100003ab8: e0 0b 40 fd 	ldr	d0, [sp, #16]
100003abc: 00 d8 61 5e 	scvtf	d0, d0
100003ac0: e2 1b 40 bd 	ldr	s2, [sp, #24]
100003ac4: 41 40 20 1e 	fmov	s1, s2
100003ac8: 21 a4 20 0f 	sshll.2d	v1, v1, #0
100003acc: 21 d8 61 5e 	scvtf	d1, d1
100003ad0: 08 00 00 90 	adrp	x8, 0x100003000 <_GetTime+0x6c>
100003ad4: 02 25 47 fd 	ldr	d2, [x8, #3656]
100003ad8: 21 18 62 1e 	fdiv	d1, d1, d2
100003adc: 00 28 61 1e 	fadd	d0, d0, d1
100003ae0: fd 7b 42 a9 	ldp	x29, x30, [sp, #32]
100003ae4: ff c3 00 91 	add	sp, sp, #48
100003ae8: c0 03 5f d6 	ret

0000000100003aec <_Spin>:
100003aec: ff 83 00 d1 	sub	sp, sp, #32
100003af0: fd 7b 01 a9 	stp	x29, x30, [sp, #16]
100003af4: fd 43 00 91 	add	x29, sp, #16
100003af8: a0 c3 1f b8 	stur	w0, [x29, #-4]
100003afc: da ff ff 97 	bl	0x100003a64 <_GetTime>
100003b00: e0 03 00 fd 	str	d0, [sp]
100003b04: 01 00 00 14 	b	0x100003b08 <_Spin+0x1c>
100003b08: d7 ff ff 97 	bl	0x100003a64 <_GetTime>
100003b0c: e1 03 40 fd 	ldr	d1, [sp]
100003b10: 00 38 61 1e 	fsub	d0, d0, d1
100003b14: a2 c3 5f bc 	ldur	s2, [x29, #-4]
100003b18: 41 40 20 1e 	fmov	s1, s2
100003b1c: 21 a4 20 0f 	sshll.2d	v1, v1, #0
100003b20: 21 d8 61 5e 	scvtf	d1, d1
100003b24: 00 20 61 1e 	fcmp	d0, d1
100003b28: 65 00 00 54 	b.pl	0x100003b34 <_Spin+0x48>
100003b2c: 01 00 00 14 	b	0x100003b30 <_Spin+0x44>
100003b30: f6 ff ff 17 	b	0x100003b08 <_Spin+0x1c>
100003b34: fd 7b 41 a9 	ldp	x29, x30, [sp, #16]
100003b38: ff 83 00 91 	add	sp, sp, #32
100003b3c: c0 03 5f d6 	ret

0000000100003b40 <_mythread>:
100003b40: ff 03 01 d1 	sub	sp, sp, #64
100003b44: fd 7b 03 a9 	stp	x29, x30, [sp, #48]
100003b48: fd c3 00 91 	add	x29, sp, #48
100003b4c: a0 83 1f f8 	stur	x0, [x29, #-8]
100003b50: a8 83 5f f8 	ldur	x8, [x29, #-8]
100003b54: a8 03 1f f8 	stur	x8, [x29, #-16]
100003b58: a8 03 5f f8 	ldur	x8, [x29, #-16]
100003b5c: e9 03 00 91 	mov	x9, sp
100003b60: 28 01 00 f9 	str	x8, [x9]
100003b64: a8 53 00 d1 	sub	x8, x29, #20
100003b68: 28 05 00 f9 	str	x8, [x9, #8]
100003b6c: 00 00 00 90 	adrp	x0, 0x100003000 <_mythread+0x2c>
100003b70: 00 a4 39 91 	add	x0, x0, #3689
100003b74: ac 00 00 94 	bl	0x100003e24 <_pthread_join+0x100003e24>
100003b78: bf c3 1e b8 	stur	wzr, [x29, #-20]
100003b7c: 01 00 00 14 	b	0x100003b80 <_mythread+0x40>
100003b80: a8 c3 5e b8 	ldur	w8, [x29, #-20]
100003b84: 29 00 00 b0 	adrp	x9, 0x100008000 <_mythread+0x58>
100003b88: 29 11 00 91 	add	x9, x9, #4
100003b8c: 29 01 40 b9 	ldr	w9, [x9]
100003b90: 08 01 09 6b 	subs	w8, w8, w9
100003b94: 6a 01 00 54 	b.ge	0x100003bc0 <_mythread+0x80>
100003b98: 01 00 00 14 	b	0x100003b9c <_mythread+0x5c>
100003b9c: 29 00 00 b0 	adrp	x9, 0x100008000 <_mythread+0x70>
100003ba0: 28 01 40 b9 	ldr	w8, [x9]
100003ba4: 08 05 00 11 	add	w8, w8, #1
100003ba8: 28 01 00 b9 	str	w8, [x9]
100003bac: 01 00 00 14 	b	0x100003bb0 <_mythread+0x70>
100003bb0: a8 c3 5e b8 	ldur	w8, [x29, #-20]
100003bb4: 08 05 00 11 	add	w8, w8, #1
100003bb8: a8 c3 1e b8 	stur	w8, [x29, #-20]
100003bbc: f1 ff ff 17 	b	0x100003b80 <_mythread+0x40>
100003bc0: a8 03 5f f8 	ldur	x8, [x29, #-16]
100003bc4: e9 03 00 91 	mov	x9, sp
100003bc8: 28 01 00 f9 	str	x8, [x9]
100003bcc: 00 00 00 90 	adrp	x0, 0x100003000 <_mythread+0x8c>
100003bd0: 00 10 3a 91 	add	x0, x0, #3716
100003bd4: 94 00 00 94 	bl	0x100003e24 <_pthread_join+0x100003e24>
100003bd8: 00 00 80 d2 	mov	x0, #0
100003bdc: fd 7b 43 a9 	ldp	x29, x30, [sp, #48]
100003be0: ff 03 01 91 	add	sp, sp, #64
100003be4: c0 03 5f d6 	ret

0000000100003be8 <_main>:
100003be8: ff 43 01 d1 	sub	sp, sp, #80
100003bec: fd 7b 04 a9 	stp	x29, x30, [sp, #64]
100003bf0: fd 03 01 91 	add	x29, sp, #64
100003bf4: 28 00 00 b0 	adrp	x8, 0x100008000 <_main+0x20>
100003bf8: 08 01 00 91 	add	x8, x8, #0
100003bfc: e8 1f 00 b9 	str	w8, [sp, #28]
100003c00: bf c3 1f b8 	stur	wzr, [x29, #-4]
100003c04: a0 83 1f b8 	stur	w0, [x29, #-8]
100003c08: a1 03 1f f8 	stur	x1, [x29, #-16]
100003c0c: a8 83 5f b8 	ldur	w8, [x29, #-8]
100003c10: 08 09 00 71 	subs	w8, w8, #2
100003c14: 40 01 00 54 	b.eq	0x100003c3c <_main+0x54>
100003c18: 01 00 00 14 	b	0x100003c1c <_main+0x34>
100003c1c: 08 00 00 b0 	adrp	x8, 0x100004000 <_main+0x38>
100003c20: 08 05 40 f9 	ldr	x8, [x8, #8]
100003c24: 00 01 40 f9 	ldr	x0, [x8]
100003c28: 01 00 00 90 	adrp	x1, 0x100003000 <_main+0x40>
100003c2c: 21 38 3a 91 	add	x1, x1, #3726
100003c30: 77 00 00 94 	bl	0x100003e0c <_pthread_join+0x100003e0c>
100003c34: 20 00 80 52 	mov	w0, #1
100003c38: 72 00 00 94 	bl	0x100003e00 <_pthread_join+0x100003e00>
100003c3c: a8 03 5f f8 	ldur	x8, [x29, #-16]
100003c40: 00 05 40 f9 	ldr	x0, [x8, #8]
100003c44: 6c 00 00 94 	bl	0x100003df4 <_pthread_join+0x100003df4>
100003c48: ea 1f 40 b9 	ldr	w10, [sp, #28]
100003c4c: 28 00 00 b0 	adrp	x8, 0x100008000 <_main+0x78>
100003c50: 08 11 00 91 	add	x8, x8, #4
100003c54: 00 01 00 b9 	str	w0, [x8]
100003c58: 28 00 00 b0 	adrp	x8, 0x100008000 <_main+0x84>
100003c5c: 09 01 40 b9 	ldr	w9, [x8]
100003c60: e8 03 09 aa 	mov	x8, x9
100003c64: e9 03 00 91 	mov	x9, sp
100003c68: 28 01 00 f9 	str	x8, [x9]
100003c6c: e8 03 0a aa 	mov	x8, x10
100003c70: 28 05 00 f9 	str	x8, [x9, #8]
100003c74: 00 00 00 90 	adrp	x0, 0x100003000 <_main+0x8c>
100003c78: 00 b4 3a 91 	add	x0, x0, #3757
100003c7c: 6a 00 00 94 	bl	0x100003e24 <_pthread_join+0x100003e24>
100003c80: a0 63 00 d1 	sub	x0, x29, #24
100003c84: 01 00 80 d2 	mov	x1, #0
100003c88: 02 00 00 90 	adrp	x2, 0x100003000 <_main+0xa0>
100003c8c: 42 00 2d 91 	add	x2, x2, #2880
100003c90: 03 00 00 90 	adrp	x3, 0x100003000 <_main+0xa8>
100003c94: 63 38 3b 91 	add	x3, x3, #3790
100003c98: 66 00 00 94 	bl	0x100003e30 <_pthread_join+0x100003e30>
100003c9c: 08 00 00 71 	subs	w8, w0, #0
100003ca0: e8 07 9f 1a 	cset	w8, ne
100003ca4: 48 01 00 36 	tbz	w8, #0, 0x100003ccc <_main+0xe4>
100003ca8: 01 00 00 14 	b	0x100003cac <_main+0xc4>
100003cac: 00 00 00 90 	adrp	x0, 0x100003000 <_main+0xc4>
100003cb0: 00 40 3b 91 	add	x0, x0, #3792
100003cb4: 01 00 00 90 	adrp	x1, 0x100003000 <_main+0xcc>
100003cb8: 21 54 3b 91 	add	x1, x1, #3797
100003cbc: e2 03 80 52 	mov	w2, #31
100003cc0: 03 00 00 90 	adrp	x3, 0x100003000 <_main+0xd8>
100003cc4: 63 68 3b 91 	add	x3, x3, #3802
100003cc8: 48 00 00 94 	bl	0x100003de8 <_pthread_join+0x100003de8>
100003ccc: 01 00 00 14 	b	0x100003cd0 <_main+0xe8>
100003cd0: e0 83 00 91 	add	x0, sp, #32
100003cd4: 01 00 80 d2 	mov	x1, #0
100003cd8: 02 00 00 90 	adrp	x2, 0x100003000 <_main+0xf0>
100003cdc: 42 00 2d 91 	add	x2, x2, #2880
100003ce0: 03 00 00 90 	adrp	x3, 0x100003000 <_main+0xf8>
100003ce4: 63 3c 3c 91 	add	x3, x3, #3855
100003ce8: 52 00 00 94 	bl	0x100003e30 <_pthread_join+0x100003e30>
100003cec: 08 00 00 71 	subs	w8, w0, #0
100003cf0: e8 07 9f 1a 	cset	w8, ne
100003cf4: 48 01 00 36 	tbz	w8, #0, 0x100003d1c <_main+0x134>
100003cf8: 01 00 00 14 	b	0x100003cfc <_main+0x114>
100003cfc: 00 00 00 90 	adrp	x0, 0x100003000 <_main+0x114>
100003d00: 00 40 3b 91 	add	x0, x0, #3792
100003d04: 01 00 00 90 	adrp	x1, 0x100003000 <_main+0x11c>
100003d08: 21 54 3b 91 	add	x1, x1, #3797
100003d0c: 02 04 80 52 	mov	w2, #32
100003d10: 03 00 00 90 	adrp	x3, 0x100003000 <_main+0x128>
100003d14: 63 44 3c 91 	add	x3, x3, #3857
100003d18: 34 00 00 94 	bl	0x100003de8 <_pthread_join+0x100003de8>
100003d1c: 01 00 00 14 	b	0x100003d20 <_main+0x138>
100003d20: a0 83 5e f8 	ldur	x0, [x29, #-24]
100003d24: 01 00 80 d2 	mov	x1, #0
100003d28: 45 00 00 94 	bl	0x100003e3c <_pthread_join+0x100003e3c>
100003d2c: 08 00 00 71 	subs	w8, w0, #0
100003d30: e8 07 9f 1a 	cset	w8, ne
100003d34: 48 01 00 36 	tbz	w8, #0, 0x100003d5c <_main+0x174>
100003d38: 01 00 00 14 	b	0x100003d3c <_main+0x154>
100003d3c: 00 00 00 90 	adrp	x0, 0x100003000 <_main+0x154>
100003d40: 00 40 3b 91 	add	x0, x0, #3792
100003d44: 01 00 00 90 	adrp	x1, 0x100003000 <_main+0x15c>
100003d48: 21 54 3b 91 	add	x1, x1, #3797
100003d4c: 42 04 80 52 	mov	w2, #34
100003d50: 03 00 00 90 	adrp	x3, 0x100003000 <_main+0x168>
100003d54: 63 18 3d 91 	add	x3, x3, #3910
100003d58: 24 00 00 94 	bl	0x100003de8 <_pthread_join+0x100003de8>
100003d5c: 01 00 00 14 	b	0x100003d60 <_main+0x178>
100003d60: e0 13 40 f9 	ldr	x0, [sp, #32]
100003d64: 01 00 80 d2 	mov	x1, #0
100003d68: 35 00 00 94 	bl	0x100003e3c <_pthread_join+0x100003e3c>
100003d6c: 08 00 00 71 	subs	w8, w0, #0
100003d70: e8 07 9f 1a 	cset	w8, ne
100003d74: 48 01 00 36 	tbz	w8, #0, 0x100003d9c <_main+0x1b4>
100003d78: 01 00 00 14 	b	0x100003d7c <_main+0x194>
100003d7c: 00 00 00 90 	adrp	x0, 0x100003000 <_main+0x194>
100003d80: 00 40 3b 91 	add	x0, x0, #3792
100003d84: 01 00 00 90 	adrp	x1, 0x100003000 <_main+0x19c>
100003d88: 21 54 3b 91 	add	x1, x1, #3797
100003d8c: 62 04 80 52 	mov	w2, #35
100003d90: 03 00 00 90 	adrp	x3, 0x100003000 <_main+0x1a8>
100003d94: 63 a4 3d 91 	add	x3, x3, #3945
100003d98: 14 00 00 94 	bl	0x100003de8 <_pthread_join+0x100003de8>
100003d9c: 01 00 00 14 	b	0x100003da0 <_main+0x1b8>
100003da0: 28 00 00 b0 	adrp	x8, 0x100008000 <_main+0x1cc>
100003da4: 09 01 40 b9 	ldr	w9, [x8]
100003da8: e8 03 09 aa 	mov	x8, x9
100003dac: 29 00 00 b0 	adrp	x9, 0x100008000 <_main+0x1d8>
100003db0: 29 11 00 91 	add	x9, x9, #4
100003db4: 29 01 40 b9 	ldr	w9, [x9]
100003db8: 2a 79 1f 53 	lsl	w10, w9, #1
100003dbc: e9 03 00 91 	mov	x9, sp
100003dc0: 28 01 00 f9 	str	x8, [x9]
100003dc4: e8 03 0a aa 	mov	x8, x10
100003dc8: 28 05 00 f9 	str	x8, [x9, #8]
100003dcc: 00 00 00 90 	adrp	x0, 0x100003000 <_main+0x1e4>
100003dd0: 00 30 3e 91 	add	x0, x0, #3980
100003dd4: 14 00 00 94 	bl	0x100003e24 <_pthread_join+0x100003e24>
100003dd8: 00 00 80 52 	mov	w0, #0
100003ddc: fd 7b 44 a9 	ldp	x29, x30, [sp, #64]
100003de0: ff 43 01 91 	add	sp, sp, #80
100003de4: c0 03 5f d6 	ret

Disassembly of section __TEXT,__stubs:

0000000100003de8 <__stubs>:
100003de8: 10 00 00 b0 	adrp	x16, 0x100004000 <__stubs+0x4>
100003dec: 10 02 40 f9 	ldr	x16, [x16]
100003df0: 00 02 1f d6 	br	x16
100003df4: 10 00 00 b0 	adrp	x16, 0x100004000 <__stubs+0x10>
100003df8: 10 0a 40 f9 	ldr	x16, [x16, #16]
100003dfc: 00 02 1f d6 	br	x16
100003e00: 10 00 00 b0 	adrp	x16, 0x100004000 <__stubs+0x1c>
100003e04: 10 0e 40 f9 	ldr	x16, [x16, #24]
100003e08: 00 02 1f d6 	br	x16
100003e0c: 10 00 00 b0 	adrp	x16, 0x100004000 <__stubs+0x28>
100003e10: 10 12 40 f9 	ldr	x16, [x16, #32]
100003e14: 00 02 1f d6 	br	x16
100003e18: 10 00 00 b0 	adrp	x16, 0x100004000 <__stubs+0x34>
100003e1c: 10 16 40 f9 	ldr	x16, [x16, #40]
100003e20: 00 02 1f d6 	br	x16
100003e24: 10 00 00 b0 	adrp	x16, 0x100004000 <__stubs+0x40>
100003e28: 10 1a 40 f9 	ldr	x16, [x16, #48]
100003e2c: 00 02 1f d6 	br	x16
100003e30: 10 00 00 b0 	adrp	x16, 0x100004000 <__stubs+0x4c>
100003e34: 10 1e 40 f9 	ldr	x16, [x16, #56]
100003e38: 00 02 1f d6 	br	x16
100003e3c: 10 00 00 b0 	adrp	x16, 0x100004000 <__stubs+0x58>
100003e40: 10 22 40 f9 	ldr	x16, [x16, #64]
100003e44: 00 02 1f d6 	br	x16
