bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;a - byte, b - word, c - double word, d - qword - Interpretare cu semn
;(b+b+d)-(c+a)
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    a db -5
    b dw -7
    c dd -3
    d dq -3
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        mov AX, [b]
        add AX, [b]
        cwde
        add EAX, [d]
        adc EDX, [d+4] ; EDX : EAX = b + b + d
        push EDX
        push EAX
        mov AL, [a]
        cbw
        cwde
        add EAX, [c] ; EAX = c + a
        cdq 
        pop ECX
        pop EBX ; EBX:ECX = b + b + d
        sub ECX, EAX
        sbb EBX, EDX; EBX:ECX = (b + b + d) - (c + a)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
