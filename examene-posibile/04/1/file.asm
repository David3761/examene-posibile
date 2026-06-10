%include "printf64.asm"

section .data
    zeros dw 0b0010110100010000
    vec db 'vybirnffrzoyl', 0
    len_vec equ $ - vec
    format_out_b db "%s", 10, 0

    struc endianess
        little: resb 8
        big: resb 8
        ; TODO: c) Declare the fields of the structure
        ;          "big" - for big-endian binary string representation
        ;          "little" - for little-endian binary string representation
    endstruc

section .bss
    ; TODO: d) Declare a variable "endianness_vec" of type "endianess"
    endianess_vec: resb endianess_size * (len_vec - 1)

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; TODO: a) Count the number of trailing zero bits in "zeros"

    push r12
    push r13
    push r14
    push r15
    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor r15, r15

    movzx r12, word [zeros]

.check:
    cmp r12, 0
    je .done_check

    mov r13, r12
    and r13, 1
    cmp r13, 1
    je .done_check

    inc r15
    shr r12, 1
    jmp .check

.done_check:
    PRINTF64 `%d\n\x0`, r15

    pop r15
    pop r14
    pop r13
    pop r12

    ; TODO: b) Perform ROT13 on the string "vec"

    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor r15, r15
    push r12
    push r13
    push r14
    push r15

.iterate_vec:
    cmp byte [vec + r12], byte 0
    je .done_iteration_vec

    xor r13, r13
    movzx r13, byte [vec + r12]
    add r13, 13
    cmp r13, 'z'
    jge .transform

    mov byte [vec + r12], r13b
    jmp .next_b

.transform:
    sub r13, 26
    mov byte [vec + r12], r13b

.next_b:
    inc r12
    jmp .iterate_vec

.done_iteration_vec:
    lea rdi, [format_out_b]
    lea rsi, [vec]
    call printf

    pop r15
    pop r14
    pop r13
    pop r12

    ; TODO: c) Print the size of the "endianess" structure (bits and bytes)

    mov rax, endianess_size
    mov rdx, rax
    imul rdx, 8
    PRINTF64 `%d %d\n\x0`, rax, rdx

    ; TODO: d) Print the string "vec" in big-endian and little-endian formats
    ;          Store the results in the "endianness_vec" structure

    ; TODO d
    ; TODO d
    xor r12, r12                              ; index caracter

.iterate_vec_d:
    cmp byte [vec + r12], byte 0
    je .done_iteration_vec_d

    movzx r13, byte [vec + r12]               ; r13 = caracterul

    ; calculează adresa struct-ului i
    mov rax, r12
    imul rax, endianess_size                  ; rax = i * 16
    lea r14, [rel endianess_vec]
    add r14, rax                              ; r14 = &endianess_vec[i]

    xor rbx, rbx                              ; bit index

.iterate_bit_d:
    cmp rbx, 8
    jge .next_char_d

    ; little-endian: bit (rbx) → little[rbx]
    mov rcx, rbx
    mov rax, r13
    shr rax, cl
    and rax, 1
    add rax, '0'
    mov [r14 + little + rbx], al

    ; big-endian: bit (7 - rbx) → big[rbx]
    mov rcx, 7
    sub rcx, rbx
    mov rax, r13
    shr rax, cl
    and rax, 1
    add rax, '0'
    mov [r14 + big + rbx], al

    inc rbx
    jmp .iterate_bit_d

.next_char_d:
    ; afișează struct-ul curent
    PRINTF64 `big: %.8s  little: %.8s\n\x0`, qword [r14 + big], qword [r14 + little]
    ; ⚠ atenție: PRINTF64 are limite, e mai sigur cu printf direct:
    ; lea rdi, [rel fmt_d]
    ; lea rsi, [r14 + big]
    ; lea rdx, [r14 + little]
    ; xor eax, eax
    ; call printf

    inc r12
    jmp .iterate_vec_d

.done_iteration_vec_d:







    ; Return 0
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
