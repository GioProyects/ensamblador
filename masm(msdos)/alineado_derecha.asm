title nombres escritos justificados a la derecha

.model small
.stack 64
.data
  namepar label byte
  maxlen db 31
  actlen db ?
  namefld db 31 dup(' ')

  prompt db 'name?',"$"
  namedsp db 31 dup(' '),13,10,"$"
  row db 00


.code
  inicio proc far
    mov ax,@data
    mov ds,ax
    mov es,ax
    mov ax,0600h
    call q10scr
    sub dx,dx
    call q20curs

    a10loop:
      call b10inpt
      test actlen,0ffh  ;no hay nombre?
      jz a90
      call d10scas
      cmp al,'*'
      je a10loop
      call e10rght    ;justificar nombre a la derecha
      call f10clnm    ;despejar nombre
      jmp a10loop
    a90:
      mov ax,4c00h
      int 21h
  inicio endp


  ;indicacion para entrada
  b10inpt proc near
    mov ah,09h
    lea dx,prompt
    int 21h
    mov ah,0ah
    lea dx,namepar
    int 21h
    ret
  b10inpt endp

  ;escudriñar asterisco en nombre
  d10scas proc near
    cld
    mov al,'*'
    mov cx,30
    lea di,namefld
    repne scasb
    je d20
    mov al,20h  ;depejar en al '*'
    d20:  ret
  d10scas endp

  ;justificar a la derecha e imprimir nombre
  e10rght proc near
    std
    mov ch,00
    mov cl,actlen   ;longitud en cx para rep
    lea si,namefld  ;calcular la posicion
    add si,cx       ;mas a la derecha
    dec si          ;del nombre que se ingresa
    lea di,namedsp+30 ;posicion a la derecha de exhibicion
    rep movsb

    left:
      mov dh,row
      mov dl,48
      call q20curs
      mov ah,09h
      lea dx,namedsp
      int 21h

      cmp row,20
      jae e20
      inc row
      jmp e90

    e20:
      mov ax,0601h
      call q10scr
      mov dh,row
      mov dl,00
      call q20curs
    e90:
      ret
  e10rght endp


  ;clear name

  f10clnm proc near
    cld
    mov ax,2020h
    mov cx,15
    lea di,namedsp
    rep stosw
    ret
  f10clnm endp

  ;scoll screen
  q10scr proc near
    mov bh,30
    mov cx,00
    mov dx,184fh
    int 10h
    ret
  q10scr endp

  ;set cursor row/col
  q20curs proc near
    mov ah,02h
    sub bh,bh
    int 10h
    ret
  q20curs endp

  end
