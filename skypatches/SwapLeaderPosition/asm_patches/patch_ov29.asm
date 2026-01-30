.org LButtonCheckHook
.area 0x8
    str r8,[sp,#0x5C]  ; original instructions optimized
    b   SwapCheck
.endarea
