.org UpdateMovePpHook
.area 0x8
	bne PPAlert
	nop
.endarea

.org huh
	add r1,r1,0x1
