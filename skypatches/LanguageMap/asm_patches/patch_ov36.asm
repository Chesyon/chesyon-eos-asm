.orga 0x30F70+0x2E8
.area 0x28
    GetLanguageMod:
        mov  r1,#0
        b    GetNewVal
    GetLanguageTypeMod:
        ; LanguageType works with numbers 1 higher than Language, so we bump it down for now...
        sub  r0,r0,#1
        mov  r1,#1
    GetNewVal:
        add  r0,pc,r0
        ldrb r0,[r0,#0x8] ; Get the r0th value from the below table of REMAP values.
        add  r0,r0,r1 ; Bump back up by 1 for LanguageType, or leave it as is (+0) for Language.
        bx   lr


    .byte ENGLISH_REMAP
    .byte FRENCH_REMAP
    .byte GERMAN_REMAP
    .byte ITALIAN_REMAP
    .byte SPANISH_REMAP
    .fill 0x3, 0xFF ; padding
.endarea
