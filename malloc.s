.section .note.GNU-stack
.section .data
	STR_INICIAL: .string "\n"
    STR_BRK: .string "brk: %p\n"
    TopoInicialHeap: .quad 0
.section .text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp # registro de ativação
    subq $16, %rsp # alocando espaço para 16 bytes

	movq $STR_INICIAL, %rdi
	call printf # printf inicial

    call IniciaAlocador # inicia o alocador

	movq $0, %rdi
	movq $60, %rax

	syscall

IniciaAlocador:
    pushq %rbp
    movq %rsp, %rbp # registro de ativação

    # executa syscall brk para obter o topo inicial do heap e armazena em TopoInicialHeap
    movq $12, %rax # syscall brk
    movq $0, %rdi # argumento 1: 0 para obter o topo inicial do heap
    syscall

    movq %rax, TopoInicialHeap # armazena o topo inicial do heap em TopoInicialHeap

    # printa o topo inicial do heap
    movq $STR_BRK, %rdi
    movq $TopoInicialHeap, %rsi
    call printf
    
    # retorna para o main
    popq %rbp
    ret


