%include "printf64.asm"

section .data
    bitset_size dd 1000

section .bss
    bitset resb 1000


section .text
extern printf
extern scanf
global main

; TODO a: Implement `void insert_in_set(char *set, int n, int x)`
; which inserts value `x` in the `set` bitset of `n` bytes.
; Params: rdi = set, esi = n, edx = x

insert_in_set:
    push rbp
    mov rbp, rsp

    leave
    ret


; TODO b: Implement `void read_set(char *set, int n, int m)`
; which reads from stdin `m` values and inserts them in the
; `set` bitset of `n` bytes.
; Params: rdi = set, esi = n, edx = m

read_set:
    push rbp
    mov rbp, rsp

    leave
    ret


; TODO c: Implement `void print_set(char *set, int n)`
; which prints all values stored in the `set` bitset of
; `n` bytes.
; Params: rdi = set, esi = n

print_set:
    push rbp
    mov rbp, rsp

    leave
    ret


; TODO d: Implement `int card_set(char *set, int n)`
; which returns the cardinal of the `set` bitset of
; `n` bytes
; Params: rdi = set, esi = n, return value in eax

card_set:
    push rbp
    mov rbp, rsp

    leave
    ret


main:
    push rbp
    mov rbp, rsp

    ; TODO a: Call `insert_in_set` using `bitset`, `bitset_size`
    ; and 56 for value.
    ; NOTE: You must print the value of the byte in which 56
    ; was inserted.


    ; TODO b: Call `read_set` using `bitset`, `bitset_size` and
    ; 2 for the number of values read from stdin.
    ; Read 160 and 161 from stdin.
    ; NOTE: You must print the value of the byte in which 160 and 161
    ; were inserted.


    ; TODO c: Call `print_set` using the bitset that was populated
    ; in the a) and b) subtasks.


    ; TODO d: Call `card_set` using the bitset that was populated
    ; in the a) and b) subtasks.
    ; NOTE: You must print the return value.


    ; Return 0.
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
