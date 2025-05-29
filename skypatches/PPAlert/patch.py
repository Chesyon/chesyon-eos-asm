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
from skytemple_files.data.str.handler import StrHandler
from skytemple_files.common.ppmdu_config.data import Pmd2Data, GAME_VERSION_EOS, GAME_REGION_US, GAME_REGION_EU, GAME_REGION_JP
from skytemple_files.patch.category import PatchCategory
from skytemple_files.patch.handler.abstract import AbstractPatchHandler, DependantPatch
from skytemple_files.common.i18n_util import f, _

ORIGINAL_INSTRUCTION = 0x12433001
OFFSET_US = 0x2324E24-0x22DC240
OFFSET_EU = 0x232588C-0x22DCB80
OFFSET_JP = 0x23262B0-0x22DD8E0


class PatchHandler(AbstractPatchHandler, DependantPatch):

    @property
    def name(self) -> str:
        return 'PPAlert'

    @property
    def description(self) -> str:
        return "Implement's PSMD's PP alert for when a move's PP reaches zero."

    @property
    def author(self) -> str:
        return 'Mond, Adex'

    @property
    def version(self) -> str:
        return '0.1.1'

    def depends_on(self) -> list[str]:
        return ["ExtraSpace"]

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
        param = self.get_parameters()
        if param["ReplaceStrings"] == "1":
            # Change dialogue
            for lang in config.string_index_data.languages:
                filename = "MESSAGE/" + lang.filename
                bin_before = rom.getFileByName(filename)
                strings = StrHandler.deserialize(bin_before, string_encoding=config.string_encoding)
                strings.strings[int(param["StringID"]) - 1] = "[move:]'s PP dropped to zero!"
                bin_after = StrHandler.serialize(strings)
                rom.setFileByName(filename, bin_after)
        # Apply the patch
        apply()

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
