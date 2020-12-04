bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;a - byte, b - word, c - double word, d - qword - Interpretare fara semn
;(c+d)-(a+d)+b  
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 5
    b dw 4
    c dd 10
    d dq 3
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        mov AL, [a]
        add EAX, [d]
        adc EDX, [d+4] ; EDX:EAX = a + d
        push EDX
        push EAX
        mov EAX, 0
        mov EDX, 0
        mov EAX, [c]
        add EAX, [d]
        adc EDX, DWORD [d+4]; EDX:EAX = c + d
        pop EBX
        pop ECX ; ECX:EBX = a + d
        sub EAX,EBX
        sbb EDX,ECX ; EDX:EAX = (c+d) - (a+d)
        mov ECX, 0
        mov CX, [b]
        add EAX, ECX
        adc EDX, 0 ; EDX:EAX = (c+d) - (a+d) + b
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        