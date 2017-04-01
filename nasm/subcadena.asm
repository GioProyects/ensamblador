section .text
   global _start        ;must be declared for using gcc
	
_start:	                ;tell linker entry point

   mov ecx,len
   mov edi,my_string
   mov ax,substring
   cld
   repne scasw
   je found ; when found
   ; If not not then the following code
	
   mov eax,4
   mov ebx,1
   mov ecx,msg_notfound
   mov edx,len_notfound
   int 80h
   jmp exit
	
found:
   mov eax,4
   mov ebx,1
   mov ecx,msg_found
   mov edx,len_found
   int 80h
	
exit:
   mov eax,1
   mov ebx,0
   int 80h
	
section .data
my_string db 'hola mundo', 0
len equ $ - my_string

substring db "ola",0
len2 equ $ - substring  

msg_found db 'found!', 0xa
len_found equ $ - msg_found

msg_notfound db 'not found!'
len_notfound equ $ - msg_notfound  