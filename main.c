#include <stdio.h>
#include <string.h>
#include "malloc.h"

void *a, *b, *c;
long d;

int main(){
	/*
	* printf aloca 135618 bytes
	* chama um printf que não printa nada só pra que esse bloco seja
	* alocado antes e não interfira no Alocador desenvolvido 
	*/
	printf("a\b");

//##############################################################################
	a = iniciaAlocador();
		
	b = alocaMem(1000);
	printf("%p\n%p\n%ld\n\n", a, b, (long) (b-a));

	c = alocaMem(100);
	printf("%p\n%p\n%ld\n\n", b, c, (long) (c-b));
	
	for(int i = 0; i < 3; i++){
		d = liberaMem(b);
	 	if(d) printf("b corretamente desalocado\n");
		if(!d) printf("b já foi desalocado antes, abortando...\n");
	}

	for(int i = 0; i < 2; i++){
		d = liberaMem(c);
	 	if(d) printf("c corretamente desalocado\n");
		if(!d) printf("c já foi desalocado antes, abortando...\n");
	}

	finalizaAlocador();
	return 0;
}
