[org 0x7c00]

mov bp, 0x8000 ; set the stack far from us
mov sp, bp

mov bx, 0x9000 ; es:bx = 0x0000 : 0x9000 = 0x09000
mov dh, 2 ; read 2 sectors
call disk_load

jmp $

%include "../function/print.asm"
%include "../function/print_hex.asm"
%include "boot_disk.asm"

times 510 - ($-$$) db 0
dw 0xaa55

; boot sector = sector 1 of cyl 0 of head 0 of hdd 0
; from now on = sector 2 ...
times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes