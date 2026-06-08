%include "printf64.asm"

section .data
nums dw 0x3dc, 0xab, 0x10, 0xd4, 0xd7, 0x14e, 0x154
nums_len dd 6
value dd 0x6852aecf
a dw 13450
b dw 52090
string db "being a bee is beeautiful"
string_len dd 25

section .text
extern printf
global main

main:
	push rbp
	mov rbp, rsp

	; TODO a: Print out all the elements 'n' of `nums` that satisfy 'n' % 8 = 4
	; HINT: Use bitwise operations!

	; TODO b: Check if the sum of 'a' and 'b' fits in 2 bytes.
	; Print "Fit" if it fits or "Not fit" if it doesn't.

	; TODO c: Check whether `value` has more bits on even positions set then
	; on odd positions.
	; Note: If there are more bits on even positions print "More bits even", otherwise
	; print "More bits odd".
	; Note: Bits are indexed from zero, so the first one is an even bit.

	; TODO d: Change all the occurances of "ee" to "zz" in `string`.

	xor eax, eax
	leave
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
