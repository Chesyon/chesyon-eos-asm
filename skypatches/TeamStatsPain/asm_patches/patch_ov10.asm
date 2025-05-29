.org HookPoint
.area 0x4
	b   CheckHpForPortrait
.endarea

.org UpdateCheck
.area 0x4
    tst r9,0x5
.endarea
