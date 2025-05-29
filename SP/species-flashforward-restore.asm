; ------------------------------------------------------------------------------
; Species Flashforward Restore - by Chesyon, written for blaze_2150
; Sets the hero and partner species using SCENARIO_SUB1 and SCENARIO_SUB2 respectively.
; Intended to be used alongside Species Flashforward Setup.
; No parameters.
; Returns: Nothing.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x50

; Uncomment the correct version

; For US
;.include "lib/stdlib_us.asm"
;.definelabel ProcStartAddress, 0x22E7248
;.definelabel ProcJumpAddress, 0x22E7AC0
;.definelabel AssemblyPointer, 0x20B0A48
;.definelabel LoadScriptVariableValueAtIndex, 0x204B678

; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x22E7B88
.definelabel ProcJumpAddress, 0x22E8400
.definelabel AssemblyPointer, 0x20B138C
.definelabel LoadScriptVariableValueAtIndex, 0x204B9B0

; File creation
.create "./code_out.bin", 0x22E7B88 ; For US: 0x22E7248
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
        push {r4-r6}
        mov r4,#5
        ldr r5,=AssemblyPointer
        ldr r5,[r5]
        MonsterRestoreLoop:
            mov r1,r4 ; variable is either 5 or 6 depending on iteration
            mov r2,#0
            bl LoadScriptVariableValueAtIndex ; load first byte of species from variable to r0
            mov r6,r0 ; store first byte in r6
            mov r1,r4
            mov r2,#1
            bl LoadScriptVariableValueAtIndex ; load second byte to r0
            add r0,r6,r0,lsl #8  ; add the two bytes together to get the proper species in r0.
            strh r0,[r5,#+0x4] ; update chimecho assembly species at the index
            cmp r4,#6 ; is this the first loop?
            addlt r4,r4,#1
            addlt r5,r5,#0x44
            blt MonsterRestoreLoop ; if so, go back to the start of the loop and do everything again with the partner.
        pop {r4-r6}
		b ProcJumpAddress ; Always branch at the end
		.pool
	.endarea
.close

