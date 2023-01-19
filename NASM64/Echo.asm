section .data

section .bss
    msg     resb    100

section .text
global _start

_start:
    mov     rbp, rsp

    mov     rdx, 100
    mov     rdi, 0          ;handle file 0 is stdin
    mov     rsi, msg
    mov     rax, 0          ;sys_read
    syscall

    mov     rdx, 100
    mov     rdi, 1          ;handle file 1 is stdout
    mov     rsi, msg
    mov     rax, 1          ;sys_write
    syscall

    mov     rdi, 0          ;exit code 0
    mov     rax, 60         ;sys_exit
    syscall
