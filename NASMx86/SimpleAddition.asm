section .bss
    a_inp       resb    32
    b_inp       resb    32
    sum         resb    32
    num1        resb    32
    num2        resb    32
    ans         resb    32

section .text
global _start

_start:
    mov     edx, 32         ;read max 32 bit
    mov     ecx, a_inp      ;ecx = input addr of a
    mov     ebx, 0          ;STDIN
    mov     eax, 3          ;SYS_READ
    int     80h

    push    a_inp
    call    atoi
    mov     [num1], eax

    mov     edx, 32
    mov     ecx, b_inp      ;ecx = input addr of b
    mov     ebx, 0
    mov     eax, 3
    int     80h

    push    b_inp
    call    atoi
    mov     [num2], eax

    mov		ebx, 0
	mov		eax, [num1]
	mov		ebx, [num2]
	add		eax, ebx

    mov     [sum], eax

    push    ans
    push    sum
    call    itoa

    mov     edx, 32
    mov     ecx, ans
    mov     ebx, 1          ;STDOUT
    mov     eax, 4          ;SYS_WRITE
    int     80h

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