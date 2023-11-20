#include <stdio.h>
#include "malloc.h"
#include <string.h>

int main () {
	iniciaAlocador();

	char *a = (char *) alocaMem(8 * sizeof(char));
	strcpy(a, "testando");
	printf("%s\n", a);
	imprimeMapa();
	liberaMem(a);
	imprimeMapa();

	long *b = (long *) alocaMem(sizeof(long));
	*b = 10028899812;
	printf("%ld\n", *b);
	imprimeMapa();
	liberaMem(b);
	imprimeMapa();

	finalizaAlocador();
}
