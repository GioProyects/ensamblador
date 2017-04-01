imprime macro cadena
  mov ax,@data
  mov ds,ax
  mov ah,09
  mov dx,offset cadena
  int 21h
endm

.model small
.stack
.data
msj db 0ah,0dh, '***** Menu *****', '$'
msj2 db 0ah,0dh, '1.- Crear Archivo', '$'
msj3 db 0ah,0dh, '2.- Abrir Archivo', '$'
msj4 db 0ah,0dh, '3.- Modificar archivo', '$'
msj5 db 0ah,0dh, '4.- Eliminar archivo', '$'
msj6 db 0ah,0dh, '5.- Salir', '$'
msj7 db 0ah,0dh, 'El Cerrado de un arhcivo se hace automatico', '$'
msjelim db 0ah,0dh, 'Archivo eliminado con exito', '$'
msjcrear db 0ah,0dh, 'Archivo creado con exito', '$'
msjescr db 0ah,0dh, 'Archivo escrito con exito', '$'
msjnom db 0ah,0dh, 'Nombre del archivo: ', '$'
cadena db 'Cadena a Escribir en el archivo','$'
nombre db 'archivo2.txt',0 ;nombre archivo y debe terminar en 0
vec db 50 dup('$')
handle db 0
linea db 10,13,'$'
.code
inicio:

menu:
  imprime msj
  imprime msj2
  imprime msj3
  imprime msj4
  imprime msj5
  imprime msj6
  imprime msj7

  mov ah,0dh
  int 21h
 ;comparamos la opcion que se tecleo
  mov ah,01h
  int 21h
  cmp al,31h
  je crear
  cmp al,32h
  je abrir
  cmp al,33h
  je pedir
  cmp al,34h
  je eliminar
  cmp al,35h
  je salir

crear:
mov ax,@data
mov ds,ax
;crear
mov ah,3ch
mov cx,0
mov dx,offset nombre
int 21h
jc salir ;si no se pudo crear
imprime msjcrear
mov bx,ax
mov ah,3eh ;cierra el archivo
int 21h
jmp menu

abrir:
;abrir
mov ah,3dh
mov al,0h ;0h solo lectura, 1h solo escritura, 2 lectura y escritura
mov dx,offset nombre
int 21h
mov ah,42h
mov al,00h
mov bx,ax
mov cx,50
int 21h
;leer archivo
mov ah,3fh
;mov bx,ax
mov bx,ax
mov cx,10
mov dx,offset vec
;mov dl,vec[si]
int 21h
mov ah,09h
int 21h

;Cierre de archivo
mov ah,3eh
int 21h
jmp menu

pedir:
  mov ah,01h
  int 21h
  mov vec[si],al
  inc si
  cmp al,0dh
  ja pedir
  jb pedir

editar:
;abrir
mov ah,3dh
mov al,1h
mov dx,offset nombre
int 21h
jc salir ;Si hubo error
;Escritura de archivo
mov bx,ax ; mover hadfile
mov cx,si ;num de caracteres a grabar
mov dx,offset vec
mov ah,40h
int 21h
imprime msjescr
cmp cx,ax
jne salir ;error salir
mov ah,3eh ;Cierre de archivo
int 21h
jmp menu

eliminar:
mov ah,41h
mov dx, offset nombre
int 21h
jc salir ;Si hubo error
imprime msjelim

salir:
mov ah,04ch
int 21h
end





















.model small
.stack 64
.data
  disarea db "pc users society",13,10
  nombre db "c:creadoasm.txt",00h
  maneja dw ?

  mensaje db "hola mundo ensamblador",13,10,"$"
.code

  main proc far
    mov ax,@data
    mov ds,ax

    ;call crear_archivo

    call salir

  main endp

  crear_archivo proc near
      mov ah,3ch
      mov cx,00
      lea dx,nombre
      int 21h
      ;jc salir
      call salir
      mov maneja,ax
      ret
  crear_archivo endp

  tamano_cursor proc near
    mov ah,01h
    mov ch,00
    mov cl,14
    int 10h
    ret
  tamano_cursor endp

  posicion_cursor proc near
    mov ah,02h
    mov bh,00
    mov dh,05
    mov dl,0fh
    int 10h
  posicion_cursor endp

  modo_video proc near
    mov ah,00h
    mov al,07h
    int 10h
    ret
  modo_video endp

  salir proc near
    mov ax,4c00h
    int 21h
  salir endp

  end
