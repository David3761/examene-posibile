%include "printf64.asm"


; structure for a binary_fun entry
struc binary_fun_t
	number: resd 1	; the number
	mask: resd 1	; the mask that should be applied to the number using the logical AND operation
	maskedn: resd 1	; the number with the applied mask
	negate: resd 1	; the negate value of number
endstruc

section .bss
ave_string: resb 13

section .data

binary_funs:
	istruc binary_fun_t
		at number, dd 0xAABBCCDD
		at mask, dd 0xFFFF0000
		at maskedn, dd 0
		at negate, dd 0
	iend

binary_vec: dw 0x1, 0x2, 0x3, 0x6, 0x9, 0xff
binary_len: dd 6

init_string: db 'IOCLA Rullz!', 0
string_len: dd 12
N: db 5

section .text
extern printf
extern exit
global main

ave:
	push rbp
	mov rbp, rsp

	PRINTF64 `Before transformation: %s\n\x0`, init_string

	mov rsi, init_string
	mov rdi, ave_string

	; TODO c: Apply the following transformation for each character of init_string
	; newc = (c - 'A' + N ) % 31 + 'A'


	PRINTF64 `After transformation: %s\n\x0`, ave_string

	leave
	ret

exit42:
	push rbp
	mov rbp, rsp

	mov eax, edi ; 1st param (in rdi)

	; TODO d: if eax is a multiple of 42, then exit 42

	PRINTF64 `%d is not a multiple of 42.\n\x0`, rdi
	leave
	ret

main:
	push rbp
	mov rbp, rsp


	; TODO a: Compute fields `maskedn` and `negate`
	; maskedn = number & mask
        ; negate = not number

	; TODO a: Print structure fields

	; TODO b: Count number of elements with the second least significant bit equal to 1

	xor rbx, rbx
	PRINTF64 `No of elements: %d\n\x0`, rbx

	; TODO c: Complete function `ave`

	call ave

	; TODO d: Complete function exit42
	mov edi, 2
	call exit42

	mov edi, 42
	call exit42

	; Return 0.
	xor eax, eax
	leave
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
