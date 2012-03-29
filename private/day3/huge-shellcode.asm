;; Talk at Pwnies: Advanced shellcode
;; DIKU, fall 2011
;;
;; Morten Brøns-Pedersen
;;
;; Huge shellcode to demonstrate egg and omelet hunters. Trampoline based hello
;; world style, just prints ~3.5K lipsum.
;;
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        bits 32
        %include "32.asm"
start:
        jmp short trampoline
entry:
        ;; Write lipsum
        xor eax, eax
        mov al, SYS_write
        xor ebx, ebx
        mov bl, STD_OUT
        pop ecx
        xor edx, edx
        mov dx, 3502
        int 0x80
        ;; Clean exit
        xor eax, eax
        inc eax
        int 0x80
trampoline:
        call entry
        ;; 3502 characters
data:   db `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquam libero eu mi tempor ut tempus augue porta. Praesent lacinia augue eu eros tincidunt ullamcorper. Nullam et ante nec ante varius tincidunt. Vivamus sagittis tellus sed ipsum bibendum eget fringilla massa commodo. Integer dolor orci, consequat quis dapibus vitae, iaculis lacinia leo. Pellentesque viverra, urna rhoncus scelerisque euismod, nulla enim volutpat nunc, non laoreet enim leo non nunc. Etiam neque massa, sollicitudin vel pretium sed, mollis vel enim. Donec eu erat neque, eget semper neque. Sed odio justo, elementum sit amet luctus a, semper sed diam. Donec et sapien nec lorem rhoncus viverra. Nullam malesuada, erat nec rhoncus posuere, augue est hendrerit velit, eu facilisis ante orci vel tortor.\n\nPellentesque gravida auctor neque in lobortis. Suspendisse enim turpis, faucibus nec scelerisque a, eleifend id justo. Integer varius sagittis nunc nec porta. Phasellus vitae nibh sit amet libero convallis lacinia. Curabitur aliquam molestie massa, quis facilisis augue rutrum eget. Aliquam odio leo, facilisis at scelerisque eget, consequat luctus est. Nam iaculis tortor eget arcu elementum placerat. Cras porttitor posuere convallis. Quisque congue lacus non ante rhoncus vel condimentum dolor rhoncus. Nullam cursus lorem ac purus eleifend hendrerit. Donec urna tortor, imperdiet hendrerit placerat quis, malesuada malesuada nibh. Cras consequat pharetra tortor, vel malesuada dui ultrices non. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque in feugiat lectus. Pellentesque eget mauris massa, quis lacinia enim. Aliquam congue, ipsum non imperdiet tristique, magna nibh venenatis enim, id accumsan est dui id metus.\n\nProin ultricies faucibus dignissim. In hac habitasse platea dictumst. Sed luctus cursus ipsum, id vehicula mi interdum eu. Suspendisse nec pretium justo. Aenean rutrum leo vitae lectus lobortis elementum. In id est in justo egestas bibendum non id mauris. Fusce nec metus magna. Ut hendrerit nunc lorem. Maecenas a eros odio, vel hendrerit felis. Nam vehicula commodo tellus, at fermentum ipsum luctus eget.\n\nProin eget elit libero, in placerat massa. Morbi metus diam, commodo ac vestibulum eget, gravida eget augue. Curabitur tristique hendrerit mattis. Ut eros nisi, imperdiet sed pharetra eu, consequat in felis. Vestibulum ut lorem nec est interdum ornare id eu justo. Aenean non est tortor, sit amet sodales augue. Donec sapien ligula, porttitor et faucibus lobortis, interdum quis justo. Quisque id consequat metus.\n\nUt ligula nulla, venenatis a mattis ac, tempus at mi. Aliquam nibh libero, tincidunt vel pulvinar ut, lobortis vitae libero. Vestibulum varius pretium dui, id fringilla nibh scelerisque id. In tincidunt, arcu ac bibendum volutpat, urna justo posuere elit, id sollicitudin arcu mauris et nunc. Curabitur imperdiet nisl quis odio molestie vitae dapibus lorem aliquam. Maecenas et consequat leo. Morbi sapien ligula, commodo et tempor a, dictum ac felis. Mauris massa tellus, tincidunt ac placerat tincidunt, hendrerit quis mauris. Donec sapien magna, pretium et posuere eget, interdum sed justo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse ornare nibh sit amet erat posuere cursus. Fusce accumsan ornare arcu, sit amet eleifend turpis interdum in. Sed feugiat, purus sit amet sollicitudin fringilla, libero felis bibendum libero, ut varius felis velit at arcu.`
