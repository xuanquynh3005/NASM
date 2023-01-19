section .bss

section .data
    msg     db      'Hello World!', 0Ah     
    len     db      $ - msg     
                               
section .text
    global  _start
 
_start:
    mov     edx, len     
    mov     ecx, msg    
    mov     ebx, 1     ;write to the STDOUT file 
    mov     eax, 4     ;system call number (sys_write)
    int     80h

    mov     ebx, 0      ;return 0 status on exit - 'No Errors'
    mov     eax, 1      ;system call number (sys_exit)
    int     80h