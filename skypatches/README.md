# Skypatches
This is a collection of my various skypatches to make various modifications to the game. Some will be more useful than others; I just put everything I write here, including requests. I do my best to document what they do, so make sure you know what you're applying!

If you're just looking to use these patches, you'll want to go into the folder for the patch you want and download the .skypatch file itself! Everything else in the folders is the actual code powering the patches.

## Memory map
Patch overlaps. You know them and you hate them.

Actually, just in case you don't, let's go over them really quick. Skypatches that use overlay36 (ExtraSpace) often write their code into the "free area", an area that built-in SkyTemple patches won't touch. The thing is, many people put their patches *right* at the start, causing them to overlap, meaning one patch will overwrite the code for another. This results in a game crash 99% of the time. Patch overlaps can be fixed by adjusting the starting point (the .org(a) of patch_overlay36.asm).

The below table lists the default starting point of each patch and their sizes; my patches are by default configured to not overlap with each other, but there's not much I can do for patches by other people, so it's generally going to be up to you to adjust your files to avoid patch overlaps.
| Name                       | Free Area Offset | Overlay36 Location | RAM Location | Size |
|----------------------------|------------------|--------------------|--------------|------|
| TeamStatsPain              | N/A              | 0x1B70             | 0x23A8BF0    | 0x20 |
| PartyUpdatesMap            | 0x20             | 0x30F90            | 0x23D8010    | 0x20 |
| AllowWindDisabling         | 0x40             | 0x30FB0            | 0x23D8030    | 0xC  |
| AlwaysAllowPortraitDefault | 0x4C             | 0x30FBC            | 0x23D803C    | 0x8  |
| BetterEscortClients        | 0x54             | 0x30FC4            | 0x23D8044    | 0x58 |
| ExpMultiplier              | 0xAC             | 0x3101C            | 0x23D809C    | 0x10 |
| PPAlert                    | 0xBC             | 0x3102C            | 0x23D80AC    | 0x54 |
| MeteredSkyPeak             | 0x110            | 0x31080            | 0x23D8100    | 0x84 |

## What about PMD: Crowned?
If you're looking for my patches made for and used exclusively in my ROMhack, PMD: Crowned- they're not here, sorry! Crowned uses [c-of-time](https://github.com/SkyTemple/c-of-time), which isn't skypatches. if you *really* want to use code from that, just ask- I can adapt it into a skypatch if doing so is feasible, and if not I can at the very least give you the C code.