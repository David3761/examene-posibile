%include "printf64.asm"

section .rodata
format: db "String is: %s", 10, 0
format_len: db "String len is: %d", 10, 0
format_char: db "Character %c appears %d times", 10, 0
change_len: dd 24

section .bss
challenge_accepted: resb 25

section .data
change_me: db "No OnE cAn cHaNgE mE!!!", 10, 0

mantra: db "Biblioteca, nu librarie!", 10, 0
mantra_len: dd 26

section .text
extern printf
extern malloc
extern strcpy
extern islower
extern isupper
extern tolower
extern toupper
global main

numc:
	push rbp
	mov rbp, rsp
	; TODO c: complete the `void numc(char *s, char c)` function
	; 1st param (s) is in rdi, 2nd param (c) is in sil/rsi

	push rdi
	push rsi

	xor r14, r14
	xor r12, r12

.iterate_string:
	cmp byte [rdi + r12], byte 0
	je .done_iteration_string

	mov rax, rsi
	cmp byte [rdi + r12], al
	jne .next
	inc r14

.next:
	inc r12
	jmp .iterate_string

.done_iteration_string:

	mov rdx, r14
	lea rdi, [rel format_char]
	xor eax, eax

	call printf

	pop rsi
	pop rdi

	leave
	ret


switch:
	push rbp
	mov rbp, rsp

	; 1st param (change_me address) is in rdi
	; 2nd param (change_me_len)     is in rsi


	; TODO d: Use `islower`, `isupper`, `tolower`, `toupper` to modify change_me

	push rbx
	push r12

	mov rbx, rdi
	xor r12, r12

.iterate_string:
	cmp byte [rbx + r12], byte 0
	je .done_iteration_string

	movzx rdi, byte [rbx + r12]
	call islower
	cmp rax, 0
	jne .make_upper

	movzx rdi, byte [rbx + r12]
	call isupper
	cmp rax, 0
	jne .make_lower
	movzx rax, byte [rbx + r12]
	jmp .next

.make_upper:
	movzx rdi, byte [rbx + r12]
	call toupper
	jmp .next

.make_lower:
	movzx rdi, byte [rbx + r12]
	call tolower

.next:
	mov byte [rbx + r12], al
	inc r12
	jmp .iterate_string

.done_iteration_string:

	lea rdi, [format]
	mov rsi, rbx
	xor eax, eax
	call printf

	pop r12
	pop rbx

	leave
	ret

main:
	push rbp
	mov rbp, rsp

	; TODO a: Allocate "I <3 IOCLA!" on the stack. Print the result.
	; You can use the `format` and `format_len` strings for printf

    sub rsp, 16                          ; alocă 16 bytes (aliniere)

    mov byte [rsp],      'I'
    mov byte [rsp + 1],  ' '
    mov byte [rsp + 2],  '<'
    mov byte [rsp + 3],  '3'
    mov byte [rsp + 4],  ' '
    mov byte [rsp + 5],  'I'
    mov byte [rsp + 6],  'O'
    mov byte [rsp + 7],  'C'
    mov byte [rsp + 8],  'L'
    mov byte [rsp + 9],  'A'
    mov byte [rsp + 10], '!'
    mov byte [rsp + 11], 0               ; null terminator

    ; varianta cu printf direct:
    lea rdi, [rel format]                ; format = "String is: %s\n"
    mov rsi, rsp                         ; adresa buffer-ului
    xor eax, eax
    call printf

    lea rdi, [rel format_len]            ; format_len = "String len is: %d\n"
    mov rsi, 11                          ; lungimea string-ului
    xor eax, eax
    call printf

    add rsp, 16                          ; eliberează buffer-ul


	; TODO b: Call malloc to allocat 100 bytes and copy the content of the `matra`
	; string in the newly allocated buffer

	mov rdi, 100
	call malloc
	mov rdi, rax
	lea rsi, [mantra]
	call strcpy

	mov rdi, rax
	call printf

	; TODO c: Complete the `numc` function and test it using `mantra` as a string
	; and `i` as a character

	lea rdi, [mantra]
	mov al, byte 'i'
	mov rsi, rax
	call numc

  	; TODO d: Complete the `switch` function
	mov rdi, change_me
	mov esi, [change_len]
	call switch


	; Return 0.
	xor eax, eax
	leave
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
