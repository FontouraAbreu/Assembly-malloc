CC = gcc
CFLAGS = -g -Wall -no-pie
PROG = malloc

all: $(PROG)

$(PROG): main.o malloc.o
	$(CC) $(CFLAGS) -o $(PROG) main.o malloc.o 

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

malloc.o: malloc.s
	as malloc.s -o malloc.o

purge:
	rm -rf *.o  $(PROG) 
