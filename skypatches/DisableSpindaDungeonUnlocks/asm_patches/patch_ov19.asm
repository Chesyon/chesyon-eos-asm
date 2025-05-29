; vanilla code calls a function to unlock the dungeon.
; nop does nothing, so we replace the function call with an instruction
; that does nothing, effectively removing the function call.
.org UnlockCall
    nop
