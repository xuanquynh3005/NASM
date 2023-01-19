section .data
    num         dd      0
    num2        dd      0
    num3        dd      1
    nline		db		20h, 0h
section .bss
    input		resb	30 
	output		resb	30 
section .text
    global _start

_start:
        mov     ecx, inputE
        mov     edx, 30
        mov     ebx, 0
        mov     eax, 3
        int     80h

        push    input
        call    atoi
        mov     [num], eax
        cmp		BYTE [num],3
	    jge		el1
	    call	FIBONACI

    el1:
        mov		eax, 0
	    push	eax
	    push	output
	    call	itoa

        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, nline
        mov     edx, 1
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov		eax, 1
	    push	eax
        push	output
	    call	itoa
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, nline
        mov     edx, 1
        mov     ebx, 1
        mov     eax, 4
        int     80h

        call    FIBONACI
        push    eax
        push	output
	    call	itoa

        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ebx, 0
        mov     eax, 1
        int     80h

FIBONACI:
        push	ebp
	    mov		ebp, esp
	    mov		ecx, 0
	    mov		ecx, [num]
	    xor		eax, eax
	    xor		ebx, ebx
	    jmp		L1

    L3:	
	    mov		eax, ecx
	    push	eax
	    push	output
	    call	itoa
	    xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h
	
        mov     ebx, 0
        mov     eax, 1
        int     80h

    L1:
	
	    cmp		ecx, 0
	    je		L3
	    cmp		ecx, 1
	    je		L3
	    cmp		ecx, 2
	    je		L6
	    jmp		L4

    L4:
	    xor		eax, eax
	    xor		ebx, ebx
	    mov		eax, [num2]
	    mov		ebx, [num3]
	    mov		[num2],ebx
	    add		eax, ebx
	    mov		[num3],eax
	    cmp		ecx, 3
	    je		L5
	    jmp		L7
    L5:
	    xor		eax, eax
	    mov		eax, [num3]
	    pop		ebp
	    ret		4

    L6:
	
	    mov		eax, 0
	    push	eax
        push	output
	    call	itoa
	    xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, nline
        mov     edx, 3
        mov     ebx, 1
        mov     eax, 4
        int     80h

	    mov		eax, 1
	    push	eax
	    push	output
	    call	itoa
	
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ebx, 0
        mov     eax, 1
        int     80h

    L7:

	    mov		ebx, ecx
	    push	ebx
	    push	eax
	    push	output
	    call	itoa
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

	    xor     ecx, ecx
        mov     ecx, nline
        mov     edx, 3
        mov     ebx, 1
        mov     eax, 4
        int     80h
        pop		ebx
	    mov		ecx, ebx
	    dec		ecx
	    jmp		L4

atoi:
	push	ebp
	mov	    ebp, esp
	push	esi
	push	edx
	push	ebx

	mov	    esi, [ebp + 8]
	xor	    eax, eax
	mov	    ebx, 10
	
	.atoi_str:
        mul     ebx
        mov	    dl, [esi]
        inc	    esi
        cmp	    dl, 0Ah
        jz	    .done
        and	    dl, 0Fh
        add	    eax, edx
        jmp	    .atoi_str

	.done:
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
	
	.itoa_str:
        xor	    edx, edx
        div	    ebx
        or	    dl, 30h
        mov	    [edi], dl
        dec	    edi
        test	eax, eax
        jz	    .done
        jmp	    .itoa_str

	.done:
        add	    edi, 9
        sub	    edi, [ebp + 0Ch]
        mov	    eax, edi
        pop	    ebx
        pop	    edx
        pop	    edi
        pop	    ebp
        ret	    8