extern printf

%macro PRINTF 2
    mov rsi, %2
    mov rdi, %1
    xor rax, rax
    call printf
%endmacro
