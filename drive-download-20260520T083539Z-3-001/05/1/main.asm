%include "printf64.asm"

section .rodata
arr: dw 8000, 5000, 4444, 10003, 7001, 10000, 9003, 20001
arr2: dw 0, 44, 3, 5, 71, 12, 54, 333
N equ 8

section .data
; TODO c: Create array `bools` of N elements

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; TODO a: Copy arr to the stack.

    ; TODO a: Print the new array.

    ; TODO b: Increment all odd values in the array created at TODO a.

    ; TODO b: Print the array that has been modified.

    ; TODO c: For each position `i` in `bools`, set `bools[i]` to 1 if the sum of
    ; all elements in `arr` except for `arr[i]` fits in a variable of type `short`.
    ; Otherwise, set to 0.

    ; TODO c: Print bools.

    ; TODO d: For each `arr2[i]`, print it if `arr2[i]` can be written using at most `i` bits.

    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
