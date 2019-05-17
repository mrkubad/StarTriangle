program SEGMENT
ORG 100h
ASSUME CS: program
start:
	jmp main

; VARIABLES

wrong_size db 'Triangle size must be located into range from 2 to 9!$'
enter_size db 'Enter size of triagnle: $'

; SUBFUNCTIONS
printNewLine:
	push ax
	mov ah, 02h
	push dx
	mov dl, 0Dh
	int 21h
	mov dl, 0Ah
	int 21h
	pop dx
	pop ax
	ret
getUserInput:
    mov ah, 01h
    int 21h
    sub al, 48
	ret
print_star:
	push ax
	mov ah, 02h
	push dx
	mov dl, '*'
	int 21h
	pop dx
	pop ax
	ret
print_wrong_size:
	push dx
	push ax
	mov ah, 09h
	lea dx, wrong_size
	int 21h
	pop ax
	pop dx
	ret
print_enter_size:
	push dx
	push ax
	mov ah, 09h
	lea dx, enter_size
	int 21h
	pop ax
	pop dx
	ret
	
print_string_and_exit:
	call print_wrong_size
	jmp koniec
; MAIN FUNCTION	
main:
	call print_enter_size
	call getUserInput ;we have in al number entered by user
	call printNewLine
	
	cmp al, 1
	jle print_string_and_exit
	cmp al, 9
	jg print_string_and_exit
	
	; doing main code for drawing triangle
	xor ch, ch ; zeroing ch 8-bit register

	first_loop:
		cmp ch, al
		jge end_looping
		mov cl, ch
		second_loop:
			cmp cl, 0
			js after_second_loop
			call print_star
			sub cl, 1
			jmp second_loop
		after_second_loop:
			call printNewLine
			add ch, 1
			jmp first_loop

	end_looping:

koniec:
    mov ah, 4Ch ; exit function
    int 21h ; execute funcion from ah register
program ENDS
END start
