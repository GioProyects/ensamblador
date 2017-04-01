title minmay (com)

.model small
.stack 64
.code
org 100h

begin:
	jmp main

titlex db "cambio a mayusculas"

	main proc near
		lea bx,titlex+1
		mov cx,26

		b20:
			mov ah,[bx]
			cmp ah,61h
			jb b30
			cmp ah,7ah
			ja b30
			and ah,11011111b
			mov [bx],ah
		b30:
			inc bx

			loop b20
		mov ax,4c00h
		int 21h
	main endp
end begin