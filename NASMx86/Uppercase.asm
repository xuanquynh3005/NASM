section .bss
    sinput  resb    32

section .text
global _start

_start:
    mov     edx, 32         ;read max 32 bit
    mov     ecx, sinput     ;input addr 
    mov     ebx, 0          ;STDIN
    mov     eax, 3          ;SYS_READ
    int     80h

    push    eax
    call    Uppercase

    mov     edx, 32         ;read max 32 bit
    mov     ecx, sinput     ;input addr 
    mov     ebx, 1          ;STDOUT
    mov     eax, 4          ;SYS_WRITE
    int     80h

    mov     ebx, 0
    mov     eax, 1
    int     80h
    
Uppercase:
    push    ebp
    mov     ebp, esp
    push    esi
    mov     esi, sinput             ;esi = input addr 

    upper:
        cmp     byte [esi], 0       ;compare each byte of input to 0
        jz      pop_str
        cmp     byte [esi], 'a'
        jl      return
        cmp     byte [esi], 'z'
        jg      return
        sub     byte [esi], 20h
    
    return: 
        inc     esi
        jmp     upper

    pop_str:
        pop     edx
        pop     ebp
        ret     4

