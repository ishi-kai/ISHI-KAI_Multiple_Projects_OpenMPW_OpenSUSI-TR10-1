#!/usr/bin/env python3
"""Compare two array geometries under the same serial peripheral budgets.

This is block budgeting, not a placed/routed peripheral layout. The search is
restricted to binary row/column counts, a single array and two final-row lanes.
"""
from pathlib import Path
from collections import Counter
import importlib.util,json,sys,hashlib
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'sram_macro_study'))
import estimate_capacity as base


def footprint(variant,r,c):
    if variant=='euler_shared':
        return c*23.2+((c-1)//16)*21.2+43,r*29.6+(12.2 if r%2 else 0)
    # Even mirrored rows: exact expression measured against all saved tops.
    return c*52.6+3,66.3+(r//2-1)*32.6


def estimate(variant,r,c,u,strip):
    rb=(r-1).bit_length();cb=(c-1).bit_length()
    _,meta,groups=base.digital(rb,cb)
    row=Counter(groups['row_decoder']);col=Counter(groups['col_decoder'])
    row_final=Counter({('AND2_X1' if rb<=3 else 'AND3_X1'):r})
    # For <=3 column bits macro_model uses two inverters after its predecode.
    col_final=Counter({'AND2_X1':c}) if cb>=4 else Counter({'INV_X1':2*c})
    assert all(row[n]>=v for n,v in row_final.items())
    assert all(col[n]>=v for n,v in col_final.items())
    globalbom=Counter(groups['controller'])+(row-row_final)+(col-col_final)
    globalbom+=base.schematic_bom('write_control.sch');globalbom['BUF_X4']+=12
    packed=base.pack_rows(globalbom,u);aw,ah=footprint(variant,r,c)
    alternatives=[]
    for rot in (0,90):
        uw,uh=(aw+137.6,ah+strip) if rot==0 else (ah+strip,aw+137.6)
        w=max(uw,592.6);h=uh+packed['height_um']+100
        alternatives.append(dict(rotation_deg=rot,width_um=round(w,1),height_um=round(h,1),
                                 fits=w<=600+1e-6 and h<=1800+1e-6))
    floor=min(alternatives,key=lambda a:(not a['fits'],max(a['width_um']/600,a['height_um']/1800)))
    return dict(variant=variant,rows=r,columns=c,bits=r*c,utilization=u,column_strip_um=strip,
                array_width_um=round(aw,1),array_height_um=round(ah,1),array_area_um2=round(aw*ah,2),
                digital_abut_area_um2=base.area(globalbom+row_final+col_final),
                global_logic_rows=len(packed['rows']),global_logic_height_um=packed['height_um'],
                global_bom=dict(globalbom),row_final_bom=dict(row_final),column_final_bom=dict(col_final),
                controller=meta,floorplan=floor)


def main():
    dims=json.loads((HERE/'single_dimensions.json').read_text())['arrays']
    for name,d in dims.items():
        r,c=map(int,name.rsplit('_',1)[1].split('x'))
        if r%2:continue
        w,h=footprint('t4_singlewl',r,c)
        assert abs(w-d['width_um'])<1e-6 and abs(h-d['height_um'])<1e-6
    cases=[estimate(v,r,c,u,s) for v in ('euler_shared','t4_singlewl')
           for u,s in ((.65,150),(.75,120),(.85,120))
           for r in (4,8,16,32,64) for c in (4,8,16,32,64) if r*c<=2048]
    best=[]
    for v in ('euler_shared','t4_singlewl'):
        for u in (.65,.75,.85):
            fits=[a for a in cases if a['variant']==v and a['utilization']==u and a['floorplan']['fits']]
            best.append(max(fits,key=lambda a:(a['bits'],-a['floorplan']['height_um'])) if fits else None)
    report=dict(scope='Binary configurations; shared serial architecture; block estimates, no peripheral routing/pads/ESD.',
        assumptions=['Row final stage region 137.6 um, two lanes with pitch conversion (unrouted).',
                     'Column circuit depth 120/150 um, common analog region 120 x 60 um.',
                     'T4 has terminal body-tap rows only; extra tap rows, RC, IR drop, latch-up constraints unresolved.'],
        source_sha256={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in
                       [HERE/'build.py',Path(base.__file__),HERE.parent/'sram_macro_study/macro_model.py',
                        ROOT/'learning/schematics/sram_serial_controller.sch',ROOT/'sram512/schematics/write_control.sch']},
        best=best,cases=cases)
    (HERE/'capacity_comparison.json').write_text(json.dumps(report,indent=2)+'\n')
    for b in best:print(b['variant'],b['utilization'],b['bits'],b['rows'],b['columns'],b['floorplan'])


if __name__=='__main__':main()
