xor ebx, ebx  ; virker altid
mul ebx       ; hvis ebx nul     -> eax+edx tom
shl eax, 31   ; hvis eax lige    -> eax tom
shr eax, 31   ; hvis eax positiv -> eax tom
cdq           ; hvis eax positiv -> edx tom

push byte 7
pop eax       ; eax = 7
