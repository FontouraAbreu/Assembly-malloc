.section .data

.section .text
.globl main
main:
	movq $13, %rdi
	movq $60, %rax
	syscall
