# DisableIsFutureDungeon
A quick jam patch originally written  for silverfox88's Cutting Ties hack, that makes IsFutureDungeon always return false.

## The technical details
It literally just overwrites the start of IsFutureDungeon with (the ASM equivalent of) `return false;`. Nothing super exciting.

## But why?
The sole use of IsFutureDungeon is in GetTalkLine (the function responsible for fetching dialogue when you talk to an ally in dungeons.) It actually has a "restrictions" system, where certain conditions will block certain talk lines from being used. If IsFutureDungeon returns true for the active dungeon, `restrictions` will be set to 1, which limits the chosen dialogue to only the first two dialogue lines in the pool. So, in summary, without this patch, allies will only be able to use their first two dialogue lines in future dungeons instead of their whole pool.

## Okay, but why did Chunsoft code it this way?
Great question! When I first researched this, I was completely baffled. At the end of the day, we can only theorize, but the leading theory is that it prevents the partner from saying the hero's name out loud while Grovyle is in the party, as Grovyle is supposed to learn that the hero is his old partner as a twist at the end of the future sequence. Honestly, I'm just surprised Chunsoft thought things that far through.
