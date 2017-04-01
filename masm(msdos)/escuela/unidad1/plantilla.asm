; multi-segment executable file template.
.286
data segment
    ; add your data here!
    pkey db "press any key...$"
data ends

stack segment
    db 32 dup('stack---')
stack ends

codigo segment
  assume ds:data,ss:stack,cs:codigo
  main proc far
    push ds
    push 0
    mov ax,data
    mov ds,ax

    mov ah,09h
    lea dx,pkey
    int 21h

    ret
  main endp
codigo ends
end main
