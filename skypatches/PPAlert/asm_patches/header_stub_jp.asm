.relativeinclude on
.nds
.arm

.definelabel UpdateMovePpHook, 0x23262B0 ; towards end of UpdateMovePp (in pmdsky-debug), subne r3, r3, #1
.definelabel huh, 0x23262C0 ; this is just the vanilla instruction, not sure why it's here but i suppose i'll leave it lol. UpdateMovePPHook + 0x10
.definelabel ReturnAddress, 0x23262B8 ; UpdateMovePpHook + 0x8
.definelabel LoadAndPlayAnimation, 0x22E5958
.definelabel UpdateStatusIconFlags, 0x22E5124 ; (from pmdsky-debug)
.definelabel SmthSmthAnimations, 0x234C2F4 ; can you tell i have no clue what these functions do?
.definelabel LogMessageByIdWithPopup, 0x234C708 ; (from pmdsky-debug)
