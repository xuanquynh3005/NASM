section .bss
    sinput  resb    32     ; reserve a 32 byte space in memory for the users input string

section .text
global _start

_start:
    mov     edx, 32         ;read max 32 bit
    mov     ecx, sinput     ;ecx = input addr 
    mov     ebx, 0          ;STDIN
    mov     eax, 3          ;SYS_READ
    int     80h

    mov     edx, 32
    mov     ecx, sinput
    mov     ebx, 1          ;STDOUT
    mov     eax, 4          ;SYS_WRITE
    int     80h

    mov     ebx, 0
    mov     eax, 1
    int     80h

