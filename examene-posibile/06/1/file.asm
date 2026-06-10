%include "printf64.asm"

section .data
    N dd    5
    matrix db 1, 2, 3, 4, 5,  \
              6, 7, 8, 9, 10, \
              11, 12, 13, 14, 15, \
              16, 17, 18, 19, 20, \
              21, 22, 23, 24, 25
section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; TODO a: Print all the elements of the matrix line by line
    ; separated by a newline


    ; TODO b: For each row, print the row number together with
    ; the sum of all elements on that row

    ; TODO c: Compute and print the sum of all elements on the main diagonal
    ; elements on the main diagonal have i = j

    ; TODO d: For each colum, find the maximum value in that column
    ; and print it

    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
