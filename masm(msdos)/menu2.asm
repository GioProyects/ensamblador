.model small
.stack 100
.data
  toprow equ 00
  botrow equ 07
  lefcol equ 16
  col    db  00
  row    db  00
  count  db  ?
  lines  db   7
  attrib db   ?
  ninteen db  1
  menu  db  0c9h,17 dup(0cdh),0bbh
        db  0bah,'1.-Adress Record ',0bah
        db  0bah,'2.-Delete Record ',0bah
        db  0bah,'3.-Enter   Order ',0bah
        db  0bah,'4.-Print  Record ',0bah
        db  0bah,'5.-Adress Record ',0bah
        db  0bah,'6.-Update Account',0bah
        db  0bah,'7.-View   Account',0bah
        db  0c8h,17 dup(0cdh),0bch


  prompt  db  'to select an item use up/down arrow'
        db  ' and pressed enter'
        db  10,13,09,'Press enter to exit'

.code
  main proc far
    mov ax,@data
    mov ds,ax
    mov es,ax

    call limpiar_pantalla
    call menu_desplegar
    call salida
  main endp

  opcion_inverso proc near
    mov ah,00h
    mov al,row
    lea si,menu+1
    add si,ax
  opcion_inverso endp


  limpiar_pantalla proc near
    mov ax,0600h
    mov bh,07h      ;color rojo(4) sobre blanco(7)
    mov cx,0000
    mov dx,184fh
    int 10h
    ret
  limpiar_pantalla endp

  salida proc near
    mov ax,4c00h
    int 21h
    ret
  salida endp

  menu_desplegar proc near
    ;mov row,toprow
    mov lines,09
    lea si,menu
    b90:
      mov count,19
      mov col,lefcol
    repetir:
      call posicion_cursor
      mov ah,09h
      mov al,[si]
      mov bh,0    ;pagina
      mov bl,17h  ;atributo fondo cafe,con azul
      mov cx,01
      int 10h
      inc col
      inc si
      dec count
      jnz repetir
      inc row
      dec lines
      jnz b90
      ret
  menu_desplegar endp

  posicion_cursor proc near
    mov ah,02h
    mov bh,00
    mov dh,row
    mov dl,col
    int 10h
    ret
  posicion_cursor endp


  end
