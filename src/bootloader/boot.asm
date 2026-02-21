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
bdb_sectors_per_track:      dw 18
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
    push bx


.loop:
    lodsb           ;loads next character in al
    or al, al       ;checks if next character is null, using or operation
    jz .done

    mov ah, 0x0E        ;calling bios input for prinitng text -> using 0x0E write character in tty mode
    mov bh, 0           ;chnages page no to 0
    int 0x10            ;calling bios interupt for video interupt

    jmp .loop

.done:
    pop bx
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


    ;adding something to read from floppy, fat
    
    ;need to initialize ebr_d_no to dl

    mov [ebr_drive_number], dl          ;direct addressing of memory address

    mov ax, 1
    mov cl, 1
    mov bx, 0x7E00
    call disk_read




    ;printing message now

    mov si, msg_hello
    call puts

    cli
    hlt

;
;handling error handling
;

floppy_error:
    mov si, msg_read_failed
    call puts
    jmp wait_key_and_reboot

wait_key_and_reboot:
    mov ah, 0
    int 16h                  ;interupt to wait for keypress
    jmp 0FFFFh:0             ;boot to start of BIOS, to restart







.halt:              ;used to halt if suppose code jumps after 1st halt
    cli
    hlt


;DISK ROUTINES - NO NEED TO UNDERSTAND SHIT



;converts standard lba addressing to chs addressing, used by physical hard disk_reset

lba_to_chs:
    push ax
    push dx


    xor dx,dx
    div word [bdb_sectors_per_track]


    inc dx
    mov cx, dx

    xor dx, dx
    div word [bdb_heads]

    mov dh, dl
    mov ch, al
    shl ah, 6
    or cl, ah

    pop ax
    mov dl, al
    pop ax
    ret


;reading sectors from disk!!!!!!

disk_read:
    push ax
    push bx
    push cx
    push dx
    push di

    push cx
    call lba_to_chs
    pop ax

    mov ah, 02h
    mov di, 3           ;retry counter

.retry:
    pusha
    stc
    int 13h
    jnc .done

    popa
    call disk_reset

    dec di
    test di, di
    jnz .done


;if retry fails

.fail:
    jmp floppy_error


.done:
    popa

    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret





;resets the disk controller

disk_reset:
    pusha
    mov ah, 0
    stc
    int 13h
    jc floppy_error
    popa
    ret








msg_hello: db "Hello world!", ENDL, 0
msg_read_failed: db 'Read from disk failed!', ENDL, 0




times 510-($-$$) db 0       ;filling up with zero padding
dw 0AA55h                   ;end of the program 
