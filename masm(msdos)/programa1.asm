; multi-segment executable file template.
.286
data segment
    mensaje db "Dame 2 numeros:",10,13,'$'
    a db ? ,'$'
    b db ?
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

    mov ah,09h
    lea dx,mensaje
    int 21h

    mov ah,01h
    int 21h
    mov a,al

    mov ah,01h
    int 21h
    add a,al
    sub a,48

    mov ah,09h
    lea dx,a
    int 21h

    ret
  main endp
codigo ends
end main
