%include "printf64.asm"

section .data
    pushme dw 1, 2, 16, 32, 10, 33, 0, 4, 16, 8
    count dd 0x3333CCCC
    mystr db "Ana are mere", 10, 0
    needle db "re", 0

section .text
extern strstr
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; TODO a: Reverse the `pushme` array, in place, without using additional arrays
    ; You must print the array after reversing it.

    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 8

    xor r12, r12
    xor r13, r13
    xor r14, r14

.iterate_pushme:
    cmp r12, 4
    jge .done_iteration_pushme

    movzx r13, word [pushme + r12 * 2]
    mov r15, 9
    sub r15, r12
    movzx r14, word [pushme + r15 * 2]
    mov rbx, r13
    mov word [pushme + r12 * 2], r14w
    mov word [pushme + r15 * 2], bx

    inc r12
    jmp .iterate_pushme

.done_iteration_pushme:

    xor r12, r12
.iterate_pushme2:
    cmp r12, 10
    jge .done_iteration_pushme2

    xor r13, r13
    movzx r13, word [pushme + r12 * 2]
    PRINTF64 `%d \x0`, r13

    inc r12
    jmp .iterate_pushme2

.done_iteration_pushme2:
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12

    ; TODO b: Check if the number of `1` bits from the `count` variable is even.

    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor r15, r15
    push r12
    push r13
    push r14
    push r15

    mov r12, [count]

.count:
    cmp r12, 0
    je .done_count

    mov r13, r12
    and r13, 1
    cmp r13, 0
    je .not_good_bit
    inc r14

.not_good_bit:
    shr r12, 1
    jmp .count

.done_count:
    and r14, 1
    je .bad_number
    PRINTF64 `Good number\n\x0`
    jmp .done_b

.bad_number:
    PRINTF64 `Bad number\n\x0`

.done_b:
    pop r15
    pop r14
    pop r13
    pop r12

    ; TODO c: Check if the elements on odd positions from the `pushme` array are
    ; powers of 2. ONLY print the elements on odd positions that are powers of 2.

    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor r15, r15
    push r12
    push r13
    push r14
    push r15


.iterate_pushme_c:
    cmp r12, 10
    jge .done_iteration_pushme_c

    test r12, 1
    jz .next

    xor r13, r13
    movzx r13, word [pushme + r12 * 2]
    xor r14, r14

.check:
    cmp r13, 0
    je .done_check

    test r13, 1
    jz .not_1

    inc r14

.not_1:
    shr r13, 1
    jmp .check

.done_check:
    cmp r14, 1
    jne .next

    movzx r13, word [pushme + r12 * 2]
    PRINTF64 `%d \x0`, r13

.next:
    inc r12
    jmp .iterate_pushme_c

.done_iteration_pushme_c:
    pop r15
    pop r14
    pop r13
    pop r12

    ; TODO d: Check if the substring saved in `needle` exists in the string `str`.
    ; Print YES or NO, if the substring exists in the string or not.

    lea rdi, [mystr]
    lea rsi, [needle]
    call strstr

    cmp rax, 0
    je .not_d

    PRINTF64 `yes\n\x0`
    jmp .done_ex

.not_d:
    PRINTF64 `NO\n\X0`

.done_ex:

    ; Return 0.
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
