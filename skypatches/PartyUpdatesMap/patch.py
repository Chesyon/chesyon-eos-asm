#  Copyright 2025-2026 Chesyon
#
#  This source code is licensed under the MIT license: https://github.com/Chesyon/chesyon-eos-asm/blob/main/LICENSE_MIT
#  However, the distribution is licensed under GPLv3: https://github.com/Chesyon/chesyon-eos-asm/blob/main/LICENSE_GPLv3
#  For a non-legalese version of what this means, see https://chesyon.me/eos-licenses.html.

from typing import Callable

from ndspy.rom import NintendoDSRom

from skytemple_files.common.util import read_u32, get_binary_from_rom
from skytemple_files.common.ppmdu_config.data import Pmd2Data, GAME_VERSION_EOS, GAME_REGION_EU, GAME_REGION_US, GAME_REGION_JP
from skytemple_files.patch.category import PatchCategory
from skytemple_files.patch.handler.abstract import AbstractPatchHandler, DependantPatch
from skytemple_files.common.i18n_util import f, _

ORIGINAL_INSTRUCTION = 0xE5D00007
OFFSET_EU = 0x2305E64-0x22DCB80
OFFSET_US = 0x2305438-0x22DC240
OFFSET_JP = 0x2306988-0x22DD8E0


class PatchHandler(AbstractPatchHandler, DependantPatch):

    @property
    def name(self) -> str:
        return 'PartyUpdatesMap'

    @property
    def description(self) -> str:
        return "Causes all party members to update the dungeon minimap."

    @property
    def author(self) -> str:
        return 'Chesyon'

    @property
    def version(self) -> str:
        return '0.1.0'

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
         # Apply the patch
         apply()

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
