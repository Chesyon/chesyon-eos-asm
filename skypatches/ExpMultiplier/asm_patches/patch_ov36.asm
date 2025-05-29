.orga 0x30F70+0xAC
.area 0x10
ExpScaling:
    ldr r1,=Multiplier ; multiplier to r1
    mul r0,r0,r1       ; multiply our exp gained (r0) by our exp multiplier (r1)
    ldmia sp!,{r4, pc} ; return
.pool
.endarea
