org 0x0

_start:
    jmp start
    nop

times 33 db 0

jmp main

ola: db "Qual seu nome? ", 0
hello: db "Opa, ", 0
pos_hello: db ", seja bem-vindo(a)!", 0
newline: db 0x0D, 0x0A, 0
input_buffer: times 32 db 0   ; buffer para o nome (max 31 chars + 0)

showString:                  ; SI aponta para string terminada em 0
    lodsb
    cmp al, 0
    je .done
    call printChar
    jmp showString
.done:
    ret

printChar:
    mov ah, 0x0e
    int 0x10
    ret

readLine:                    ; Lê string do teclado para [SI], termina com 0
    xor cx, cx               ; contador de chars
.read:
    mov ah, 0x00
    int 0x16                 ; lê char do teclado em AL
    cmp al, 0x0D             ; Enter?
    je .done
    cmp al, 0x08             ; Backspace?
    je .backspace
    cmp cx, 30               ; Limite do buffer (30 chars)
    jae .read
    mov [si], al
    inc si
    inc cx
    mov ah, 0x0e
    int 0x10                 ; ecoa caractere
    jmp .read
.backspace:
    cmp cx, 0
    je .read
    dec si
    dec cx
    mov ah, 0x0e
    mov al, 0x08
    int 0x10                 ; ecoa backspace
    mov al, ' '
    int 0x10                 ; apaga caractere
    mov al, 0x08
    int 0x10                 ; volta cursor
    jmp .read
.done:
    mov al, 0
    mov [si], al             ; termina string com 0
    ret

start:
    jmp 0x7c0:main

main:
    cli
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    sti

    mov si, ola
    call showString

    mov si, newline
    call showString

    mov si, input_buffer
    call readLine

    mov si, newline
    call showString

    mov si, hello
    call showString

    mov si, input_buffer
    call showString

    mov si, pos_hello
    call showString

    jmp $

times 510 - ($ - $$) db 0
dw 0xAA55
