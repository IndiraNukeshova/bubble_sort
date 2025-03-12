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
    GET_UDEC 4, [n]
input:
    cmp ecx, dword [n]
    je .end
    GET_DEC 4, [mas+ecx*4]
    inc ecx
    jmp input
.end:
    push dword [n]
    push mas
    call bubble_sort
    add esp, 8
    xor ecx,ecx
output1:
    cmp ecx, dword [n]
    je .end
    PRINT_DEC 4, [mas+ecx*4]
    PRINT_STRING " "
    inc ecx
    jmp output1
.end:
    ret    
bubble_sort:
    enter 8,0    
    mov edi, [ebp+12] ; n
    mov esi, [ebp+8] ; mas
    ; меняю из старой сортировки esi ebp-4 внешний счётчик
    ; меняю из старой сортировки edi ebp-8 счётчик перестановок
    
    mov dword [ebp-4], 0
    mov dword [ebp-8], 0
bubble:
    cmp dword [ebp-4], 0
    jne check
sort:
    mov dword [ebp-8], 0
    cmp edi, dword [ebp-4]
    je outb
    xor ecx,ecx
    inc dword [ebp-4]
bubble1: 
    mov edx, ecx
    inc edx
buble2:
    cmp edx, edi
    je bubble
    mov eax, dword [esi+ecx*4]
    cmp eax, dword [esi+edx*4]
    jg swap
    inc ecx
    jmp bubble1
swap:
    mov eax, [esi+ecx*4]
    mov ebx, [esi+edx*4]
    mov [esi+ecx*4], ebx
    mov [esi+edx*4], eax
    inc ecx
    inc dword [ebp-8]
    jmp bubble1
check: 
    cmp dword [ebp-8], 0
    jne sort
outb:
    leave
    ret
