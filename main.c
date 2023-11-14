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
	iniciaAlocador();
	
	a = alocaMem(100);
	b = alocaMem(200);
	c = alocaMem(300);
	printf("%p\n%p\n%p\n\n", a, b, c);
	liberaMem(a);
	liberaMem(b);

	printf("%p\n", achaLivre(100));
	d = achaLivre(200);
	if (d != NULL) printf("%p\n", d);

	finalizaAlocador();
	return 0;
}
