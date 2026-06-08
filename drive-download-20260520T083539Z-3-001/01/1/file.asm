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


    ; TODO c: Verify whether `heavy_number` is a heavy number.
    ; A number is considered heavy if its most significant bit (MSB) is set to 1,
    ; and the number formed by concatenating the third and fourth byte is greater than 255.
    ; Example: for the number 0xabcdef12, the msb is 1 and the resulting number is 0xcdab
    ; NOTE: You must print "The number <nr> is heavy" if
    ; <nr> is heavy, otherwise print "The number <nr> is not heavy".


    ; TODO d: Print the heavy numbers in the `battle` array in hexadecimal format.


    ; TODO b: Modify return value to 55
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
