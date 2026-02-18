ORG 0X7C00          ;injection address of program
BITS 16             ;16-bit code

%define ENDL 0x0D, 0x0A            


start:
    jmp main            ;makes sure main is first executed




;writing funtion to print string into the bootloader

puts:
    push si
    push ax

.loop:
    lodsb           ;loads next character in al
    or al, al       ;checks if next character is null, using or operation
    jz .done

    mov ah, 0x0E        ;calling bios input for prinitng text -> using 0x0E write character in tty mode
    mov bh, 0           ;chnages page no to 0
    int 0x10            ;calling bios interupt for video interupt

    jmp .loop

.done:
    pop ax
    pop si
    ret




main:               ;main program entry point

    ;settin up data segments

    mov ax, 0
    mov ds, ax
    mov es, ax   ;cant move direclty to es

    mov ss, ax
    mov sp, 0X7C00          ;initalize to start of OS as stack moves downwards


    ;printing message now

    mov si, msg_hello
    call puts


    hlt

.halt:              ;used to halt if suppose code jumps after 1st halt
    jmp .halt



msg_hello: db "hello world!", ENDL, 0




times 510-($-$$) db 0       ;filling up with zero padding
dw 0AA55h                   ;end of the program 
