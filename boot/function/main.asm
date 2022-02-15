[org 0x7c00]

mov bx, HELLO
call print

%include "print.asm"

; data
HELLO:
    db 'Hello, World', 0
GOODBYE:
    db 'Goodbye', 0

times 510-($-$$) db 0
dw 0xaa55