.org JumpInvalChar
.area 0x4
    ; Normally, this would jump to InvalChar, but we're going to run some extra checks to make the char "valid" if it's a number
    b TryHandleNumberChar
.endarea
