.org FadeOutDungeonSoundCallsite
.area 0x4
    bl TryFadeOutDungeonSound
.endarea

.org StopBgmCommandCallsite
.area 0x8
    bl TryStopDungeonSound
    nop
.endarea
