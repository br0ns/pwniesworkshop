#!/bin/sh
gcc -m32 -fno-stack-protector -z execstack -o legetime1 legetime1.c
gcc -m32 -fno-stack-protector -z execstack -o legetime2 legetime2.c
gcc -m32 -fno-stack-protector -z execstack -o legetime3 legetime3.c
gcc -m32 -fno-builtin-memset -fno-stack-protector -z execstack -o legetime4 legetime4.c
gcc -m32 -fno-stack-protector -z execstack -o legetime5 legetime5.c
