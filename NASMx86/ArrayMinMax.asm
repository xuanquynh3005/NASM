section .data
    space		db  20h, 0h
    min	        dd	1000000
	max		    dd	0
    line_feed   db  0Ah, 0h

section .bss
    input		resb	30 
	output		resb	30 
    len			resd	1
section .text
    global _start

_start:
        mov     ecx, input
        mov     edx, 30
        mov     ebx, 0
        mov     eax, 3
        int     80h

        push    input
        call    atoi
        mov     [len], eax

    compare_str:
        cmp		byte [len], 0
	    jz		printf
        mov     ecx, input
        mov     edx, 30
        mov     ebx, 0
        mov     eax, 3
        int     80h
        dec     byte [len]
        push    input
        call    atoi
        mov		ebx, 0
	    mov		ebx, eax
	    cmp		ebx, [max]
	    jg		max
	    jmp		find_min

    find_min:	
	    cmp		ebx, [min]
	    jl		min
	    jmp		compare_str
    
    min:
	    mov		[min],ebx
	    jmp		compare_str

    max: 
	    mov		[max],ebx
	    jmp		find_min

    printf:
        mov 	ebx, [max]
        push    ebx
	    push	output
	    call	itoa
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, space
        mov     edx, 3
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov 	ebx, [min]
        push    ebx
	    push	output
	    call	itoa
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, line_feed
        mov     edx, 1
        mov     ebx, 1
        mov     eax, 4
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