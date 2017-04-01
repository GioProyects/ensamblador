;Escribir un código que verifique si dos cadenas son iguales
.286
.model small
.stack 64
.data
  cad1 db "holando$"
  cad2 db "holado$"
  iguales db "son iguales$"
  desiguales db "no son iguales$"

.code
  mov ax,@data
  mov ds,ax
  ;mov es,ax
  
  verificar:
    mov al,cad2[si]
    cmp al,cad1[si]
    je comprobar
    jne noigual

  comprobar:
    cmp cad1[si],'$'
    jne aumentar
    mov ah,09h
    lea dx,iguales
    int 21h
    jmp salir

  aumentar:
    inc si
    jmp verificar

  noigual:
    mov ah,09h
    lea dx,desiguales
    int 21h

  salir:
    mov ax,4c00h
    int 21h
    end
