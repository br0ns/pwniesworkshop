[BITS 32]

global _start

; Strengen /bin/sh bruges i execve
sh: db "/bin/sh", 0

_start:
    mov eax, 11 ; vælg funktionen execve
    mov ebx, sh ; sæt første argument (filename)
    mov ecx, 0  ; sæt andet argument (argv)
    mov edx, 0  ; sæt tredje argument (envp)
    int 0x80    ; kald på styresystemet
