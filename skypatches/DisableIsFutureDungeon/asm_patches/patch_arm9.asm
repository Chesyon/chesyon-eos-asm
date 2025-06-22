.org IsFutureDungeon
.area 0x1C
    mov r0,#0       ; set return value to fals
    bx  lr          ; return
    .fill 0x14, 0x0 ; zero out the unused code
.endarea
