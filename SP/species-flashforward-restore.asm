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

.definelabel MaxSize, 0x80 ; calculated 0x78- giving a bit of wiggle room in case i was wrong.

; Uncomment the correct version

; For US
;.include "lib/stdlib_us.asm"
;.definelabel ProcStartAddress, 0x22E7248
;.definelabel ProcJumpAddress, 0x22E7AC0
;.definelabel AssemblyPointer, 0x20B0A48
;.definelabel LoadScriptVariableValue, 0x204B4EC

; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x22E7B88
.definelabel ProcJumpAddress, 0x22E8400
.definelabel AssemblyPointer, 0x20B138C
.definelabel LoadScriptVariableValue, 0x204B824

; File creation
.create "./code_out.bin", 0x22E7B88 ; For US: 0x22E7248
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
        ; r4 - script var
        ; r5 - assembly pointer
        push {r4,r5}
        ldr r0,=AssemblyPointer
        ldr r0,[r0]
        mov r4,#5
        mov r5,#0
        MonsterRestoreLoop:
            mov r1,r4 ; variable is either 5 or 6 depending on iteration
            bl LoadScriptVariableValue ; load species from variable to r0
            strh r0,[r5,#+0x4] ; update chimecho assembly species at the index
            cmp r4,#6 ; is this the first loop?
            addlt r4,r4,#1
            addlt r5,r5,#0x44
            blt MonsterRestoreLoop ; if so, go back to the start of the loop and do everything again with the partner.
        pop {r4,r5}
		b ProcJumpAddress ; Always branch at the end
		.pool
	.endarea
.close

