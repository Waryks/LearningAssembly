bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; f+(c-2)*(3+a)/(d-4) = 3 + 4/2 = 3 + 2 = 5
    a db 1
    c db 3
    d db 6
    f dw 3
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        sub byte [c], 2 ; [c] - > [c] - 2
        mov AL, [c] ; AL = [c]
        add byte [a], 3 ; [a] - > [a] + 3
        sub byte [d], 4 ; [d] - > [d] - 4
        mul byte [a] ; AX = AL * [a] = (c - 2) * (3 + a)
        div byte [d] ; AH = AX % d & AL = AX / d = (c - 2) * (3 + a) / (d - 4)
        mov BL, AL
        mov AX, 0
        mov AL, BL
        add AX, word [f] ; [f] = [f] + BX = f + (c - 2) * (3 + a) / (d - 4)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
