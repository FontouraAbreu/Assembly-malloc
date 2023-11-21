CC = gcc
CFLAGS = -g -Wall -no-pie -g
PROG = avalia

all: $(PROG)

$(PROG): avalia.o meuAlocador.o
	$(CC) $(CFLAGS) -o $(PROG) avalia.o meuAlocador.o 

avalia.o: avalia.c
	$(CC) $(CFLAGS) -c avalia.c -o avalia.o

meuAlocador.o: meuAlocador.s
	as meuAlocador.s -o meuAlocador.o -g

purge:
	rm -rf *.o  $(PROG) 
