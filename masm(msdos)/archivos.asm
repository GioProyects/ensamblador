title crea en disco un archivo de nombres
.model small
.stack 64

.data
  namepar label byte
  maxlen db 30
  namelen db ?
  namerec db 30 dup(" "),13,10

  error_code db 00
  handle dw ?
  path db "nombres",0
  prompt db "nombre?"
  row db 01
  open_error db "open error$"
  write_error db "wrte error$"

.code
  main proc far
    mov ax,@data
    mov ds,ax
    mov es,ax

    mov ax,0600h
    call q10scr
    call q20curs
    call c10crea
    cmp error_code,00
    jz a20loop
    jmp a90

    a20loop:
      call d10proc
      cmp namelen,00
      jne a20loop
      call g10close
    a90:
      mov ax,4c00h
      int 21h
  main endp

  c10crea proc near
    mov ah,3ch
    mov cx,00
    lea dx,path
    int 21h
    jc c20
    mov handle,ax
    ret
    c20:
      lea dx,open_error
      call x10error
      ret
  c10crea endp

  d10proc proc near
    mov ah,40h
    mov bx,01
    mov cx,06
    lea dx,prompt
    int 21h
    mov ah,0ah
    lea dx,namepar
    int 21h
    cmp namelen,00
    jz d90
    mov al,20h
    sub ch,ch
    mov cl,namelen
    lea di,namerec
    add di,cx
    neg cx
    add cx,30
    rep stosb
    call f10writ
    call e10scrl
    d90:
      ret
    d10proc endp


    e10scrl proc near
      cmp row,18
      jae e10
      inc row
      jmp e90
      e10:
        mov ax,0601h
        call q10scr
      e90:
        call q20curs
        ret
    e10scrl endp

    f10writ proc near
      mov ah,40h
      mov bx,handle
      mov cx,32
      lea dx,namerec
      int 21h
      jnc f20
      lea dx,write_error
      call x10error
      mov namelen,00
      f20:
        ret
    f10writ endp

    g10close proc near
      mov namerec,1ah
      call f10writ
      mov ah,3eh
      mov bx,handle
      int 21h
      ret
    g10close endp

    q10scr proc near
      mov bh,1eh
      mov cx,0000
      +mov dx,184fh
      int 10h
      ret
    q10scr endp

    q20curs proc near
      mov ah,02h
      mov bh,00
      mov dh,row
      mov dl,00
      int 10h
      ret
    q20curs endp

    x10error proc near
      mov ah,40h
      mov bx,01
      mov cx,21
      int 21h
      mov error_code,01
      ret
    x10error endp

  end
