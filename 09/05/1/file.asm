%include "printf64.asm"

section .data
    plaintext:   db  "Hello, Worldz!", 0
    vocale: db "aeiouAEIOU ", 0
    SHIFT       equ 3
 
    fmt_enc     db  "Encoded : %s", 10, 0
    fmt_dec     db  "Decoded : %s", 10, 0
    fmt_num     db  "%d", 10, 0      ; format pentru numere (a, d)
 
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
    xchg rdi, rsi              ; strchr(s, c): rdi=vocale (sirul), rsi=caracterul
    call strchr
    
    ; intoarcem ce am pus in stiva
    pop rdx
    pop rcx

    test rax, rax
    jz .continue_loop

    cmp r15b, ' '             ; spatiul e in `vocale`, dar nu e vocala -> il sar
    je .continue_loop

    ; daca l-a gasit, incrementez contorul
    inc rdx

.continue_loop:
    inc rcx
    jmp .string_loop

.end_string_loop:
    xor rax, rax
    mov rdi, rdx
    mov rsi, rdx              ; numarul de vocale ca argument
    mov rdi, fmt_num          ; format string pentru printf
    call printf

    ; TODO b: Shift all letters inside the plaintext string with SHIFT positions
    ; make sure to loop from z to a, e.g. y will become b (y -> z -> a -> b).

    ; b: shiftez fiecare litera cu SHIFT, cu wrap; non-literele raman la fel
    mov rsi, plaintext        ; sursa
    mov rdi, encoded          ; destinatie
.enc_loop:
    mov al, [rsi]
    test al, al
    jz .enc_done
    cmp al, 'a'
    jb .enc_upper
    cmp al, 'z'
    ja .enc_store
    sub al, 'a'               ; litera mica
    add al, SHIFT
    cmp al, 26
    jb .enc_lo_ok
    sub al, 26                ; wrap z -> a
.enc_lo_ok:
    add al, 'a'
    jmp .enc_store
.enc_upper:
    cmp al, 'A'
    jb .enc_store
    cmp al, 'Z'
    ja .enc_store
    sub al, 'A'               ; litera mare
    add al, SHIFT
    cmp al, 26
    jb .enc_up_ok
    sub al, 26
.enc_up_ok:
    add al, 'A'
.enc_store:
    mov [rdi], al
    inc rsi
    inc rdi
    jmp .enc_loop
.enc_done:
    mov byte [rdi], 0         ; terminator nul
    mov rdi, fmt_enc
    mov rsi, encoded
    xor eax, eax
    call printf

    ; TODO c: Decode the string resulted at b) back to the original form an print it.

    ; c: decodific shiftand invers (-SHIFT == +(26-SHIFT))
    mov rsi, encoded
    mov rdi, decoded
.dec_loop:
    mov al, [rsi]
    test al, al
    jz .dec_done
    cmp al, 'a'
    jb .dec_upper
    cmp al, 'z'
    ja .dec_store
    sub al, 'a'
    add al, 26 - SHIFT
    cmp al, 26
    jb .dec_lo_ok
    sub al, 26
.dec_lo_ok:
    add al, 'a'
    jmp .dec_store
.dec_upper:
    cmp al, 'A'
    jb .dec_store
    cmp al, 'Z'
    ja .dec_store
    sub al, 'A'
    add al, 26 - SHIFT
    cmp al, 26
    jb .dec_up_ok
    sub al, 26
.dec_up_ok:
    add al, 'A'
.dec_store:
    mov [rdi], al
    inc rsi
    inc rdi
    jmp .dec_loop
.dec_done:
    mov byte [rdi], 0
    mov rdi, fmt_dec
    mov rsi, decoded
    xor eax, eax
    call printf

    ; TODO d: Print the string checksum.

    ; d: suma caracterelor pe un octet, apoi complement fata de 2
    mov rsi, decoded
    xor edx, edx              ; suma pe 8 biti in dl
.cks_loop:
    mov al, [rsi]
    test al, al
    jz .cks_done
    add dl, al
    inc rsi
    jmp .cks_loop
.cks_done:
    neg dl                    ; complement fata de 2
    movzx esi, dl
    mov rdi, fmt_num
    xor eax, eax
    call printf


    ; Return 0.
    xor rax, rax
    leave
    ret
