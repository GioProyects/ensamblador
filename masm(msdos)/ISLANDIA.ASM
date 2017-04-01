;ESTRUCTURA EN MODO REAL
PAGE 60,132
TITLE ESTRUCTURA EN MR
;--------------------------------
PILA  SEGMENT PARA STACK 'STACK';segemento de pila
      DW 32 DUP(0);define word
PILA  ENDS ; fin del segmento
;--------------------------------
DATOS SEGMENT PARA 'DATA' ;segemento de datos

DATOS ENDS ; fin del segmento
;-------------------------------
CODIGO SEGMENT PARA 'CODE' ;segmento de codigo
MAIN   PROC FAR ; procedimiento principal
       ASSUME CS:CODIGO, SS:PILA, DS:DATOS
       MOV AX, DATOS
       MOV DS, AX
;------------------------------------------------
       ;instrucciones

       ;limpia PANTALLA y pone toda roja la PANTALLA
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 4FH
       MOV CX, 0000H
       MOV DX, 184FH
       INT 10H

       ;dibuja un rectangulo gris desde la posicion
       ;0000h hasta la 0909h
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 240D
       MOV CX, 0000H
       MOV DX, 0909H
       INT 10H

       ;dibuja un rectangulo azul sobre el rectangulo gris
       ;anterioro
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 1FH
       MOV CX, 0000H
       MOV DX, 0707H
       INT 10H

       ;dibuja un rectangulo al lado derecho del rectangulo anterior
       ;de color gris
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 240D
       MOV CX, 000EH
       MOV DX, 094FH
       INT 10H

       ;dibuja un rectangulo azul sobre
       ;el rectangulo gris anterior
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 1FH
       MOV CX, 0010H
       MOV DX, 0074FH
       INT 10H

       ;rectangulo gris en la esquina inferior izquierda
       ;de la pantalla
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 240D
       MOV CX, 0E00H
       MOV DX, 1809H
       INT 10H

       ;rectangulo azul sobre el rectangulo anterior
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 1FH
       MOV CX, 1000H
       MOV DX, 1807H
       INT 10H

       ;rectangulo gris al lado de rectangulo anterior
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 240D
       MOV CX, 0E0EH
       MOV DX, 184FH
       INT 10H

       ;rectangulo azul sobre el rectangulo anterior
       MOV AH, 06H
       MOV AL, 00H
       MOV BH, 1FH
       MOV CX, 1010H
       MOV DX, 184FH
       INT 10H

       MOV AH, 02H ;FUNCION
       MOV BH, 00H ;NUMERO DE PAGINA
       MOV DH, 25D ;FILA
       MOV DL, 00D ;COLUMNA
       INT 10H

      MOV AH, 01H ;RECIVE LA TECLA LA ALMACENA EN AL Y NO TIENE ECO MONITOR
      INT 21H

      	;MOV AX, 0H ;limpieza de regsitro

      ;------------------------------------------------
       MOV AX, 4C00H; finaliza el programa
       INT 21H
MAIN   ENDP ; fin procedimiento
CODIGO ENDS; FIN SEGMENTO
       END MAIN; fin programa
