"""Expose the existing full schematic's name at the submitted GDS top."""
from common import *


def geometry(layout, top):
    layers = {}
    for index in layout.layer_indexes():
        info = layout.get_info(index)
        texts = []
        iterator = top.begin_shapes_rec(index)
        while not iterator.at_end():
            shape = iterator.shape()
            if shape.is_text():
                texts.append(str(shape.text.transformed(iterator.trans())))
            iterator.next()
        layers[(info.layer, info.datatype)] = (
            db.Region(top.begin_shapes_rec(index)), sorted(texts))
    return layers


def export_layout(source, output):
    layout = db.Layout()
    layout.read(str(source))
    top = layout.cell('sram512_macro')
    core = layout.cell('sram512')
    assert top is not None and core is not None
    instances = list(top.each_inst())
    assert len(instances) == 1 and instances[0].cell_index == core.cell_index()
    assert [c.name for c in layout.top_cells()] == ['sram512_macro']
    before = geometry(layout, top)
    bounds = top.bbox()
    # Integrate just the coordinate/port wrapper. Keep every lower hierarchy,
    # polygon and label, including the wrapper's seven external port labels.
    core.name = 'sram512_original_core'
    top.flatten(1, True)
    top.name = 'sram512'
    options = db.SaveLayoutOptions()
    options.gds2_write_timestamps = False
    output = Path(output)
    output.parent.mkdir(parents=True, exist_ok=True)
    top.write(str(output), options)
    saved = db.Layout()
    saved.read(str(output))
    assert [c.name for c in saved.top_cells()] == ['sram512']
    assert saved.dbu == layout.dbu and saved.top_cell().bbox() == bounds
    after = geometry(saved, saved.top_cell())
    assert before.keys() == after.keys()
    checks = []
    for spec, (region, texts) in before.items():
        difference = region ^ after[spec][0]
        checks.append(dict(layer=list(spec), polygons_equal=difference.is_empty(),
                           texts_equal=texts == after[spec][1], text_count=len(texts)))
    assert all(c['polygons_equal'] and c['texts_equal'] for c in checks), checks
    return dict(passed=True, source_gds_sha256=sha(source), submitted_gds_sha256=sha(output),
                source_top='sram512_macro', submitted_top='sram512',
                change='Integrate only the outer coordinate/port wrapper; preserve all physical geometry and text.',
                bbox_um=str(saved.top_cell().dbbox()), layers=checks)
