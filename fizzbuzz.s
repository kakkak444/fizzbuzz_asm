    .intel_syntax noprefix
    .globl main
    .text
main:
    push    rbp
    mov     rbp,    rsp
    sub     rsp,    16
    lea     rdi,    scanf_str[rip]
    lea     rsi,    [rbp - 4]
    call    scanf@PLT
    mov     edi,    DWORD PTR [rbp - 4]
    call    fizzbuzz
    leave
    mov     rax,    0
    ret

fizzbuzz:
    push    rbp
    mov     rbp,    rsp
    sub     rsp,    32
    mov     QWORD PTR [rbp - 16],   rbx
    mov     QWORD PTR [rbp - 24],   r12
    xor     rbx,    rbx
    mov     rbx,    0
    movsx   r12,    edi
mod15:
    inc     rbx
    cmp     rbx,    r12
    jg      final
    xor     rax,    rax
    xor     rdx,    rdx
    mov     rax,    rbx
    mov     rsi,    15
    cqo
    idiv    rsi
    test    rdx,    rdx
    jnz     mod3
    lea     rdi,    fizzbuzz_str[rip]
    call    puts@PLT
    jmp     mod15
mod3:
    xor     rax,    rax
    xor     rdx,    rdx
    mov     rax,    rbx
    mov     rsi,    3
    cqo
    idiv    rsi
    test    rdx,    rdx
    jnz     mod5
    lea     rdi,    fizz_str[rip]
    call    puts@PLT
    jmp     mod15
mod5:
    xor     rax,    rax
    xor     rdx,    rdx
    mov     rax,    rbx
    mov     rsi,    5
    cqo
    idiv    rsi
    test    rdx,    rdx
    jnz     default
    lea     rdi,    buzz_str[rip]
    call    puts@PLT
    jmp     mod15
default:
    lea     rdi,    default_str[rip]
    mov     rsi,    rbx
    call    printf@PLT
    jmp     mod15
final:
    mov     rbx,    QWORD PTR [rbp - 16]
    mov     r12,    QWORD PTR [rbp - 24]
    leave
    ret

.section .rodata
fizz_str:
    .asciz  "fizz"

buzz_str:
    .asciz  "buzz"

fizzbuzz_str:
    .asciz  "fizzbuzz"

default_str:
    .asciz  "%ld\n"

scanf_str:
    .asciz  "%d"
