GCC=gcc -m32 -O0 -z execstack -fno-stack-protector -fno-builtin

.PHONO: all clean
all:
	$(GCC) -o legetime1 legetime1.c
	$(GCC) -o legetime2 legetime2.c
	$(GCC) -o legetime3 legetime3.c
	#$(GCC) -o legetime4 legetime4.c
	nasm e-penis.asm

clean:
	rm -f legetime1 legetime2 legetime3 legetime4 e-penis
