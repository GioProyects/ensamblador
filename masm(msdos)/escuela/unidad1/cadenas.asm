; multi-segment executable file template.
.286
data segment
    ; add your data here!
    msg db "antes:",10,13,'$'
    msg1 db "despues:",10,13,'$'


    cad1 db 4 dup(?),'$'
    cad2 db 5 dup(?),'$'
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


    mov ah,09h
    lea dx,msg
    int 21h

    ciclo:
      mov ah,01h
      int 21h
      cmp al,10
      je inicio
      mov cad1[si],al
      inc si
      cmp si,4
      jne ciclo

    inicio:
      mov dx,si
      mov si,0

    ciclo2:
      mov ah,01h
      int 21h
      cmp al,10
      je comparar
      mov cad2[si],al
      inc si
      cmp si,5
      jne ciclo2 

    comparar:
      mov cx,dx
      cld
      lea si,cad1
      lea di,cad2   
    rep movsb

    mov ah,09h
    lea dx,salto
    int 21h

    mov ah,09h
    lea dx,msg1
    int 21h

    xor ax,ax
  
    mov ah,09h
    lea dx,cad1
    int 21h    
    
    mov ah,09h
    lea dx,salto
    int 21h

    mov ah,09h
    lea dx,cad2
    int 21h    



    ret
  main endp
codigo ends
end main
