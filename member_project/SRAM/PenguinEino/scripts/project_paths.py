"""Shared circuit locations after the repository organization."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CORE_SCHEMATICS = ROOT / 'sram512/schematics'
LEARNING_SCHEMATICS = ROOT / 'learning/schematics'


def schematic_path(name):
    for directory in (CORE_SCHEMATICS, LEARNING_SCHEMATICS):
        path = directory / name
        if path.is_file():
            return path
    raise FileNotFoundError(f'Unknown project schematic: {name}')
