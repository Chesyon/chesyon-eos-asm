.relativeinclude on
.nds
.arm

; Hooks
.definelabel FadeOutDungeonSoundCallsite, 0x22E190C
.definelabel StopBgmCommandCallsite, 0x234D3C4

; pmdsky-debug documented functions
.definelabel GetLeaderActionId, 0x22F219C
.definelabel GetPerformanceFlagWithChecks, 0x204CDF4
.definelabel IsDungeonEndReasonFailure, 0x22EE5A8
.definelabel StopBgmCommand, 0x2017F40

; Functions currently undocumented in pmdsky-debug
.definelabel StopBgm2Command, 0x2018170
.definelabel FadeOutDungeonSound, 0x22EC514
