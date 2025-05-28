; THIS SP IS A WORK IN PROGRESS, DO NOT USE IT AS IS!

; ------------------------------------------------------------------------------
; Species Flashforward Setup - by Chesyon, written for blaze_2150
; Sets the hero and partner to their highest evolved form, storing their original forms to SCENARIO_SUB1 and SCENARIO_SUB2 respectively.
; Call Irdkwia's "Remove Party" process before this one! (MAYBE TODO: include that in this...?)
; No parameters.
; Returns: Nothing.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810 ; TODO: calculate value once code is done

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
			EvoLoop:
				mov r0,r5
				mov r2,#0x1 ; we don't care about sprite size here
				mov r3,#0x0 ; suuuure i guess we can block shedinja
				bl GetEvolutions
				cmp r0,#0x0
				beq EndEvoLoop ; if this current form cannot evolve, stop evolving
				; TODO: figure out how to access the array stored in r1 to store a new species id into r5.
				b EvoLoop
			EndEvoLoop:
			strh r5,[r6,#+0x4] ; store new monster id into chimecho assembly
			cmp r4,#0x1 ; we want to run this loop twice
			addlt r4,r4,#0x1
			addlt r6,#0x44
			blt MonsterUpdateLoop
		pop {r4-r6}
		b ProcJumpAddress ; Always branch at the end
		.pool
	.endarea
.close
