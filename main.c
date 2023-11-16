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
	printBlock(a);
	liberaMem(a);

	b = alocaMem(200);
	printBlock(b);
	liberaMem(b);

	c = alocaMem(100);
	printBlock(c);

	d = alocaMem(200);
	printBlock(d);

	liberaMem(c);
	liberaMem(d);

	finalizaAlocador();
	return 0;
}
