imprimir macro texto
  mov ah,09h
  lea dx,texto
  int 21h
endm

.model small
;.stack 64
.data
  col db 00
  row db 00

    opcion db "Escoge una opcion:$"

    a1 db "********************",10,13,'$'
    a2 db "*  1.-Start        *",10,13,'$'
    a3 db "*  2.-Add Words    *",10,13,'$'
    a4 db "*  3.-Exit         *",10,13,'$'
    a5 db "********************",10,13,'$'
    namepar label byte
    maxlen db 2
    actlen db ?
    namefld db 02 dup(' ')

.code
    main proc far
        mov ax,@data
        mov ds,ax
        mov es,ax

        call limpiar_pantalla
        call cursor
        imprimir a1
        imprimir a2
        imprimir a3
        imprimir a4
        imprimir a5

        mov ah,09h
        lea dx,opcion
        int 21h

        mov ah,0ah
        lea dx,namepar
        int 21h

        cmp namefld,3
        je salir
        cmp namefld,1
        je comenzar

        comenzar:
          mov row,10
          mov col,15
          call cursor
          imprimir opcion

        salir:
          mov ax,4c00h
          int 21h

    main endp


    limpiar_pantalla proc near
      mov ax,0600h
      mov bh,07h
      mov cx,0000h
      mov dx,184fh
      int 10h
      ret
    limpiar_pantalla endp

    cursor proc near
      mov ah,02h
      mov bh,00
      mov dh,row
      mov dl,col
      int 10h
      ret
    cursor endp
    end
