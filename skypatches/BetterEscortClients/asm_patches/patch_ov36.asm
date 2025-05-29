.orga 0x30F70+0x54 ; start of common area in ov36, with an additional 0x54 to allow for compatibility with my other patches.
.area 0x58
    LevelScaling:
        push  {r0,r2,r3,r14}
        ; Calculates the max level of the party, and saves it to r1. This is based on Mond's LevelScalingPublic; thanks!
        mov   r1,0h ; r1: Loop counter
    loopLevelScale:
        mov   r0,r1
        ; Validates the entity
        ; push pop on r1-r4 because this function tends to mess up registers
        push  {r1-r4}
        bl    GetActiveTeamMember
        pop   {r1-r4}
        cmp   r0,0h
        beq   nextIterScaling
        ldrb  r4,[r0]
        tst   r4,1h
        beq   nextIterScaling
        ldrb  r2,[r0, 2h]
        ; r3 will keep your max party level
        cmp   r1,#0
        moveq r3,#0
        cmp   r2,r3
        movgt r3,r2
    nextIterScaling:
        add   r1,r1,1h
        cmp   r1,0x3
        blt   loopLevelScale
        mov   r1,r3
        pop   {r0,r2,r3,r15}
.endarea
