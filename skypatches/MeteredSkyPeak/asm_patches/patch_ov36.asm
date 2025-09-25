.orga 0x31080
.area 0x84
; r7 has dungeon_id
; r6 has floor_byte
; r5 has apparentDungeonId
; r4 has someStringId
; if in a sky peak dungeon, increase floor_byte by apparentDungeonId << 8. this approach preserves the dungeon id (which we will want access to later), while also pushing the floor number past 0xFF, which will never happen in vanilla circumstances (we can check this to trigger custom text)
SkyPeakFloorJank:
    cmp r7,MIN_SKY_PEAK_ID
    blt SkyPeakFloorJank_ret
    cmp r7,MAX_SKY_PEAK_ID
    bgt SkyPeakFloorJank_ret
    add r6,r6,r5,lsl #8      ; floor_byte += (apparentDungeonId << 8)
    SkyPeakFloorJank_ret:
        mov r0,r5 ; original instruction
        bx  lr    ; return

CustomTextCheck:
    cmp r1,#0x100
    blt GetLanguage ; return to original control flow if the floor number is < 256
    ; violating convention with my register usage here but GetNbFloors only uses r0 and r1
    push r4
    mov  r4,r0       ; buf to r4
    lsr  r2,r1,#8    ; apparentDungeonId to r2
    and  r3,r1,#0xFF ; floorNum to r3
    sub  r3,r3,#1    ; meterCount to r3
    FloorSumLoop:
        sub  r2,r2,#1 ; i--
        cmp  r2,MIN_SKY_PEAK_ID
        blt  EndFloorSumLoop
        mov  r0,r2
        bl   GetNbFloors
        add  r3,r3,r0
        b    FloorSumLoop
    EndFloorSumLoop:
        mov  r0,r4
        pop  r4
        ldr  r1,=FMT_STRING
        mov  r2,#100
        mul  r2,r3,r2
        bl   sprintf
        b    GetFloorNumStringRet
FMT_STRING:
    .asciiz "[CS:V]%d[CR] M"
.pool
.endarea
