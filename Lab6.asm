bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;Se dau cuvintele A, B si C. Sa se obtina octetul D ca suma a numerelor reprezentate de:
;biţii de pe poziţiile 0-4 ai lui A
;biţii de pe poziţiile 5-9 ai lui B
;Octetul E este numarul reprezentat de bitii 10-14 ai lui C. Sa se obtina octetul F ca rezultatul scaderii D-E.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0111011101010111b ; 23
    b dw 1001101110111110b ; 29
    c dw 0100110101111001b 
    d db 0
    e db 0
    f db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        mov AX, [a]
        and AX, 0000000000011111b ; izolam biti 0-4 ai lui A
        mov BX, AX ;BX = bitii 0-4 din A
        mov AX, [b]
        and AX, 0000001111100000b ; izolam bitii 5-9 ai lui B 
        mov CL, 5
        ror AX, CL; rotim 5 pozitii la dreapta
        add AX, BX
        mov [d], AL;  punem rezultatul in D = 23 + 29 = 52
        mov AX, [c]
        and AX, 0111110000000000b ; izolam bitii 10-14 ai lui C 
        mov CL, 10
        ror AX, CL; rotim 10 pozitii la dreapta
        mov [e], AL
        mov CL, [d]
        sub CL, [e] ; CL = D-E 
        mov [f], CL
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
