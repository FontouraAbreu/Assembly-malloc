#include <stdio.h>
#include <string.h>
#include "malloc.h"

long *a, *b, *c, *d;
long e;

void printBlock(long *k){
	printf("ponteiro:\t%p\nocp:\t\t%ld\nsize:\t\t%ld\n\n", k, *(k-2), *(k-1));
}

int main(){
	/*
	* printf aloca 135618 bytes
	* chama um printf que não printa nada só pra que esse bloco seja
	* alocado antes e não interfira no Alocador desenvolvido 
	*/
	printf("a\b");

//##############################################################################
	a = iniciaAlocador();
	printf("%p\n", a);
	
	a = alocaMem(100);
	b = alocaMem(300);
	c = alocaMem(200);

	printf("%p\n%p\n%p\n\n", a, b, c);

	if(achaLivre() != NULL) printf("Não há nodos livres ainda\n");
	
	liberaMem(c);
	printf("%p livre\n\n", achaLivre());

	liberaMem(b);
	printf("%p livre\n\n", achaLivre());


	finalizaAlocador();
	return 0;
}
