;Escribir un código que verifique que todas los caracteres de una cadena se encuentran en otra.
;Por ejemplo: todas las letras de la cadena “casa” se encuentran en “escaso”.
;Pero no todas las letras de “cerro” se en cuentran en “recanate”

.model small
;.stack 64
.data
  cad1 db "recante$"
  subc db "cerro$"
  iguales db "todas las letras se encuentran$"
  desiguales db "no todas las letras se encuentran$"

.code
  main proc far
    mov ax,@data
    mov ds,ax

    comienzo:
      mov al,cad1[si]
      cmp al,subc[di]
      jne incremento
      inc di
      mov si,0
      cmp subc[di],'$'
      jz sies
    incremento:
      inc si
      cmp cad1[si],'$'
      jne comienzo
      jz noes
    sies:
      mov ah,09h
      lea dx,iguales
      int 21h
      jmp salir
    noes:
      mov ah,09h
      lea dx,desiguales
      int 21h
    salir:
      mov ax,4c00h
      int 21h
  main endp
end
