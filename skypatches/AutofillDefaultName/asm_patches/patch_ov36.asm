.orga 0x311C4
.area 0x24
AutofillName:
    push  {r0,r14}
    add   r0,sp,#0xC0
    ldr   r1,=DEFAULT_HERO_NAME
    mov   r2,#10   ; We want to copy ten characters
    bl    strncpy
    add   r1,sp,#0xC0
    mov   r2,r1
    pop   {r0,r15} ; return to original code
.pool
.endarea
