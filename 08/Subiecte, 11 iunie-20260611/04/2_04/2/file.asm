section .data
    out:  resb 100
    out_size equ 100
    time_format db '%Y-%m-%d %H:%M:%S', 0
    fmt_str db "%s", 10, 0      ; format pentru afisare cu newline


section .text
extern printf
extern time, localtime, strftime, sleep
global main

sort_array:
    ; TODO c: TODO
    ; c: bubble sort in-place pe bytes (rdi = vector, rsi = numar elemente)
    push rbp
    mov rbp, rsp
    mov rcx, rsi               ; contor exterior
.sa_outer:
    cmp rcx, 1
    jle .sa_done
    xor r8, r8                 ; i = 0
.sa_inner:
    mov r9, rcx
    dec r9
    cmp r8, r9                 ; i < count-1
    jge .sa_next
    mov al, [rdi + r8]
    mov dl, [rdi + r8 + 1]
    cmp al, dl
    jbe .sa_noswap
    mov [rdi + r8], dl         ; interschimb elementele vecine
    mov [rdi + r8 + 1], al
.sa_noswap:
    inc r8
    jmp .sa_inner
.sa_next:
    dec rcx
    jmp .sa_outer
.sa_done:
    pop rbp
    ret

d_loop:
    ; TODO d: TODO
    ; d: afiseaza data/ora de rdi(=n) ori, la interval de rsi(=m) secunde
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    sub rsp, 16                ; spatiu pentru time_t (mentine alinierea)
    mov rbx, rdi               ; n
    mov r12, rsi               ; m
.dl_loop:
    test rbx, rbx
    jz .dl_end
    xor edi, edi
    call time
    mov [rsp], rax
    mov rdi, rsp
    call localtime
    mov rdi, out
    mov rsi, out_size
    mov rdx, time_format
    mov rcx, rax
    xor eax, eax
    call strftime
    mov rdi, fmt_str
    mov rsi, out
    xor eax, eax
    call printf
    mov rdi, r12               ; asteapta m secunde
    call sleep
    dec rbx
    jmp .dl_loop
.dl_end:
    add rsp, 16
    pop r12
    pop rbx
    pop rbp
    ret


main:
    push rbp
    mov rbp, rsp

    ; TODO a: Allocate "IOCLA is funz!" on the stack and, then, print its content using `printf`
    ; a: pun sirul pe stiva (pe qwords) si il afisez cu printf
    mov rax, ' funz!'          ; ' funz!' + doi octeti nul
    push rax
    mov rax, 'IOCLA is'
    push rax                   ; rsp -> "IOCLA is funz!\0\0"
    mov rsi, rsp
    mov rdi, fmt_str
    xor eax, eax
    call printf

    ; TODO b: Print current date and time
    ; b: time -> localtime -> strftime(time_format) -> printf
    sub rsp, 16
    xor edi, edi
    call time
    mov [rsp], rax
    mov rdi, rsp
    call localtime
    mov rdi, out
    mov rsi, out_size
    mov rdx, time_format
    mov rcx, rax
    xor eax, eax
    call strftime
    mov rdi, fmt_str
    mov rsi, out
    xor eax, eax
    call printf
    add rsp, 16

    ; TODO c: call sort_array on the string defined on point a
    ; c: sortez cele 14 caractere de pe stiva si afisez rezultatul
    mov rdi, rsp
    mov rsi, 14
    call sort_array
    mov rsi, rsp
    mov rdi, fmt_str
    xor eax, eax
    call printf

    ; TODO d: call d_loop(3, 1)
    ; d: apelez d_loop(3, 1)
    mov rdi, 3
    mov rsi, 1
    call d_loop


    ; Return 0.
    xor rax, rax
    leave
    ret
