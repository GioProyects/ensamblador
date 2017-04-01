DATOS SEGMENT
  array db 5 dup(?)
  salto db 10,13,'$'
  mayor db ?,' es mayor',10,13,'$'
  menor db ?,' es menor',10,13,'$'
  msg db 10,13,"Deme 5 numeros:",10,13,'$'
  menu db 10,13,"0.-Seguir 1.- Salir",10,13,'$'
DATOS ENDS

PILA SEGMENT STACK
    DW 256 DUP (?)
PILA ENDS

CODIGO SEGMENT
    MAIN PROC FAR
        ASSUME CS:CODIGO, DS:DATOS, SS:PILA
        push ds
        push ax
        mov ax, DATOS
        mov ds, ax

        principal:
          mov ah,09h
          lea dx,msg
          int 21h

          mov si,0
          mov cx,5
          llenado:
            mov ah,01h
            int 21h
            mov array[si],al

            inc si
            loop llenado
            ;cmp si,cx
            ;jb llenado

          mov ah,09h
          lea dx,salto
          int 21h
          ; 91827

          ;sacar el mayor
          ;xor ax,ax
          mov si,0
          mov dl,array[0]
          mov bl,array[0]
          comprobar:
          cmp dl,array[si]
          jb movermen
          ;cmp bl,array[si]
          ja movermay
          jmp incremento

          movermay:
            mov dl,array[si]
            jmp incremento
          movermen:
            mov bl,array[si]
          incremento:
            inc si
            cmp si,cx
            jb comprobar

          mov mayor,dl
          mov menor,bl

          mov ah,09h
          lea dx,mayor
          int 21h

          mov ah,09h
          lea dx,menor
          int 21h

          mov ah,09h
          lea dx,menu
          int 21h

          mov ah,01h
          int 21h
          cmp al,31h
          jb principal



        RET
      MAIN ENDP
CODIGO ENDS
END MAIN
