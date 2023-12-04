#include <stdio.h>
#include "meuAlocador.h"

int main (int argc, char** argv) {
 	void *a;
	iniciaAlocador(); 

	a = (char *) alocaMem(10 * sizeof(char));
	liberaMem(a);

	finalizaAlocador();
}
