;Escribir un código que verifique si una cadena es subcadena de otra.
;Por ejemplo: “la Mu” es subcadena de “Hola Mundo”.
;La cadena: “233” es subcadena de la cadena “2122432234”

.model small
;.stack 100h
.data
  cad1 db "hola mundo$"
  subc db "la un$"
  iguales db "es subcadena$"
  desiguales db "no es subcadena$"

.code
  main proc far
    mov ax,@data
    mov ds,ax

    comienzo:
      mov al,cad1[si]
      cmp al,subc[di]
      jne incremento
      inc di
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
