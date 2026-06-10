;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PRINTF64 fmt[, arg1, arg2, arg3, arg4, arg5]
;
; x86_64 System V ABI variant of the IOCLA PRINTF32 macro.
; - Embeds the format string inline (jump-over trick)
; - First 6 args (format + up to 5 more) go in rdi, rsi, rdx, rcx, r8, r9
; - Caller-saved regs are preserved around the call
; - Stack stays 16-byte aligned at the `call` boundary
; - Variadic call requires al = 0 (no XMM args used)
;
; IMPORTANT: arguments must be 64-bit operands.
;   - Labels (addresses) work directly:  PRINTF64 `%s\n\x0`, my_label
;   - Use 64-bit registers:               PRINTF64 `%d\n\x0`, rbx  (NOT ebx)
;   - For memory, prefer qword:           PRINTF64 `%d\n\x0`, qword [val]
;     (if val is `dd`, do `movzx rbx, dword [val]` first and pass rbx)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%macro PRINTF64 1-6
    ; save caller-saved registers we may clobber
    push    rax
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    pushfq
    sub     rsp, 8              ; align stack to 16 bytes before call
                                ; (10 pushes = 80 bytes already aligned;
                                ; +8 to compensate that call adds 8)

    jmp     %%endstr
%%str:  db %1
%%endstr:

%if %0 >= 6
    mov     r9, %6
%endif
%if %0 >= 5
    mov     r8, %5
%endif
%if %0 >= 4
    mov     rcx, %4
%endif
%if %0 >= 3
    mov     rdx, %3
%endif
%if %0 >= 2
    mov     rsi, %2
%endif
    lea     rdi, [rel %%str]
    xor     eax, eax            ; 0 vector args (mandatory for variadic)
    call    printf

    add     rsp, 8
    popfq
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rax
%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
