# PartyUpdatesMap
Causes all party members to update the map, even if offscreen, like they do in PSMD.

## The technical details
This is a very wacky patch. Due to my unending pursuit of optimization, half of this code is in overlay29, and half of it is in overlay36.
There's a couple of vanilla instructions that wouldn't have gotten called anyways, so we can just overwrite those instructions with patch code to save some overlay36 space.
That being said, splitting it between two overlays is VERY annoying for readability. So here's all the code in one place! (Cleaned up and with extra comments)
```asm
    push  r4
    ldrb  r4,[r0,#0x7]    ; is_team_leader to r4
    ldrb  r0,[r0,#0x6]    ; is_not_team_member to r0
    cmp   r0,#0x1         ; is this not a party member?
    popeq r4
    beq   IfCheckFails    ; if this is not a party member, we should not update the map.
    add   r0,r9,#0x4      ; setup for DiscoverMinimap
    bl    DiscoverMinimap ; if this IS a party member (it is if we've gotten this far,) update the minimap
    cmp   r4,#0x0         ; is this the leader?
    pop   r4              
    beq   IfCheckFails    ; if not we should not run the rest of the leader-only code
    b     ReturnPoint     ; otherwise go ahead and run the rest of the leader-only code 
```
With that quirk addressed, *now* we can talk about how this works.

Before updating the minimap and triggering a trap, the game first checks if the monster is the leader. I refer to this code as "leader-only" code.
I had originally thought "okay, I'll just remove the check then!" and this is what I did for the first iteration of the patch!

This was not a good idea.

Removing the check caused ALL the leader-only code to run for all party members, which led to some *very* wonky side-effects. For example, one party member stepping on a trap would cause it to activate for each member of the party.
Obviously this was not desirable! So I'd have to take a more fine-tuned approach. The second (current) iteration does custom checks:
* If the monster is not in the party, do not run ANY leader-only code.
* If the monster is in the party, update the minimap.
* If the monster is NOT the leader, skip running the rest of the leader only code.

This new approach *seems* to work. Hooray!
