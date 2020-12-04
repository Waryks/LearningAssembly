bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;(8-a*b*100+c)/d+x; a,b,d-byte; c-doubleword; x-qword -2-5=-7
; fara semn
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db -1
    b db -1
    d db -4
    c dd 100
    x dq -5
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        mov AL, [a]
        imul byte [b]
        mov BX, 100
        imul BX ; DX:AX = a*b*100
        push DX
        push AX
        pop EBX ; EBX = a*b*100
        mov EAX, 8
        sub EAX, EBX ; AX = 8-a*b*100 
        add EAX, [c] ; EAX = 8-a*b*100+c
        mov ECX, EAX ; ECX = 8-a*b*100+c
        mov AL, [d]
        cbw
        cwde ; EAX = d
        mov EBX, EAX ; EBX = d
        mov EAX, ECX ; EAX = 8-a*b*100+c
        cdq ; EDX : EAX = 8-a*b*100+c
        idiv EBX ; EAX = (8-a*b*100+c)/d EDX = (8-a*b*100+c)%d
        mov EDX, 0 ; EDX = 0
        add EAX, [x] 
        adc EDX, [x+4] ; EDX:EAX = (8-a*b*100+c)/d+x
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
