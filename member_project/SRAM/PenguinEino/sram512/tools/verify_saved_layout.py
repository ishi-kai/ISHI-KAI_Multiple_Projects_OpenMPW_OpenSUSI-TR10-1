#!/usr/bin/env python3
"""Recheck the saved GDS against the current Xschem source and original PDK."""
import shutil
from common import *
from geometry_audit import audit
from manufacturing import verify as mask_verify


def compare_saved_mask(manufacturing):
    """GDS timestamps may differ; compare every layer of the delivered mask."""
    saved = HERE / 'layout/sram512_mask.gds'
    generated = Path(manufacturing['source']) / 'manufacturing/sram512_mask.gds'
    assert sha(generated) == manufacturing['mask_sha256']
    layouts = [db.Layout(), db.Layout()]
    for layout,path in zip(layouts, (saved, generated)):
        layout.read(str(path))
    assert layouts[0].dbu == layouts[1].dbu
    tops = [layout.cell('sram512_macro') for layout in layouts]
    assert all(top is not None for top in tops)
    specs = sorted({(li.layer, li.datatype) for layout in layouts for li in layout.layer_infos()})
    layers = []
    for spec in specs:
        regions = [db.Region(top.begin_shapes_rec(layout.layer(*spec)))
                   for layout,top in zip(layouts,tops)]
        if all(r.is_empty() for r in regions):
            continue
        difference = regions[0] ^ regions[1]
        layers.append(dict(layer=list(spec), passed=difference.is_empty(),
                           difference_area_um2=difference.area() * layouts[0].dbu**2))
    return dict(passed=bool(layers) and all(r['passed'] for r in layers),
        saved_mask_sha256=sha(saved), regenerated_mask_sha256=sha(generated), layers=layers,
        scope='All polygon layers of the delivered mask equal the newly generated, fully DRC-checked mask. GDS timestamps and non-mask text are not polygons.')


def main():
    source=HERE/'layout';work=WORK/'layout/rechecked16x32'
    work.mkdir(parents=True,exist_ok=True)
    for name in ('sram512.gds','placement.json','ports.json','array_geometry.json','coordinate_frames.json'):
        shutil.copy2(source/name,work/name)
    generated=netlist(ROOT/'sram512/schematics/sram512_macro.sch',work/'schematic',lvs=True)
    text=generated.read_text()
    text=re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',r'M\1\2',text)
    reference=work/'reference.spice';reference.write_text(text)
    result=verify_layout(work/'sram512.gds','sram512_macro',reference,work/'checks')
    assert all(result[k]['passed'] for k in ('drc','lvs')),result
    result['geometry']=audit(work,require_origin=True)
    result['manufacturing']=mask_verify(work)
    result['saved_mask_comparison']=compare_saved_mask(result['manufacturing'])
    result['passed']=result['manufacturing']['passed'] and result['saved_mask_comparison']['passed']
    result['scope']='Saved layout independently checked against the current editable Xschem hierarchy and unmodified dev decks.'
    write_json(REPORTS/'saved_layout_recheck.json',result)
    print(result['passed'],result['gds_sha256'],flush=True)
    return result


if __name__=='__main__':
    raise SystemExit(0 if main()['passed'] else 1)
