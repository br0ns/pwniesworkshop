;; Talk at Pwnies: Advanced shellcode
;; DIKU, fall 2011
;;
;; Morten Brøns-Pedersen
;;
;; Demonstration of the trampoline technique.
;;
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        bits 32
        %include "32.asm"
start:  jmp short trampoline
entry:  xor eax, eax            ; write(
        mov al, SYS_write
        xor ebx, ebx            ; std_out,
        mov bl, STD_OUT
        pop ecx                 ; *data,
        xor edx, edx
        mov dl, 19              ; 19);
        int 0x80
        ;; We could exit here, but hell, let's go again!
trampoline:
        call entry
data:   db `Hello, trampoline!\n`