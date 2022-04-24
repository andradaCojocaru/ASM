extern strtok
extern strcmp
extern qsort
extern strlen

section.data
    delim db ' ,.', 10,0


global get_words
global compare_func
global sort

section .text

; function for comparing the words
my_compare:
    enter 0,0

    push ebx
    push esi
    push edi
    mov ebx, [ebp + 8]  ;first parameter
    mov ebx, [ebx]      ;get value of address
    mov esi, [ebp + 12] ;second address
    mov esi, [esi]
    push esi
    push ebx
    push esi
    call strlen         ;find length of second word
    add esp, 4
    push eax
    push ebx
    call strlen         ;find length of first word
    add esp, 4
    pop ecx
    cmp eax, ecx
    jl swap             ;if smaller swap
    jg break            ;if greater break
    je continue         ;if equal compare
swap:
    pop ebx
    pop esi
    mov eax, ebx
    mov ebx, esi
    mov esi, eax
    xor eax, eax
    push esi
    push ebx
    cmp eax, 0
    je break
continue:
    call strcmp
break:
    add esp, 8
    pop edi
    pop esi
    pop ebx
    leave
    ret

; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0

    push ebx
    push esi
    push edi
    mov ebx, [ebp + 8];  words
    mov esi, [ebp + 12];  number_of_words
    mov edi, [ebp + 16]; size

    push my_compare ;put fourth parameter - compare function
    push 4          ;put third parameter - sizeof(char *)
    push esi        ;put second parameter - number_of_words
    push ebx        ;put first parameter - words

    call qsort
    add esp, 16

    pop edi
    pop esi
    pop ebx

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0
    
    push ebx
    push esi
    push edi

    mov ebx, [ebp + 8]; s
    mov esi, [ebp + 12]; words
    mov edi, [ebp + 16]; number_of_words

    xor ecx, ecx
    push ecx    ;save ecx because in function will be altered
    push delim  ;put second parameter - the delimiter
    push ebx    ;put the second parameter - the string
    call strtok ;make first split
    add esp, 8
    pop ecx
    mov dword[esi + 4 * ecx], eax ;put the value in pointer array
split:
    inc ecx
    push ecx
    push delim
    push 0      ;put null value
    call strtok ;call again strtok
    add esp, 8
    pop ecx
    mov dword[esi + 4 * ecx], eax
    cmp ecx, edi
    jl split

    ;mov eax, esi
    pop edi
    pop esi
    pop ebx
 
    leave
    ret
