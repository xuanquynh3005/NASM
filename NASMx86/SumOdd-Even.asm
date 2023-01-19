section .data
    SumO    db "Tong le = ", 0h 
    SumE    db "Tong chan = ", 0h 
    nl      db 0Ah, 0Dh, 0h 
    
section .bss
    num     resb 10
    odd     resd 1
    even    resd 1
    
section .text
global _start

_start:
    push    10
    push    num
    call    read

    push    num
    call    atoi
    mov     esi, eax           

    find:
        cmp     esi, 0
        jz      break
        push    10
        push    num
        call    read
        dec     esi
        push    num
        call    atoi
        mov     ebx, eax
        mov     ecx, 2
        xor     edx, edx
        div     ecx
        cmp     dl, 1           ;eax%ecx == 1
        jz      odd             ;jmp sum odd
    
    even:
        mov     edi, [even]
        add     edi, ebx
        mov     [even], edi
        jmp     find

    odd:
        mov     edi, [odd]
        add     edi, ebx
        mov     [odd], edi
        jmp     find

    break:
        push    11
        push    SumO
        call    write
        xor     edx, edx
        mov     edx, [odd]
        push    edx
        push    num
        call    itoa
        push    10
        push    num
        call    write

        push    2
        push    nl
        call    write

        push    13
        push    SumE
        call    write
        xor     edx, edx
        mov     edx, [even]
        push    edx
        push    num
        call    itoa
        push    10
        push    num
        call    write

        push    2
        push    nl
        call    write
    
    mov     ebx, 0
    mov     eax, 1
    int     80h

atoi:
	push	ebp
	mov	    ebp, esp
	push	esi
	push	edx
	push	ebx

	mov	    esi, [ebp + 8]
	xor	    eax, eax
	mov	    ebx, 10
	
	atoi_str:
        mul     ebx
        mov	    dl, [esi]
        inc	    esi
        cmp	    dl, 0Ah
        jz	    done
        and	    dl, 0Fh
        add	    eax, edx
        jmp	    atoi_str

	done:
        xor	    edx, edx	
        div	    ebx
        pop	    ebx
        pop	    edx
        pop	    esi
        pop	    ebp	
        ret	    4

itoa:
    push	ebp	
	mov	    ebp, esp
	push	edi
	push	edx
	push	ebx

	mov	    edi, [ebp + 0Ch]
	add	    edi, 9
	mov	    byte [edi], 0Ah
	dec	    edi
	mov	    eax, [ebp + 08h]
	mov	    ebx, 10
	
	itoa_str:
        xor	    edx, edx
        div	    ebx
        or	    dl, 30h
        mov	    [edi], dl
        dec	    edi
        test	eax, eax
        jz	    done
        jmp	    itoa_str

	done:
        add	    edi, 9
        sub	    edi, [ebp + 0Ch]
        mov	    eax, edi
        pop	    ebx
        pop	    edx
        pop	    edi
        pop	    ebp
        ret	    8

read:
    push    ebp
    mov     ebp, esp
    push    edx
    push    ecx
    push    ebx

    mov     edx, [ebp+0Ch]          ;num
    mov     ecx, [ebp+08h]          ;str
    mov     ebx, 0
    mov     eax, 3
    int     80h

    pop     ebx
    pop     ecx
    pop     edx
    mov     esp, ebp
    pop     ebp
    ret     8

write:
    push    ebp
    mov     ebp, esp
    push    edx
    push    ecx
    push    ebx
    push    eax

    mov     edx, [ebp+0Ch]          ;num
    mov     ecx, [ebp+08h]          ;str
    mov     ebx, 1
    mov     eax, 4
    int     80h

    pop     eax
    pop     ebx
    pop     ecx
    pop     edx
    mov     esp, ebp
    pop     ebp
    ret     8