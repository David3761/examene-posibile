section .data
  string   db  "Hello, Worldz!", 0
  fmt      db  "%llx", 10, 0
  n        dd  10
  fmt_d    db  "%d", 10, 0       ; format zecimal (fibo)
  fmt_s    db  "%s", 10, 0       ; format string


section .text
extern printf
extern malloc, memset, memcpy, free
global main

fibo:
	; TODO a: Implement a recursive fibonacci function.
	; Use the value in `n` to test the function, and print the result in main.
    ; fibo(n) in rdi -> rax; fib(0)=0, fib(1)=1, fib(n)=fib(n-1)+fib(n-2)
    cmp rdi, 1
    jg .recurse
    mov rax, rdi              ; cazuri de baza
    ret
.recurse:
    push rbx
    push r12
    mov r12, rdi              ; pastrez n peste apeluri
    lea rdi, [r12 - 1]
    call fibo
    mov rbx, rax              ; fib(n-1)
    lea rdi, [r12 - 2]
    call fibo
    add rax, rbx              ; fib(n-1) + fib(n-2)
    pop r12
    pop rbx
    ret


main:
    push rbp
    mov rbp, rsp


    push rbx                  ; va retine pointerul de heap
    sub rsp, 8                ; aliniere la 16

    ; a: testez fibo cu n si afisez rezultatul
    mov edi, [n]
    call fibo
    mov rsi, rax
    mov rdi, fmt_d
    xor eax, eax
    call printf

    ; TODO b: Allocate and memset to 0x12 a 4096 bytes memory area on the heap
    ; b: aloc 4096 octeti pe heap si ii umplu cu 0x12
    mov rdi, 4096
    call malloc
    mov rbx, rax              ; salvez pointerul alocat
    mov rdi, rbx
    mov rsi, 0x12
    mov rdx, 4096
    call memset
    mov rsi, [rbx]            ; primii 8 octeti
    mov rdi, fmt
    xor eax, eax
    call printf

    ; TODO c: Copy "string" in the memory area allocated above.
    ; c: copiez string in zona alocata si il afisez
    mov rdi, rbx
    mov rsi, string
    mov rdx, 15               ; "Hello, Worldz!" + nul
    call memcpy
    mov rsi, rbx
    mov rdi, fmt_s
    xor eax, eax
    call printf

    ; TODO d: Free the memory area
    ; d: eliberez memoria
    mov rdi, rbx
    call free

    add rsp, 8
    pop rbx

    ; Return 0.
    xor rax, rax
    leave
    ret
