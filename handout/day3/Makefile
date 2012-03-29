GCC=gcc -m32

all: huge-shellcode connect-back bindshell c-bindshell egg-hunter

c-bindshell: c-bindshell.c
	$(GCC) c-bindshell.c -o c-bindshell

huge-shellcode: huge-shellcode.asm
	nasm -I linux/ huge-shellcode.asm

connect-back: connect-back.asm
	nasm -I linux/ connect-back.asm

bindshell: bindshell.asm
	nasm -I linux/ bindshell.asm

egg-hunter: egg-hunter.asm
	nasm -I linux/ egg-hunter.asm

clean:
	rm -f c-bindshell huge-shellcode connect-back bindshell egg-hunter