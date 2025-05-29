.orga 0x30F70+0x40 ; starting point of free area in overlay 36, with an extra 0x40 to allow compatibility with my other patches. IF YOU ALREADY HAVE SKYPATCHES APPLIED THAT USE OVERLAY 36, YOU WILL NEED TO ADJUST THIS NUMBER!
.area 0xC
    WindCounterCheck:
    poplt {r4,pc}    ; if turn counter is negative, don't run the rest of DecrementWindCounter
    ; if not...
    subgt r1,r1,#0x1 ; original instruction
    bx    lr         ; return to original code
.endarea
