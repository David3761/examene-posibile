%include "printf64.asm"

section .data
    N  dd 6
    demo_lap1 db "11:34"
    demo_lap2 db "10:35"

    laps_arr db "10:00", 0, "11:10", 0, "09:34", 0, "14:03", 0, "10:45", 0, "10:20", 0
    time_fmt db "%d ", 10, 0
    int_fmt db "%d ", 10, 0
    time_fmt_str db "%s", 10, 0

section .text
global main
extern printf

;TODO a: Implement int time_to_seconds(char *time_str)
; -> `time_str` is a string representing time in format `MM:SS`.
;     the string is always valid
; -> returns the number of seconds in the `time_str`.
; Param: rdi = time_str, return value in eax
time_to_seconds:
    push rbp
    mov rbp, rsp

    leave
    ret

; TODO b: Implement int compare_laps(char *lap1_str, char *lap2_str)
; `lap1_str` and `lap2_str` are strings representing time in format `MM:SS`.
; returns 1, if lap1_str is faster than lap2_str
; returns -1, if lap1_str is slower than lap2_str
; return 0, if lap1_str is equal to lap2_str
; Params: rdi = lap1_str, rsi = lap2_str, return value in eax
compare_laps:
    push rbp
    mov rbp, rsp


    leave
    ret

; TODO c: Implement count_total_time(char *time_str, int len)
; -> `time_str` is an array of bytes representing times in format `MM:SS`,
;     separated by `0` (end of string).
; -> `len` the number of elements in `time_str`.
; -> return the total time in the array.
; Params: rdi = time_str, esi = len, return value in eax
count_total_time:
    push rbp
    mov rbp, rsp


    leave
    ret

; TODO d: Implement `int count_slower_laps(char *time_arr, int len, char *demo_lap)
; -> `time_arr` is an array of bytes representing times in format `MM:SS`,
;     separated by `0` (end of string).
; -> `len` the number of elements in `time_str`.
; -> `demo_lap` is a string representing time in format `MM:SS`.
; -> returns the number of laps in `time_arr` strictly slower than `demo_lap`.
; Params: rdi = time_arr, esi = len, rdx = demo_lap, return value in eax
count_slower_laps:
    push rbp
    mov rbp, rsp


    leave
    ret

main:
    push rbp
    mov rbp, rsp

    ; TODO a: Compute the number of seconds in `demo_lap1` by calling
    ; `int time_to_seconds(char *time_str)` function.
    ; print the result using `printf` function


    ; TODO b: Compare `demo_lap2` and `demo_lap1` (in this order) by calling
    ; `int compare_laps(char *time_str1, char *time_str2)
    ; print the result using `printf` function


    ; TODO c: Compute total workout time for a training session described
    ; by `laps_arr` using `int count_total_time(char *time_str, int len)`
    ; print the result using `printf` function


    ; TODO d: Compute the number of strictly slower laps than `demo_lap2` using
    ; `int count_slower_laps(char *time_arr, int len, char *demo_lap)`
    ; print the result using `printf` function

    ; Return 0.
    xor eax, eax
    leave
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
