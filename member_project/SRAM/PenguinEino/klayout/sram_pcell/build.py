#!/usr/bin/env python3
"""6T SRAM made from unmodified TR-1um library PCells and parent routing."""
from pathlib import Path
import argparse, hashlib, importlib.util, json, sys
import klayout.db as db
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(ROOT/'scripts'))
from pdk_profiles import pdk_path
PDK=pdk_path()
sys.path.insert(0,str(PDK/'libs.tech/klayout/tech/python'))
from cells import tr_1um
LIBRARY=tr_1um('TR-1um')
spec=importlib.util.spec_from_file_location('dense_pcell_ref',HERE.parent/'dense_sram/build.py')
dense=importlib.util.module_from_spec(spec);spec.loader.exec_module(dense)

class Drawing(dense.Drawing):
    def pcell(self,name,x,y,parameters=None,rotation=0):
        c=self.layout.create_cell(name,'TR-1um',parameters or {})
        assert c is not None and c.is_pcell_variant(),name
        self.cell.insert(db.CellInstArray(c.cell_index(),db.Trans(rotation,False,
            round(x/self.layout.dbu),round(y/self.layout.dbu))))
        return c
    def contact(self,x,y,active=None):
        assert active in ('GC','AP','AN'),active
        return self.pcell({'GC':'cont_g','AP':'cont_p','AN':'cont_n'}[active],x,y)
    def via(self,x,y):return self.pcell('via_1',x,y)

def mos(d,kind,n,x,y):
    return d.pcell(kind,x,y,dict(w=3.4,l=1.0,n=n,cont_between_gates=True,y0='c'))

def fill_metal_notches(l,c):
    li=l.layer(13,0);reg=db.Region(c.begin_shapes_rec(li)).merged();add=db.Region()
    for p in reg.each():
        one=db.Region(p)
        add+=one.sized(round(.7/l.dbu)).sized(-round(.7/l.dbu))-one
    c.shapes(li).insert(add)  # additions only, to parent routing

def bitcell(l,X=22,H=29.6,separation=2.0,family='split'):
    c=l.create_cell('pcell_core');d=Drawing(l,c);py=20.4
    # split: contacts 0,4,8 and 10,14,18. Overlap only on the common
    # VSS/VDD diffusion; both original contact cuts are retained.
    if family in ('split','six_single'):
        if family=='split':
            mos(d,'fet_n',2,4,0);mos(d,'fet_n',2,12+separation,0)
        else:
            for gx in (2,6,10+separation,14+separation):mos(d,'fet_n',1,gx,0)
        mos(d,'fet_p',1,6,py);mos(d,'fet_p',1,10+separation,py)
        right=16+separation;ng=(6,10+separation);middle=8+separation/2
    elif family=='single_strip':
        mos(d,'fet_n',4,8,0);mos(d,'fet_p',2,8,py)
        right=16;ng=(6,10);middle=8
    else:raise ValueError(family)
    d.box('WN',-3.5,11.7,X+3.5,29.1)
    for gx in ng:d.box('GC',gx-.5,2.4,gx+.5,py-2.4)
    for gx in (2,right-2):d.box('GC',gx-.5,-5.1,gx+.5,-2.4)
    d.box('GC',0,-5.1,X,-4.1);d.box('M2',0,-4.5,X,-1.5)
    for x in (-.4,right+.4):d.box('M1',x-.9,-5.7,x+.9,H-5.7)
    for cy,vy in ((0,3),(py,H-5.7)):
        d.wire('M1',[(middle,cy),(middle,vy)],1.8);d.via(middle,vy)
        d.box('M2',0,vy-1.5,X,vy+1.5)
    # Keep the two feedback crossings in M2, with offset gate contacts.
    d.wire('M1',[(4,0),(4,5),(3.6,5),(3.6,11),(2.8,11),(2.8,py),(4,py)],1.8)
    qr=right-4
    d.wire('M1',[(qr,0),(qr,3.6),(15.2,3.6),(15.2,11),(14.4,11),
                 (14.4,17.8),(qr,17.8),(qr,py)],1.8)
    for nx,vy,vx,gx,gy,gate in ((3.6,8.4,8.4,11.6,7.4,ng[1]),
                              (14.4,13.8,9.6,6.4,16.4,ng[0])):
        d.via(nx,vy);d.via(vx,vy)
        d.wire('M2',[(nx,vy),(vx,vy)],3.4)
        d.wire('GC',[(gate,gy),(gx,gy)],1)
        d.contact(gx,gy,'GC')
        d.wire('M1',[(vx,vy),(vx,gy),(gx,gy)],1.8)
    fill_metal_notches(l,c)
    return c

def array(l,core,rows,cols,X=22,H=29.6,interval=16,gap=21.2,probe=False,right=18):
    name=f'pcell_{"probe_" if probe else ""}{rows}x{cols}'
    top=l.create_cell(name);d=Drawing(l,top)
    cx=lambda col:col*X+(col//interval)*gap
    width=cx(cols-1)+X
    for r in range(rows):
        ty=r*H+5.7 if not r%2 else (r+1)*H-5.7
        sign=-1 if r%2 else 1
        for col in range(cols):
            top.insert(db.CellInstArray(core.cell_index(),db.Trans(db.Trans.M0 if r%2 else db.Trans.R0,
                round(cx(col)/l.dbu),round(ty/l.dbu))))
            if probe:
                for q,x,y in [('Q',3.6,8.4),('QB',14.4,13.8)]:
                    d.label('M1',f'{q}{r}{col}',cx(col)+x,ty+sign*y)
        py,cy,y=(ty+sign*a for a in (-4.6,-3.7,-3.0))
        d.box('M2',-9.6,y-1.5,width+9.6,y+1.5)
        for first in range(0,cols,interval):
            x=cx(first)
            d.box('GC',x-6.4,py-.5,x,py+.5)
            d.wire('GC',[(x-6.4,py),(x-6.4,cy)],1)
            d.contact(x-6.4,cy,'GC');d.via(x-9.6,y)
            d.box('M1',x-11.3,min(y-1.7,cy-1.3),x-5.1,max(y+1.7,cy+1.3))
        d.label('M2',f'WL{r}',-9.6,y)
    vd=sorted({(r//2*2+1)*H for r in range(rows)})
    vs=[r*H+8.7 if not r%2 else (r+1)*H-8.7 for r in range(rows)]
    edges=[(-1,cx(first)) for first in range(0,cols,interval)]+[(1,width)]
    for side,bx in edges:
        tap=bx+side*5.6;supply=bx+side*14.4;ground=bx+side*19.8
        for ys,active,spine in ((vd,'AN',supply),(vs,'AP',ground)):
            for y in ys:
                if active=='AN':d.box('WN',bx-12 if side<0 else 0,y-(H-17.4),width+12,y+(H-17.4))
                d.contact(tap,y,active);vx=bx+side*8.8;d.via(vx,y)
                d.box('M1',min(vx,tap)-1.7,y-1.7,max(vx,tap)+1.7,y+1.7)
                d.box('M2',min(spine,0)-1.7,y-1.5,max(width,spine)+1.7,y+1.5)
                d.via(spine,y)
            d.box('M1',spine-.9,min(vd+vs)-1.7,spine+.9,max(vd+vs)+1.7)
    d.label('M1','VDD',-14.4,vd[0]);d.label('M1','VSS',-19.8,vs[0])
    for col in range(cols):
        d.label('M1',f'BL{col}',cx(col)-.4,5.7)
        d.label('M1',f'BLB{col}',cx(col)+right+.4,5.7)
    if rows==cols==1:
        d.label('M1','Q',3.6,14.1);d.label('M1','QB',14.4,19.5)
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

def audit(layout):
    cells=[]
    for c in layout.each_cell():
        if c.is_pcell_variant():
            cells.append(dict(cell=c.name,library=c.pcell_library().name(),
                declaration=c.pcell_declaration().name(),parameters=c.pcell_parameters_by_name()))
    return cells

def make(out,X=22,H=29.6,separation=2.0,family='split',shapes=((1,1),(2,2),(4,4)),interval=16,probe=False):
    out=Path(out).resolve();out.mkdir(parents=True,exist_ok=True)
    l=db.Layout();l.dbu=.05;l.technology_name='TR-1um'
    c=bitcell(l,X,H,separation,family);dims={}
    for r,n in shapes:
        top=array(l,c,r,n,X,H,interval,probe=False,right=16+separation if family in ('split','six_single') else 16)
        box=top.dbbox();dims[top.name]=dict(rows=r,columns=n,bits=r*n,width_um=round(box.width(),4),height_um=round(box.height(),4),area_um2=round(box.area(),4))
        (out/(top.name+'.spice')).write_text(reference(top.name,r,n))
    if probe:
        top=array(l,c,2,2,X,H,interval,probe=True)
        (out/(top.name+'.spice')).write_text(reference(top.name,2,2))
    options=db.SaveLayoutOptions();options.gds2_write_cell_properties=True;options.gds2_write_file_properties=True
    source=out/'pcell.gds';l.write(str(source),options)
    info=dict(family=family,pitch_um=[X,H],area_per_bit_um2=round(X*H,4),
              shared_contact_separation_um=separation,tap_interval=interval,arrays=dims,
              pcell_variants=audit(l),gds_sha256=hashlib.sha256(source.read_bytes()).hexdigest())
    (out/'dimensions.json').write_text(json.dumps(info,indent=2)+'\n')
    print(f'{family}: {X} x {H}, {X*H:.2f} um2/bit, saved {source}',flush=True)
    return info

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--out',type=Path,default=ROOT/'build/sram_pcell/tr_split')
    p.add_argument('--width',type=float,default=22);p.add_argument('--height',type=float,default=29.6)
    p.add_argument('--separation',type=float,default=2);p.add_argument('--family',default='split')
    a=p.parse_args();make(a.out,a.width,a.height,a.separation,a.family)
