.orga 0x30F70+0x4C ; starting point of free area in overlay 36, with an extra 0x4C to allow compatibility with my other patches. IF YOU ALREADY HAVE SKYPATCHES APPLIED THAT USE OVERLAY 36, YOU WILL NEED TO ADJUST THIS NUMBER!
.area 0x8
AlwaysAllowDefault:
    strb r2,[r0,#0xf]
    bx   lr
.endarea
