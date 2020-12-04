bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s db '+', '4', '2', 'a', '8', '4', 'X', '5'
    l equ $-s
    d times l db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        
        mov ecx, l ;lungimea sirului din s e salvata in ecx
        mov esi, 0 ;indexul sirului s
        mov edi, 0 ;indexul sirului d
        jecxz Sf
        Repeta:
            mov al, [s+esi]
            cmp al, 57
            jbe num1 
            jmp litera
            num1:  
                cmp al, 48
                jae num2
                jmp litera
                num2:
                    mov [d+edi], al
                    inc edi
            litera: 
            inc esi
        loop Repeta
        Sf:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
