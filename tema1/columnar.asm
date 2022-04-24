section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    xor ecx, ecx    ; make ecx 0
    xor eax, eax    ; make eax 0

; iterate for every value of key
Iterate:
    ; put in edx the key value
    mov edx, dword[edi + 4 * ecx]
    ; counter for key
    inc ecx
Add_ciphertext:
    ; we need another register, so we put the value of ecx on stack
    push ecx
    ; ch saves the proper value of haystack
    mov ch, [esi + edx]
    ; we put tha value on the specific position in ciphertext
    mov [ebx + eax], ch
    ; after we finished the operations , we extract ecx value from stack
    pop ecx
    ; counter for ebx
    inc eax
    ; the step is len_cheie 
    add edx, [len_cheie]
    ; we compare edx to len_haystack to see if we have another values or we
    ; need to move to another key
    cmp edx, [len_haystack]
    jl Add_ciphertext
    cmp ecx, [len_cheie]
    jl Iterate

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY