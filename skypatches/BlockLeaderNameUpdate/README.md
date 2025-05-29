# BlockLeaderNameUpdate
Don't overwrite the name of the party leader when setting the hero name. Written for Raysee, researched by Adex.

This is intended to be used if you want your hero to have a fixed name, but you still want to use the hero name menu to store some other user input text.
$HERO_FIRST_NAME is still updated, so that will store the text input from the user, which can be displayed with `[c_name:NPC_HERO_FIRST]`.

This patch is for a pretty specific use case, so make sure you know what you're doing before applying this!

## Original use case
Raysee's Oneshot Mystery Dungeon hack has a fixed hero (Niko), but wants the player to be able to input their *own* name, such that the characters can refer to the player by name.
This patch allows the player to input their own name and have it be accessible through `[c_name:NPC_HERO_FIRST]`, while keeping the hero's name as Niko.

## The technical details
Nothing too exciting here. Just `nop`ing two calls to StrncpySimple to stop the name from the name menu from being written to the hero, while leaving the code that updates the script variable untouched.

Sorry for the lack of insight, Adex did all the RE work for this one. But even ignoring that, there's not much *to* talk about.
