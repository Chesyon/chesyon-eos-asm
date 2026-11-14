.orga 0x311E8
.area 0x70
    ; Brain was not braining while writing this, so uhh five billion comments lmao.
    ; Different possible cases.
    ; # = case number
    ; V = should continue on victory (63)
    ; F = should continue on failure (62)
    ; E = end reason is failure
    ; #  V  F  E
    ; 1  0  0  0 => music stops
    ; 2  0  0  1 => music stops
    ; 3  0  1  0 => music stops
    ; 4  0  1  1 => music continues
    ; 5  1  0  0 => music continues
    ; 6  1  0  1 => music stops
    ; 7  1  1  0 => music continues
    ; 8  1  1  1 => music continues
    TryFadeOutDungeonSound:
        push {r0,r4,r5,lr}
        bl   GetLeaderActionId
        subs r0,r0,#0x2B ; ACTION_QUICKSAVE
        beq  PostEval

        ; Not a quicksave. Do loss/victory checks
        mov r0,PFLAG_CONTINUE_ON_LOSS
        bl  GetPerformanceFlagWithChecks
        mov r4,r0
        mov r0,PFLAG_CONTINUE_ON_VICTORY
        bl  GetPerformanceFlagWithChecks

        ; Cases 1, 2, 7, 8: If both are enabled or disabled (r0 == r4), it doesn't matter how you exited, it just matters what the flag was. If both are 0 (r0 == 0), music should stop (r0 = 0). If both are 1 (r0 == 1), music should continue (r0 = 1).
        cmp r0,r4
        beq PostEval ; r0 is already what it needsd to be for these cases!

        ; Otherwise, exit reason DOES matter. (Result of PFLAG_CONTINUE_ON_VICTORY is unneeded past this point since it can be deduced logically)
        bl  IsDungeonEndReasonFailure

        ; Cases 3, 4: We want to continue on loss (r4 != 0). If end reason is failure (r0 == 1), music should continue (r0 = 1). If end reason is victory (r0 == 0), music should stop (r0 = 0). r0 is already what it needs to be!
        cmp r4,#0x0
        bne PostEval ; r0 is already what it needs to be for these cases!

        ;  Cases 5, 6: We want to continue on victory (No condition needed, these are the only remaining cases). If end reason is failure (r0 == 1), music should stop (r0 = 0). If end reason is victory (r0 == 0), music should continue (r0 = 1). r0 should be flipped.
        rsb r0,r0,#1 ; r0 = 1 - r0. 0 (exit is victory) becomes 1 (continue music), 1 (exit is failure) becomes 0 (stop music).
        PostEval:
            strb r0,[pc,#0x28] ; STOP_DUNGEON_SOUND. We only actually check the fade condition here. We store the evaluated result to STOP_DUNGEON_SOUND to reuse in the second hook.
            cmp  r0,#0
            pop  {r0,r4,r5,lr}
            bxne lr ; if conditions are met, skip the function call to fade out sound
            b    FadeOutDungeonSound ; Tail call optimization!

    TryStopDungeonSound:
        ldrb r0,[pc,#0x14] ; STOP_DUNGEON_SOUND
        cmp  r0,#0
        bxne lr
        push {lr}
        bl   StopBgmCommand
        bl   StopBgm2Command
        pop  {pc}

    STOP_DUNGEON_SOUND:
        .byte 0x0
.endarea
