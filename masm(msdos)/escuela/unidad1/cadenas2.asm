; multi-segment executable file template.
.286
data segment
    cadena1 db 5 dup(?),'$'
    cadena2 db 6 dup(?),'$'

    before db "antes:$"
    after db "despues$"

    salto db 10,13,'$'
data ends

stack segment
    db 32 dup('stack---')
stack ends

codigo segment
  assume ds:data,ss:stack,cs:codigo
  main proc far
    push ds
    push 0
    mov ax,data
    mov ds,ax
    mov es,ax


    mov si,0
    llenar:
      mov ah,01h
      int 21h
      cmp al,10
      je restaurar
      mov cadena1[si],al
      inc si 
      cmp si,5
      jne llenar

    restaurar:
      mov si,0

    llenar2:
      mov ah,01h
      int 21h
      cmp al,10
      je intercambiar
      mov cadena2[si],al
      inc si 
      cmp si,6
      jne llenar2

    intercambiar:

      lea si,cadena1
      lea di,cadena2
      mov cx,4
      rep movsb

    despues:
      mov ah,09h
      lea dx,after
      int 21h

      mov ah,09h
      lea dx,salto
      int 21h

      mov ah,09h
      lea dx,cadena1
      int 21h

      mov ah,09h
      lea dx,salto
      int 21h

      mov ah,09h
      lea dx,cadena2
      int 21h      
    salir:
      ret
  main endp
codigo ends
end main
