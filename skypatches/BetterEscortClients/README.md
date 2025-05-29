# BetterEscortClients
Makes escort clients match the party in level so they aren't as helpless. Requested by Gayschlatt.
~~(It's worth noting that this kind of defeats the point from a narrative perspective, because why do they need your help if they're as experienced as you?
But hey, it's kind of better from a gameplay perspective this way, and it was a request anyways.)~~
## The technical details
Turns out there's only a single place in the code used to determine the level of escort clients! There's a table of possible levels, and a function fetches from that, storing the level in r1.
That means we can just hijack it accessing that table and set r1 to whatever we want to choose a level for the client ourselves.
And that's exactly what we do here; we hook at the code that assigns r1 a value from the table, and then run our own code to determine the level.
### So how do we determine the level?
This actually uses a lot of code from Mond's LevelScalingPublic. It iterates through each party member (skipping over escort clients), and checks the level of each of them, holding onto the highest one.
Once we've determined the max party level, we write it to r1.
