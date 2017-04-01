.model small
.stack 64
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
    menu    db  0c9h,17 dup(0cdh),0bbh
            db  0bah,'Adress Record    ',0bah
            db  0bah,'Delete Record    ',0bah
            db  0bah,'Enter   Order    ',0bah
            db  0bah,'Print  Record    ',0bah
            db  0bah,'Adress Record    ',0bah
            db  0bah,'Update Account   ',0bah
            db  0bah,'View   Account   ',0bah
            db  0c8h,17 dup(0cdh),0bch


    prompt  db  'to select an item use up/down arrow'
            db  ' and pressed enter'
            db  10,13,09,'Press enter to exit'




 .code
    main proc far
        mov ax,@data
        mov ds,ax
        mov es,ax


        ;despejar pantalla
        call q10clr
        mov row,botrow+2
        mov col,00
        ;posicion cursor
        call q20cur
        mov ah,40h
        mov bx,01
        mov cx,75
        lea dx,prompt
        int 21h

        a10loop:
            call b10menu
            mov col,lefcol+1
            call q20cur
            mov row,toprow+1
            mov attrib,16h          ;video inverso
            ;call h10disp
            ;call d10inpt
            cmp al,0dh
            je a10loop
            mov ax,0600h
            call q10clr

            mov ax,4c00h
            int 21h
    main endp


    q10clr proc near
        mov ax,0600h
        mov bh,61h
        mov cx,0000
        mov dx,184fh
        int 10h
    q10clr endp

    d10inpt proc near
        mov ah,10h
        int 16h
        cmp ah,50h
        je d20
        cmp ah,48h
        je d30
        cmp ah,0dh
        je d90
        jmp d10inpt

        d20:
            mov attrib,71h
            call h10disp
            inc row
            cmp row,botrow+1
            jmp d40
        d30:
            mov attrib,71h
            call h10disp
            dec row
            cmp row,toprow+1
            jae d40
            mov row,botrow-1
        d40:
            call q20cur
            mov attrib,16h
            call h10disp
            jmp d10inpt
        d90:
            ret
    d10inpt endp


    h10disp proc near
        mov ah,00
        mov al,row
        mul ninteen
        lea si,menu+1
        add si,ax
        mov count,17
        h20:
            call q20cur
            mov ah,09h
            mov al,[si]
            mov bh,00
            mov bl,attrib
            mov cx,01
            int 10h
            inc col
            inc si
            dec count
            jnz h20
            mov col,lefcol+1
            call q20cur
            ret
    h10disp endp

    b10menu proc near
        mov row,toprow
        mov lines,09
        lea si,menu
        mov attrib,71h
        b20:
            mov col,lefcol
            mov count,19
        b30:
            call q20cur
            mov ah,09h
            mov al,[si]
            mov bh,00
            mov bl,73h
            mov cx,01
            int 10h
            inc col
            inc si
            dec count
            jnz b30
            inc row
            dec lines
            jnz b20
            ret
    b10menu endp


    q20cur proc near
        mov ah,02h
        mov bh,00
        mov dh,row
        mov dl,col
        int 10h
        ret
    q20cur endp
    end
