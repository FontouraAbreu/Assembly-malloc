.section .note.GNU-stack
.section .data
    TopoInicialHeap: .quad 0
	TopoHeap: .quad 0
.section .text

.globl IniciaAlocador
IniciaAlocador:
    pushq %rbp
    movq %rsp, %rbp # registro de ativação

    # executa syscall brk para obter o topo inicial do heap e armazena em TopoInicialHeap
    movq $12, %rax # syscall brk
	movq $0, %rdi
    syscall

    movq %rax, TopoInicialHeap # armazena o topo inicial do heap em TopoInicialHeap
	movq %rax, TopoHeap

    # retorna para o main
    popq %rbp
    ret

.globl FinalizaAlocador
FinalizaAlocador:
	pushq %rbp
	movq %rsp, %rbp

	movq $12, %rax
	movq TopoInicialHeap, %rdi
	movq %rdi, TopoHeap
	syscall

	movq TopoInicialHeap, %rax
	
	popq %rbp
	ret

.globl AumentaHeap
AumentaHeap:
	pushq %rbp
	movq %rsp, %rbp

	subq $8, %rbp
	movq %rdi, -8(%rbp) # salvando o argumento na pilha

	movq TopoHeap, %rdi 
	addq -8(%rbp), %rdi
	movq $12, %rax # soma o argumento em rdi e chama a brk
	syscall

	movq %rax, TopoHeap

	addq $8, %rbp
	popq %rbp
	ret


.globl Print
Print:
	pushq %rbp
	movq %rsp, %rbp

	movq $1, %rax
	movq $1, %rdi
	movq $10, %rdx
	syscall

	popq %rbp
	ret
