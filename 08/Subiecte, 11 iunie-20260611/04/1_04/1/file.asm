%include "printf64.asm"

section .data
    pal	    dd 123454321
    n	    db 6
    string  db "IOCLA is funz!", 10, 0


section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp


    ; TODO a: Check if `pal` is a palindrom number.
    ; Print "Palindrom :)" if true, or "Nu este palindrom :(" if false.

    ; a: construiesc numarul inversat si il compar cu originalul
    mov eax, [pal]              ; numarul original
    mov r8d, eax               ; copie de lucru
    xor r9d, r9d               ; numarul inversat
    mov r10d, 10
.rev_loop:
    mov eax, r8d
    xor edx, edx
    div r10d                   ; eax = n/10, edx = n%10
    mov r8d, eax
    imul r9d, r9d, 10
    add r9d, edx               ; inversat = inversat*10 + cifra
    test r8d, r8d
    jnz .rev_loop
    mov eax, [pal]
    cmp eax, r9d
    jne .not_palin
    PRINTF64 `Palindrom :)!\n`
    jmp .after_a
.not_palin:
    PRINTF64 `Nu este palindrom :(!\n`
.after_a:


    ; TODO b: Compute and print the first n powers of 6.

    ; b: pornesc de la 6 (6^1) si inmultesc cu 6 de n ori
    movzx rcx, byte [n]        ; contor = n
    mov r8, 6                  ; puterea curenta a lui 6
.pow_loop:
    PRINTF64 `%lu\n`, r8
    imul r8, 6
    dec rcx
    jnz .pow_loop


    mov rax, string
    ; TODO c: Uncomment the following line. Fix the running errors without changing the code below.
    mov [rax + 9], dword 0x6c6c6568

    PRINTF64 `%s`, rax

    ; TODO d: Print each character of string in hexa

    ; d: parcurg string-ul si afisez codul hexa al fiecarui caracter
    mov rsi, string
.hex_loop:
    movzx edi, byte [rsi]
    test dil, dil              ; m-am oprit la terminatorul nul
    jz .hex_done
    PRINTF64 `%02x\n`, rdi
    inc rsi
    jmp .hex_loop
.hex_done:

    ; Return 0.
    xor rax, rax
    leave
    ret
