; ------------------------------------------------------------------------------
; Return True - by Chesyon, written for silverfox88
; It literally just returns one.
; Intended to be used to replace vanilla SPs like IS_TEAM_SETUP_HERO_AND_PARTNER_ONLY.
; No parameters.
; Returns: 1.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x8

; Uncomment the correct version

; For US
;.include "lib/stdlib_us.asm"
;.definelabel ProcStartAddress, 0x22E7248
;.definelabel ProcJumpAddress, 0x22E7AC0
;.definelabel AssemblyPointer, 0x20B0A48
;.definelabel GetEvolutions, 0x2053E88
;.definelabel SaveScriptVariableValueAtIndex, 0x204B988

; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x22E7B88
.definelabel ProcJumpAddress, 0x22E8400
.definelabel AssemblyPointer, 0x20B138C
.definelabel GetEvolutions, 0x2054204
.definelabel SaveScriptVariableValueAtIndex, 0x204BCC0

; File creation
.create "./code_out.bin", 0x22E7B88 ; For US: 0x22E7248
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
        mov r0,#1
		b   ProcJumpAddress ; Always branch at the end
	.endarea
.close
