; ------------------------------------------------------------------------------
; Mentry Has Type - by Chesyon, written for JaiFain
; Checks if a Chimecho Assembly member has a specified type as either of their types. Slot 0 is the player, 1 is the partner, and 5+ are recruitables.
; Param 1: ent_id
; Param 2: type (a list of IDs can be found at https://github.com/UsernameFodder/pmdsky-debug/blob/fa1452aec810593dce6f7ab5f3b7209b05670a66/headers/types/common/enums.h#L2190-L2209 )
; Returns: 0 if the member does not has the specified type, or 1 if it does.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

; Uncomment/comment the following labels depending on your version.

; For US
;.include "lib/stdlib_us.asm"
;.definelabel ProcStartAddress, 0x22E7248
;.definelabel ProcJumpAddress, 0x22E7AC0
;.definelabel TEAM_MEMBER_TABLE_PTR, 0x20B0A48
;.definelabel GetType, 0x2052A04

; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x22E7B88
.definelabel ProcJumpAddress, 0x22E8400
.definelabel TEAM_MEMBER_TABLE_PTR, 0x20B138C
.definelabel GetType, 0x2052D3C

; File creation
.create "./code_out.bin", 0x22E7B88 ; For US: 0x22E7248
	.org ProcStartAddress
	.area 0x50 ; Define the size of the area
        push {r4,r5}
		ldr  r0,=TEAM_MEMBER_TABLE_PTR
		ldr  r0,[r0]
		mov  r1,#0x44
		mla  r0,r7,r1,r0 ; Get mentry address
        ldrh r5,[r0,#0x4] ; Get species for mentry
        mov  r4,#0
        TypeLoop:
            mov   r0,r5
            mov   r1,r4
            bl    GetType
            cmp   r0,r6 ; Check if the type is the target type
            moveq r0,#1
            beq   ret ; if it is, return true!
            cmp   r4,#0 ; otherwise, are we on the first loop?
            addeq r4,r4,#1 ; if so, go to the second loop
            beq   TypeLoop
		mov r0,#0 ; if not, return false
        ret:
            pop {r4,r5}
		    b   ProcJumpAddress
		.pool
	.endarea
.close
