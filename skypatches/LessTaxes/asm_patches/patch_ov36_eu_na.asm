.orga 0x311AC
.area 0x18
CustomFraction:
    push {r0,r1,r2,lr}
    mul r0,r2,r0 ; original-ish instruction
    mov r1,Percent
    bl FX_DivS32
    mov r3,r0
    pop {r0,r1,r2,pc}
.endarea
