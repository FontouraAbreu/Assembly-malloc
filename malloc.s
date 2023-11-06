.section .data
	STR: .string "Hello, world!"

.section .text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	movq $STR, %rdi
	call printf
	
	movq $0, %rdi
	movq $60, %rax

	syscall
