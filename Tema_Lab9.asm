bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, printf, scanf 
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll 

; Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici si spatii. Sa se inlocuiasca toate literele de pe pozitii pare cu numarul pozitiei. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "nume.txt", 0  ; numele fisierului care va fi creat
    mod_acces db "w", 0          ; modul de deschidere a fisierului - 
                                 ; w - pentru scriere. daca fiserul nu exista, se va crea     
    text db "am fost afara si nu am facut nimicsd", 0    ; textul care va fi scris in fisier
    ;        a2 4o6t 8f10r12
    len equ $-text
    descriptor_fis dd -1 
    formatc db "%c", 0
    formatd db "%d", 0

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2

        mov [descriptor_fis], eax 
        
        cmp eax, 0
        je final

        mov ebx, 0
        mov ecx, len
        mov esi, 0
        repeta:
            push ecx
            mov bl, [text + esi]
            cmp bl, 32
            je spatiu ; daca e spatiu
                mov eax, esi
                mov dl , 2
                div dl
                cmp ah, 0
                je pozPar
                jmp spatiu
                pozPar:
                push dword esi
                push dword formatd
                push dword [descriptor_fis]
                call [fprintf]
                add esp, 4*3
            jmp sfarsit
            spatiu:
            push dword ebx
            push dword formatc
            push dword [descriptor_fis]
            call [fprintf]
            add esp, 4*3
            sfarsit:
            inc esi
            pop ecx 
        loop repeta
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        final:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
