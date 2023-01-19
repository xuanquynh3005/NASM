section .data

section .bss
    inp     resb 30
section .text
global _start

_start:
    mov     edx, 30
    mov     ecx, inp
    mov     ebx, 0
    mov     eax, 3

    push    inp
    call    reverse

    mov     edx, eax
    mov     ecx, inp
    mov     ebx, 1
    mov     eax, 4

    mov     ebx, 0
    mov     eax, 1
    int     80h

reverse: 
    push    ebp
    mov     ebp, esp
    push    ebx
    mov     ebx, [ebp+08h]          ;str
    xor     esi, esi

    re:
        xor     edx, edx
        mov     dl, [ebx+esi]
        cmp     dl, 0Ah 
        jz      popstr
        push    edx
        inc     esi
        jmp     re

    popstr:
        xor     edx, edx
        pop     edx
        mov     [ebx], dl
        inc     ebx
        dec     esi
        cmp     esi, 0h
        jz      break
        jmp     popstr

    break:
        pop     ebx
        pop     ebp
        ret     4