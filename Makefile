CC = gcc
CFLAGS = -g -Wall -no-pie -g
PROG = main

all: $(PROG)

$(PROG): main.o memLib.o
	$(CC) $(CFLAGS) -o $(PROG) main.o memLib.o 

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

memLib.o: memLib.s
	as memLib.s -o memLib.o -g

purge:
	rm -rf *.o  $(PROG) 
