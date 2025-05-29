# FixAuraBows
Did you know aura bows are completely broken? As in, they're so badly broken that wearing them is a *hindrance*? Neither did I!

Regardless, thanks to Chritchy's research, this skypatch has been made to fix this bug.

## The bug
I didn't actually know about this bug before Chritchy talked about it, so I'm probably not the *most* qualified person to explain this one.
Instead, let's look at what UsernameFodder had to say on the matter, from his [Demystifying Damage](https://reddit.com/r/MysteryDungeon/comments/11nrln9) post:
> They're supposed to increase your special attack too...except there's a mistake in the code. When you're being hit by a special move, it raises your *opponent's* special attack instead.
> It also raises your special defense, but since A is multiplied by 0.66 while D is multiplied by -0.56, the net effect of an aura bow is to *lower* your special defense slightly.
> So yeah, these things suck. 

## The technical details
Most of the work here was done by Chritchy, so I don't have much insight. I *do* know that the fix is done by adjusting which values get boosted by the Aura Bow.
