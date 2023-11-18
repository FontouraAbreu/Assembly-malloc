#include <stdio.h>
#include <string.h>
#include "malloc.h"

void *a, *b, *c, *d;

int main(){
	iniciaAlocador();

	a = alocaMem(10);
	b = alocaMem(5);
	Print();

	liberaMem(a);
	Print();
	liberaMem(b);
	Print();
	
 	c = alocaMem(31);
	Print();

	liberaMem(c);
	Print();

	d =	alocaMem(32);
	Print();

	liberaMem(d);
	Print();

	finalizaAlocador();
	return 0;
}
