%include "printf64.asm"

section .text

add_and_print:
    push    rbp
    mov     rbp, rsp
    add     rdi, rsi           ; rdi = a + b
    PRINTF  fmt_result, rdi    ; uses fmt_result from main.asm
    pop     rbp
    ret
