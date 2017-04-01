%macro imprimir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .text
	GLOBAL _start

_start:
	mov ecx,len
	mov edi,cadena
	mov esi,carac	
	cld
	comienzo:
		repne cmpsb cadena,carac
		je found

		imprimir msg_notfound,len_notfound
		jmp exit

	found:
		inc edi
		inc esi
		jmp comienzo

	imprimir msg_found,len_found

	exit:
		mov eax,1
		mov ebx,0
		int 80h

section .data
	cadena db "escaso",0
	len equ $ - cadena

	carac db "caso",0
	len2 equ $ - carac

	msg_found db "found",10,13
	len_found equ $ - msg_found

	msg_notfound db "no found",10,13
	len_notfound equ $ - msg_notfound