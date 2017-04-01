.model small
.data
.code
  begin proc far
    ;mov ah,00h
    ;mov al,10h ;modo grafico
    ;mov al,03h  ;modo texto
    ;int 10h

    ;paleta de colores
    ;mov ah,0bh
    ;mov bh,00
    ;mov bh,01 ;selecciona la paleta
    ;mov bl,00
    ;int 10h

    ;escribe un pixel punto
    mov ah,0ch
    mov al,03   ;color del pixel
    mov bh,0    ;pagina 0
    mov cx,50   ;columna
    mov dx,70   ;renglon
    int 10h

    mov ax,4c00h
    int 21h
  begin endp
  end begin
