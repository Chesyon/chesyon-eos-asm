# AllowWindDisabling
Blocks the wind counter from counting down if it's currently negative, allowing one to effectively disable a floor's turn limit. Originally developed for a trap dungeon in [EoS Archipelago](https://github.com/Chesyon/eos-archipelago-patches/blob/main/src/cancel_wind_check.s).
Use this by setting a floor's initial turn limit to -1 (or any negative number) to disable its turn limit.

## The technical details
This one isn't too exciting. It just checks the wind counter, and doesn't run the code that decreases it if it's less than 0.

### My main concern
This code will COMPLETELY break if there's a way for the turn counter to become negative in normal gameplay. A turn counter of 0 will kick you out as intended, but if it manages to skip 0 and go directly into the negatives, the turn counter will be disabled and the player will never get kicked out.
I'm especially concerned because the turn counter was PROGRAMMED as a signed integer (as in, it's allowed to be negative). I'm not sure why they'd write it this way if it *wasn't* possible for the turn counter to go into the negatives in vanilla.
Buuuuut nobody has reported the patch breaking yet, so I suppose it's fine. Maybe the integer being signed was just for redundancy/a just-in-case scenario? Not sure, but if it works it works.