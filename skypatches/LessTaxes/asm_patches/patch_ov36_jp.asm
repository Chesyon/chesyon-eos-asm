.orga 0x311AC
.area 0x14
CustomFraction:
    push {r1,r2,r3,lr}
    mul r0,r2,r0 ; original instruction
    mov r1,Percent
    bl FX_DivS32
    pop {r1,r2,r3,pc}
.endarea
