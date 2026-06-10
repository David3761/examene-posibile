%include "printf64.asm"

section .data
    map_size: dd 27
    sir: db "we all love iocla.", 0
    fmt_out1 db "%c: %d", 10, 0

section .bss
    map: resb 27

section .text
extern printf
global main


; TODO a: Implement `void insert_in_map(char *map, int *size, char *str)`
; which inserts letters and their occurrences found in the string `str` into `map`.
; Params (x86_64 SysV): rdi = map, rsi = size, rdx = str

insert_in_map:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    sub rsp, 8

    xor r12, r12

.iterate_sir:
    movzx r8, byte [rdx + r12]
    test r8, r8
    jz .done_iteration_sir

    cmp r8, 'a'
    jl .skip
    cmp r8, 'z'
    jg .skip

    sub r8, 'a'
    movzx r9, byte [rdi + r8]
    inc r9
    mov byte [rdi + r8], r9b

.skip:
    inc r12
    jmp .iterate_sir

.done_iteration_sir:

    xor r12, r12
    xor r13, r13          ; max valoare
    xor r14, r14          ; index max

.find_maxi:
    cmp r12d, esi
    jge .done_find_maxi

    movzx rax, byte [rdi + r12]
    cmp rax, r13
    jle .next
    mov r13, rax
    mov r14, r12          ; păstrăm INDEXUL maxim

.next:
    inc r12
    jmp .find_maxi

.done_find_maxi:
    add r14, 'a'          ; convertim indexul în literă

    lea rdi, [rel fmt_out1]
    mov rsi, r14
    mov rdx, r13
    xor eax, eax
    call printf

    add rsp, 8
    pop r14
    pop r13
    pop r12
    leave
    ret






; TODO b: Implement `void print_map(char *map, int *size)`
; which displays, for each key in `map` of maximum size `size`,
; its value—that is, for each letter with a non-zero count,
; print "<Letter>: <count>\n".
; Params: rdi = map, rsi = size

print_map:
    push rbp
    mov rbp, rsp

    push r12
    push r13
    push r14
    push r15

    xor r12, r12

.iterate_b:
    cmp r12d, esi
    jge .done_iteration_b

    movzx r13, byte [rdi + r12]
    add r12, 'a'

    cmp r13, 0
    je .next
    PRINTF64 `%c: %d\n\x0`, r12, r13

.next:
    sub r12,'a'
    inc r12
    jmp .iterate_b

.done_iteration_b:

    pop r15
    pop r14
    pop r13
    pop r12

    leave
    ret


; TODO c: Implement `void card_map(char *map, int *size)`
; which displays the number of the <key, value> stored in the `map` of maximum size `size` bytes.
; Params: rdi = map, rsi = size

card_map:
    push rbp
    mov rbp, rsp


    push r12
    push r13
    push r14
    push r15

    xor r12, r12
    xor r13, r13
    xor r14, r14

.iterate_c:
    cmp r12d, esi
    jge .done_iteration_c

    movzx r13, byte [rdi + r12]
    add r12, 'a'

    cmp r13, 0
    je .next
    inc r14

.next:
    sub r12,'a'
    inc r12
    jmp .iterate_c

.done_iteration_c:

    PRINTF64 `%d\n\x0`, r14

    leave
    ret


; TODO d: Implement `void expand_map(char *map, int *size)`
; which traverses the entire `map` of maximum size `size`,
; and for each key updates its associated value using the formula:
; ((2 * value + 1) << 7) % 5.
; Params: rdi = map, rsi = size

expand_map:
    push rbp
    mov rbp, rsp

    push r12
    push r13
    push r14
    push r15

    xor r12, r12

.iterate_d:
    cmp r12d, esi
    jge .done_iteration_d

    movzx r13, byte [rdi + r12]
    imul r13, 2
    inc r13
    shl r13, 7
    mov rax, r13
    xor rdx, rdx
    mov rbx, 5
    div rbx
    mov rax, rdx
    mov byte [rdi + r12], al

.next:
    inc r12
    jmp .iterate_d

.done_iteration_d:

    leave
    ret


main:
    push rbp
    mov rbp, rsp

    ; TODO a: Call `insert_in_map` using `map`, `size`, and the string in `.data`
    ; that counts letter occurrences and stores them in `map`.
    ; NOTE: Display the letter with the highest occurrence and its count at the end.

    lea rdi, [map]
    mov rsi, [map_size]
    lea rdx, [sir]
    call insert_in_map

    ; TODO b: Call `print_map` using `map` and `size`
    ; which prints each letter in the map with a non-zero count.
    ; NOTE: Allocate the string "It's not that hard." on the stack,
    ; call `insert_in_map` for this string first, then print the map.


sub rsp, 32
mov byte [rsp],      'I'
mov byte [rsp + 1],  't'
mov byte [rsp + 2],  "'"        ; sau 0x27
mov byte [rsp + 3],  's'
mov byte [rsp + 4],  ' '
mov byte [rsp + 5],  'n'
mov byte [rsp + 6],  'o'
mov byte [rsp + 7],  't'
mov byte [rsp + 8],  ' '
mov byte [rsp + 9],  't'
mov byte [rsp + 10], 'h'
mov byte [rsp + 11], 'a'
mov byte [rsp + 12], 't'        ; ← lipsea
mov byte [rsp + 13], ' '        ; ← lipsea
mov byte [rsp + 14], 'h'        ; ← lipsea
mov byte [rsp + 15], 'a'        ; ← lipsea
mov byte [rsp + 16], 'r'
mov byte [rsp + 17], 'd'
mov byte [rsp + 18], '.'
mov byte [rsp + 19], 0


    lea rdi, [map]
    mov esi, dword [map_size]
    lea rdx, [rsp]
    call insert_in_map

    lea rdi, [map]
    mov esi, dword [map_size]
    call print_map

    ; TODO c: Call `card_map` using `map` and `size`
    ; which displays the cardinality (number of unique letters) of the map.
    ; NOTE: Use the map populated by previous calls.

    lea rdi, [map]
    mov esi, dword [map_size]
    call card_map

    ; TODO d: Call `expand_map` using `map` and `size`
    ; which updates each value with ((2 * value + 1) << 7) % 5 formula.
    ; call `print_map` to display the updated map.

    lea rdi, [map]
    mov esi, dword [map_size]
    call expand_map

    lea rdi, [map]
    mov esi, dword [map_size]
    call print_map

    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
