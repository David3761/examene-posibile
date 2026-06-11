section .data
  string   db  "Hello, Worldz!", 0
  fmt      db  "%llx", 10, 0
  n        dd  10


section .text
extern printf
global main

fibo:
	; TODO a: Implement a recursive fibonacci function.
	; Use the value in `n` to test the function, and print the result in main.


main:
    push rbp
    mov rbp, rsp


    ; TODO b: Allocate and memset to 0x12 a 4096 bytes memory area on the heap



    ; TODO c: Copy "string" in the memory area allocated above.



    ; TODO d: Free the memory area


    ; Return 0.
    xor rax, rax
    leave
    ret
