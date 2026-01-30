#  Copyright 2025-2026 Chesyon
#
#  This source code is licensed under the MIT license: https://github.com/Chesyon/chesyon-eos-asm/blob/main/LICENSE_MIT
#  However, the distribution is licensed under GPLv3: https://github.com/Chesyon/chesyon-eos-asm/blob/main/LICENSE_GPLv3
#  For a non-legalese version of what this means, see https://chesyon.me/eos-licenses.html.

from typing import Callable

from ndspy.rom import NintendoDSRom

from skytemple_files.common.util import read_u32, get_binary_from_rom
from skytemple_files.common.ppmdu_config.data import Pmd2Data, GAME_VERSION_EOS, GAME_REGION_US, GAME_REGION_EU, GAME_REGION_JP
from skytemple_files.patch.category import PatchCategory
from skytemple_files.patch.handler.abstract import AbstractPatchHandler, DependantPatch
from skytemple_files.common.i18n_util import f, _

ORIGINAL_INSTRUCTION = 0xE3190004 # hex representation of tst r9,0x4 (which we are changing to tst r9,0x5)
OFFSET_US = 0x22C0DE8-0x22BCA80
OFFSET_EU = 0x22C1728-0x22BD3C0 # location of tst r9,0x4 minus starting point of overlay 10
OFFSET_JP = 0x22C2590-0x22BE220


class PatchHandler(AbstractPatchHandler, DependantPatch):

    @property
    def name(self) -> str:
        return 'TeamStatsPain'

    @property
    def description(self) -> str:
        return "If available, change a team member's portrait in the Team Stats menu to pain when in critical condition."

    @property
    def author(self) -> str:
        return 'Chesyon, Adex'

    @property
    def version(self) -> str:
        return '0.1.1'

    def depends_on(self) -> list[str]:
        return ["ExtraSpace"]

    def is_applied(self, rom: NintendoDSRom, config: Pmd2Data) -> bool:
         overlay10 = get_binary_from_rom(rom, config.bin_sections.overlay10)
         if config.game_version == GAME_VERSION_EOS:
            if config.game_region == GAME_REGION_US:
                return read_u32(overlay10, OFFSET_US) != ORIGINAL_INSTRUCTION
            if config.game_region == GAME_REGION_EU:
                return read_u32(overlay10, OFFSET_EU) != ORIGINAL_INSTRUCTION
            if config.game_region == GAME_REGION_JP:
                return read_u32(overlay10, OFFSET_JP) != ORIGINAL_INSTRUCTION
         raise NotImplementedError()

    def apply(self, apply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data) -> None:
         # Apply the patch
         apply()

    def unapply(self, unapply: Callable[[], None], rom: NintendoDSRom, config: Pmd2Data):
        raise NotImplementedError()
