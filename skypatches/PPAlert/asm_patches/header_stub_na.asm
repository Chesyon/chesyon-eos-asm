.relativeinclude on
.nds
.arm

.definelabel UpdateMovePpHook, 0x2324E24 ; towards end of UpdateMovePp (in pmdsky-debug), subne r3, r3, #1
.definelabel huh, 0x2324E34 ; this is just the vanilla instruction, not sure why it's here but i suppose i'll leave it lol. UpdateMovePPHook + 0x10
.definelabel ReturnAddress, 0x2324E2C ; UpdateMovePpHook + 0x8
.definelabel LoadAndPlayAnimation, 0x22E42E8
.definelabel UpdateStatusIconFlags, 0x22E3AB4 ; (from pmdsky-debug)
.definelabel SmthSmthAnimations, 0x234B084 ; can you tell i have no clue what these functions do?
.definelabel LogMessageByIdWithPopup, 0x234B498 ; (from pmdsky-debug)
