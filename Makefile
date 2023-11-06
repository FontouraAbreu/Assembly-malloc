LIBS = \
/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 \
/usr/lib/x86_64-linux-gnu/crt1.o \
/usr/lib/x86_64-linux-gnu/crti.o \
/usr/lib/x86_64-linux-gnu/crtn.o 

LIBS_2 = \
/lib/ld-linux-x86-64.so.2 \
/usr/lib/crt1.o \
/usr/lib/crti.o \
/usr/lib/crtn.o

all: malloc

malloc: malloc.o
	ld malloc.o -o malloc -dynamic-linker ${LIBS} -lc 
	@rm -rf malloc.o

force: malloc.o
	ld malloc.o -o malloc -dynamic-linker ${LIBS_2} -lc 
	@rm -rf malloc.o

malloc.o: malloc.s
	as malloc.s -o malloc.o

purge:
	rm -rf malloc.o malloc
