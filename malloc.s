# EXEMPLO DA ESTRUTURA DE DADOS DO NODO
#	struct node {
#		long ocp;			Nodo ocupado ou não
#		long size;			Tamanho do nodo
#		void data[size]		seção de dados alocada
#	}
.section .data
    TopoInicialHeap: .quad 0
	TopoHeap: .quad 0
.section .text
.globl getTopoInicialHeap
.globl iniciaAlocador
.globl finalizaAlocador
.globl alocaMem
.globl achaLivre
.globl liberaMem

#	void* getTopoInicialHeap()	################################################
#	devolve o valor do topo inicial da heap	####################################
getTopoInicialHeap:
	pushq %rbp
	movq %rsp, %rbp

	movq TopoInicialHeap, %rax

	popq %rbp
	ret
################################################################################



#	void iniciaAlocador()	####################################################
#	inicia o brk	############################################################
iniciaAlocador:
    pushq %rbp
    movq %rsp, %rbp

    movq $12, %rax # syscall brk
	movq $0, %rdi
    syscall

	# armazena o retorno da syscall em TopoInicialHeap e TopoHeap
    movq %rax, TopoInicialHeap
	movq %rax, TopoHeap

    popq %rbp
    ret
################################################################################



#	void finalizaAlocador()	####################################################
#	finaliza o alocador retornando pro valor inicial do brk	####################
finalizaAlocador:
	pushq %rbp
	movq %rsp, %rbp

	# mata todos os bytes alocados retornando o valor do brk pro inicial
	movq $12, %rax
	movq TopoInicialHeap, %rdi 
	movq %rdi, TopoHeap
	syscall
	
	popq %rbp
	ret
################################################################################



#	void* achaLivre()	########################################################
#	procura pelo primeiro nodo livre a partir do topoInicialHeap	############
achaLivre:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rbp

	movq $0, -8(%rbp) # valor do ponteiro a ser retornado (começa em null)
	movq %rdi, -16(%rbp) # tamanho minimo do nodo

	movq TopoInicialHeap, %rdi # ocp do primeiro nodo
	
	init_while:
	cmpq $0, (%rdi)
	jne continue
	movq %rdi, %rdx
	addq $8, %rdx
	movq (%rdx), %rdx
	cmpq %rdx, -16(%rbp)
	jle retorna_nodo
	
	continue:
	addq $8, %rdi
	movq (%rdi), %rcx
	addq $8, %rdi 
	addq %rcx, %rdi # %rdi contém endereço do início do próximo nodo
	
	cmpq %rdi, TopoHeap # Se verdadeiro, chegou ao fim sem achar nodos livres
	je fim_while

	jmp init_while
	fim_while:
	movq -8(%rbp), %rdi

 	retorna_nodo:	
	addq $16, %rdi # soma 16 para apontar para data
	movq %rdi, %rax

	addq $16, %rbp
	popq %rbp
	ret
################################################################################


#	void* alocaMem(long s)	####################################################
#	recebe o número de bytes a ser alocado em s	################################
#	aloca o nodo e retorna o ponteiro para o início dos dados do nodo	########
alocaMem:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rbp # alocando espaço para variáveis locais

	movq %rdi, -8(%rbp) # valor do argumento com tamanho do bloco
	movq TopoHeap, %rdx
	movq %rdx, -16(%rbp) # Salvando o endereço de ocp do bloco a ser alocado

	movq TopoHeap, %rdi # topo atual da heap
	addq -8(%rbp), %rdi # + adicionar tamanho do bloco a ser alocado
	addq $16, %rdi # + adicionar tamanho das variáveis de controle do nodo
	movq $12, %rax
	syscall
	
	movq %rax, TopoHeap

	# Bloco já alocado, adicionar valores corretos no controle #################

	movq -16(%rbp), %rbx # %rbx contém o endereço de ocp do bloco
	movq %rbx, %rcx 
	addq $8, %rcx # %rcx contém o endereço de size do bloco

	movq $1, (%rbx) # coloca o valor 1 em ocp do bloco
	movq -8(%rbp), %rbx
	movq %rbx, (%rcx) # coloca o tamanho do bloco em size

	movq %rcx, %rax
	addq $8, %rax # Salvando inicio dos dados para retorno em var

	addq $16, %rbp
	popq %rbp
	ret
################################################################################



#	void liberaMem(void* p)	####################################################
#	muda o valor de ocp do nodo para 0	########################################
liberaMem:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rbp # retorno: 1 se for desalocado, 0 se já tiver desalocado
	movq $0, -8(%rbp)

	movq %rdi, %rbx
	subq $16, %rbx
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
################################################################################
