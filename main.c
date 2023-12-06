#include <stdio.h>
#include "memLib.h"

int main (int argc, char** argv) {
  void *a, *b, *c, *d, *e;
	initAllocator();
	
	a = allocBlk(10);
	printHeap();
	b = allocBlk(20);
	printHeap();
	c = allocBlk(30);
	printHeap();
	d = allocBlk(40);
	printHeap();
	e = allocBlk(50);
	printHeap();

	freeBlk(b);
	freeBlk(d);
	printHeap();
	freeBlk(e);
	printHeap();

	b = allocBlk(15);
	printHeap();

	endAllocator();
	return 0;
}
