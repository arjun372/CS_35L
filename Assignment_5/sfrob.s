	.file	"sfrob.c"
	.text
	.type	frobcmp, @function
frobcmp:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	jmp	.L2
.L4:
	addq	$1, -8(%rbp)
	addq	$1, -16(%rbp)
.L2:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L3
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L3
	movq	-8(%rbp), %rax
	movzbl	(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	%al, %dl
	je	.L4
.L3:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L5
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L6
.L5:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	jne	.L7
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	jne	.L8
.L7:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	xorl	$42, %eax
	movsbl	%al, %edx
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	xorl	$42, %eax
	movsbl	%al, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	jmp	.L9
.L8:
	movl	$-1, %eax
.L9:
	jmp	.L10
.L6:
	movl	$1, %eax
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	frobcmp, .-frobcmp
	.type	qsort_compatible_frobcmp, @function
qsort_compatible_frobcmp:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	frobcmp
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	qsort_compatible_frobcmp, .-qsort_compatible_frobcmp
	.type	displayStream, @function
displayStream:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L15
.L18:
	movl	$0, -4(%rbp)
	jmp	.L16
.L17:
	mov	-8(%rbp), %eax
	salq	$3, %rax
	addq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movl	-4(%rbp), %eax
	subl	$1, %eax
	mov	%eax, %eax
	leaq	(%rdx,%rax), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar
.L16:
	mov	-8(%rbp), %eax
	salq	$3, %rax
	addq	-24(%rbp), %rax
	movq	(%rax), %rdx
	mov	-4(%rbp), %eax
	leaq	(%rdx,%rax), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	setne	%al
	addl	$1, -4(%rbp)
	testb	%al, %al
	jne	.L17
	mov	-8(%rbp), %eax
	salq	$3, %rax
	addq	-24(%rbp), %rax
	movq	(%rax), %rdx
	mov	-4(%rbp), %eax
	leaq	(%rdx,%rax), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, %edi
	call	putchar
	addl	$1, -8(%rbp)
.L15:
	movl	-8(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jb	.L18
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	displayStream, .-displayStream
	.section	.rodata
	.align 8
.LC0:
	.string	"Memory allocation error. Exiting (1)"
	.text
.globl main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	movl	$32768, %edi
	.cfi_offset 3, -24
	call	malloc
	movq	%rax, -64(%rbp)
	movl	$512, %edi
	call	malloc
	movq	%rax, -56(%rbp)
	cmpq	$0, -64(%rbp)
	je	.L21
	cmpq	$0, -56(%rbp)
	je	.L21
	movl	$0, -36(%rbp)
	movl	$0, -32(%rbp)
	movl	$512, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$4096, -20(%rbp)
.L34:
	call	getchar
	movl	%eax, -40(%rbp)
	cmpl	$-1, -40(%rbp)
	je	.L22
	movl	-40(%rbp), %eax
	cmpb	$32, %al
	jne	.L23
.L22:
	cmpl	$0, -32(%rbp)
	jne	.L24
	movl	-40(%rbp), %eax
	cmpb	$32, %al
	jne	.L36
.L24:
	movl	-32(%rbp), %eax
	addl	$1, %eax
	mov	%eax, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	je	.L37
.L26:
	movl	$0, -36(%rbp)
	jmp	.L27
.L28:
	mov	-36(%rbp), %eax
	addq	-48(%rbp), %rax
	mov	-36(%rbp), %edx
	addq	-56(%rbp), %rdx
	movzbl	(%rdx), %edx
	movb	%dl, (%rax)
	addl	$1, -36(%rbp)
.L27:
	movl	-36(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jb	.L28
	movl	$0, -32(%rbp)
	mov	-36(%rbp), %eax
	addq	-48(%rbp), %rax
	movb	$32, (%rax)
	mov	-24(%rbp), %eax
	salq	$3, %rax
	addq	-64(%rbp), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, (%rax)
	addl	$1, -24(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jne	.L29
	addl	$4096, -20(%rbp)
	mov	-20(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	je	.L38
.L29:
	cmpl	$-1, -40(%rbp)
	je	.L39
	nop
	jmp	.L34
.L23:
	movl	-32(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jne	.L33
	addl	$512, -28(%rbp)
	mov	-28(%rbp), %edx
	movq	-56(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	je	.L40
.L33:
	mov	-32(%rbp), %eax
	addq	-56(%rbp), %rax
	movl	-40(%rbp), %edx
	movb	%dl, (%rax)
	addl	$1, -32(%rbp)
	jmp	.L34
.L39:
	nop
.L32:
	mov	-24(%rbp), %ebx
	movq	-64(%rbp), %rax
	movl	$qsort_compatible_frobcmp, %ecx
	movl	$8, %edx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	qsort
	movl	-24(%rbp), %edx
	movq	-64(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	displayStream
	jmp	.L25
.L36:
	nop
.L25:
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movl	$0, %edi
	call	exit
.L37:
	nop
	jmp	.L21
.L38:
	nop
	jmp	.L21
.L40:
	nop
.L21:
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movq	stderr(%rip), %rax
	movq	%rax, %rdx
	movl	$.LC0, %eax
	movq	%rdx, %rcx
	movl	$36, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fwrite
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.4.7 20120313 (Red Hat 4.4.7-16)"
	.section	.note.GNU-stack,"",@progbits
