#!/usr/bin/env python3
"""Add isolated, large M2 name lettering to the submitted SRAM GDS.

The lettering occupies the clear vertical lane between the rightmost signal
routes and the output rails.  It is polygon geometry, not an LVS port label.
Run this after exporting the submission GDS.  The script also restores the
verified bitcell geometry if the known uncommitted edit is present.
"""
import hashlib
import json
import shutil
import zipfile
from pathlib import Path

import klayout.db as db
from submission_figures import pin_figure
from submission_previews import export_previews


ROOT = Path(__file__).resolve().parents[2]
GDS = ROOT / 'submission/sram512.gds'
MANIFEST = ROOT / 'reviews/submission_manifest.json'
CELL = 'sram512_silicon_art'
LAYER = (20, 0)
BACKUP = ROOT / 'build/silicon_art/submission_before_art_and_marker_repair.gds'
FONT = {
    'A': ('01110', '11011', '10001', '11111', '10001', '10001', '10001'),
    'E': ('11111', '10000', '10000', '11111', '10000', '10000', '11111'),
    'I': ('11111', '00100', '00100', '00100', '00100', '00100', '11111'),
    'K': ('10011', '10110', '11100', '11000', '11100', '10110', '10011'),
    'N': ('11001', '11001', '11101', '10101', '10111', '10011', '10011'),
    'O': ('11111', '10001', '10001', '10001', '10001', '10001', '11111'),
    'S': ('11111', '10000', '10000', '11111', '00001', '00001', '11111'),
    'U': ('10001', '10001', '10001', '10001', '10001', '10001', '11111'),
    'Z': ('11111', '00011', '00110', '01100', '11000', '10000', '11111'),
}


def main():
    BACKUP.parent.mkdir(parents=True, exist_ok=True)
    if not BACKUP.exists():
        shutil.copy2(GDS, BACKUP)
    layout = db.Layout()
    layout.read(str(GDS))
    top = layout.cell('sram512')
    assert top is not None and layout.dbu == 0.001
    if layout.cell(CELL) is not None:
        raise RuntimeError(f'{CELL} already exists; refusing to duplicate artwork')

    # A stray 235/0 polygon in each repeated bitcell appeared in the edited
    # submission GDS.  The verified source bitcell has no shape on that layer.
    core = layout.cell('pcell_core')
    marker = layout.layer(235, 0)
    assert core is not None
    removed_marker = not core.shapes(marker).is_empty()
    if removed_marker:
        assert core.shapes(marker).size() == 1
        core.shapes(marker).clear()
    # The same edited cell moved both pull-up devices off the verified grid.
    # Return just these two instances to the source GDS coordinates.
    pullups = sorted((inst for inst in core.each_inst()
                      if inst.cell.name == 'fet_p$7'), key=lambda inst: inst.trans.disp.x)
    assert len(pullups) == 2
    old_points = [inst.trans.disp for inst in pullups]
    source_points = [db.Point(6_000, 20_400), db.Point(12_000, 20_400)]
    shifted_points = [db.Point(6_985, 20_400), db.Point(10_975, 20_400)]
    assert old_points in (source_points, shifted_points)
    if old_points == shifted_points:
        for inst, point in zip(pullups, source_points):
            inst.trans = db.Trans(point)

    layer = layout.layer(*LAYER)
    art = layout.create_cell(CELL)
    pixel = 5_000  # 5 um squares, 35 um glyph height
    advance = 35_000
    x_right = 1_731_000
    spans = []
    for word, y_base in (('EINOSUKE', 28_000), ('OKAZAKI', 322_000)):
        region = db.Region()
        for index, letter in enumerate(word):
            for row, bits in enumerate(FONT[letter]):
                for col, bit in enumerate(bits):
                    if bit == '1':
                        # Rotate a horizontal word 90 degrees counterclockwise.
                        x = x_right - (7 - row) * pixel
                        y = y_base + index * advance + col * pixel
                        region.insert(db.Box(x, y, x + pixel, y + pixel))
        region.merge()
        art.shapes(layer).insert(region)
        spans.append([word, list(map(lambda n: n * layout.dbu,
                                     (region.bbox().left, region.bbox().bottom,
                                      region.bbox().right, region.bbox().top)))])

    # Require 3 um clearance from existing M2 before adding the instance.
    original_m2 = db.Region(top.begin_shapes_rec(layer))
    original_m2.merge()
    original_m2.size(3_000)
    artwork = db.Region(art.begin_shapes_rec(layer))
    assert (original_m2 & artwork).is_empty(), 'Artwork touches existing M2'
    assert artwork.bbox() == db.Box(1_696_000, 28_000, 1_731_000, 557_000)
    top.insert(db.CellInstArray(art.cell_index(), db.Trans()))

    options = db.SaveLayoutOptions()
    options.gds2_write_timestamps = False
    layout.write(str(GDS), options)
    manifest = json.loads(MANIFEST.read_text())
    digest = hashlib.sha256(GDS.read_bytes()).hexdigest()
    manifest['files']['sram512.gds'] = {'bytes': GDS.stat().st_size, 'sha256': digest}
    previews = export_previews(GDS, GDS.parent)
    pins = pin_figure(GDS, GDS.parent)
    manifest['previews']['layout'] = previews['layout']
    manifest['figures']['pins'] = pins
    for name in ('sram512_layout.png', 'sram512_pins.png'):
        path = GDS.parent / name
        manifest['files'][name] = {
            'bytes': path.stat().st_size,
            'sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
        }
        target = ROOT / 'build/sram512/submission' / name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
    manifest['silicon_art'] = {
        'cell': CELL, 'layer': list(LAYER), 'words_and_bboxes_um': spans,
        'orientation_degrees': 90, 'pixel_um': 5,
        'minimum_existing_m2_clearance_um': 3,
        'submitted_gds_sha256': digest,
    }
    manifest['submission_repair'] = {
        'cell': 'pcell_core', 'removed_layer': [235, 0],
        'removed_shapes': int(removed_marker),
        'restored_pmos_origins_dbu': ([[6_000, 20_400], [12_000, 20_400]]
                                       if old_points == shifted_points else []),
        'reason': 'Restore the verified source bitcell geometry where the submitted GDS had a stray polygon and shifted PMOS instances.',
    }
    archive = ROOT / 'build/sram512/submission' / f'sram512_submission_{digest[:12]}.zip'
    archive.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(archive, 'w', zipfile.ZIP_DEFLATED) as bundle:
        for name in sorted(manifest['files']):
            bundle.write(ROOT / 'submission' / name, 'submission/' + name)
    manifest['archive'] = {
        'path': str(archive.relative_to(ROOT)),
        'sha256': hashlib.sha256(archive.read_bytes()).hexdigest(),
        'bytes': archive.stat().st_size,
    }
    MANIFEST.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + '\n')
    print(f'{GDS}: {digest}')
    print(spans)


if __name__ == '__main__':
    main()
