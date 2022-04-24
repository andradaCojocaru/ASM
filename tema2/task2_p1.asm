section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:
	pop ecx
	pop eax
	pop edx

	push ecx
	push eax
	push edx
	
	pop edx; extract first parameter
	pop eax; extract second parameter

	cmp eax, edx

	jl swap; swap them if the first one is smaller
	jge prepare_cmmmdc

swap:
	push eax
	push edx
	pop eax
	pop edx

prepare_cmmmdc:
	; put values on stack
	push eax
	push edx
	pop ecx; make ecx have edx value
	push ecx

; if (a % b == 0) return b
; return cmmmdc(b, a % b)
cmmmdc:
	xor edx, edx
	div ecx; get remainder value

	cmp edx, 0
	je continue; if remainder is 0 continue
	pop eax; get b value
	push eax; put it on stack
	push edx
	pop ecx; put in ecx, edx value
	cmp edx, 0
	jne cmmmdc; recursive function

; cmmmc = (a * b) / cmmmdc
continue:
	pop eax; get a value
	pop edx; get b value

	push ecx; put cmmmdc value on stack

	push edx
	pop ecx; make ecx value, edx value

	xor edx, edx
	mul ecx; get a * b


	pop ecx; get cmmmdc value

	xor edx, edx
	div ecx; get (a * b) / cmmmdc
	
	ret
