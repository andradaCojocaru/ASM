; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    xor ebx, ebx  ; make ebx 0
    dec edx       ; start from len - 1

make_zero_vector:                 ; make the all_ages array full of 0
    mov dword[ecx + 4 * ebx], eax ; put 0
    inc ebx                       ; increase the counter
    cmp ebx, edx                  ; if we reached the end of arrray
    jl make_zero_vector           ; loop until the condition is reached

get_ages:
    ; put the present year in eax
    mov eax, dword[esi + my_date.year]

    ; make substraction between present year and year of born
    sub eax, dword[edi + 8 * edx + my_date.year]

    ; decrement edx in case we need to return to get_ages
    dec edx

    cmp eax, 0
    ; return to get_ages if the year is after or in present
    jle get_ages

    inc edx

    ; put present month in bx
    mov bx, word[esi + my_date.month]

    ; make substraction between present and born month
    sub bx, word[edi + 8 * edx + my_date.month]

    cmp bx, 0
    jg put_in_vector                         
    jl dec_age 

    ; put present day in bx
    mov bx, word[esi + my_date.day]

    ; substraction between present and born day
    sub bx, word[edi + 8 * edx + my_date.day]
    cmp bx, 0
    jge put_in_vector

; decrement eax if it is need
dec_age:
    dec eax

; put year in array all_ages
put_in_vector:
    mov dword[ecx + 4 * edx], eax
    dec edx
    cmp edx, 0
    ; if edx is greater or equal to 0, return to get_ages
    jge get_ages

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
