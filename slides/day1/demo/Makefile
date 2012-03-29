
.PHONY: all clean
all:
	nasm -f elf legetime1.asm; ld -melf_i386 -o legetime1 legetime1.o
	nasm -f bin legetime2.asm
	nasm -f bin legetime3.asm
	gcc -m32 -o exploitable exploitable.c -fno-stack-protector -z execstack

clean:
	rm legetime1 legetime1.o legetime2 legetime3 exploitable