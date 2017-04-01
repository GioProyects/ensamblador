.286
DATOS SEGMENT
  menu db "1.-llenar",10,13,"2.-Salir",10,13,'$'
  finizquierdo db "fin!!!$"

  punto1x dw 0000h
  punto1y dw 0008h
  punto2x dw 0100h
  punto2y dw 0108h

  

  pos1 db 10,13,"posicion en X:$"
  pos2 db 10,13,'posicion en y:$'
  posx dw ?,'$'
  posy dw ?,'$'
DATOS ENDS

PILA SEGMENT STACK
    db 32 DUP ('stack---')
PILA ENDS

CODIGO SEGMENT
    MAIN PROC FAR
        ASSUME CS:CODIGO, DS:DATOS, SS:PILA
        PUSH DS
        PUSH AX
        MOV AX, DATOS
        MOV DS, AX

        mov ax,0600h
        mov bh,07h
        mov cx,0000h
        mov dx,184fh
        int 10h

        ;modo video
        mov ah,0h
        mov al,02h
        int 10h

        ;posicionar raton
        mov ah,02h
        mov bh,0
        mov dh,00
        mov dl,00
        int 10h

        
        ;--------------ventana
        mov cx,punto1x
        mov dx,punto1y
    		mov bh, 0fh; clrfondoclrtxt
    		mov ah, 06h
    		mov al, 00h
    		int 10h


        mov cx,punto2x
        mov dx,punto2y
        ;mov ch, 01 ;fila1
    		;mov cl, 00 ;columna1
    		;mov dh, 10 ;fila2
    		;mov dl, 08;columa2
    		mov bh, 0fh; clrfondoclrtxt
    		mov ah, 06h
    		mov al, 00h
    		int 10h

        mov ah,09h
        lea dx, menu
        int 21h

        mov ax, 00h
    		int 33h
    		cmp ax, 00
    		je fin

        mov ax,1
        int 33h
    		movimiento:          
          mov ax,3
          int 33h
          cmp cx,punto1x
          jna movimiento
          ;jmp movimiento
          verificar:  
            cmp dx,punto1y
            jnb movimiento
            mov ax,5
            int 33h
            cmp cx,0
            jne movimiento
            lea dx,finizquierdo
            mov ah,09h
            int 21h
        fin:
          ret
      MAIN ENDP
CODIGO ENDS
END MAIN
