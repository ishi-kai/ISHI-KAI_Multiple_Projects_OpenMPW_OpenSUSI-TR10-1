#!/usr/bin/env python3
"""Compact the T1b-inspired shared-source candidate; MOS W/L unchanged.
Apostolidis et al. 2016, Fig. 2/3/8: topology and array-sharing comparison.
All dimensions are um. Original candidate remains untouched.
"""
from pathlib import Path
import importlib.util,json,sys
import klayout.db as db
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
spec=importlib.util.spec_from_file_location('dense_build',HERE.parent/'dense_sram/build.py')
dense=importlib.util.module_from_spec(spec);spec.loader.exec_module(dense)
Drawing=dense.Drawing
T=.2
H=29.6

def euler(layout):
    c=layout.create_cell('compact_core');d=Drawing(layout,c)
    X=22.4-2*T
    d.box('WN',-3.5,11.7,X+3.5,29.1)
    d.box('AN',-.9+T,-1.7,20.1-T,1.7)
    d.box('AP',3.5,18.7,15.7,22.1)
    for x in (.4+T,4.8,9.6,14.4,18.8-T):d.contact(x,0)
    for x in (4.8,9.6,14.4):d.contact(x,20.4)
    d.box('GC',11.5,-2.9,12.5,23.3)
    d.wire('GC',[(7.2,-2.4),(7.2,5.1),(6.8-T,5.1),(6.8-T,17.4),(7.2,17.4),(7.2,22.8)],1)
    for x in (2.4+T,16.8-T):d.box('GC',x-.5,-5.1,x+.5,2.9)
    d.box('GC',0,-5.1,X,-4.1)
    d.box('M2',0,-4.5,X,-1.5)
    for x,cx in ((T,.4+T),(19.2-T,18.8-T)):
        d.box('M1',x-.9,-5.7,x+.9,H-5.7)
        d.box('M1',min(x-.9,cx-1.3),-1.3,max(x+.9,cx+1.3),1.3)
    # Shared VSS between both pull-downs and shared VDD between both pull-ups.
    for cy,vy in ((0,2.7-T),(20.4,H-5.7)):
        d.wire('M1',[(9.6,cy),(9.6,vy)],1.8);d.via(9.6,vy)
        d.box('M2',0,vy-1.5,X,vy+1.5)
    # Drain paths stay in M1, with local detours around the opposite gate pads.
    d.wire('M1',[(4.8,0),(4.8,5),(4+T,5),(4+T,11),(3.2+T,11),(3.2+T,20.4),(4.8,20.4)],1.8)
    d.wire('M1',[(14.4,0),(14.4,3.6),(16-T,3.6),(16-T,11.0),(15.2-T,11.0),(15.2-T,17.8),(14.4,17.8),(14.4,20.4)],1.8)
    # Two short horizontal M2 crossings. Gate contact offsets respect V1/GC.
    for nx,vy,gx,gy,px in ((4+T,8.1-T,12.4-T,7.4,12),(15.2-T,13.5-T,6.8+T,16.4,6.8-T)):
        vx=9.2-T if nx==4+T else 9.6
        d.via(nx,vy);d.via(vx,vy)
        d.wire('M2',[(nx,vy),(vx,vy)],3.4)
        d.wire('GC',[(px,gy),(gx,gy)],1)
        d.contact(gx,gy,'GC')
        d.wire('M1',[(vx,vy),(vx,gy),(gx,gy)],1.8)
    # Close sub-rule notches separately within each already connected M1 polygon.
    # DRC and LVS run on the resulting saved geometry, with no rule exclusions.
    li=layout.layer(13,0)
    fixed=db.Region()
    for p in db.Region(c.shapes(li)).merged().each():
        amount=round(.7/layout.dbu)
        fixed.insert(db.Region(p).sized(amount).sized(-amount))
    c.shapes(li).clear();c.shapes(li).insert(fixed)
    return c


def euler_array(l,core,rows,cols,interval=16,gap=21.2,shared=True,prefix="compact"):
    X=22.4-2*T
    top=l.create_cell(f'{prefix}_{rows}x{cols}');d=Drawing(l,top)
    def cx(c):return c*X+(c//interval)*gap
    width=cx(cols-1)+X
    for r in range(rows):
        ty=r*H+5.7 if not r%2 else (r+1)*H-5.7
        for c in range(cols):
            top.insert(db.CellInstArray(core.cell_index(),db.Trans(db.Trans.M0 if r%2 else db.Trans.R0,round(cx(c)/l.dbu),round(ty/l.dbu))))
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
    vs=[(r*H+8.4-T if not r%2 else (r+1)*H-8.4+T) for r in range(rows)]
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
                if active=='AN':d.box('WN',bx-12 if side<0 else 0,y-(H-17.4),width+12,y+(H-17.4))
                d.contact(tap,y,active)
                vx=bx+side*8.8
                d.via(vx,y)
                d.box('M1',min(vx,tap)-1.7,y-1.7,max(vx,tap)+1.7,y+1.7)
                d.box('M2',min(spine,0)-1.7,y-1.5,max(width,spine)+1.7,y+1.5)
                d.via(spine,y)
            d.box('M1',spine-.9,min(vd+vs)-1.7,spine+.9,max(vd+vs)+1.7)
    d.label('M1','VDD',-14.4,vd[0]);d.label('M1','VSS',-19.8,vs[0])
    for c in range(cols):
        d.label('M1',f'BL{c}',cx(c)+T,5.7)
        d.label('M1',f'BLB{c}',cx(c)+19.2-T,5.7)
    if rows==cols==1:
        d.label('M1','Q',4+T,13.8-T);d.label('M1','QB',15.2-T,19.2-T)
    return top


def reference(name,rows,cols):
    text=dense.reference(name,rows,cols)
    if '_probe_' in name:
        for r in range(rows):
            for c in range(cols):
                for q in ('Q','QB'):text=text.replace(f'{q}_{r}_{c}',f'{q}{r}{c}')
        lines=text.splitlines();lines[1]+=' '+' '.join(f'{q}{r}{c}' for r in range(rows) for c in range(cols) for q in ('Q','QB'))
        text='\n'.join(lines)+'\n'
    return text


def add_probe(l):
    original=l.cell('compact_2x2');top=l.create_cell('compact_probe_2x2')
    top.insert(db.CellInstArray(original.cell_index(),db.Trans()));d=Drawing(l,top)
    for li in (l.layer(48,0),l.layer(49,0)):
        for shape in original.shapes(li).each():
            if shape.is_text():top.shapes(li).insert(shape.text)
    for r in range(2):
        ty=5.7 if r==0 else 2*H-5.7
        for c in range(2):
            for q,x,y in [('Q',4+T,8.1-T),('QB',15.2-T,13.5-T)]:
                d.label('M1',f'{q}{r}{c}',c*(22.4-2*T)+x,ty+(-y if r else y))
    return top


def main():
    l=db.Layout();l.dbu=.1;c=euler(l);dims={}
    out=ROOT/'build/sram_compact';out.mkdir(parents=True,exist_ok=True)
    shapes=[(16,r,n) for r,n in ((1,1),(2,2),(4,4),(4,17),(8,8),(16,16),(16,32),(16,64),(20,76))]
    shapes += [(8,r,n) for r,n in ((4,17),(16,16),(16,32))]
    for interval,r,n in shapes:
        top=euler_array(l,c,r,n,interval=interval,prefix='compact' if interval==16 else 'compact_strap8');b=top.dbbox()
        dims[top.name]=dict(bits=r*n,rows=r,columns=n,strap_interval=interval,
                            width_um=round(b.width(),1),height_um=round(b.height(),1),area_um2=round(b.area(),2))
        (out/(top.name+'.spice')).write_text(reference(top.name,r,n))
    top=add_probe(l);(out/(top.name+'.spice')).write_text(reference(top.name,2,2))
    l.write(str(HERE/'compact.gds'))
    (HERE/'dimensions.json').write_text(json.dumps(dict(pitch_um=[22.4-2*T,H],area_per_bit_um2=(22.4-2*T)*H,arrays=dims),indent=2)+'\n')
    print(json.dumps(dims,indent=2))


if __name__=='__main__':main()
