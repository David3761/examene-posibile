%include "printf64.asm"

section .rodata
format: db "String is: %s", 10, 0
format_len: db "String len is: %d", 10, 0
format_char: db "Character %c appears %d times", 10, 0
change_me: db "No OnE cAn cHaNgE mE!!!", 10, 0
change_len: dd 24

section .bss
challenge_accepted: resb 25

section .data

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

	leave
	ret


switch:
	push rbp
	mov rbp, rsp

	; 1st param (change_me address) is in rdi
	; 2nd param (change_me_len)     is in rsi
	mov r12, rdi ; change_me
	mov r13, rsi ; change_me_len

	; TODO d: Use `islower`, `isupper`, `tolower`, `toupper` to modify change_me

	leave
	ret

main:
	push rbp
	mov rbp, rsp

	; TODO a: Allocate "I <3 IOCLA!" on the stack. Print the result.
	; You can use the `format` and `format_len` strings for printf


	; TODO b: Call malloc to allocat 100 bytes and copy the content of the `matra`
	; string in the newly allocated buffer


	; TODO c: Complete the `numc` function and test it using `mantra` as a string
	; and `i` as a character

  	; TODO d: Complete the `switch` function
	mov rdi, change_me
	mov esi, [change_len]
	call switch


	; Return 0.
	xor eax, eax
	leave
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
