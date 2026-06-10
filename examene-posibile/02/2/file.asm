%include "printf64.asm"

section .data
    str_a db "D0n't w0RrY", 10, 0
    str1_d db "Bigg String", 10, 0
    str2_d db "Smol", 0


section .text
extern strcpy
extern malloc
extern strlen
extern strncpy
extern printf
global main

; TODO a: Implement `void lowercase(char *src)`
; Change all uppercase characters from `src` to lowercase.
; Param: rdi = src

lowercase:
    push rbp
    mov rbp, rsp

    push r12
    push r13
    xor r12, r12
    xor r13, r13

.iterate_string:
    cmp byte [str_a + r12], byte 0
    je .done_iteration_string

    movzx r13, byte [str_a + r12]
    cmp r13, 'A'
    jl .next
    cmp r13, 'Z'
    jg .next

    add r13, 32
    mov byte [str_a + r12], r13b

.next:
    inc r12
    jmp .iterate_string

.done_iteration_string:
    xor r12, r12
    xor r13, r13

.print_str1:
    cmp byte [str_a + r12], byte 0
    je .done_print_str1

    movzx r13, byte [str_a + r12]
    PRINTF64 `%c\x0`, r13

    inc r12
    jmp .print_str1

.done_print_str1:
    pop r13
    pop r12

    leave
    ret


; TODO b: Implement `int ispow(int n)`
; Return 1 if n is a power of 4, 0 otherwise.
; Param: edi = n, return value in eax

ispow:
    push rbp
    mov rbp, rsp

    push r12
    push r13

    xor r12, r12
    xor r13, r13

.check:
    cmp rdi, 0
    je .done_check

    inc r12
    test rdi, 1
    jz .not_good_bit
    inc r13


.not_good_bit:
    shr rdi, 1
    jmp .check

.done_check:
    cmp r13, 1
    jne .bad_number
    test r12, 1
    jnz .bad_number
    mov rax, 1
    jmp .final_done_a

.bad_number:
    xor rax, rax
    pop r13
    pop r12

.final_done_a:
    leave
    ret


; TODO c: Implement `int myabs(int n)`
; Return -n if n < 0, n otherwise
; Param: edi = n, return value in eax

myabs:
    push rbp
    mov rbp, rsp

    cmp rdi, 0
    jl .neg1
    jmp .final_done_c

.neg1:
    neg rdi

.final_done_c:
    mov rax, rdi
    leave
    ret


; TODO d: Implement `void strswap(char *s1, char *s2, int size1, int size2)`
; Params: rdi = s1, rsi = s2, edx = size1, ecx = size2

strswap:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 8                 ; aliniere (5 push-uri + 1 sub = 48 bytes)

    mov r12, rdi               ; s1 (callee-saved, nu se pierde la call)
    mov r13, rsi               ; s2
    mov r14d, edx              ; size1
    mov r15d, ecx              ; size2

    cmp r14, r15
    jl .first_lower

.second_lower:
    ; min = size2 (r15)
    movsxd rdi, r15d
    call malloc
    mov rbx, rax               ; rbx = temp buffer

    ; strncpy(temp, s1, size2)
    mov rdi, rbx
    mov rsi, r12
    mov edx, r15d
    call strncpy

    ; strncpy(s1, s2, size2)
    mov rdi, r12
    mov rsi, r13
    mov edx, r15d
    call strncpy

    ; strncpy(s2, temp, size2)
    mov rdi, r13
    mov rsi, rbx
    mov edx, r15d
    call strncpy

.first_lower:
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    leave
    ret



main:
    push rbp
    mov rbp, rsp

    ; TODO a: Call `lowercase` using `str_a` as argument.
    ; You must print the resulted string.

    lea rdi, [str_a]
    call lowercase

    ; TODO b: Call `ispow()` using 256 and 8 as arguments.
    ; Print the result both times.

    mov rdi, 256
    call ispow
    PRINTF64 `%d\n\x0`, rax

    mov rdi, 8
    call ispow
    PRINTF64 `%d\n\x0`, rax

    ; TODO c: Call `myabs()` using both a negative and a positive argument.
    ; Print the results.

    mov rdi, 5
    call myabs
    PRINTF64 `%d\n\x0`, rax

    mov rdi, -1
    call myabs
    PRINTF64 `%d\n\x0`, rax

    ; TODO d: Call `strswap` using `str1_d` and `str2_d` as arguments.
    ; Print both strings after the function ends.



lea rdi, [rel str1_d]
call strlen
mov r12, rax               ; size1

lea rdi, [rel str2_d]
call strlen
mov r13, rax               ; size2

lea rdi, [rel str1_d]
lea rsi, [rel str2_d]
mov edx, r12d              ; size1
mov ecx, r13d              ; size2
call strswap

PRINTF64 `%s\n%s\n\x0`, str1_d, str2_d


    ; Return 0.
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
