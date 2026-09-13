#!/usr/bin/env python3
"""Compare the submitted bit-cell master with the user's original generator."""
from layout_analog import pc
from common import *


def verify(source):
    source=Path(source)
    actual=db.Layout();actual.read(str(source));a=actual.cell('pcell_core')
    assert a is not None
    reference=db.Layout();reference.dbu=.001;reference.technology_name='TR-1um'
    b=pc.bitcell(reference,family='six_single')
    assert actual.dbu==reference.dbu
    layers={(x.layer,x.datatype) for x in actual.layer_infos()}|{(x.layer,x.datatype) for x in reference.layer_infos()}
    rows=[]
    for spec in sorted(layers):
        ra=db.Region(a.begin_shapes_rec(actual.layer(*spec)))
        rb=db.Region(b.begin_shapes_rec(reference.layer(*spec)))
        if ra.is_empty() and rb.is_empty():continue
        difference=ra^rb
        rows.append(dict(layer=list(spec),difference_area_um2=difference.area()*actual.dbu**2,
                         passed=difference.is_empty()))
    result=dict(passed=bool(rows) and all(r['passed'] for r in rows),
        source_gds_sha256=sha(source),source_generator='klayout/sram_pcell/build.py',
        generator_sha256=sha(ROOT/'klayout/sram_pcell/build.py'),family='six_single',
        layers=rows,pdk=provenance('dev'),
        scope='Layer-by-layer geometry XOR of the submitted shared bit-cell master and a fresh call to the user PCell generator with the dev PDK. The separate geometry audit counts all 512 physical cells.')
    write_json(REPORTS/'pcell_preservation.json',result)
    print('PCell geometry preservation:',result['passed'],len(rows),'layers',flush=True)
    return result


if __name__=='__main__':
    raise SystemExit(0 if verify(HERE/'layout/sram512.gds')['passed'] else 1)
