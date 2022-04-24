section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    xor ebx, ebx             ; the equivalent of i variable
    dec ecx                  ; start from len - 1

Iterate:
    xor ah, ah               ; make ah 0
    mov ah, byte [esi + ebx] ; copy plain[i]
    xor ah, byte [edi + ecx] ; making xor ah, copy key[len - i - 1]
    mov [edx + ebx], ah      ; move result to edx
    inc ebx
    dec ecx
    cmp ecx, 0               ; stop if we reach end of string
    jge Iterate              ; if not equal go to loop


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY