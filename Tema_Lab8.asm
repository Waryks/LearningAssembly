bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf ; adaugam printf si scanf ca functii externa            
import exit msvcrt.dll    
import printf msvcrt.dll    ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll 
              ; tell nasm that exit exists even if we won't be defining it
   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Se da un numar natural negativ a (a: dword). 
;Sa se afiseze valoarea lui in baza 10 si in baza 16, in urmatorul format: "a = <base_10> (baza 10), a = <base_16> (baza 16)"
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	nr dd 0
    citim db "N= ", 0
	message  db "a = %d (baza 10), a = %x (baza 16)", 0
	format db "%d", 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax,0
        mov ebx,0
        mov ecx,0
        mov edx,0

        push dword citim
        call [printf]
        add esp, 4 * 1
               
		push dword nr
		push dword format
		call [scanf]
		add esp, 4 * 2
        
        push dword [nr]
        push dword [nr]
        push dword message
        call [printf]
        add esp, 4 * 3
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
