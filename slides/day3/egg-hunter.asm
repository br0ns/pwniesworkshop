loop:   push eax
        inc esp
        pop eax
        cmp eax, 0xDECAFBAD
        jne short loop
        jmp esp
