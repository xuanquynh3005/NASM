section .data
    Hello   db "Hello World!", 0Ah, 0h

section .bss

section .text
global _start:

_start:
    mov     rbp, rsp

    mov     rdi, 1                      ;file handle 1 is stdout
    mov     rsi, Hello                  ;address of string to output
    mov     rdx, 13                     ;sizeof Hello
    mov     rax, 1                      ;sys_write
    syscall                             ;invoke operating system to do the write

    mov     rdi, 0                      ;exit code 
    mov     rax, 60                     ;sys_exit
    syscall                             ;invoke operating system to exit


