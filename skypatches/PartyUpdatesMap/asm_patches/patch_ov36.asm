.orga 0x30F70+0x20 ; starting point of free area in overlay 36, with an extra 0x20 to allow compatibility with my other patches. IF YOU ALREADY HAVE SKYPATCHES APPLIED THAT USE OVERLAY 36, YOU WILL NEED TO ADJUST THIS NUMBER!
.area 0x20
PartyCheck:
    popeq r4
    beq   IfCheckFails
    add   r0,r9,#0x4
    bl    DiscoverMinimap
    cmp   r4,#0x0
    pop   r4
    beq   IfCheckFails
    b     ReturnPoint
.endarea
