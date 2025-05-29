 #  Copyright 2020-2025 Capypara and the SkyTemple Contributors
 #
 #  This file is part of SkyTemple.
 #
 #  SkyTemple is free software: you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
 #  the Free Software Foundation, either version 3 of the License, or
 #  (at your option) any later version.
 #
 #  SkyTemple is distributed in the hope that it will be useful,
 #  but WITHOUT ANY WARRANTY; without even the implied warranty of
 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 #  GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License
 #  along with SkyTemple.  If not, see <https://www.gnu.org/licenses/>.

 #  This template is by Chesyon! Is the above block even needed? I don't know! But I'll leave it in regardless!

from typing import Callable

from ndspy.rom import NintendoDSRom

from skytemple_files.common.util import read_u32, get_binary_from_rom
from skytemple_files.common.ppmdu_config.data import Pmd2Data, GAME_VERSION_EOS, GAME_REGION_EU, GAME_REGION_US, GAME_REGION_JP
from skytemple_files.patch.category import PatchCategory
from skytemple_files.patch.handler.abstract import AbstractPatchHandler#, DependantPatch # <- uncomment this if the patch uses overlay 36.
from skytemple_files.common.i18n_util import f, _

# the following variables are used in the is_applied check below.
# hex representation of the instruction you're overwriting. note that in ghidra the bytes are shown in reverse order! ex: 58 07 c1 05 -> 0x05C10758
ORIGINAL_INSTRUCTION = 0x05C10758
# address of the instruction you're overwriting minus the start point of the overlay'
OFFSET_EU = 0x22ED1C8-0x22DCB80
OFFSET_US = 0x22EC818-0x22DC240
OFFSET_JP = 0x22EDE80-0x22DD8E0


class PatchHandler(AbstractPatchHandler):
#class PatchHandler(AbstractPatchHandler, DependantPatch): # If the patch uses overlay 36, comment the above line and uncomment this line.

    @property
    def name(self) -> str:
        return 'Template'

    @property
    def description(self) -> str:
        return "Description goes here"

    @property
    def author(self) -> str:
        return 'Chesyon'

    @property
    def version(self) -> str:
        return '0.1.0'

    # Uncomment the below lines if the patch uses overlay 36.
    #def depends_on(self) -> list[str]:
        #return ["ExtraSpace"] # (if the patch has any additional dependencies, those can be listed here too. ex: ["ExtraSpace", "ExpandPokeList", "TeamStatsPain"])

    # Change all instances of overlay29 in this function to the desired overlay to check.
    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
         overlay29 = get_binary_from_rom(rom, config.bin_sections.overlay29)
         if config.game_version == GAME_VERSION_EOS:
            if config.game_region == GAME_REGION_US:
                return read_u32(overlay29, OFFSET_US) != ORIGINAL_INSTRUCTION
            if config.game_region == GAME_REGION_EU:
                return read_u32(overlay29, OFFSET_EU) != ORIGINAL_INSTRUCTION
            if config.game_region == GAME_REGION_JP:
                return read_u32(overlay29, OFFSET_JP) != ORIGINAL_INSTRUCTION
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         apply() # Apply the patch

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
