#  Copyright 2026 Chesyon
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

ORIGINAL_INSTRUCTION_EU_US = 0xE0030092
ORIGINAL_INSTRUCTION_JP = 0xE0000092
OFFSET_EU = 0x3DAF4
OFFSET_US = 0x3D7F8
OFFSET_JP = 0x3DBE0


class PatchHandler(AbstractPatchHandler, DependantPatch):

    @property
    def name(self) -> str:
        return 'LessTaxes'

    @property
    def description(self) -> str:
        return "Reduces the amount of 'total' reward money given by job clients, to give the appearance of less money being taken by the guild. THIS DOES NOT AFFECT THE MONEY RECEIVED BY THE PLAYER. Does not affect the dialogue in m02a1001.ssb."

    @property
    def author(self) -> str:
        return 'Chesyon, happylappy'

    @property
    def version(self) -> str:
        return '0.1.0'

    def depends_on(self) -> list[str]:
        return ["ExtraSpace"]

    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
         arm9 = get_binary_from_rom(rom, config.bin_sections.arm9)
         if config.game_version == GAME_VERSION_EOS:
            if config.game_region == GAME_REGION_US:
                return read_u32(arm9, OFFSET_US) != ORIGINAL_INSTRUCTION_EU_US
            if config.game_region == GAME_REGION_EU:
                return read_u32(arm9, OFFSET_EU) != ORIGINAL_INSTRUCTION_EU_US
            if config.game_region == GAME_REGION_JP:
                return read_u32(arm9, OFFSET_JP) != ORIGINAL_INSTRUCTION_JP
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         apply() # Apply the patch

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
