.model small
.stack 64
.data
  msg1 db "Programa para introducir datos$"
  nombre db "Cual es tu nombre?$"
  edad db "Cual es tu edad?$"
  gusto db "Te gusta ensamblador?$"

  nom db 30 dup(' ')
  ed db 2 dup(' ')
  gus db 4 dup(' ')

  namepar label byte
  maxlen db 20
  actlen db ?
  namefld db 20 dup(' ')

.code
  begin proc far

    mov ax,@data
    mov ds,ax
    mov es,ax

    ;crea una pantalla
    mov ax,0600h
    mov bh,30h
    mov cx,0000h
    mov dx,184fh
    int 10h

    ;fijar el cursor
    mov ah,02h
    mov ah,00
    mov dh,00
    mov dl,20
    int 10h

    ;mensaje inicial
    mov ah,09h
    lea dx,msg1
    int 21h

    ;primera preguntaa

    ;fijar el cursor
    mov ah,02h
    mov ah,00
    mov dh,03
    mov dl,20
    int 10h

    mov ah,09h
    lea dx,nombre
    int 21h

    ;pausa
    mov ah,08h
    int 21h

    ;capturar cadena
    mov ah,3fh
    mov bx,00
    mov cx,30
    lea dx,nom
    int 21h

    ;escribir cadena en pantalla
    ;fijar el cursor
    mov ah,02h
    mov ah,00
    mov dh,05
    mov dl,20
    int 10h


    mov ah,40h
    mov bx,01
    mov cx,30
    lea dx,nom
    int 21h
    ;mov ah,02h
    ;mov cx,30
    ;lea di,nom
    ;repetir:
    ;  mov dl,[di]
    ;  int 21h
    ;  inc di
    ;  loop repetir




    ;salir
    mov ax,4c00h
    int 21h

  begin endp
  end
