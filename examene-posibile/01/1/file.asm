%include "printf64.asm"

section .data
    danger db "FrggrLrSmAugNvrvrG", 10, 0
    heavy_number dd -16772556
    battle dd -16707020, 447812148, -1968106956, 1609673524, -1, 305402420, -1484674544, -1576992769, -858993460, 178956970

section .text
extern printf
global main

main:
    push rbp
    mov rbp, rsp

    ; TODO a: Print the dangerous letters from the `danger` string.
    ; A letter is dangerous if its ASCII code divided by 5 leaves a remainder less than or equal to 1.

    push rbx
    push r12

    xor rcx, rcx
    xor r12, r12

.iterate_danger:
    cmp byte [danger + r12], byte 0
    je .done_iteration_danger

    movzx rax, byte [danger + r12]
    mov rbx, 5
    xor rdx, rdx
    div rbx
    cmp edx, 1
    jg .next
    movzx rax, byte [danger + r12]
    PRINTF64 `%c\x0`, rax

.next:
    inc r12
    jmp .iterate_danger

.done_iteration_danger:

    pop r12
    pop rbx

    ; TODO c: Verify whether `heavy_number` is a heavy number.
    ; A number is considered heavy if its most significant bit (MSB) is set to 1,
    ; and the number formed by concatenating the third and fourth byte is greater than 255.
    ; Example: for the number 0xabcdef12, the msb is 1 and the resulting number is 0xcdab
    ; NOTE: You must print "The number <nr> is heavy" if
    ; <nr> is heavy, otherwise print "The number <nr> is not heavy".

    mov edi, dword [heavy_number]
    test edi, 0x80000000
    jz .not_heavy

    mov edi, dword [heavy_number]

    mov rsi, rdi
    shr rsi, 16
    and rsi, 0xFF

    mov rdx, rdi
    shr rdx, 24
    and rdx, 0xFF

    shl rsi, 8
    or rsi, rdx

    cmp esi, dword 255
    jle .not_heavy

    PRINTF64 `the number is heavy\n\x0`
    jmp .done_heavy


.not_heavy:
.done_heavy:
    ; TODO d
    xor rcx, rcx
    lea rdi, [rel battle]

.iterate_battle:
    cmp rcx, 10
    jge .done_iterate_battle

    mov esi, dword [rdi + rcx * 4]

    test esi, 0x80000000
    jz .next_battle

    mov rdx, rsi
    shr rdx, 16
    and rdx, 0xFF                 ; byte 3 → rdx

    mov r8, rsi                   ; ← r8 în loc de rcx!
    shr r8, 24
    and r8, 0xFF                  ; ← masca pe r8

    shl rdx, 8
    or rdx, r8

    cmp rdx, 255
    jle .next_battle

    PRINTF64 `0x%X\n\x0`, rsi    ; afișezi numărul original, nu rdx-ul concatenat

.next_battle:
    inc rcx
    jmp .iterate_battle

.done_iterate_battle:

    mov eax, 55
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
