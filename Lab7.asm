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
    sir dd 127F5678h, 0ABCDABCDh
    len equ ($-sir)/4
    sirRez times len dd 0
    sumLeft dw 0
    sumRight dw 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax,0
        mov ebx,0
        mov ecx,0
        mov edx,0
        
        mov esi, sir
        mov edi, 0
        mov ecx, len
        repeta:
            mov word [sumLeft], 0
            mov word [sumRight], 0
            lodsb
            cbw
            add word [sumRight], AX
            lodsb
            cbw
            add word [sumLeft], AX
            lodsb
            cbw
            add word [sumRight], AX
            lodsb
            cbw
            add word [sumLeft], AX
            mov DX, [sumRight]
            mov AX, [sumLeft]
            push AX
            push DX
            pop EAX
            mov [sirRez+edi],EAX
            add edi, 4
        loop repeta
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
