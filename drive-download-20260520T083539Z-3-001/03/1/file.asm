%include "printf64.asm"

section .data
    perfect db 0b00011001
    pure db 1, 0b00011001, 0b00011110, 0, 4, 5
    address dq 1
    duplicates dd 1, 2, 3, 1, 4, 3, 16, 4, 2

section .bss
    tmp0 resq 1
    tmp1 resq 1

section .text
extern printf
global main

preamble:
    enter 0, 0

    lea rax, [rel tmp1]
    mov [rel tmp0], rax
    lea rax, [rel tmp0]
    mov [rel address], rax

    leave
    ret

main:
    push rbp
    mov rbp, rsp

    call preamble

    ; TODO a: Verifiy whether `perfect` is a perfect number.
    ; Perfect numbers have the 2 mid bits equal.
    ; NOTE: You must print "The number <nr> is perfect" if
    ; nr is perfect, otherwise "The number <nr> is not perfect".


    ; TODO b: Verify whether `pure` is a pure array.
    ; Pure arrays have all numbers placed on power of 2 indeces
    ; perfect.
    ; NOTE: You must print "The array is pure" if pure, otherwise
    ; "The array is not pure".


    ; TODO c: Verify whether `address` is magic.
    ; Magic addresses contain the 0 value after three dereferences.
    ; NOTE: You must print "The address is magic" if magic, otherwise
    ; "The address is not magic".


    ; TODO d: Get the only value that's not duplicate from the
    ; `duplicates` array.
    ; NOTE: You must use only one loop and print the unique value
    ; afterwards.


    ; Return 0.
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
