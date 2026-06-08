%include "printf64.asm"

section .data
    str_a db "D0n't w0RrY", 10, 0
    str1_d db "Bigg String", 10, 0
    str2_d db "Smol", 0


section .text
extern printf
global main

; TODO a: Implement `void lowercase(char *src)`
; Change all uppercase characters from `src` to lowercase.
; Param: rdi = src

lowercase:
    push rbp
    mov rbp, rsp

    leave
    ret


; TODO b: Implement `int ispow(int n)`
; Return 1 if n is a power of 4, 0 otherwise.
; Param: edi = n, return value in eax

ispow:
    push rbp
    mov rbp, rsp

    leave
    ret


; TODO c: Implement `int myabs(int n)`
; Return -n if n < 0, n otherwise
; Param: edi = n, return value in eax

myabs:
    push rbp
    mov rbp, rsp

    leave
    ret


; TODO d: Implement `void strswap(char *s1, char *s2, int size1, int size2)`
; Params: rdi = s1, rsi = s2, edx = size1, ecx = size2

strswap:
    push rbp
    mov rbp, rsp

    leave
    ret


main:
    push rbp
    mov rbp, rsp

    ; TODO a: Call `lowercase` using `str_a` as argument.
    ; You must print the resulted string.


    ; TODO b: Call `ispow()` using 256 and 8 as arguments.
    ; Print the result both times.


    ; TODO c: Call `myabs()` using both a negative and a positive argument.
    ; Print the results.


    ; TODO d: Call `strswap` using `str1_d` and `str2_d` as arguments.
    ; Print both strings after the function ends.


    ; Return 0.
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
