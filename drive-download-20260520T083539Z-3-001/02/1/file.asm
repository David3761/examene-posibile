%include "printf64.asm"

section .data
    pushme dw 1, 2, 16, 32, 10, 33, 0, 4, 16, 8
    count dd 0x3333CCCC
    mystr db "Ana are mere", 10, 0
    needle db "re", 0

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; TODO a: Reverse the `pushme` array, in place, without using additional arrays
    ; You must print the array after reversing it.


    ; TODO b: Check if the number of `1` bits from the `count` variable is even.


    ; TODO c: Check if the elements on odd positions from the `pushme` array are
    ; powers of 2. ONLY print the elements on odd positions that are powers of 2.


    ; TODO d: Check if the substring saved in `needle` exists in the string `str`.
    ; Print YES or NO, if the substring exists in the string or not.


    ; Return 0.
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
