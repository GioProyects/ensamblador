;colocacion del cursor
;	mov ah,02h
;	mov bh,0
;	mov dh,20
;	mov dl,12
;	int 10h


;limpiar pantalla
; AH = función 06H
; AL = OOH para la pantalla completa
; BH = número del atributo
; CX = renglón:columna iniciales
; DX = renglónxolumna finales

;mov ax,0600h
;mov bh,71h	;blanco(7) sobre azul(1)
;mov cx,0000h;esquina superior izquierda
;mov dx,184fh;esquina inferior derecha
;int 10h


;despliegue en pantalla




page 60.132
title pantalla
.model small
.stack 64
.data
	cadena db 'nombre?','$'
.code
	main proc far

	mov ah,09h
	lea dx,cadena
	int 21h

	mov ax,4c00h
	int 21h
	main endp
	end main