%include "printf64.asm"

section .data
    map_size: dd 27
    sir: db "we all love iocla.", 0

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

    leave
    ret


; TODO c: Implement `void card_map(char *map, int *size)`
; which displays the number of the <key, value> stored in the `map` of maximum size `size` bytes.
; Params: rdi = map, rsi = size

card_map:
    push rbp
    mov rbp, rsp

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

    leave
    ret


main:
    push rbp
    mov rbp, rsp

    ; TODO a: Call `insert_in_map` using `map`, `size`, and the string in `.data`
    ; that counts letter occurrences and stores them in `map`.
    ; NOTE: Display the letter with the highest occurrence and its count at the end.


    ; TODO b: Call `print_map` using `map` and `size`
    ; which prints each letter in the map with a non-zero count.
    ; NOTE: Allocate the string "It's not that hard." on the stack,
    ; call `insert_in_map` for this string first, then print the map.


    ; TODO c: Call `card_map` using `map` and `size`
    ; which displays the cardinality (number of unique letters) of the map.
    ; NOTE: Use the map populated by previous calls.


    ; TODO d: Call `expand_map` using `map` and `size`
    ; which updates each value with ((2 * value + 1) << 7) % 5 formula.
    ; call `print_map` to display the updated map.


    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
