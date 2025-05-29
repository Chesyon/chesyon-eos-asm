# DisableSpindaDungeonUnlocks
Removes the hardcoded random-chance unlocks for dungeons unlocked in Spinda's Cafe. Originally made for [EoS Archipelago](https://github.com/Chesyon/eos-archipelago-patches/blob/main/patches/patch.asm#L243-L246).
Note that this patch doesn't do anything on its own! The scripts related to Spinda still unlock the dungeons, so you'll need to edit those scripts as well. Chunsoft just, *for some reason*, added a backup measure to unlock it in the game's code. Why? ┐('～`*)┌

So yes this only removes the hardcoded unlocks, not the one in the scripts. The fact that this patch needs to exist only further convinces me that the devs got REALLY sloppy when developing Sky.

## The technical details
It's literally just a well placed `nop` to disable the function call that unlocks the dungeon.