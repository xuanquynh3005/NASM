section .data

section .bss
    string  resb 100

section .text
global _start

_start:
    mov     rbp, rsp

    mov     rdx, 256
    mov     rdi, 0          
    mov     rsi, string
    mov     rax, 0          
    syscall

    mov     rsi, string
    call    reverse

    mov     rsi, string
    mov     rdx, rdi
    call    printf

    mov     rdi, 0
    mov     rax, 60
    syscall

printf:
    mov     al, 0Ah
    mov     [rsi+rdx], al
    inc     rdx
    mov     rdi, 1
    mov     rax, 1
    syscall
    ret

reverse:
    push    rbp
    mov     rbp, rsp
    push    rax
    push    rcx
    push    rdx
    mov     rdi, rsi        ;add str
    mov     rdx, rsi
    xor     rax, rax
    xor     rcx, rcx

    pushstr:
        lodsb               ;al = [esi++]
        cmp     al, 0Ah
        jz      popstr
        push    rax
        inc     rcx
        jmp     pushstr

    popstr:
        cmp     rcx, 0
        jz      break
        pop     rax
        stosb               ;al = [edi++]
        dec     rcx
        jmp     popstr 

    break:
        sub     rdi, rdx    ;len str
        pop     rdx
        pop     rcx
        pop     rax
        mov     rsp, rbp
        pop     rbp
        ret