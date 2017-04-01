%macro mensaje 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

%macro keytab 2
mov eax,3
mov ebx,2
mov ecx,%1
mov edx,%2
int 80h
%endmacro

section .data
	entrada db "escriba una letra:",10,13
	len_entrada equ $ - entrada

	salida db "uds escribio:",10,13
	len_salida equ $ - salida

	ale db "que no sea numero",10,13
	len_ale equ $-ale

	salto db 13

section .bss
	letra resb	1

section .text
	GLOBAL _start

	_start:
		mensaje entrada,len_entrada
		keytab letra,1
		mensaje salida,len_salida
		mensaje letra,1
		mensaje salto,1

		salir:
			mov eax,1
			mov ecx,0
			int 80h	
