#!/usr/bin/env python3
"""TR-1um research candidates; all distances in um, minimum MOS W/L=3.4/1."""
from pathlib import Path
import sys
import json
import klayout.db as db
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
import build as baseline
Drawing=baseline.Drawing

def euler(layout):
    c=layout.create_cell('euler');d=Drawing(layout,c)
    X=23.2
    d.box('WN',-3.5,11.7,X+3.5,29.1)
    d.box('AN',-1.3,-1.7,20.5,1.7)
    d.box('AP',3.5,18.7,15.7,22.1)
    for x in (0,4.8,9.6,14.4,19.2):d.contact(x,0)
    for x in (4.8,9.6,14.4):d.contact(x,20.4)
    for x in (7.2,12):d.box('GC',x-.5,-2.9,x+.5,23.3)
    for x in (2.4,16.8):d.box('GC',x-.5,-5.1,x+.5,2.9)
    d.box('GC',0,-5.1,X,-4.1)
    d.box('M2',0,-4.5,X,-1.5)
    for x,cx in ((-.4,0),(19.6,19.2)):
        d.box('M1',x-.9,-5.7,x+.9,23.9)
        d.box('M1',min(x-.9,cx-1.3),-1.3,max(x+.9,cx+1.3),1.3)
    # Shared VSS between both pull-downs and shared VDD between both pull-ups.
    for cy,vy in ((0,3.0),(20.4,23.9)):
        d.wire('M1',[(9.6,cy),(9.6,vy)],1.8);d.via(9.6,vy)
        d.box('M2',0,vy-1.5,X,vy+1.5)
    # Drain paths stay in M1, with local detours around the opposite gate pads.
    d.wire('M1',[(4.8,0),(4.8,5),(4,5),(4,11),(2.8,11),(2.8,20.4),(4.8,20.4)],1.8)
    d.wire('M1',[(14.4,0),(14.4,3.6),(16.4,3.6),(16.4,11.0),(15.2,11.0),(15.2,17.8),(14.4,17.8),(14.4,20.4)],1.8)
    # Two short horizontal M2 crossings. Gate contact offsets respect V1/GC.
    for nx,vy,gx,gy,px in ((4,8.4,12.8,7.4,12),(15.2,13.8,6.4,16.4,7.2)):
        d.via(nx,vy);d.via(9.6,vy)
        d.wire('M2',[(nx,vy),(9.6,vy)],3.4)
        d.wire('GC',[(px,gy),(gx,gy)],1)
        d.contact(gx,gy,'GC')
        d.wire('M1',[(9.6,vy),(9.6,gy),(gx,gy)],1.8)
    # Close sub-rule notches separately within each already connected M1 polygon.
    # DRC and LVS run on the resulting saved geometry, with no rule exclusions.
    li=layout.layer(13,0)
    fixed=db.Region()
    for p in db.Region(c.shapes(li)).merged().each():
        amount=round(.7/layout.dbu)
        fixed.insert(db.Region(p).sized(amount).sized(-amount))
    c.shapes(li).clear();c.shapes(li).insert(fixed)
    return c


def euler_array(l,core,rows,cols,interval=16,gap=39.6,shared=False):
    X,H=23.2,29.6
    prefix='euler_shared' if shared else 'euler'
    top=l.create_cell(f'{prefix}_{rows}x{cols}');d=Drawing(l,top)
    def cx(c):return c*X+(c//interval)*gap
    width=cx(cols-1)+X
    for r in range(rows):
        ty=r*H+5.7 if not r%2 else (r+1)*H-5.7
        for c in range(cols):
            top.insert(db.CellInstArray(core.cell_index(),db.Trans(db.Trans.M0 if r%2 else db.Trans.R0,round(cx(c)*10),round(ty*10))))
        sign=-1 if r%2 else 1
        py=ty+sign*(-4.6)
        cy=ty+sign*(-3.7)
        y=ty+sign*(-3.0)
        d.box('M2',-9.6,y-1.5,width+9.6,y+1.5)
        for first in range(0,cols,interval):
            x=cx(first)
            d.box('GC',x-6.4,py-.5,x,py+.5)
            d.wire('GC',[(x-6.4,py),(x-6.4,cy)],1)
            d.contact(x-6.4,cy,'GC');d.via(x-9.6,y)
            d.box('M1',x-11.3,min(y-1.7,cy-1.3),x-5.1,max(y+1.7,cy+1.3))
        d.label('M2',f'WL{r}',-9.6,y)
    vd=sorted({(r//2*2+1)*H for r in range(rows)})
    vs=[(r*H+8.7 if not r%2 else (r+1)*H-8.7) for r in range(rows)]
    # Separate edge columns contain real body contacts and M1 vertical supplies.
    edges=[]
    for first in range(0,cols,interval):
        edges.append((-1,cx(first)))
        if not shared or first+interval>=cols:
            edges.append((1,cx(min(first+interval,cols)-1)+X))
    for side,bx in edges:
        tap=bx+side*5.6
        supply=bx+side*14.4;ground=bx+side*19.8
        for ys,active,spine in ((vd,'AN',supply),(vs,'AP',ground)):
            for y in ys:
                if active=='AN':d.box('WN',bx-12 if side<0 else 0,y-12.2,width+12,y+12.2)
                d.contact(tap,y,active)
                vx=bx+side*8.8
                d.via(vx,y)
                d.box('M1',min(vx,tap)-1.7,y-1.7,max(vx,tap)+1.7,y+1.7)
                d.box('M2',min(spine,0)-1.7,y-1.5,max(width,spine)+1.7,y+1.5)
                d.via(spine,y)
            d.box('M1',spine-.9,min(vd+vs)-1.7,spine+.9,max(vd+vs)+1.7)
    d.label('M1','VDD',-14.4,vd[0]);d.label('M1','VSS',-19.8,vs[0])
    for c in range(cols):
        d.label('M1',f'BL{c}',cx(c)-.4,5.7)
        d.label('M1',f'BLB{c}',cx(c)+19.6,5.7)
    if rows==cols==1:
        d.label('M1','Q',4,14.1);d.label('M1','QB',15.2,19.5)
    return top


def make_euler(out,shapes=((1,1),(2,2),(4,4),(8,8),(16,64)),shared=False):
    l=db.Layout();l.dbu=.1;c=euler(l);dims={}
    for r,n in shapes:
        top=euler_array(l,c,r,n,gap=21.2 if shared else 39.6,shared=shared);b=top.dbbox()
        dims[top.name]={'width_um':round(b.width(),1),'height_um':round(b.height(),1),'bits':r*n}
    prefix='euler_shared' if shared else 'euler'
    if shared:
        add_probe(l,l.cell('euler_shared_2x2'),True)
    l.write(str(out/(prefix+'.gds')))
    report={'pitch_x_um':23.2,'pitch_y_um':29.6,'area_per_bit_um2':686.72,'tap_interval_columns':16,
            'tap_gap_um':21.2 if shared else 39.6,
            'shared_tap_columns':shared,'footprints':dims}
    (out/(prefix+'_dimensions.json')).write_text(json.dumps(report,indent=2)+'\n')
    return report


def add_probe(l,original,euler_design):
    """Add only probe text; electrical polygons are inherited without changes."""
    top=l.create_cell(('euler_shared' if euler_design else 'baseline')+'_probe_2x2')
    top.insert(db.CellInstArray(original.cell_index(),db.Trans()))
    d=Drawing(l,top)
    # Strict-port LVS requires I/O labels on the probe top, not only its child.
    for layer in (l.layer(48,0),l.layer(49,0)):
        for shape in original.shapes(layer).each():
            if shape.is_text():top.shapes(layer).insert(shape.text)
    for r in range(2):
        ty=(5.7 if r==0 else 53.5) if euler_design else (0 if r==0 else 68)
        for c in range(2):
            for name,x,y in (('Q',4,8.4),('QB',15.2,13.8)) if euler_design else (('Q',8.1,10),('QB',13.5,10)):
                d.label('M1' if euler_design else 'M2',f'{name}{r}{c}',
                        c*(23.2 if euler_design else 21.2)+x,ty+(-y if r else y))
    return top


def make_baseline(out):
    l=db.Layout();l.read(str(HERE.parent/'dense_sram/sram_dense.gds'))
    top=baseline.array(l,l.cell('sram_dense'),17,78)
    add_probe(l,l.cell('sram_dense_2x2'),False)
    l.write(str(out/'baseline_fit.gds'))
    b=top.dbbox()
    return {'top':top.name,'bits':1326,'width_um':round(b.width(),1),'height_um':round(b.height(),1)}


def main():
    reports={}
    reports['euler']=make_euler(HERE,((1,1),(2,2),(4,4),(4,17),(8,8),(16,64),(20,68)))
    reports['euler_shared']=make_euler(HERE,((1,1),(2,2),(4,4),(4,17),(8,8),(16,64),(20,72)),True)
    reports['baseline_fit']=make_baseline(HERE)
    print(json.dumps(reports,indent=2))


if __name__=='__main__':
    main()
