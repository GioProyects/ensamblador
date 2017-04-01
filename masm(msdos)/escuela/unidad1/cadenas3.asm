; multi-segment executable file template.
.286
data segment
  cadena db 5 dup(?),'$'
  char db ?,'$'
  pedir_char db "caracter?:$"
  salto db 10,13,'$'

  no db "no esta",10,13,'$'
  si_esta db "si esta",10,13,'$'
  pos dw ?,'$'
  cad_pos db "posicion:$"
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
      je comparar
      mov cadena[si],al
      inc si 
      cmp si,5
      jne llenar

      mov ah,09h
      lea dx,salto
      int 21h

    comparar:
      mov ah,09h
      lea dx,pedir_char
      int 21h

      mov ah,01h
      int 21h
      cld
      mov cx,5
      lea di,cadena
      repne scasb
      jne no_esta

      mov ah,09h
      lea dx,salto
      int 21h

      mov ah,09h
      lea dx,si_esta
      int 21h    

      mov ah,09h
      lea dx,cad_pos
      int 21h

      ;sub di,48
      ;mov ax,di
      mov pos,cx
      mov ah,09h
      lea dx,pos
      int 21h

      jmp salir

    no_esta:
      mov ah,09h
      lea dx,salto
      int 21h

      mov ah,09h
      lea dx,no
      int 21h
    salir:
      ret
  main endp
codigo ends
end main
