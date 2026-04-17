; ------------------------------------------------------------------------------
; Set Portrait Monster - by Chesyon, ported from eos-archipelago-patches for Gala1D
; C version can be found at https://github.com/Chesyon/eos-archipelago-patches/blob/92809b4f4fa02785a05d386bb67ea30c36ff8613/src/special_processes.c#L292-L296
; Sets the cutscene portrait box to a use a specified monster and emotion.
; Useful if you want to display a portrait for a monster without making an actor for them.
; Param 1: Monster ID
; Param 2: Emotion ID
; Returns: Nothing.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

; Uncomment the correct version

; For US
;.include "lib/stdlib_us.asm"
;.definelabel ProcStartAddress, 0x22E7248
;.definelabel ProcJumpAddress, 0x22E7AC0
;.definelabel SCRIPT_PORTRAIT_PARAMS, 0x2324EA4
;.definelabel SetPortraitEmotion, 0x204D7F4

; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x22E7B88
.definelabel ProcJumpAddress, 0x22E8400
.definelabel SCRIPT_PORTRAIT_PARAMS, 0x23259E4
.definelabel SetPortraitEmotion, 0x204DB2C

; File creation
.create "./code_out.bin", 0x22E7B88 ; For US: 0x22E7248
	.org ProcStartAddress
	.area 0x18 ; Define the size of the area
        ldr  r0,=SCRIPT_PORTRAIT_PARAMS
        strh r7,[r0]
        mov  r1,r6
        bl   SetPortraitEmotion
	    b    ProcJumpAddress ; Always branch at the end
	    .pool
	.endarea
.close
