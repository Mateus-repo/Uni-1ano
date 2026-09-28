global main

section .text
main:
    mov edi, 1
    lea rsi, [rel msg]
    mov edx, msg_len
    mov eax, 1
    syscall

    mov edi, 3
    mov eax, 60
    syscall

section .data
msg:    db 'teste x64 ok', 10
msg_len equ $ - msg
