ORG 0X7C00          ;injection address of program
BITS 16             ;16-bit code

%define ENDL 0x0D, 0x0A       ;used to define the ENDL in nasm


;FAT12 HEADERS

jmp short start
nop

bdb_oem:                    db 'MSWIN4.1'
bdb_bytes_per_sector:       dw 512
bdb_sector_per_cluster:     db 1
bdb_reserved_sectors:       dw 1
bdb_fat_count:              db 2
bdb_dir_entries_count:      dw 0E0h
bdb_total_sectorsL          dw 2880
bdb_media_descriptor_type:  db 0F0h
bdb_sectors_per_fat:        dw 9
bdb_sectos_per_track:       dw 18
bdb_heads:                  dw 2
bdb_hidden_sectors:         dd 0
bdb_large_sector_count:     dd 0
            

;extended boot record

ebr_drive_number:           db 0
                            db 0    ;reserved
ebr_signature:              db 29h
ebr_volume_id:              db 12h, 34h, 56h, 78h
ebr_volume_label:           db 'ALOHOMORA OS'
ebr_system_id:              db 'FAT12   '




start:
    jmp main            ;makes sure main is first executed



;-----------------------------------------------------------------------------------------------------------'

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



msg_hello: db "Hello world!", ENDL, 0




times 510-($-$$) db 0       ;filling up with zero padding
dw 0AA55h                   ;end of the program 
