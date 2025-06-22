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

from typing import Callable

from ndspy.rom import NintendoDSRom

from skytemple_files.common.util import read_u32, get_binary_from_rom
from skytemple_files.common.ppmdu_config.data import Pmd2Data, GAME_VERSION_EOS, GAME_REGION_EU, GAME_REGION_US, GAME_REGION_JP
from skytemple_files.patch.category import PatchCategory
from skytemple_files.patch.handler.abstract import AbstractPatchHandler
from skytemple_files.common.i18n_util import f, _

# the following variables are used in the is_applied check below.
# hex representation of the instruction you're overwriting. note that in ghidra the bytes are shown in reverse order! ex: 58 07 c1 05 -> 0x05C10758
ORIGINAL_INSTRUCTION = 0xE350001B
# address of the instruction you're overwriting minus the start point of the overlay
OFFSET_EU = 0x2051804-0x2000000
OFFSET_US = 0x20514CC-0x2000000
OFFSET_JP = 0x205181C-0x2000000


class PatchHandler(AbstractPatchHandler):

    @property
    def name(self) -> str:
        return 'DisableIsFutureDungeon'

    @property
    def description(self) -> str:
        return "Causes IsFutureDungeon to always return false."

    @property
    def author(self) -> str:
        return 'Chesyon'

    @property
    def version(self) -> str:
        return '0.1.0'

    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
         arm9 = get_binary_from_rom(rom, config.bin_sections.arm9)
         if config.game_version == GAME_VERSION_EOS:
            if config.game_region == GAME_REGION_US:
                return read_u32(arm9, OFFSET_US) != ORIGINAL_INSTRUCTION
            if config.game_region == GAME_REGION_EU:
                return read_u32(arm9, OFFSET_EU) != ORIGINAL_INSTRUCTION
            if config.game_region == GAME_REGION_JP:
                return read_u32(arm9, OFFSET_JP) != ORIGINAL_INSTRUCTION
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         apply() # Apply the patch

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
