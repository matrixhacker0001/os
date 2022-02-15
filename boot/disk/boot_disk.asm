disk_load:
    pusha
    ; reading from disk requires setting specific values in all registers
    ; so we will overwrite our input parameters from 'dx'. Let's save it
    ; to the stack for later use.

    push dx

    mov ah, 0x02 ; Set Disk Interrupt function to read
    mov al, dh ; Set number of sections to read
    mov cl, 0x02 ; Set initial boot sector to start read from - 0x01 stores boot sector - 0x02 is the first sector to start from
    mov ch, 0x00 ; Set track / cylinder number to start read from
    mov dh, 0x00 ; Set head number to initial value

    int 0x13 ; Start BIOS disk function to run
    jc disk_error

    pop dx
    cmp al, dh    ; BIOS also sets 'al' to the # of sectors read. Compare it.
    jne sectors_error

    mov bx, DISK_SUCCESS
    call print

    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah = error code, dl = disk error that dropped the error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk Read Error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
DISK_SUCCESS: db "Disk Loaded Successfully", 0