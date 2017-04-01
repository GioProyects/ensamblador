.model small
.data
mensaje db 'ABECEDARIO$'
letras db 'ABCDEFGHIJKLMNÑOPQRWYZ$'

.code
empieza:
mov ax,@data
mov ds,ax
;LIMPIA LA PANTALLA
;mov ah,00h
;mov al,03h
;int 10h
mov dx,OFFSET mensaje
mov ah,09h
int 21h
mov cx,26
mov bx,OFFSET letras
Itera:
mov al,cl
xlat
mov dl,al
mov ah,02h
int 21h
mov dl,10;BRINCA
int 21h
loop Itera

mov dx,OFFSET letras
mov ah,09h
int 21h

mov ax,4c00h
int 21h
.stack
end empieza
