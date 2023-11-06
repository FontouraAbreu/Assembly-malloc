LIBS = \
/lib/ld-linux-x86-64.so.2 \
/usr/lib/crt1.o \
/usr/lib/crti.o \
/usr/lib/crtn.o

all: malloc
	@rm -rf malloc.o

malloc.o:	
	as malloc.s -o malloc.o

malloc: malloc.o
	ld malloc.o -o malloc -dynamic-linker ${LIBS} -lc

purge:
	rm -rf malloc.o malloc
