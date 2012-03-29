[BITS 32]

    ; Push strengen "/bin/sh".
    push `/sh\0`
    push `/bin`

    ; Sæt argumenterne til execve op
    mov eax, 11
    mov ebx, esp
    mov ecx, 0
    mov edx, 0

    ; Kald styresystemet
    int 0x80
