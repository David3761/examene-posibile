%include "printf64.asm"

section .data
    zeros dw 0b0010110100010000
    vec db 'vybirnffrzoyl', 0
    len_vec equ $ - vec

    struc endianess
        ; TODO: c) Declare the fields of the structure
        ;          "big" - for big-endian binary string representation
        ;          "little" - for little-endian binary string representation
    endstruc

section .bss
    ; TODO: d) Declare a variable "endianness_vec" of type "endianess"

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; TODO: a) Count the number of trailing zero bits in "zeros"

    ; TODO: b) Perform ROT13 on the string "vec"

    ; TODO: c) Print the size of the "endianess" structure (bits and bytes)

    ; TODO: d) Print the string "vec" in big-endian and little-endian formats
    ;          Store the results in the "endianness_vec" structure

    ; Return 0
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
