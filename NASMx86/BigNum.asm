section .data
   	len1	    dd  0
	len2	    dd  0
	lenmin	    dd  0

section .bss
   	num1        resb    20
   	num2        resb    20
    num3        resb    20

section .text
    global _start

_start:
        mov     ecx, num1
        mov     edx, 20
        mov     ebx, 0
        mov     eax, 3
        int     80h

        push	num1
		call	LEN
		mov		[len1], eax
        mov     ebx, num1
        add     ebx,eax
        mov     BYTE [ebx], 0

        mov     ecx, num2
        mov     edx, 20
        mov     ebx, 0
        mov     eax, 3
        int     80h

        push	num2
		call	LEN
		mov		[len2], eax
        mov     ebx, num2
        add     ebx,eax
        mov     BYTE [ebx], 0
        push	num1
		call	CHECK
		push	num2
		call	CHECK

        mov	eax, [len1]
		cmp	eax, [len2]			; len1 > len2
		jg	L1
		cmp	eax, [len2]			; len1 < len2
		jle	L2

    L1:
        mov		eax, [len2] 
		mov		[lenmin], eax
		push    num1
		push    num2
		mov     eax, [lenmin]
        push    eax
		call	ADD_TWO
		push    num3
		call	CHECK

        xor     ecx, ecx
        mov     ecx, num3
        mov     edx, 20
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ebx, 0
        mov     eax, 1
        int     80h

    L2:
        mov		eax, [len2]
		mov		[lenmin], eax
		push	num2
		push	num1
    	mov     eax, [lenmin]
		push	eax
		call	ADD_TWO
    	push    num3
		call	CHECK

        xor     ecx, ecx
        mov     ecx, num3
        mov     edx, 20
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ebx, 0
        mov     eax, 1
        int     80h


ADD_TWO:
	    push	ebp
	    mov		ebp, esp
	    mov		ecx, [ebp+8]		;	lenmin
	    mov		esi, [ebp+12]		;	dia chi nho
	    mov		edi, [ebp+16]		;	dia chi lon
	    mov		edx, num3
	    mov		eax, 0
	    jmp		L13
    L23:	
	    sub		al, 0Ah
	    xor		ah, ah
	    mov		ah, 1
	    jmp		L33
    L13:	
	    mov		ebx,0
	    add		bh,ah
	    mov		eax, 0
	    mov		bl, BYTE [edi]
	    mov		al, BYTE [esi]
		cmp		al, 0
		jz		L93
		sub		al, 30h

	L93:
	    sub		bl, 30h
	    add		bl,bh
	    add		al,bl
	    cmp		al,0Ah
	    jge		L23
    L33:
	    add		al, 30h
	    mov		BYTE [edx], al
	    inc		esi
	    inc		edx
	    inc		edi
	    loop	L13
	
	    mov		ebx,[lenmin]
	    cmp		ebx,[len1]
	    jne		L43
	    jmp		L73

    L43:	
	    mov		ebx, 0
	    add		bh, ah
	    mov		bl, BYTE [edi]
	    cmp		bl, 0h
	    je		L73
	    mov		eax, 0
	    sub		bl, 30h
	    add		bl, bh
	    mov		eax, 0
	    cmp		bl, 0Ah
	    jge		L53

    L63:	
	    add		bl, 30h
	    mov		BYTE [edx], bl
	    inc		edx
	    inc		edi
	    loop	L43

    L53:	
	    sub		bl, 0Ah
	    xor		ah, ah
	    mov		ah, 1
	    jmp		L63

    L73:	
	    cmp		ah,1h
	    je		L83
	    inc		edx
	    mov		BYTE [edx],	0
	    pop		ebp
	    ret		12

    L83:
	    mov		BYTE [edx],	1
	    add		BYTE [edx],	30h
	    inc		edx
	    mov		BYTE [edx],	0
	    pop		ebp
	    ret		12


CHECK:
	    push	ebp
	    mov		ebp, esp
	    mov		esi, [ebp+8]
	    mov		edi, [ebp+8]
	    mov		ecx, 0
    L12:	
	    mov		eax, 0
	    mov		al,	BYTE [esi]
	    cmp		al, 0
	    jz		L21
	    push	eax
	    inc		esi
	    inc		ecx
	    jmp		L12
    L21:			
	    mov		eax, 0
	    pop		eax
	    mov		BYTE [edi],al
	    inc		edi
	    loop	L21
	    pop		ebp
	    ret		4

LEN:
        push	ebp
	    mov		ebp, esp
	    mov		ebx, [ebp+8]
	    mov		eax,0

    L11:
	    cmp		BYTE [ebx], 0Ah
	    jz		L22
	    inc		eax
	    inc		ebx
	    jmp		L11
	
    L22:
	    pop		ebp
	    ret		4

