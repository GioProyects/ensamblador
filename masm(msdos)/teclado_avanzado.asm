page 60,132
title seleccion de una opcion de meni
.model small
.stack 64
.data
  toprow  equ 00
  botrow  equ 07
  lefcol  equ 16
  col     db 00
  row     db 00
  count   db ?
  lines   db 7
  attrib  db ?
  ninteen db  ?
  menu    db  0c9h,17 dup(0cdh),0bbh
          db  0bah,'add record',0bah
          db  0bah,'delete record',0bah
          db  0bah,'enter record',0bah
          db  0bah,'print report',0bah
          db  0bah,'update accounts',0bah
          db  0bah,'view record',0bah
          db 0c8h ,17 dup(0cdh),0bch
prompt db 06,'to select an item,use up/down arrow'
        db 'and press Enter'
        db 13,10,09,'press Enter to exit'

.code
  start proc far
    mov ax,@data
    mov ds,ax
    mov es,ax

    call q10clr   ;despejar pantalla
    mov row,botrow+2
    mov col,00
    call q20curs    ;fijar cursor
    mov ah,40h      ;peticion de exhibicion
    mov bx,01       ;manejo de pantalla
    mov cx,75       ;numero de caracteres
    lea dx,prompt   ;indicacion
    int 21h


    a10loop:
      call b10menu  ;exhibicion del menu
      mov col,lefcol+1
      call q20curs    ;fijar cursor
      mov row,toprow+1  ;fijar hilera a opcion de usuario
      mov attrib,16h    ;fijar video inverso
      call h10disp      ;resalta la linea del menu
      call d10inp       ;proporcionar para la seleccion del menu
      cmp al,0dh        ;enter presionado?
      je a10loop        ;si,continuar
      mov ax,4c00h
      int 21h
  start endp

  ;mostrar todo el menu
  b10menu proc near
    mov row,toprow    ;fijar hilera superior
    mov lines,08      ;numero de lineas
    lea si,menu
    mov attrib,71h    ;azul sobre blanco

    b20:
      mov col,lefcol  ;fijar col izquierda del menu
      mov count,19
      mov ah,10h  ;peticion de entrada
    b30:
      call q20curs    ;fijar cursor en la siguiente columna
      mov ah,09h      ;peticion de exhibicion
      mov al,[si]     ;obtener caracter del menu
      mov bh,00       ;pagina 0
      mov bl,71h      ;nuevo atributo
      mov cx,01       ;un caracter
      int 10h
      inc col         ;siguiente col
      inc si          ;fijar siguiente caracter
      dec count       ;ultimo caracter?
      jnz b30         ;no repetir
      inc row         ;sig hilera
      dec lines       ;
      jnz b20         ;se imprimieron todas las lineas?
      ret
    b10menu endp


    ;aceptar entrada a pedido
    d10inp proc near
      int 16h
      cmp ah,50h    ;flecha hacia abajo?
      je d20
      cmp ah,48h    ;flecha hacia arriba?
      je d30
      cmp ah,0dh    ;tecla enter?
      je d90
      cmp ah,1bh    ;tecla escape?
      je d90
      jmp d10inp
      d20:
        mov attrib,71h    ;azul sobre blanco
        call h10disp      ;fijar la linea anterior a video normal
        inc row
        cmp row ,botrow-1 ;se paso la hilera interior?
        jbe d40           ;no muy bien
        mov row,toprow+1  ;si,restablecer
        jmp d40
      d30:
        mov attrib,71h    ;video normal
        call h10disp      ;fijar linea anterior a video normal
        dec row
        cmp row,toprow+1  ;abajo de la hilera superior?
        jae d40           ;no muy bien
        mov row,botrow    ;si,restablecer
      d40:
        call q20curs    ;fijar cursor
        mov attrib,16h  ;video inverso
        call h10disp    ;fijar nueva linea a video inverso
        jmp d10inp
      d90:
        ret
      d10inp endp



      ;fijar linea de menu a normal/resaltada
      h10disp proc near
        mov ah,00
        mov al,row    ;la hilera dice que linea fijar
        mul ninteen   ;multiplica por la longitud de la linea
        lea si,menu+1 ;por la linea de menu seleccionada
        add si,ax
        mov count,17  ;caracteres a exhibicion
        h20:
          call q20curs    ;fijar cursor en segmento columna
          mov ah,0c9h     ;exhibicion
          mov al,[si]     ;obtener caracter del menu
          mov bh,00       ;pagina
          mov bl,attrib   ;nuevo atributo
          mov cx,01       ;un caracter
          int 10h
          inc col         ;siguiente columna
          inc si          ;siguiente caracter
          dec count       ;ultimo caracter?
          jnz h20         ;no repetir
          mov col,lefcol+1  ;restablecer columna a la izquierda
          call q20curs    ;fijar cursor
          ret
        h10disp endp


        ;despejar pantalla
        q10clr proc near
          mov ax,0600h
          mov bh,61h
          mov cx,0000
          mov dx,184fh
          int 10h
          ret
        q10clr endp


        ;fijar cursor hilera/columna
        q20curs proc near
          mov ah,02h
          mov bh,00
          mov dh,row
          mov dl,col
          int 10h
          ret
        q20curs endp



  end start
