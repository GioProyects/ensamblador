;Repetition Prefixes

;The REP prefix, when set before a string instruction, for example - REP MOVSB, causes repetition of the instruction based on a counter placed at the CX register. REP executes the instruction, decreases CX by 1, and checks whether CX is zero. It repeats the instruction processing until CX is zero.

;The Direction Flag (DF) determines the direction of the operation.

;    Use CLD (Clear Direction Flag, DF = 0) to make the operation left to right.
;    Use STD (Set Direction Flag, DF = 1) to make the operation right to left.

;The REP prefix also has the following variations:

;    REP: It is the unconditional repeat. 
			;It repeats the operation until CX is zero.

;    REPE or REPZ: It is conditional repeat. 
					;It repeats the operation while the zero flag
					;indicates equal/zero. 
					;It stops when the ZF indicates not 
					;equal/zero or when CX is zero.

;    REPNE or REPNZ: It is also conditional repeat. 
					;It repeats the operation while the zero
					;flag indicates not equal/zero.
					;It stops when the ZF indicates equal/zero
					;or when CX is decremented to zero.


	

section .text
	GLOBAL _start

	_start:
		mov esi,msg
		mov edi,msg1
		mov ecx,len
		cld
		repz cmpsb
		jecxz equal

		;no son iguales
		mov eax,4
		mov ebx,1
		mov ecx,no_iguales
		mov edx,len_no_iguales
		int 80h

		mov eax,1
		mov ebx,0
		int 80h

		equal:
			mov eax,4
			mov ebx,1
			mov ecx,iguales
			mov edx,len_iguales
			int 80h
			mov eax,1
			mov ebx,0
			int 80h

section .data
	msg db "cadenasdasd1",0
	len equ $ - msg

	msg1 db "cadena1",0
	len1 equ $ - msg1

	iguales db "son iguales",10,13
	len_iguales equ $ - iguales

	no_iguales db "no son iguales",10,13
	len_no_iguales equ $ - no_iguales