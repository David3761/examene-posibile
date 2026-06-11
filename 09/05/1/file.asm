%include "printf64.asm"

section .data
    plaintext:   db  "Hello, Worldz!", 0
    vocale: db "aeiouAEIOU ", 0
    SHIFT       equ 3
 
    fmt_enc     db  "Encoded : %s", 10, 0
    fmt_dec     db  "Decoded : %s", 10, 0
 
section .bss
    encoded     resb 64
    decoded     resb 64
 

section .text
extern strchr
extern printf
global main


main:
    push rbp
    mov rbp, rsp

    ; TODO a: Count the number of vowels in plaintext.
    mov r12, plaintext
    xor rcx, rcx
    xor rdx, rdx

.string_loop:
    ; r10 -> caracterl
    movzx r15, byte [r12 + rcx]
    ; daca am ajuns la NULL
    test r15, r15

    jz .end_string_loop

    ; pregatim pentru strchr
    xor rax, rax
    push rcx
    push rdx
    
    mov rdi, r15
    mov rsi, vocale
    call strchr
    
    ; intoarcem ce am pus in stiva
    pop rdx
    pop rcx

    test rax, rax
    jz .continue_loop

    ; daca l-a gasit, incrementez contorul
    inc rdx

.continue_loop:
    inc rcx
    jmp .string_loop

.end_string_loop:
    xor rax, rax
    mov rdi, rdx
    call printf

    ; TODO b: Shift all letters inside the plaintext string with SHIFT positions
    ; make sure to loop from z to a, e.g. y will become b (y -> z -> a -> b).

    

    ; TODO c: Decode the string resulted at b) back to the original form an print it.



    ; TODO d: Print the string checksum.


    ; Return 0.
    xor rax, rax
    leave
    ret
