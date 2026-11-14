.relativeinclude on
.nds
.arm

; Hooks
.definelabel FadeOutDungeonSoundCallsite, 0x22E0274
.definelabel StopBgmCommandCallsite, 0x234C160

; pmdsky-debug documented functions
.definelabel GetLeaderActionId, 0x22F0B9C
.definelabel GetPerformanceFlagWithChecks, 0x204CA94
.definelabel IsDungeonEndReasonFailure, 0x22ECF44
.definelabel StopBgmCommand, 0x2017EE8

; Functions currently undocumented in pmdsky-debug
.definelabel StopBgm2Command, 0x2018118
.definelabel FadeOutDungeonSound, 0x22EAEAC
