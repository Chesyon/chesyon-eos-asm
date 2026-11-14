.relativeinclude on
.nds
.arm

; Hooks
.definelabel FadeOutDungeonSoundCallsite, 0x22E0BB4
.definelabel StopBgmCommandCallsite, 0x234CD60

; pmdsky-debug documented functions
.definelabel GetLeaderActionId, 0x22F1550
.definelabel GetPerformanceFlagWithChecks, 0x204CDCC
.definelabel IsDungeonEndReasonFailure, 0x22ED8F4
.definelabel StopBgmCommand, 0x2017F84

; Functions currently undocumented in pmdsky-debug
.definelabel StopBgm2Command, 0x20181B4
.definelabel FadeOutDungeonSound, 0x22EB85C
