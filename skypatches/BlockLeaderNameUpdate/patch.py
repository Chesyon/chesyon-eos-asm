 #  Copyright 2020-2024 Capypara and the SkyTemple Contributors
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

# since we're overwriting a branch, the original instruction varies between regions, so we have to define them separately :pensive:
ORIGINAL_INSTRUCTION_US = 0xEBFFB5C1
OFFSET_US = 0x2037A10-0x2000000
ORIGINAL_INSTRUCTION_EU = 0xEBFFB5B5
OFFSET_EU = 0x2037D0C-0x2000000
ORIGINAL_INSTRUCTION_JP = 0xEBFFB505
OFFSET_JP = 0x2037D50-0x2000000


class PatchHandler(AbstractPatchHandler):

    @property
    def name(self) -> str:
        return 'BlockLeaderNameUpdate'

    @property
    def description(self) -> str:
        return "Blocks the hero name menu from setting the name of the leader."

    @property
    def author(self) -> str:
        return 'Chesyon, Adex'

    @property
    def version(self) -> str:
        return '0.1.0'

    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
         arm9 = get_binary_from_rom(rom, config.bin_sections.arm9)
         if config.game_version == GAME_VERSION_EOS:
            if config.game_region == GAME_REGION_US:
                return read_u32(arm9, OFFSET_US) != ORIGINAL_INSTRUCTION_US
            if config.game_region == GAME_REGION_EU:
                return read_u32(arm9, OFFSET_EU) != ORIGINAL_INSTRUCTION_EU
            if config.game_region == GAME_REGION_JP:
                return read_u32(arm9, OFFSET_JP) != ORIGINAL_INSTRUCTION_JP
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         # Apply the patch
         apply()

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
