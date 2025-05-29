; ------------------------------------------------------------------------------
; Species Flashforward Setup - by Chesyon, written for blaze_2150
; Sets the hero and partner to their highest evolved form, storing their original forms to SCENARIO_SUB1 and SCENARIO_SUB2 respectively.
; If using this causes the game to crash, call Irdkwia's "Remove Party" process before this! Hopefully that won't happen though!
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
;.definelabel GetEvolutions, 0x2053E88
;.definelabel SaveScriptVariableValue, 0x204B820

; For EU
.include "lib/stdlib_eu.asm"
.definelabel ProcStartAddress, 0x22E7B88
.definelabel ProcJumpAddress, 0x22E8400
.definelabel AssemblyPointer, 0x20B138C
.definelabel GetEvolutions, 0x2054204
.definelabel SaveScriptVariableValue, 0x204BB58

; File creation
.create "./code_out.bin", 0x22E7B88 ; For US: 0x22E7248
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		push {r4-r6}
		mov r4,#0x0 ; set up iterator (we use a register that functions won't touch so it's not lost after function calls)
		ldr r6,=AssemblyPointer
		ldr r6,[r6]
		MonsterUpdateLoop:
			ldrh r5,[r6,#+0x4] ; Species of assembly index [iterator] to r5
			; r0 doesn't matter for SaveScriptVariableValue
			add r1,r4,#0x5 ; save to script variable [5 + iterator] (starts at SUB1)
			mov r2,r5 ; we want to save the species value
			bl SaveScriptVariableValue ; save the value!
			sub sp,sp,#0x28 ; allocate 28 bytes of space on the stack for the GetEvolutions output
			EvoLoop:
				mov r0,r5 ; check evolutions of current (r5) species
				mov r1,sp ; save output to stack
				mov r2,#0x1 ; we don't care about sprite size here
				mov r3,#0x0 ; suuuure i guess we can block shedinja
				bl GetEvolutions
				cmp r0,#0x0
				beq EndEvoLoop ; if this current form cannot evolve, stop evolving
				ldrh r5,[sp] ; get the first entry on the output array of GetEvolutions
				b EvoLoop
			EndEvoLoop:
			add sp,sp,#0x28 ; unallocate those bytes we allocated earlier
			strh r5,[r6,#+0x4] ; store new monster id into chimecho assembly
			cmp r4,#0x1 ; we want to run this loop twice (once for hero once for partner)
			addlt r4,r4,#0x1
			addlt r6,r6,#0x44
			blt MonsterUpdateLoop
		pop {r4-r6}
		b ProcJumpAddress ; Always branch at the end
		.pool
	.endarea
.close
