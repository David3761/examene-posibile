section .data
    fmt_result  db  "Result: %d", 10, 0   ; used by math_utils.asm too

section .text

main:
    mov     rdi, 10
    mov     rsi, 32
    call    add_and_print

    leave
    ret
