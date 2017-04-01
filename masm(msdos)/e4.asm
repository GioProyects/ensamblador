;Escribir una programa que reciba una cadena ingresada por teclado,
;terminada en ENTER. Luego que elimine todos los caracteres que no son dígitos,
;sin utilizar una variable auxiliar.
.model small
.stack 64
.data
  path db "archivo",00h
  handle dw ?
  outstr db 255 dup('Hola que tal ')
  msg_error db "Error fatal$"

.code
  main proc far
    mov ax,@data
    mov ds,ax

    ;mov ah,3ch
    ;mov cx,00
    ;lea dx,path
    ;int 21h
    ;jc error
    ;mov handle,ax

    mov ah,3dh
    mov al,10
    lea dx,path
    int 21h
    jc error
    mov handle,ax

    mov ah,40h
    mov bx,handle
    mov cx,256
    lea dx,outstr
    int 21h

    jc error
    cmp ax,256
    jne error

    mov ah,3eh
    mov bx,handle
    int 21h
    jmp salir

    error:
      mov ah,09h
      lea dx,msg_error
      int 21h

    salir:
      mov ax,4c00h
      int 21h
  main endp
end
