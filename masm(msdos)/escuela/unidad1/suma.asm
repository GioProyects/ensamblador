.286
DATOS SEGMENT
  asc1 db '578'
  asc2 db '694'
  ascsum db '0000','$'
  result db ?,'$'
DATOS ENDS

PILA SEGMENT STACK
    DW 256 DUP (?)
PILA ENDS

CODIGO SEGMENT
    MAIN PROC FAR
        ASSUME CS:CODIGO, DS:DATOS, SS:PILA
        PUSH DS
        PUSH AX
        MOV AX, DATOS
        MOV DS, AX

        clc
        mov ax,0034h
        mov bx,0038h
        sub al,bl
        aas
        or al,3030h

        ;mov bl,al
        ;mov al,ah
        ;mov ah,bl

        mov result,al
        mov ah,09h
        lea dx,result
        int 21h

        RET
    MAIN ENDP

    suma_ext proc near
      mov ax,39h
      mov bx,39h
      add al,bl
      aaa
      or ax,3030h
      mov bl,al
      mov al,ah
      mov ah,bl

      mov result,ax
      mov ah,09h
      lea dx,result
      int 21h
    suma_ext ENDP

CODIGO ENDS
END MAIN
