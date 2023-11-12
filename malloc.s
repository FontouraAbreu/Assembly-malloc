.section .note.GNU-stack
.section .data
    TopoInicialHeap: .quad 0
	TopoHeap: .quad 0
.section .text

.globl iniciaAlocador
iniciaAlocador:
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

.globl finalizaAlocador
finalizaAlocador:
	pushq %rbp
	movq %rsp, %rbp

	movq $12, %rax
	movq TopoInicialHeap, %rdi
	movq %rdi, TopoHeap
	syscall
	
	popq %rbp
	ret

.globl alocaMem
alocaMem:
#	struct node{
#		long ocp; 1 ou 0 se bloco está ocupado
#		long size; tamanho do bloco
#		long data[size]; dados 
#}
	pushq %rbp
	movq %rsp, %rbp

	subq $16, %rbp # alocando espaço para variáveis locais
	movq %rdi, -8(%rbp) # valor do argumento com tamanho do bloco
	movq TopoHeap, %rdx
	movq %rdx, -16(%rbp) # Salvando o endereço do topo atual para adicionar os campos

	movq TopoHeap, %rdi # topo atual da heap
	addq -8(%rbp), %rdi # adicionar tamanho do bloco a ser alocado
	addq $16, %rdi	# adicionar variáveis de controle do nodo
	movq $12, %rax
	syscall
	
	movq %rax, TopoHeap

	movq -16(%rbp), %rbx # %rbx contém o endereço de ocp do bloco
	movq %rbx, %rcx 
	addq $8, %rcx # %rcx contém o endereço de size do bloco

	movq $1, (%rbx) # coloca o valor 1 em ocp do bloco
	movq -8(%rbp), %rbx
	movq %rbx, (%rcx)

	movq %rcx, %rax
	addq $8, %rax # Salvando inicio dos dados para retorno em var

	addq $16, %rbp
	popq %rbp
	ret

.globl liberaMem
liberaMem:
#	struct node{
#		long ocp; 1 ou 0 se bloco está ocupado
#		long size; tamanho do bloco
#		long data[size]; dados 
#}
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rbp # ret variable
	movq $0, -8(%rbp)

	movq %rdi, %rbx
	subq $16, %rbx # %rbx contém endereço do ocp do nodo
	movq (%rbx), %rcx # %rcx contém o valor do ocp do nodo

	cmpq $0, %rcx
	je fim_alocado
	movq $0, (%rbx)
	movq $1, -8(%rbp)

	fim_alocado:
	movq -8(%rbp), %rax
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
