.286
	;--------------------------------------------------------------
	spila SEGMENT
	  DB 32 DUP ('stack---')
	spila ENDS
	;--------------------------------------------------------------

	;--------------------------------------------------------------
	sdatos SEGMENT
		msjin db 'A E I O U$'
		msjcr db 'SELECCIONA UN CARACTER$'
		msjsal db 'SALIR$'
		palabra db 10 dup(?),'$'

		posx dw ?
		posy dw ?

		fil db ?
		col db ?

		auxf db 5
		auxc db 4
		char db ?, '$'
		cont db ?

	sdatos ENDS
	;--------------------------------------------------------------

	;--------------------------------------------------------------
	scodigo SEGMENT
	  ASSUME SS:spila, DS: sdatos, CS: scodigo

	  MAIN PROC FAR
		PUSH DS
		PUSH 0
		MOV AX, sdatos
		MOV DS, AX

		mov ax,0600h
		mov bh,07H
		mov cx,0000h
		mov dx,184FH
		int 10H

		;posicion del cursor
		mov ah, 02h
		mov bh, 00h
		mov dh, 3;fila
		mov dl, 4;columna
		int 10h

		;--------------ventana
		mov ch, 3 ;fila1
		mov cl, 4; columna1
		mov dh, 3; fila2
		mov dl, 20;columa2
		mov bh, 01fh; clrfondoclrtxt
		mov ah, 06h
		mov al, 00h
		int 10h

		MOV AH, 09H
		LEA DX, msjin
		int 21h

		;---------------------------------------------------------------------SALIR_----------------

		;posicion del cursor
		mov ah, 02h
		mov bh, 00h
		mov dh, 7;fila
		mov dl, 4;columna
		int 10h

		;--------------ventana
		mov ch, 7 ;fila1
		mov cl, 4; columna1
		mov dh, 7; fila2
		mov dl, 20;columa2
		mov bh, 02fh; clrfondoclrtxt
		mov ah, 06h
		mov al, 00h
		int 10h

		MOV AH, 09H
		LEA DX, msjsal
		int 21h

		;---------------------------------------------------------------------------------------

		;posicion del cursor
		mov ah, 02h
		mov bh, 00h
		mov dh, 5;fila
		mov dl, 4;columna
		int 10h
		;--------------ventana
		mov ch, 5 ;fila1
		mov cl, 4; columna1
		mov dh, 5; fila2
		mov dl, 20;columa2
		mov bh, 03fh; clrfondoclrtxt
		mov ah, 06h
		mov al, 00h
		int 10h

		;inicia mouse

		mov ax, 00h
		int 33h
		cmp ax, 00
		je fin

		pulsado:
			mov ax, 01h
			int 33h

			mov ax, 05h
			int 33h

			cmp bx, 1
			je clicizq
			cmp bx, 2
			je clicder
		jmp pulsado

		clicder:
			jmp fin

		clicizq:
		mov posx, cx
		mov ax, posx
		mov bl, 8
		div bl
		mov col, al     ; mueve a col la columna en modo texto guardada en al

		mov posy, dx;
		mov ax, posy
		mov bl,8
		div bl
		mov fil, al; mueve a fil la fila en modo texto guardada en al

		cmp fil, 7
		je fin

		mov ah, 02h
		mov bh, 00h
		mov dh, fil
		mov dl, col
		int 10h

		mov ah,08h
		mov bh,00h
		int 10h
		sub al, 30h
		mov char, al


		add char, 30h
		mov al, char


		mov palabra[si], al
		mov ah, 02h
		mov bh, 00h
		mov dh, auxf
		mov dl, auxc
		int 10h

		mov ah, 09h
		lea dx, char
		int 21h

		add auxc, 1 ;incrementa la columna para que el proximo caracter lo imprima frente al anterior
		inc si
		cmp si, 10
		je fin

	jmp pulsado


		fin:

		ret
	  MAIN ENDP
	scodigo ENDS
	;--------------------------------------------------------------

end MAIN
