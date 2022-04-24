section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	push ebp
	mov	ebp, esp

	push ebx
	push esi
	push edi
	mov ebx, [ebp + 8];n
	mov esi, [ebp + 12];node

	xor edx, edx; make counter 0

find_first:
	mov eax, [esi + 8 * edx]; put first number (1)
	inc edx
	cmp eax, 1
	jne find_first
	dec edx

	lea eax, [esi + 8 * edx]; save its address
	push eax

	mov ecx, edx; put the index of first number
	mov eax, 2; put the second number to iterate
	xor edi, edi; make 0
	xor edx, edx; make 0
find_value:
	mov edi, [esi + 8 * edx]; put the value

	inc edx; iterate throw array
	cmp edi, eax
	jne find_value; if is not found, loop
	dec edx

	lea edi, [esi + 8 * edx]; put address as next node
	mov dword[esi + 8 * ecx + 4], edi

	mov ecx, edx; save the index
	inc eax
	xor edx, edx
	cmp eax, ebx
	jle find_value; loop if not found
	pop eax
	pop edi
	pop esi
	pop ebx

	leave
	ret
