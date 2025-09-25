.org GetFloorNumStringHook
.area 0x4
    bl CustomTextCheck
.endarea

.org FloorCardTextHook ; original instruction: mov r0,r5
.area 0x4
    bl SkyPeakFloorJank
.endarea
