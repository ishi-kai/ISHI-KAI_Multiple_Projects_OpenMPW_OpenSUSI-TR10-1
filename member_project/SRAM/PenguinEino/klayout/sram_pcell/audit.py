#!/usr/bin/env python3
"""Check saved geometry before loading the PCell library, then check round trip.

Run in a fresh Python process: registering the library before reading the GDS
could regenerate variants and conceal a change to the stored geometry.
"""
from pathlib import Path
from collections import Counter
import hashlib,json,re
import klayout.db as db

HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]

def regions(layout,cell):
    return {(layout.get_info(i).layer,layout.get_info(i).datatype):
            db.Region(cell.begin_shapes_rec(i)).merged() for i in layout.layer_indexes()}

def main():
    metadata=json.loads((HERE/'dimensions.json').read_text())
    source=HERE/'pcell.gds';digest=hashlib.sha256(source.read_bytes()).hexdigest()
    assert digest==metadata['gds_sha256']
    static=db.Layout();static.read(str(source))
    assert not any(c.is_pcell_variant() for c in static.each_cell()), 'Run in a fresh process'
    # Copy the saved polygons before making the library available.
    saved={v['cell']:regions(static,static.cell(v['cell'])) for v in metadata['pcell_variants']}
    core=static.cell('pcell_core');layers=regions(static,core)
    count=Counter(i.cell.name for i in core.each_inst() if i.cell.name in ('fet_n','fet_p'))
    assert count=={'fet_n':4,'fet_p':2},count
    parent_active=sum(db.Region(core.shapes(static.find_layer(*key))).area()
                      for key in ((3,1),(3,2)))
    assert parent_active==0
    expected_gates=db.Region()
    for inst in core.each_inst():
        if inst.cell.name not in ('fet_n','fet_p'):continue
        own=saved[inst.cell.name]
        expected_gates+=((own[(3,1)]+own[(3,2)]) & own[(8,1)]).transformed(inst.trans)
    actual_gates=(layers[(3,1)]+layers[(3,2)]) & layers[(8,1)]
    assert (actual_gates ^ expected_gates).is_empty(), 'Parent routing changes a MOS gate'

    # Only now import and register the installed, unmodified TR-1um PCells.
    from build import audit,PDK
    fresh=db.Layout();fresh.dbu=static.dbu;fresh.technology_name='TR-1um'
    comparisons=[]
    for v in metadata['pcell_variants']:
        generated=fresh.create_cell(v['declaration'],'TR-1um',v['parameters'])
        expected=regions(fresh,generated);stored=saved[v['cell']]
        differences={str(key):round((stored.get(key,db.Region()) ^ expected.get(key,db.Region())).area()*fresh.dbu**2,8)
                     for key in set(stored)|set(expected)}
        assert not any(differences.values()),(v,differences)
        comparisons.append(dict(**v,geometry_xor_um2=differences))
    restored=db.Layout();restored.technology_name='TR-1um';restored.read(str(source))
    restored_variants=audit(restored)
    assert sorted(restored_variants,key=lambda v:v['cell'])==sorted(metadata['pcell_variants'],key=lambda v:v['cell'])

    extracted=ROOT/'build/sram_pcell/final/pcell_1x1.extracted'
    mos=re.findall(r'(?m)^XM\S+ .*? (NMOS|PMOS) L=(\S+) W=(\S+)',extracted.read_text())
    assert Counter(mos)=={('NMOS','1u','3.4u'):4,('PMOS','1u','3.4u'):2},mos
    pdk=PDK/'libs.tech/klayout/tech/python'
    source_paths=[p for p in pdk.rglob('*') if p.is_file() and '__pycache__' not in p.parts]
    result=dict(passed=True,gds_sha256=digest,dbu_um=static.dbu,
                stored_geometry_checked_before_library_registration=True,
                library='TR-1um',core_mos_instances=dict(count),parent_active_area_um2=0,
                gate_area_xor_um2=0,variants=comparisons,round_trip_parameters_match=True,
                extracted_mos_count=len(mos),extracted_sha256=hashlib.sha256(extracted.read_bytes()).hexdigest(),
                pdk_source_sha256={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(source_paths)})
    (HERE/'pcell_audit.json').write_text(json.dumps(result,indent=2)+'\n')
    print('PASS: six original MOS PCell instances, zero geometry XOR, unchanged gates, live PCell round trip')

if __name__=='__main__':main()
