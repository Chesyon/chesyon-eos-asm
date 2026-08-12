
# SeparateMenuSpecialEpisodeStrings
Changes the strings in the Special Episode list in the Top Menu to strings 15434-15439. Niche-ish patch for JaiFain's [PMD: Eternal Elemental](https://hacks.skytemple.org/h/eternal_elemental). EU only for now due to the patch being niche, but if somebody else needs this I'll come back and make a 0.2.0 with configuration and NA/JP support.
![Demonstration of SeparateMenuSpecialEpisodeStrings 1](one.png)
![Demonstration of SeparateMenuSpecialEpisodeStrings 2](another.png)
###### Both strings here are for Special Episode 2, but use different IDs!
This was made because Eternal Elemental's second special episode had such a long name that it needed a `[CLUM_SET]` to make it fit in the textbox, but a `[CLUM_SET]` messed up the special episode selection page. One use needs a `[CLUM_SET]`, one doesn't... sounds like it needs to use two different strings, then!
## The technical details
This one's simple enough, but I'll yap a bit about the reverse-engineering process. The regular string ID is 370, or 0x172. That's not a valid immediate, so it can't just go in a `mov` instruction (for more on ARM immediates, see [Alisdair McDiarmid's article on the matter](https://alisdair.mcdiarmid.org/) with the calculator that I *still* use occasionally instead of learning to eyeball it). As such, I was expecting it to be a pool value, so finding it would just be a matter of searching for the bytes 72 01 00 00 in Ghidra... and I was wrong. No useful hits.  So I ended up doing things the hard way! I'm summing up 2 hours of research in one run-on sentence, but I dug into overlay 1 to figure out how the top menu works, did a smidge of work on the main struct used there (size 0x184), and through some GDB breakpoints, determined that the string IDs live at 0x11C in the struct, and are populated early on in `CreateMainMenus`. Look at 0x2331910 [ov1 EU], and watch r0...
```arm
ldr  r2,[r7,#0x0]=>MAIN_MENUS_PTR
add  r0,r6,#0x72
ldr  r1,[r2,#0x114]
add  r2,r2,#0x11c
add  r3,r2,r1, lsl #0x3
str  r6,[r3,#0x4]
mov  r1,r1, lsl #0x3
add  r0,r0,#0x100
strh r0,[r2,r1]
```
`add r0,r6,#0x72`, and `add r0,r0,#0x100`. Special episode ID (r6) plus 0x172; there we are! I don't entirely get why it's compiled this way, since as far as I can tell, it would take the exact same space and the same number of cycles to use a pool value. Though...
### A tangent about `ldr` and saving single cycles
A fun little thing I recently learned is that the `add r0,r6,#0x72` is between the other two `ldr`s to save a single cycle. `ldr`ing something to a register (r2, here) takes two cycles, but it can move onto the next instruction after the first cycle. However, the `ldr`ed value can't actually be *used* until that second cycle is done. If you try to use it (i.e. with `ldr  r1,[r2,#0x114]`) in the instruction immediately after, that second cycle won't have completed yet, and the processor will need to stall for a cycle before it can run the current instruction. So in short: after `ldr`ing to a register, you should have the next instruction not use the destination register to not waste a cycle! The `add r0,r6,#0x72` is the only instruction that *could* go between those `ldr`s, and therefore, the compiler puts it there. Okay tangent over!

### Putting the new number in
With the way immediates work, 0x??00 and 0x?? are both valid immediates no matter what you put there, so no matter what 2-byte string ID we wanted to use, it could be fit into those `add`s. In this case, we want 15434, or 0x3C4A, so we do `add r0,r6,#0x4A`, and `add r0,r0,#0x3C00`. And that's it!

###### ~~I'm really out here writing 600 words about a 2 line assembly patch...~~ 

