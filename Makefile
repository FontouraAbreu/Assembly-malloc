LIBS = \
/lib/ld-linux-x86-64.so.2 \
/usr/lib/crt1.o \
/usr/lib/crti.o \
/usr/lib/crtn.o

malloc:
	as malloc.s -o malloc.o
	ld malloc.o -o malloc -dynamic-linker ${LIBS} -lc

purge:
	rm -rf malloc.o malloc
