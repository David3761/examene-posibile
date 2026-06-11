section .data

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp


    ; TODO b: Call iz_chill


    ; TODO c: Call a function from `libiocla.a` that prints "No more IOCLA!"

    ; Return 0.
    xor rax, rax
    leave
    ret
