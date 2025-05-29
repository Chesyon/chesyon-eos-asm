# ExpMultiplier
Multiplies all Exp gained by an integer between 0 and 16, selected on patch application. Selecting 0 will block any Exp from being gained!
Originally written for [EoS Archipelago](https://github.com/Chesyon/eos-archipelago-patches/blob/main/src/exp_scaling.s).

This patch is currently only compatible with EU. NA/JP support coming soon!
I originally made this skypatch so people could test the feature before it was officially implemented, which is why it's a little rough.

## The technical details
This one isn't *super* exciting. There's a function to determine the amount of Exp gained from something, so we just hook right before it returns, and multiply the return value by a number before allowing the code to return.

Side note: Despite how I said a multiplier of 0 would stop Exp from being gained, this *technically* isn't true. You'll gain exactly 1 Exp from anything.
If I had to guess, this is some Chunsoft failsafe to stop the game from exploding violently as a result of trying to gain 0 Exp?

### Differences from Archipelago
If you look at the Archipelago version of this patch (linked at the top of this README), you'll notice it's a bit different.
This is because in Archipelago, the multiplier is written separately from the patch itself, as it's a YAML setting.
As such, the Archipelago version needs to fetch the multiplier from memory and trim it down to 4 bits (since only 4 bits are allocated for the multiplier- any other bits are garbage data.)
This 4 bit allocation is also the reason behind the maximum multiplier of 16[^1]. That restriction doesn't actually apply to this skypatch version, but I just didn't bother to change it I guess?
Maybe I'll change it in a future iteration of this patch. Talking of potential future iterations...

### .5 multipliers?
It irks me that this code doesn't allow for a multiplier for 1.5 or something... simply because we can't easily store 1.5 in a register, much less just multiply something by 1.5 in one instruction.
Of course, we can always do bitshifting math, because `x * 1.5 = x + (x >> 1)`. So it's definitely possible, though the multiplier would have to be stored internally as twice of what it actually is.
For example, 1.5 would be represented as 3, 2 would be represented as 4, and 2.5 would be represented as 5.
Point being, I'll probably come back to this for a future EoS Archipelago version, and I'll update this skypatch when I do.

[^1]: ~~Technically this should have been a maximum of 15, since 0b1111 = 15, so point and laugh I guess. But again the limit for this skypatch is completely arbitrary anyways.~~
