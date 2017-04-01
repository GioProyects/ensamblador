.model small
.stack 64
.data
  ;dato db "presione cualquier tecla para salir$"
  dato db "Cual es tu nombre?",10,13,"$"
  saludo db "Hola ","$"
  nombre db 20 dup(0)
.code
  start proc far
    mov ax,@data
    mov ds,ax

    mov ah,09h  ;llamada a rutina imrpimir cadena por pantalla
    lea dx,dato
    int 21h

    mov ah,0ah
    lea dx,nombre
    mov nombre[0],60
    int 21h

    mov ah,09h
    lea dx,saludo
    int 21h

    ;imprime el dato tecleado y guardado en nombre
    mov bx,0
    otro:
      mov dl,nombre[bx+2]
      mov ah,2
      int 21h
      inc bx
      cmp bl,nombre[1]  ;Compara con el numero de caracteres total
      jne otro

    salir:
      mov ax,4c00h
      int 21h

  start endp
  end start
