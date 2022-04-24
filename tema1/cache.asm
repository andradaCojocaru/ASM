;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    mov esi, edx
    shr esi, OFFSET_BITS
    mov [ebx + edi], esi
    push esi
    push eax
    push ebx
    xor ebx, ebx
    mov eax, esi
    xor esi, esi
    rol eax, OFFSET_BITS

    mov ebx, [eax]
    mov [ecx + edi * CACHE_LINE_SIZE], ebx

    mov esi, edx
    shr esi, TAG_BITS
    pop ebx
    mov eax, byte[ecx + edi * CACHE_LINE_SIZE]
    pop eax
    pop esi
    

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


