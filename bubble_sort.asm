%include "io.inc"
section .data
    n dd 0
section .bss
    mas resd 256
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor ecx,ecx
    xor edx,edx
    xor esi, esi
    xor edi, edi
    GET_UDEC 4, [n]
    xor eax, eax
input:
    cmp ecx, dword [n]
    je bubble
    GET_DEC 4, [mas+ecx*4]
    inc ecx
    jmp input
bubble:
    cmp esi, 0
    jne check
sort:
    xor edi,edi
    cmp esi, dword [n]
    je output
    xor ecx,ecx
    inc esi
bubble1: 
    mov edx, ecx
    inc edx
buble2:
    cmp edx, dword [n]
    je bubble
    mov eax, dword [mas+ecx*4]
    cmp eax, dword [mas+edx*4]
    jg swap
    inc ecx
    jmp bubble1
swap:
    mov eax, [mas+ecx*4]
    mov ebx, [mas+edx*4]
    mov [mas+ecx*4], ebx
    mov [mas+edx*4], eax
    inc ecx
    inc edi
    jmp bubble1
check: 
    cmp edi, 0
    jne sort
output:
    xor ecx,ecx
output1:
    cmp ecx, dword [n]
    je end
    PRINT_DEC 4, [mas+ecx*4]
    PRINT_STRING " "
    inc ecx
    jmp output1
end:
    ret