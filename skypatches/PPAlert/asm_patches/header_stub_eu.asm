.relativeinclude on
.nds
.arm

.definelabel UpdateMovePpHook, 0x232588C ; towards end of UpdateMovePp (in pmdsky-debug), subne r3, r3, #1
.definelabel huh, 0x232589C ; this is just the vanilla instruction, not sure why it's here but i suppose i'll leave it lol. UpdateMovePPHook + 0x10
.definelabel ReturnAddress, 0x2325894 ; UpdateMovePpHook + 0x8
.definelabel LoadAndPlayAnimation, 0x22E4C98
.definelabel UpdateStatusIconFlags, 0x22E4464 ; (from pmdsky-debug)
.definelabel SmthSmthAnimations, 0x234BC84 ; can you tell i have no clue what these functions do?
.definelabel LogMessageByIdWithPopup, 0x234C098 ; (from pmdsky-debug)
