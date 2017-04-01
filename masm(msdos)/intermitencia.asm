page 60,132
title P10NMSCR (EXE) Video inverso, intermitencia y recorrido de la
.model small
.stack 64
.data
  namepar label byte
    maxlen db 20
    actnlen db 7
    namefld db 20 dup(' ')
  col db 00
  count db 00
  prompt db 'nombre?'
  row db 00

.code
  begin proc far

    mov ax,@data
    mov ds,ax
    mov es,ax
    mov ax,0600h
    call q10scr

    a20loop:
      mov col,00
      call q20curs
      call b10prmp  ;muestra una indicacion
      call d10inpt  ;proporciona enrtada de nombre
      cmp actnlen,00  ;no hay nombre?
      jne a30
      mov ax, 0600h
      call q10scr   ;si es asi limpia la pantalla
      mov ax,4c00h
      int 21h

    a30:
      call e10name
      jmp a20loop
    begin endp


    ;despliega la indicacion
    b10prmp proc near
      lea si,prompt   ;designa la direccion de la asignacion
      mov count,7
      b20:
        mov bl,24h    ;video inverso
        call f10disp  ;reutina despliegue
        inc si        ;caracter siguiente de nombre
        inc col       ;colunma siguiente
        call q20curs  ;coloca el cursor
        dec count     ;cuenta descendente
        jnz b20       ;repite el ciclo n veces
        ret

      b10prmp endp



      ;acepta la entrada de un nombre
      d10inpt proc near
        mov ah,0ah      ;peticion de
        lea dx,namepar   ;entrada de un
        int 21h         ;nombre desde
        ret             ;el teclado
      d10inpt endp


      ;despliega el nombre en video inverso y con intermitencia
      e10name proc near
        lea si,namefld  ;inicializa el nombre
        mov col,40      ;designa la col de la pantalla
        e20:
          call q20curs  ;coloca el cursor
          ;mov bl,0f1h   ;video inverso en intermitencia
          call f10disp  ;rutina de despliegue
          inc si        ;caracter sig en el nombre
          inc col       ;siguiente col de la pantalla
          dec actnlen   ;disminuye la cuenta de la longitud del nombre
          jnz e20       ;repite el ciclo n veces

          cmp row,20    ;derca del borde inferior de la pantalla?
          jae e30
          inc row       ;no? incrementa renglon
          ret
        e30:
          mov ax,0501h
          call q10scr
          ret
        e10name endp

        ;despliegue
        f10disp proc near   ;bl se designa antes
            mov ah,09h      ;peticion de despliegue
            mov al,[si]     ;obtiene el caracter de nombre
            mov bh,00       ;num de pagina
            mov cx,01       ;un caracter
            int 10h
            ret
        f10disp endp

        ;recorre la pantalla
        q10scr proc near    ;ax se asigna antes
          mov bh,17h        ;blanco sobre azul
          mov cx,0000
          mov dx,184fh      ;pantalla completa
          int 10h
          ret
        q10scr endp

        ;coloca el cursor
        q20curs proc near
          mov ah,02h
          mov bh,00   ;pagina
          mov dh,row  ;renglon
          mov dl,col
          int 10h
          ret
        q20curs endp

    end
