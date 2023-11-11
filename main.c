#include <stdio.h>
#include "malloc.h"

void *a, *b;
long c;

int main(){
	printf("\n");
	a = IniciaAlocador();
	printf("a inicial: %p\n", a);
/*	
	b = AumentaHeap(10);
	c = (long) (b - a);
	printf("a: %p\nb: %p\ndif: %ld\n\n", a, b, c);
*/	
	a = FinalizaAlocador();
	printf("a final: %p\n", a);
	return 0;
}
