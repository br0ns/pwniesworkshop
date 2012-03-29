#!/usr/bin/env python
import struct, sys

if len(sys.argv) < 2:
    print "Usage %s: [filename]" % sys.argv[0]
    exit(0)

with open(sys.argv[1], 'r') as f:
    shellcode = f.read()

print struct.pack('<L', 0xDECAFBAD) + shellcode
