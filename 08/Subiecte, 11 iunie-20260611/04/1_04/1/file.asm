%include "printf64.asm"

section .rodata
    pal	    dd 123454321
    n	    db 6
    string  db "IOCLA is funz!", 10, 0


section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp


    ; TODO a: Check if `pal` is a palindrom number.
    ; Print "Palindrom :)" if true, or "Nu este palindrom :(" if false.


    ; TODO b: Compute and print the first n powers of 6.


    mov rax, string
    ; TODO c: Uncomment the following line. Fix the running errors without changing the code below.
    ; mov [rax + 9], dword 0x6c6c6568

    PRINTF64 `%s`, rax

    ; TODO d: Print each character of string in hexa

    ; Return 0.
    xor rax, rax
    leave
    ret
