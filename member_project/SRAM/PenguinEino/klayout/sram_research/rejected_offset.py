#!/usr/bin/env python3
"""Rejected offset-via experiment: LVS matches, but DRC fails. Not for use."""
from pathlib import Path
import sys
import json
import klayout.db as db
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
import build as baseline
Drawing=baseline.Drawing

def offset_via(layout):
    c=layout.create_cell('sram_dense');d=Drawing(layout,c)
    H=31.6
    d.box('WN',-3.7,19.3,25.3,H+8.3)
    for x in (3.3,18.3):
        d.box('AN',x-1.7,-1.3,x+1.7,9.3)
        for y in (0,4,8):d.contact(x,y)
        for y in (2,6):d.box('GC',x-2.9,y-.5,x+2.9,y+.5)
    for x in (5,16.6):
        d.box('AP',x-1.7,26.3,x+1.7,H+1.3)
        for y in (27.6,H):d.contact(x,y)
        d.box('GC',x-2.9,29.1,x+2.9,30.1)
    for nx,inner,outer,px in ((3.3,6.4,1.6,5),(18.3,15.2,19.8,16.6)):
        d.wire('GC',[(nx,6),(inner,6),(inner,11.8),(outer,11.8),(outer,29.6),(px,29.6)],1)
    d.wire('GC',[(3.3,2),(18.3,2)],1)
    d.wire('GC',[(10.8,2),(10.8,14.2)],1)
    d.contact(10.8,14.2,'GC');d.box('M1',0,13.3,21.2,15.1)
    d.contact(10.8,H,'AN')
    for nx,bl,q,px in ((3.3,2.9,8.1,5),(18.3,18.7,13.5,16.6)):
        d.via(bl,-2.2)
        d.box('M1',min(nx-1.3,bl-1.7),-3.9,max(nx+1.3,bl+1.7),1.3)
        d.box('M2',bl-1.5,-3.9,bl+1.5,H)
        d.box('M2',bl-1.7,-3.9,bl+1.7,3.9)
        d.wire('M1',[(nx,4),(q,4),(q,3.4)],1.8);d.via(q,3.4)
        d.wire('M1',[(px,27.6),(q,27.6),(q,27.2)],1.8);d.via(q,27.2)
        d.wire('M2',[(q,3.4),(q,27.2)],3.4)
    for q,gx,y in ((13.5,1.6,18.6),(8.1,19.8,22.6)):
        d.via(q,y);d.contact(gx,y-.2,'GC')
        d.wire('M1',[(gx,y),(q,y)],1.8)
    d.box('M1',6.4,20.9,9.8,28.9)
    for y in (8,H):d.box('M1',0,y-.9,21.2,y+.9)
    return c

def make_offset(out,shapes=((1,1),(2,2),(4,4),(8,8),(16,64))):
    # Parameterize the proven bank generator's three local Y offsets.
    import inspect
    source=inspect.getsource(baseline.array).replace('16.6','14.2').replace('9.6','8.0').replace('13.1','12.3')
    env=dict(vars(baseline));env['PITCH_Y']=31.6
    exec(source,env)
    l=db.Layout();l.dbu=.1;c=offset_via(l)
    dimensions={}
    for rows,cols in shapes:
        top=env['array'](l,c,rows,cols);b=top.dbbox()
        dimensions[top.name]={'width_um':round(b.width(),1),'height_um':round(b.height(),1),'bits':rows*cols}
    out.mkdir(parents=True,exist_ok=True);l.write(str(out/'offset_via.gds'))
    report={'pitch_x_um':21.2,'pitch_y_um':31.6,'area_per_bit_um2':669.92,'footprints':dimensions}
    (out/'offset_via_dimensions.json').write_text(json.dumps(report,indent=2)+'\n')
    return report

if __name__=='__main__':
    print(json.dumps(make_offset(HERE),indent=2))
