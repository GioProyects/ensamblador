page 60,132
title NOMBRES (EXE) acepta nombres y los muestra en pantalla

.model small
.stack 64

.data
  namepar label byte
  maxnlen db 20
  namelen db ?
  namefld db 21 dup()
  prompt db 'nombre?'

.code
  begin proc far
    mov ax,@data
    mov ds,ax
    mov es,ax
    call q10clr

  a20loop:
    mov dx,0000
    call q20curs
    call b10prmp
    call d10inpt
    call q10clr
    cmp namelen,00
    je a30
    call e10code
    call fiocent
    jmp a20loop

  a30:
    mov ax,4c00h
    int 21h
  begin endp

  b10prmp proc near
    mov ah,09h
    lea dx,prompt

    int 21h
    ret
  b10prmp endp
  d10inpt proc near
    mov ah,0ah
    lea dx,namepar
    int 21h
    ret
  d10inpt endp

  e10code proc near
    mov bh,00
    mov bl,namelen
    mov namefld[bx],07
    mov namefld[bx+1],'$'
    ret
  e10code endp

  fiocent proc near
    mov dl,namelen
    shr dl,1
    neg dl
    add dl,40
    mov dh,12
    call q20curs
    mov ah,09h
    lea dx,namefld
    int 21h
    ret
  fiocent endp

  q10clr proc near
    mov ax,0600h
    mov bh,30
    mov cx,0000
    mov dx,184fh
    int 10h
    ret
  q10clr endp

  q20curs proc near
    mov ah,02h
    mov bh,00
    int 10h
    ret
  q20curs endp
  end
