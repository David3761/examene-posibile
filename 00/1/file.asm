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
	fmt_out1 db "Number: %d\n Mask: %d\n Maskedn: %d\n Negate: %d", 10, 0

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

	xor r12, r12

.iterate_string:
	cmp byte [rdi + r12], byte 0
	je .done_iteration_string

	movzx rdx, byte [rdi + r12]
	mov rax, rdx
	sub al, byte 'A'
	mov rdx, rax
	movzx rax, byte [N]
	add rdx, rax
	xor rax, rax
	mov rax, rdx
	xor rdx, rdx
	mov rbx, 31
	div rbx
	add rdx, byte 'A'
	mov rax, rdx
	mov byte [rsi + r12], al
	xor rdx, rdx
	xor rax, rax
	xor rbx, rbx

	inc r12
	jmp .iterate_string

.done_iteration_string:


	; TODO c: Apply the following transformation for each character of init_string
	; newc = (c - 'A' + N ) % 31 + 'A'


	PRINTF64 `After transformation: %s\n\x0`, ave_string

	leave
	ret

exit42:
    push rbp
    mov rbp, rsp
    mov r12, rdi        ; salvăm parametrul (rdi e clobbered de PRINTF64)

    xor rdx, rdx
    mov rax, rdi
    mov rbx, 42
    div rbx
    test rdx, rdx
    jnz .not_multiple   ; dacă rdx != 0, nu e multiplu

    mov edi, 42
    call exit           ; ← apelăm exit(42), nu returnăm

.not_multiple:
    PRINTF64 `%d is not a multiple of 42.\n\x0`, r12
    leave
    ret


main:
	push rbp
	mov rbp, rsp


	; TODO a: Compute fields `maskedn` and `negate`
	; maskedn = number & mask
        ; negate = not number

	; TODO a: Print structure fields

	lea rdi, [binary_funs]
	mov esi, dword [rdi + number]
	mov edx, dword [rdi + mask]
	and rsi, rdx
	mov dword [rdi + maskedn], esi
	mov esi, dword [rdi + number]
	neg esi
	mov dword [rdi + negate], esi

	lea rdi, [fmt_out1]
	mov esi, dword [binary_funs + number]
	mov edx, dword [binary_funs + mask]
	mov ecx, dword [binary_funs + maskedn]
	mov r8d, dword [binary_funs + negate]

	call printf

	; TODO b: Count number of elements with the second least significant bit equal to 1

	lea rdi, [binary_vec]
	xor rcx, rcx
	xor rdx, rdx

.iterate_vect:
	cmp ecx, dword [binary_len]
	jge .done_iteration_vect

	movzx rsi, word [binary_vec + rcx * 2]
	shr rsi, 1
	and rsi, 1
	cmp rsi, 0
	je .next
	inc rdx

.next:
	inc rcx
	jmp .iterate_vect

.done_iteration_vect:
	xor rbx, rbx
	mov rbx, rdx
	PRINTF64 `No of elements: %d\n\x0`, rbx

	; TODO c: Complete function `ave`

	lea rdi, [init_string]
	lea rsi, [ave_string]
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
