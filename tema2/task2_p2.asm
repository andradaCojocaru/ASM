section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression

; check if the number of paranthesis is even
par:
	pop ecx
	pop eax; lenght
	pop edx; char *str

	push edx
	push eax
	push ecx

	xor ecx, ecx
	inc ecx
	inc ecx

	push edx
	xor edx, edx
	div ecx ; make division to 2
	xor eax, eax
	xor ecx, ecx
	cmp edx, 0
	pop edx
	je continue
	; if it is not even is not a valid test
	jne break

; if number of paranthesis is even continue
continue:
	; determine which paranthesis we have
	cmp byte[edx + ecx], 0x28; it is a "("
	jne close_paranthesis
	je open_paranthesis

; for open paranthesis
open_paranthesis:
	; we increase eax
	inc eax
	inc ecx
	; we determine if the next string is null
	cmp byte[edx + ecx], 0
	je test
	jne continue

; for close paranthesis
close_paranthesis:
	; we decrement eax
	dec eax
	inc ecx
	; if the number of close paranthesis is greater than open paranthesis
	; we are not on a valid test
	cmp eax, 0
	jl incorect
	; we determine if the next string is null
	cmp byte[edx + ecx], 0
	je test
	jne continue

; testing at the end of iteration if number of close paranthesis is equal 
; to the open paranthesis
test:
	cmp eax, 0
	je corect
	jne incorect
; if it is corect we need to put 1 to the output
corect:
	inc eax
	cmp eax, 1
	; condition always true
	je break
; if it is incorect we need to put 0
incorect:
	xor eax, eax
	cmp eax, 0
	; condition always true
	je break
break:
	ret
	