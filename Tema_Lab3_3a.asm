bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 200-[3*(c+b-d/a)-300] = 200 - [3 * 2 - 300] = 200 - [-294] = 494
    a db 2
    b db 2
    c db 2
    d dw 4

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AX, [d]
        div BYTE [a] ; AH = AX % a & AL = AX / a = d/a
        
        mov AH, [b]
        sub AH, AL ; AH = AH - AL = b - d / a
        
        mov AL, [c]
        add AL, AH ; AL = AH + AL = c + b - d / a
        mov AH, 0
        
        mov BL, 3
        mul BL ; AX = AL * BL = 3*(c + b - d / a)
        
        mov BX, 300
        sub AX, BX ; AX = AX - BX = 3*(c + b - d / a) - 300
        
        mov BX, 200
        sub BX, AX ; BX = BX - AX = 200 - [3*(c + b - d / a) - 300]
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
