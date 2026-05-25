# LessTaxes
Reduces the amount of 'total' reward money given by job clients, to give the appearance of less money being taken by the guild. THIS DOES NOT AFFECT THE MONEY RECEIVED BY THE PLAYER. Requested by Meles. Credits to [happylappy](https://github.com/HappyLappy1/) for researching the relevant code for *Team Hack Event #2: Crimson Chrysalis*.

## The technical details
This one's on the simpler side. All money rewards for jobs are (perhaps unsurprisingly) handled internally as the amount actually given to the player. When it comes to showing the 'full' amount, which ONLY happens during the NPC thank you dialogue, it just kinda tacks a zero onto that, or more specifically, multiplies by 10. We actually don't change this behavior! We just do some division; a lot of the logic behind this is MATH.

### The MATH details
Let's start by looking at vanilla's math, because it's simple by design. "Original" represents the amount of money the player actually receives, and how it's stored internally, while "Complete" represents the amount of money the NPC says. Keep in mind that Complete is calculated based on Original, NOT the other way around.

Original is 10% of Complete -> Original is 1/10 of Complete -> Complete is Original x10.

So, to get the "Complete" amount, we're multiplying by the reciprocal of the amount the player keeps, so 1/10 because 10/1, or just 10. Now, let's say we want to have the player keep 90% instead:

Original is 90% of Complete -> Original is 9/10 of Complete -> Complete is Original x10/9.

Uh oh, that's division. If you've written assembly for this game ever, you should rightfully have a fear response to this! Division sucks. But notably, the x10 part is still there; we just need to divide by 9 afterwards.

### Okay, so now what?
The game actually has a *few* different division functions. A lot of the math functions are for floating point, but we're going to stay as far away from that as humanly possible. We'll instead focus on integer division. `_s32_div_f` is usually the goto for this, and is what Chunsoft used. HOWEVER, NitroSDK offers its own integer division function, `FX_DivS32`. Full disclosure: either works! If you want, you could swap out the function for its alternative and the results will be exactly the same. I chose to use `FX_DivS32` because it uses a little-known thing called "hardware division". Full disclosure: I understand VERY LITTLE about this. I just know there's something in the hardware specifically designed to faciliate division, and it *should* be faster than a manual software implementation like `_s32_div_f`. Allegedly. To be fully honest, I just wanted a chance to try it out ever since I heard about it, and it worked beautifully. Haven't actually checked the numbers for how many cycles it saves, though.

You can accomplish 10% (this is just vanilla), 20%, 30%, 40%, 50%, 60%, 70%, 80%, 90%, and even 100% just by changing the divisor. The requester asked for 90%, but I figured I might as well make it a parameter! If you're going to do 10%, I'd recommend just... not applying the patch, and saving a pointless calculation, and if you're going to do 100%, I'd recommend just writing a `mov r3,r2` \[EU/NA] or `mov r0,r2` \[JP] at the hook point to skip the math outright. Oh, right!

### JP
JP decided to compile this function a little differently. Thanks, JP. It ended up being different enough that it made most sense to just have different ov36 patches. Primarily, it puts the result of the multiplication into r0 instead of r3, and it needs r3 to be the same after the hook instead of r0. This does mean the ov36 code is an instruction shorter in JP, since after the `FX_DivS32` call, the number's already where it needs to be (r0). I've ignored this for the sake of the memory map, though.
