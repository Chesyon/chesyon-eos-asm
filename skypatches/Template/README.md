# Skypatch template
This template contains the files inside of a skypatch, and some helper files for compilation[^1] and testing.

This is the template I use to make all of my skypatches; though I've cleaned it up a little bit. The goal of this template is to make creation of ASM patches easier, for both more experienced hackers and people just starting out with ASM.

## Shell files
These files do some quick file operations. There's no easy command line tool for making a zip on Windows[^2], so Linux (and maybe Mac) only, sorry! Make sure you open each of these files and replace "Template" with the name of the patch.
* MakePatch.sh builds a skypatch file using config.xml, patch.py, and everything in the asm_patches folder. Also copies the newly made skypatch into the skytemple folder for test.nds.
* ResetRom.sh copies base.nds in the tests folder over test.nds. This is intended to be used to quickly unapply your patch on test.nds so you can test again after making changes.

Maybe more coming in the future? Not sure.

[^1]: "Compilation" really just means "compression" here. A skypatch is just a renamed zip file.
[^2]: 7zip seems to kind of work, but it's REALLY slow.
