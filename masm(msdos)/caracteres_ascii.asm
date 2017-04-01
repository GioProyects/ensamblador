page 60.132
title ascii (com)
.model small
.stack 64
.data
	char db 00,'$'
	mensaje db "hola mundo$"
.code

begin:

	mov ax,@data
	mov ds,ax

	;procedimiento principal
	main proc far
		call b10clr
		call c10set
		call d10disp
		mov ax,4c00h
		int 21h
	main endp


	;despejar pantalla
	b10clr proc near
		mov ax,0600h;recorre toda la pantalla
		mov bh,07	;blanco sobre negro
		mov cx,0000	;posicion izquierda superior
		mov dx,184fh;posicion derecha inferior
		int 10h
		ret
	b10clr endp

	;fijar cursor en 0,0
	c10set proc near
		mov ah,02h	;peticion de fijar el cursor
		mov bh,00	;pagina cero
		mov dx,0000	;fila 0 , columna 0
		int 10h
		ret
	c10set endp

	;exhibir caracteres ascii
	d10disp proc
		mov cx,256	;iniciar 256 caracteres
		lea dx,char	;iniciar direccion de caracter
		;sub dx,'0'
		d20:
			mov ah,09h	;imprime caracter en pantalla
			int 21h		
			inc char	;incrementa para el sig caracter
			loop d20	
			ret
	d10disp endp
	end begin
