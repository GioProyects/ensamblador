DATA SEGMENT
	XC 	  DW 320  ; Pos X del centro
	YC 	  DW 240  ; Pos Y del centro
	TEMPO DW ?    ; Temporal

	COLOR DB 20   ; Color inicial
	LAST  DB "5"
	RAD   DW 50	  ; Radio del círculo
	HOR   DW ?
	VER   DW ?
	VID   DB ?	; Salvamos el modo de video :)
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA,SS:PILA
INICIO:
	MOV AX,DATA
	MOV DS,AX

	MOV AH,0Fh	; Petición de obtención de modo de vídeo
	INT 10h		; Llamada al BIOS
	MOV VID,AL

	MOV AH,00h	; Función para establecer modo de video
	MOV AL,12h	; Modo gráfico resolución 640x480
	INT 10h

	MOV CX,XC
	MOV DX,YC
	CALL PUNTEAR

	CALL INFI

	MOV AH,00h		; Función para re-establecer modo de texto
	MOV AL,VID
	INT 10h		    ; Llamada al BIOS

	MOV AH,004Ch
	INT 21h


; <!--------- PROCEDIMIENTOS ---------------->
INFI PROC NEAR
ITERA:
	CALL GRAFICAR
	CALL ESCUCHAR
	JNZ ATENDER ; Si no está vacío atiende el que está
	; Si está vacío atiende el último ingresado
	MOV AL,LAST

ATENDER:
	CMP AL, "1"
	JNZ E2
	CALL MOVSWEST
	JMP ITERA
E2:
	CMP AL, "2"
	JNZ E3
	CALL MOVSOUTH
	JMP ITERA
E3:
	CMP AL, "3"
	JNZ E4
	CALL MOVSEAST
	JMP ITERA
E4:
	CMP AL, "4"
	JNZ E5
	CALL MOVWEST
	JMP ITERA
E5:
	CMP AL, "5"
	JNZ E6
	CALL DONTMOVE
	JMP ITERA
E6:
	CMP AL, "6"
	JNZ E7
	CALL MOVEAST
	JMP ITERA
E7:
	CMP AL, "7"
	JNZ E8
	CALL MOVNWEST
	JMP ITERA
E8:
	CMP AL, "8"
	JNZ E9
	CALL MOVNORTH
	JMP ITERA
E9:
	CMP AL, "9"
	JNZ E10
	CALL MOVNEAST
	JMP ITERA
; Alteración del RADIO a tiempo real
E10:
	CMP AL,"+"
	JNZ E11
	CALL INCREASE
	JMP ITERA
E11:
	CMP AL,"-"
	JNZ CAMBIARC
	CALL DECREASE
	JMP ITERA
; Modificación del COLOR a tiempo real
CAMBIARC:
	CMP AL,"c"
	JNZ QUIT
	CALL CCOLOR
	JMP ITERA
QUIT:
	CMP AL, "q"
	JNZ INFI
	RET
INFI ENDP

INCREASE PROC NEAR
	CALL BORRAR
	MOV AX,XC
	ADD AX,RAD
	SUB AX,640
	JZ DONTINC
	MOV AX,XC
	SUB AX,RAD
	JZ DONTINC
	MOV AX,YC
	SUB AX,RAD
	JZ DONTINC
	MOV AX,YC
	ADD AX,RAD
	SUB AX,480
	JZ DONTINC
	INC RAD
	; Si no colisiona al crecer, crece
DONTINC:
	RET
INCREASE ENDP

DECREASE PROC NEAR
	CALL BORRAR
	CMP RAD,10
	JE DONTDEC
	DEC RAD
	; Si no es diminuto puede seguir decreciendo
DONTDEC:
	RET
DECREASE ENDP

CCOLOR PROC NEAR
	ADD COLOR,27
	;MOV LAST,"5" Que se detenga al cambiar de color
	RET
CCOLOR ENDP

MOVSWEST PROC NEAR
	MOV AX,XC
	SUB AX,RAD
	JNZ NO1
	CALL MOVSEAST
	RET
NO1:
	MOV AX,YC
	ADD AX,RAD
	SUB AX,480
	JNZ	NO2
	CALL MOVNWEST
	RET
NO2:
	CALL BORRAR
	INC YC
	DEC XC
	MOV LAST,"1"
	RET
MOVSWEST ENDP

MOVSOUTH PROC NEAR
	MOV AX,YC
	ADD AX,RAD
	SUB AX,480
	JNZ NO3
	CALL MOVNORTH
	RET
NO3:
	CALL BORRAR
	INC YC
	MOV LAST,"2"
	RET
MOVSOUTH ENDP

MOVSEAST PROC NEAR
	MOV AX,YC
	ADD AX,RAD
	SUB AX,480
	JNZ NO4
	CALL MOVNEAST
	RET
NO4:
	MOV AX,XC
	ADD AX,RAD
	SUB AX,640
	JNZ NO5
	CALL MOVSWEST
	RET
NO5:
	CALL BORRAR
	INC YC
	INC XC
	MOV LAST,"3"
	RET
MOVSEAST ENDP

MOVWEST PROC NEAR
	MOV AX,XC
	SUB AX,RAD
	JNZ NO6
	CALL MOVEAST
	RET
NO6:
	CALL BORRAR
	DEC XC
	MOV LAST,"4"
	RET
MOVWEST ENDP

MOVEAST PROC NEAR
	MOV AX,XC
	ADD AX,RAD
	SUB AX,640
	JNZ NO7
	CALL MOVWEST
	RET
NO7:
	CALL BORRAR
	INC XC
	MOV LAST,"6"
	RET
MOVEAST ENDP

MOVNWEST PROC NEAR
	MOV AX,XC
	SUB AX,RAD
	JNZ NO8
	CALL MOVNEAST
	RET
NO8:
	MOV AX,YC
	SUB AX,RAD
	JNZ NO9
	CALL MOVSWEST
	RET
NO9:
	CALL BORRAR
	DEC YC
	DEC XC
	MOV LAST,"7"
	RET
MOVNWEST ENDP

MOVNORTH PROC NEAR
	MOV AX,YC
	SUB AX,RAD
	JNZ NO10
	CALL MOVSOUTH
	RET
NO10:
	CALL BORRAR
	DEC YC
	MOV LAST,"8"
	RET
MOVNORTH ENDP

MOVNEAST PROC NEAR
	MOV AX,XC
	ADD AX,RAD
	SUB AX,640
	JNZ NO11
	CALL MOVNWEST
	RET
NO11:
	MOV AX,YC
	SUB AX,RAD
	JNZ NO12
	CALL MOVSEAST
	RET
NO12:
	CALL BORRAR
	DEC YC
	INC XC
	MOV LAST,"9"
	RET
MOVNEAST ENDP

DONTMOVE PROC NEAR
	; CALL GRAFICAR
	MOV AH,00h
	INT 16h
; Si deseamos que parpadee, eliminamos las 3 de arriba.
	MOV LAST,AL
	RET
DONTMOVE ENDP

BORRAR PROC NEAR
	MOV CX,0
	MOV CL,COLOR
	PUSH CX         ; Ya que en GRAFICAR se usan todos los registros
	MOV COLOR,00h
	CALL GRAFICAR
	POP CX
	MOV COLOR,CL
	RET
BORRAR ENDP

PUNTEAR PROC NEAR
	; Grafica un punto en CX,DX
	MOV AH,0Ch		; Petición para escribir un punto
	MOV AL,COLOR	; Color del pixel
	MOV BH,00h		; Página
	INT 10H			; Llamada al BIOS
	RET
PUNTEAR ENDP

GRAFICAR PROC NEAR
; Graficamos todo el circulo !
	MOV HOR,0
	MOV AX,RAD
	MOV VER,AX

BUSQUEDA:
	CALL BUSCAR

    MOV AX,VER
	SUB AX,HOR
	CMP AX,1
	JA BUSQUEDA
	RET
GRAFICAR ENDP

BUSCAR PROC NEAR
; Se encarga de buscar la coord del pixel sgte.
	INC HOR ; Horizontalmente siempre aumenta 1

	MOV AX,HOR
	MUL AX
	MOV BX,AX ; X^2 se almacena en BX
	MOV AX,VER
	MUL AX    ; AX almacena Y^2
	ADD BX,AX ; BX almacena X^2 + Y^2
	MOV AX,RAD
	MUL AX    ; AX almacena R^2
	SUB AX,BX ; AX almacena R^2 - (X^2+Y^2)

	MOV TEMPO,AX

	MOV AX,HOR
	MUL AX
	MOV BX,AX ; BX almacena X^2
	MOV AX,VER
	DEC AX    ; una unidad menos para Y (¡VAYA DIFERENCIA!)
	MUL AX    ; AX almacena Y^2
	ADD BX,AX ; BX almacena X^2 + Y^2
	MOV AX,RAD
	MUL AX    ; AX almacena R^2
	SUB AX,BX ; AX almacena R^2 - (X^2+Y^2)

	CMP TEMPO,AX
	JB NODEC
	DEC VER
NODEC:
	CALL REPUNTEAR
	PUSH VER
	PUSH HOR
	POP VER
	POP HOR   ; Cambiamos valores
	CALL REPUNTEAR
	PUSH VER
	PUSH HOR
	POP VER
	POP HOR   ; Devolvemos originales
	RET
BUSCAR ENDP

REPUNTEAR PROC NEAR
	; I CUADRANTE
	MOV CX,XC
	ADD CX,HOR
	MOV DX,YC
	SUB DX,VER
	CALL PUNTEAR
	; IV CUADRANTE
	MOV DX,YC
	ADD DX,VER
	CALL PUNTEAR
	; III CUADRANTE
	MOV CX,XC
	SUB CX,HOR
	CALL PUNTEAR
	; II CUADRANTE
	MOV DX,YC
	SUB DX,VER
	CALL PUNTEAR
	RET
REPUNTEAR ENDP

ESCUCHAR PROC NEAR
	MOV AH,06h     ; Peticion directa a la consola
 	MOV DL,0FFh    ; Entrada de teclado
 	INT 21h        ; Interrupcion que llama al DOS
	; Si ZF está prendido quiere decir que el buffer está vacío.
	RET
	; En AL queda el ASCII del caracter ingresado.
ESCUCHAR ENDP

CODE ENDS
PILA SEGMENT STACK
      DB 777 DUP(?)
PILA ENDS
END INICIO
