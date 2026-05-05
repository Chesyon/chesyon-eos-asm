.orga 0x31194
.area 0x18
TryHandleNumberChar:
    ; Ensure character is between '0' and '9'. If not, allow the "invalid character" case to run as normal.
    cmp r3,#0x30 ; ASCII for 0
    blt InvalChar
    cmp r3,#0x39 ; ASCII for 9
    bgt InvalChar
    ; This is a number! We add 10 to get the proper index, then go to the render case.
    add r3,r3,#0x10
    b   IndexChar
.endarea
