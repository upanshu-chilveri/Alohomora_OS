ORG 0X7C00          ;injection address of program

BITS 16             ;16-bit code

main:               ;main program entry point
    hlt

.halt:
    jmp .halt

times 510-($-$$) db 0
dw 0AA55h
