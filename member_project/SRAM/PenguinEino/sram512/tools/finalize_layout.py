#!/usr/bin/env python3
"""Complete real same-net junctions, then check the immutable drawing.

These local fills close notches or widen overlaps between native cell metal
and routed metal. They require strict LVS correspondence before insertion,
and keep the original deck's spacing from every other extracted net.
"""
import shutil
from common import *


def finish():
    source = WORK / 'layout/rectangular_manual_channels'
    work = WORK / 'layout/rectangular_final_drawing'
    work.mkdir(parents=True, exist_ok=True)
    previous = json.loads((source / 'checks/result.json').read_text())
    assert previous['lvs']['passed']
    assert previous['gds_sha256'] == sha(source / 'sram512.gds')
    layout = db.Layout()
    layout.read(str(source / 'sram512.gds'))
    top = layout.cell('sram512_macro')
    core = layout.cell('sram512')
    extracted = db.LayoutVsSchematic()
    extracted.read(str(source / 'checks/sram512_macro.lvsdb'))
    circuit = extracted.netlist().circuit_by_name('sram512')
    fills = [
        ('CA1', (13, 0), (1327.65, 65.4, 1328.4, 65.85)),
        ('CA1', (20, 0), (1327.15, 64.3, 1328.4, 67.7)),
        ('VSS', (20, 0), (1032.3, 300.8, 1035.7, 305.3)),
        ('PD_YB', (20, 0), (1288.7, 69.8, 1293.55, 75.3)),
        ('RESET', (20, 0), (1436.55, 69.8, 1439.55, 75.95)),
    ]
    regions = {}
    reports = []
    for name, spec, box in fills:
        if spec not in regions:
            actual = db.Region(core.begin_shapes_rec(layout.layer(*spec)))
            index = next(i for i in extracted.layer_indexes()
                         if (extracted.layer_by_index(i) ^ actual).is_empty())
            regions[spec] = actual, index
        actual, index = regions[spec]
        own = extracted.polygons_of_net(circuit.net_by_name(name), index, True)
        pad = db.Region(db.DBox(*box).to_itype(layout.dbu))
        assert not (pad & own).is_empty(), name
        spacing = 1400 if spec == (13, 0) else 2000
        assert (pad.sized(spacing) & (actual - own)).is_empty(), (name, box)
        core.shapes(layout.layer(*spec)).insert(pad)
        reports.append(dict(net=name, layer=list(spec), box_um=list(box)))
    for name in ('placement.json', 'ports.json', 'array_geometry.json', 'reference.spice'):
        shutil.copy2(source / name, work / name)
    gds = work / 'sram512.gds'
    top.write(str(gds))
    result = verify_layout(gds, top.name, work / 'reference.spice', work / 'checks')
    box = top.dbbox()
    result.update(source_gds_sha256=previous['gds_sha256'], fills=reports,
                  dimensions_um=[box.width(), box.height()],
                  bbox_um=[box.left, box.bottom, box.right, box.top])
    write_json(work / 'result.json', result)
    print(result['drc'], result['lvs'], result['dimensions_um'], flush=True)
    return result


if __name__ == '__main__':
    result = finish()
    raise SystemExit(0 if all(result[k]['passed'] for k in ('drc', 'lvs')) else 1)
