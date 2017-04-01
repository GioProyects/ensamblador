PAGE 60,132
TITLE ESCANECADENAS cadenas iguales .exe
.model small
.stack 64
.data
  cad1 db "hola mundo$"
  cad2 db "hola mundo$"
  msg db "son iguales$"
  msg2 db "no son iguales$"
  conta dw 0

.code
  begin proc far
    mov ax,@data
    mov ds,ax

    comienzo:
      mov si,conta
      mov al,cad2[si]
      cmp cad1[si],al
      jne fin
      cmp cad1[si],"$"
      jz final
      inc conta
      loop comienzo

    final:
      mov dx,offset msg
      mov ah,09h
      int 21h
      jmp salir


      fin:
        mov dx,offset msg2
        mov ah,09h
        int 21h

      salir:
        mov ax,4c00h
        int 21h
  begin endp
  end begin
