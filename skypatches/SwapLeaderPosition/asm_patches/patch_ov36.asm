.orga 0x30F70+0x194 ; start of common area in ov36, with an additional 0x194 to allow for compatibility with my other patches.
.area 0x90
SwapCheck:
    ldr  r0,=DUNGEON_CONTROLLER_STATUS
    ldr  r0,[r0]
    ldr  r1,=0b1000000000000000001000000000
    and  r0,r0,r1 ; zero out the bits we want to ignore...
    cmp  r0,r1 ; check for L being held, Y being tapped 
    bne  Unhook ; if not, don't try to switch
    ldr  r0,=DUNGEON_PTR
    ldr  r0,[r0]
    add  r0,r0,#0x12000
    ldr  r0,[r0,#0xB2C] ; pointer to partner entity
    mov  r1,r0 ; partner to r1
    bl   EntityIsValid ; violates convention but r1 is identical after call
    cmp  r0,#0
    beq  Unhook ; don't switch if partner is invalid
    mov  r0,r6 ; when we hook, pointer to leader is in r6
    push {r1} ; save partner for later (because r1 is about to be obliterated by TrySwitchPlace)
    bl   TrySwitchPlace
    ldr  r0,=#1030
    bl   PlaySeByIdVolumeWrapper
    mov  r0,#0
	mov  r1,r6
	mov  r2,#0
	bl   SubstitutePlaceholderStringTags
	mov  r0,#1
	pop  {r1} ; partner that we pushed earlier
	mov  r2,#0
	bl   SubstitutePlaceholderStringTags
    mov  r0,r6
    ldr  r1,=SwapStringId
    bl   LogMessageByIdWithPopup
    b    Unhook
    .pool
.endarea
