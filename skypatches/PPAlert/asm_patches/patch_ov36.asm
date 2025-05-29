.orga 0x30F70+0xBC ; starting point
.area 0x54
PPAlert:
	sub r3, r3, #1
	cmp r3, #0
	bne ReturnPPAlert
	push r0-r3, lr
	push r2
	mov r0, r5
	mov r1, #62
	bl LoadAndPlayAnimation
    mov r0, r5
    bl UpdateStatusIconFlags
    pop r2
    mov r0, #0
    ldrh r1, [r2, 4h] ; move ID
    bl SmthSmthAnimations
    mov r0, r5
    ldr r1, =StringId
	bl LogMessageByIdWithPopup
    pop r0-r3, lr
ReturnPPAlert:
	strb r3, [r2, 6h]
	b ReturnAddress
.pool
.endarea
