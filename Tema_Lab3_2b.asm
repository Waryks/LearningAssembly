bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;(a-b-c)+(a-c-d-d) = -3 + -6 = -9
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 1
    b dw 1
    c dw 3
    d dw 2
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AX, [a]
        sub AX, [b] ; AX = AX - [var] = a - b
        sub AX, [c] ; AX = AX - [var] = a - b - c
        mov BX, [a]
        sub BX, [c] ; BX = BX - [var] = a - c
        sub BX, [d] ; BX = BX - [var] = a - c - d
        sub BX, [d] ; BX = BX - [var] = a - c - d - d
        add AX, BX  ; AX = AX + AB = (a-b-c)+(a-c-d-d)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
