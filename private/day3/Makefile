GCC=gcc -m32 -O -z execstack -fno-stack-protector -fno-builtin

all: server hello-trampoline huge-shellcode connect-back bindshell \
  c-bindshell egg-hunter

server: server.c
	$(GCC) server.c -o server

c-bindshell: c-bindshell.c
	$(GCC) c-bindshell.c -o c-bindshell

hello-trampoline: hello-trampoline.asm
	nasm -I linux/ hello-trampoline.asm

huge-shellcode: huge-shellcode.asm
	nasm -I linux/ huge-shellcode.asm

connect-back: connect-back.asm
	nasm -I linux/ connect-back.asm

bindshell: bindshell.asm
	nasm -I linux/ bindshell.asm

egg-hunter: egg-hunter.asm
	nasm -I linux/ egg-hunter.asm

.PHONO:clean
clean:
	rm -f hello-trampoline huge-shellcode connect-back bindshell \
  c-bindshell egg-hunter server
