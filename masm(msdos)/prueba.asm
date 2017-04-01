page 60,132
title programa
.model small
.stack 64
.data
	msg1 db "hola mundo$"
	msg2 db "hola mundo$"
	msg db "son iguales$"
	x dw 0
.code
	begin proc far
		;assume ss:stacksg,ds:datasg,cs:codesg
		mov ax,@data
		mov ds,ax

		comienzo:
			mov si,x
			mov al,msg2[si]
			cmp msg1[si],al
			jne fin
			cmp msg1[si],"$"
			jz final

		inc x
		loop comienzo

		fin:
			ret
		final:
			mov ah,09h
			mov dx,offset msg
			mov ax,4c00h
			int 21h
	begin endp
end begin
