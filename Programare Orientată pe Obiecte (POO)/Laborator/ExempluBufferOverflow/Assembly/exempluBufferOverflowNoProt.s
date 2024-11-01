	.file	"exempluBufferOverflowNoProt.cpp"
# GNU C++14 (Ubuntu 8.2.0-7ubuntu1) version 8.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 8.2.0, GMP version 6.1.2, MPFR version 4.0.1, MPC version 1.1.0, isl version isl-0.20-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -fpreprocessed exempluBufferOverflowNoProt.ii
# -mtune=generic -march=x86-64 -fno-stack-protector -fverbose-asm -Wformat
# -Wformat-security
# options enabled:  -fPIC -fPIE -faggressive-loop-optimizations
# -fasynchronous-unwind-tables -fauto-inc-dec -fchkp-check-incomplete-type
# -fchkp-check-read -fchkp-check-write -fchkp-instrument-calls
# -fchkp-narrow-bounds -fchkp-optimize -fchkp-store-bounds
# -fchkp-use-static-bounds -fchkp-use-static-const-bounds
# -fchkp-use-wrappers -fcommon -fdelete-null-pointer-checks
# -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-types
# -fexceptions -ffp-int-builtin-inexact -ffunction-cse -fgcse-lm
# -fgnu-runtime -fgnu-unique -fident -finline-atomics -fira-hoist-pressure
# -fira-share-save-slots -fira-share-spill-slots -fivopts
# -fkeep-static-consts -fleading-underscore -flifetime-dse
# -flto-odr-type-merging -fmath-errno -fmerge-debug-strings -fpeephole
# -fplt -fprefetch-loop-arrays -freg-struct-return
# -fsched-critical-path-heuristic -fsched-dep-count-heuristic
# -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
# -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
# -fsched-stalled-insns-dep -fschedule-fusion -fsemantic-interposition
# -fshow-column -fshrink-wrap-separate -fsigned-zeros
# -fsplit-ivs-in-unroller -fssa-backprop -fstdarg-opt
# -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math -ftree-cselim
# -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
# -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop
# -ftree-reassoc -ftree-scev-cprop -funit-at-a-time -funwind-tables
# -fverbose-asm -fzero-initialized-in-bss -m128bit-long-double -m64 -m80387
# -malign-stringops -mavx256-split-unaligned-load
# -mavx256-split-unaligned-store -mfancy-math-387 -mfp-ret-in-387 -mfxsr
# -mglibc -mieee-fp -mlong-double-80 -mmmx -mno-sse4 -mpush-args -mred-zone
# -msse -msse2 -mstv -mtls-direct-seg-refs -mvzeroupper

	.text
	.section	.rodata
.LC0:
	.string	"Enter the password : "
.LC1:
	.string	"%s"
.LC2:
	.string	"parola"
.LC3:
	.string	"Wrong Password "
.LC4:
	.string	"Correct Password "
	.align 8
.LC5:
	.string	"Root privileges given to the user "
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$16, %rsp	#,
# exempluBufferOverflowNoProt.cpp:7:     int pass = 0;
	movl	$0, -4(%rbp)	#, pass
# exempluBufferOverflowNoProt.cpp:9:     printf("Enter the password : \n");
	leaq	.LC0(%rip), %rdi	#,
	call	puts@PLT	#
# exempluBufferOverflowNoProt.cpp:10:     scanf("%s", buff);
	leaq	-11(%rbp), %rax	#, tmp90
	movq	%rax, %rsi	# tmp90,
	leaq	.LC1(%rip), %rdi	#,
	movl	$0, %eax	#,
	call	scanf@PLT	#
# exempluBufferOverflowNoProt.cpp:12:     if(strcmp(buff, "parola"))
	leaq	-11(%rbp), %rax	#, tmp91
	leaq	.LC2(%rip), %rsi	#,
	movq	%rax, %rdi	# tmp91,
	call	strcmp@PLT	#
# exempluBufferOverflowNoProt.cpp:12:     if(strcmp(buff, "parola"))
	testl	%eax, %eax	# _1
	je	.L2	#,
# exempluBufferOverflowNoProt.cpp:14:         printf ("Wrong Password \n");
	leaq	.LC3(%rip), %rdi	#,
	call	puts@PLT	#
	jmp	.L3	#
.L2:
# exempluBufferOverflowNoProt.cpp:18:         printf ("Correct Password \n");
	leaq	.LC4(%rip), %rdi	#,
	call	puts@PLT	#
# exempluBufferOverflowNoProt.cpp:19:         pass = 1;
	movl	$1, -4(%rbp)	#, pass
.L3:
# exempluBufferOverflowNoProt.cpp:22:     if(pass)
	cmpl	$0, -4(%rbp)	#, pass
	je	.L4	#,
# exempluBufferOverflowNoProt.cpp:24:         printf ("Root privileges given to the user \n");
	leaq	.LC5(%rip), %rdi	#,
	call	puts@PLT	#
.L4:
# exempluBufferOverflowNoProt.cpp:27:     return 0;
	movl	$0, %eax	#, _14
# exempluBufferOverflowNoProt.cpp:28: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 8.2.0-7ubuntu1) 8.2.0"
	.section	.note.GNU-stack,"",@progbits
