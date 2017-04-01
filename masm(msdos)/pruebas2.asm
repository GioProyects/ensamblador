.model small
.data
  nombre db "oscar geovani"
  nombre_len db 13
  row db 00
  col db 00

.code
  main proc far
    mov ax,@data
    mov ds,ax

    lea si,nombre
    e20:
      call cursor
      mov bl,0f1h   ;video inverso

      call imprimir
      inc si
      inc col
      dec nombre_len
      jnz e20

      cmp row,20
      jae e30
      inc row

    e30:
      mov ax,0501h
      call limpiar_pantalla

    mov ax,4c00h
    int 21h
  main endp

  limpiar_pantalla proc near
    mov bh,17h        ;blanco sobre azul
    mov cx,0000
    mov dx,184fh      ;pantalla completa
    int 10h
    ret
  limpiar_pantalla endp


  imprimir proc near
    mov ah,09h
    mov al,[si]
    mov bh,00
    mov cx,01
    int 10h
    ret
  imprimir endp

  cursor proc near
    mov ah,02h
    mov bh,00
    mov dh,row
    mov dl,col
    int 10h
    ret
  cursor endp
  end
