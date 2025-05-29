.org FirstMod
.area 0x4
    mov r0,r10
.endarea

.org SecondMod
.area 0xC
    ldrb r0,[r5,#0x30]
    add  r0,r0,r2
    strb r0,[r5,#0x30]
.endarea

.org ThirdMod
.area 0xC
    ldrb r0,[r5,#0x37]
    add  r0,r0,r2
    strb r0,[r5,#0x37]
.endarea
