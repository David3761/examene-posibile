%include "printf64.asm"

section .data
    ; TODO: b)

section .text
extern malloc
extern printf
global main

; TODO: b) Create a linear congruential generator (LCG) init function
;          Initializes the LCG with parameters a, b and m.

; TODO: c) Create a linear congruential generator (LCG) next function
;          Returns the next random number in the sequence.

; TODO: d) Create the map function
;          Takes a pointer to the buffer and a function pointer,
;          applies the function to each element in the buffer.

main:
    push rbp
    mov rbp, rsp

    ; TODO: a) Alloc an integer buffer of 32 elements and initialize it with values 0..31
    ; Print it afterwards

    ; TODO: b) Create and initialize a linear congruential generator (LCG)

    ; TODO: c) Call next_lcg with 1234
    ; Print its results

    ; TODO: d) Use the map function to apply the LCG next function
    ;          to each element in the buffer.
    ; Print the updated buffer

    ; Return 0
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
