section .data
    out:  resb 100
    out_size equ 100
    time_format db '%Y-%m-%d %H:%M:%S', 0


section .text
extern printf
global main

sort_array:
    ; TODO c: TODO

d_loop:
    ; TODO d: TODO


main:
    push rbp
    mov rbp, rsp

    ; TODO a: Allocate "IOCLA is funz!" on the stack and, then, print its content using `printf`

    ; TODO b: Print current date and time

    ; TODO c: call sort_array on the string defined on point a

    ; TODO d: call d_loop(3, 1)


    ; Return 0.
    xor rax, rax
    leave
    ret
