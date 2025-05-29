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

MODIFIED_INSTRUCTION = 0xE320F000
OFFSET_EU = 0x238DE18-0x238AC80
OFFSET_US = 0x238D2E4-0x238A140
OFFSET_JP = 0x238E83C-0x238B6A0


class PatchHandler(AbstractPatchHandler):

    @property
    def name(self) -> str:
        return 'DisableSpindaDungeonUnlocks'

    @property
    def description(self) -> str:
        return "Stops MENU_JUICE_BAR_PICK_ITEM from unlocking dungeons. NOTE: You will still need to edit s30a0701.ssb!"

    @property
    def author(self) -> str:
        return 'Chesyon'

    @property
    def version(self) -> str:
        return '0.1.0'

    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
         overlay19 = get_binary_from_rom(rom, config.bin_sections.overlay19)
         if config.game_version == GAME_VERSION_EOS:
            if config.game_region == GAME_REGION_US:
                return read_u32(overlay19, OFFSET_US) == MODIFIED_INSTRUCTION
            if config.game_region == GAME_REGION_EU:
                return read_u32(overlay19, OFFSET_EU) == MODIFIED_INSTRUCTION
            if config.game_region == GAME_REGION_JP:
                return read_u32(overlay19, OFFSET_JP) == MODIFIED_INSTRUCTION
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         # Apply the patch
         apply()

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
