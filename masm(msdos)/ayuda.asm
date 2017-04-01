.model small
.data
  ;ruta db 64 dup ("$")
  saludo db "hola mundo",10,13,'$'
  namepar db 20 dup ('$')
.code
  main proc far

    mov ax,@data
    mov ds,ax


    mov ah,00h
    mov al,12h
    int 10h

    mov ah,0ch
    mov al,10h
    mov bh,00h
    mov cx,04h
    mov dx,00h
    int 10h

    call salir

  main endp

  modo_video proc near
    mov ah,00h
    mov al,03h
    int 10h
    ret
  modo_video endp

  imprimir_mensaje proc near
    mov ah,09h
    lea dx,saludo
    int 21h
    ret
  imprimir_mensaje endp

  salir proc near
    mov ax,4c00h
    int 21h
    ret
  salir endp

  entrada_teclado proc near
    mov ah,0ah
    lea dx, namepar
    int 21h
    ret
  entrada_teclado endp

  limpiar_pantalla proc near
    mov ax,0600h
    mov bh,07h
    mov cx,0000h
    mov dx,184fh
    int 10h
    ret
  limpiar_pantalla endp

  fijar_cursor proc near
    mov ah,02h
    mov bh,00h
    mov dx,0000h
    int 10h
    ret
  fijar_cursor endp

  end
