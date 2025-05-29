# AlwaysAllowPortraitDefault
Allows the Normal portrait to be used as a fallback[^1] for a monster portrait everywhere. Originally made for [EoS Archipelago](https://github.com/Chesyon/eos-archipelago-patches/blob/main/src/AlwaysAllowPortraitDefault.s).

## The technical details
Portrait parameters have a bool that allows the Normal portrait to be used as a fallback. Despite the name of the patch, this does *not* call AllowPortraitDefault, simply because it doesn't need to.
AllowPortraitDefault enables that bool in the portrait params, but couldn't we just make it true whenever portrait params are initialized? And that's what I did! It just initalizes that bool to true, so by default, portrait params will always fallback to Normal.
If for some reason you *didn't* want a portrait to be able to fallback to normal, you could just disable this bool in the portrait params after it gets initalized.

### Isn't this very brute-force-y?
Yes!


But I haven't run into a scenario where falling back to Normal has caused issues yet so it's fine!

[^1]: Fallback, as in if a particular emotion the game wants to use is missing.