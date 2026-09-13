#!/usr/bin/env python3
"""T4-inspired 6T: staggered PMOS strips inside the two NMOS columns.

Reference: Apostolidis et al. 2016, Fig. 2 and Fig. 5 (3-metal original).
The two implementations use M1/M2 only: dual WL rails, and a single WL
with mirrored rows and shared source vias.
All values are micrometres. Device W/L is 3.4/1 for fair comparison.
"""
from pathlib import Path
import importlib.util,json,sys
import klayout.db as db
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
spec=importlib.util.spec_from_file_location('dense_build',HERE.parent/'dense_sram/build.py')
dense=importlib.util.module_from_spec(spec);spec.loader.exec_module(dense)
Drawing=dense.Drawing
X,H=52.6,21.2
S,P=21.4,32.6


def close_notches(l,c,recursive=False):
    for layer,amount in [((13,0),.7),((8,1),.6)]:
        li=l.layer(*layer);out=db.Region()
        original=db.Region(c.begin_shapes_rec(li) if recursive else c.shapes(li)).merged()
        for polygon in original.each():
            a=round(amount/l.dbu);out.insert(db.Region(polygon).sized(a).sized(-a))
        if recursive:
            c.shapes(li).insert(out-original)
        else:
            c.shapes(li).clear();c.shapes(li).insert(out)


def core(l):
    c=l.create_cell('t4_core');d=Drawing(l,c)
    d.box('WN',11.7,-8.3,33.9,17.9)
    for x in (0,45.6):
        d.box('AN',x-1.7,-1.3,x+1.7,10.9)
        for y in (0,4.8,9.6):d.contact(x,y)
    for x,lo,hi in ((20.4,0,4.8),(25.2,4.8,9.6)):
        d.box('AP',x-1.7,lo-1.3,x+1.7,hi+1.3)
        for y in (lo,hi):d.contact(x,y)
    # Both cross-coupled inverter gate routes are straight, with a contact
    # beyond the opposite PMOS strip. No M2 cross-coupling is required.
    d.box('GC',-2.9,1.9,32.9,2.9)  # QB -> left PD / left PU
    d.box('GC',12.7,6.7,48.5,7.7)  # Q  -> right PU / right PD
    for gx,gy in ((14,7.2),(31.6,2.4)):d.contact(gx,gy,'GC')
    d.wire('M1',[(0,4.8),(20.4,4.8)],1.8)
    d.wire('M1',[(25.2,4.8),(45.6,4.8)],1.8)
    d.wire('M1',[(14,4.8),(14,7.2)],1.8)
    d.wire('M1',[(31.6,2.4),(31.6,4.8)],1.8)
    # Access gates reach two horizontal M1 rails. The two rails are joined
    # outside the bitline region, at the left end of each array row.
    for points in ([(0,7.2),(8,7.2),(8,10)],[(45.6,2.4),(37.6,2.4),(37.6,-.4)]):
        d.wire('GC',points,1)
        x,y=points[-1];d.contact(x,y,'GC')
    d.box('GC',-2.9,6.7,2.9,7.7)
    d.box('GC',42.7,1.9,48.5,2.9)
    for x,y,rail in ((8,10,13.8),(37.6,-.4,-4.2)):
        d.wire('M1',[(x,y),(x,rail)],1.8)
        d.box('M1',-2,rail-.9,X-2,rail+.9)
    # M2 vertical BL, VSS, VDD, VSS, BLB. Contacts are offset from vias.
    for cx,cy,vx in ((0,9.6,3.2),(45.6,0,42.4),(0,0,8.6),(45.6,9.6,37),
                     (20.4,0,22.8),(25.2,9.6,22.8)):
        d.wire('M1',[(cx,cy),(vx,cy)],1.8);d.via(vx,cy)
    for vx in (3.2,8.6,22.8,37,42.4):d.box('M2',vx-1.5,-5.1,vx+1.5,H-5.1)
    close_notches(l,c)
    return c


def single_core(l,shared=False):
    c=l.create_cell('t4_shared_via_core' if shared else 't4_single_core');d=Drawing(l,c)
    d.box('WN',11.7,-8.3,33.9,17.9)
    for x in (0,45.6):
        d.box('AN',x-1.7,-1.3,x+1.7,10.9)
        for y in (0,4.8,9.6):d.contact(x,y)
    for x,lo,hi in ((20.4,0,4.8),(25.2,4.8,9.6)):
        d.box('AP',x-1.7,lo-1.3,x+1.7,hi+1.3)
        for y in (lo,hi):d.contact(x,y)
    d.box('GC',-2.9,1.9,30.1,2.9)
    d.box('GC',15.5,6.7,48.5,7.7)
    for gx,gy in ((16.8,7.2),(28.8,2.4)):d.contact(gx,gy,'GC')
    d.wire('M1',[(0,4.8),(0,4),(20.4,4),(20.4,4.8)],1.8)
    d.wire('M1',[(25.2,4.8),(25.2,5.6),(45.6,5.6),(45.6,4.8)],1.8)
    d.wire('M1',[(16.8,4),(16.8,7.2)],1.8)
    d.wire('M1',[(28.8,2.4),(28.8,5.6)],1.8)
    for points in ([(-2.4,7.2),(8,7.2),(8,8.6)],[(48.0,2.4),(37.6,2.4),(37.6,-.4)]):
        d.wire('GC',points,1);x,y=points[-1];d.contact(x,y,'GC')
    # One M1 WL rail. A local M2 overpass gets the left access gate past Q.
    d.box('M1',-5,-4.9,X-5,-3.1)
    d.wire('M1',[(37.6,-.4),(37.6,-4)],1.8)
    d.wire('M1',[(8,8.6),(8,8),(11.2,8)],1.8);d.via(11.2,8)
    d.via(11.2,-2.9);d.wire('M1',[(11.2,-2.9),(11.2,-4)],1.8)
    d.wire('M2',[(11.2,-2.9),(11.2,8)],3.4)
    for cx,cy,vx in ((0,9.6,-2.6),(45.6,0,42.4),(0,0,5.8),(45.6,9.6,37),
                     (20.4,0,22.8),(25.2,9.6,22.8)):
        d.wire('M1',[(cx,cy),(vx,cy)],1.8)
        if not (shared and cy==9.6):d.via(vx,cy)
    close_notches(l,c)
    return c


def single_array(l,c,rows,cols,shared=None,S=S,P=P):
    top=l.create_cell(f't4_singlewl_{rows}x{cols}');d=Drawing(l,top)
    transforms=[]
    for r in range(rows):
        ty=(r//2)*P+(S if r%2 else 0);transforms.append(ty)
        for col in range(cols):
            instance_core=shared if shared is not None and (r%2 or r+1<rows) else c
            top.insert(db.CellInstArray(instance_core.cell_index(),db.Trans(db.Trans.M0 if r%2 else db.Trans.R0,
                        round(col*X/l.dbu),round(ty/l.dbu))))
            # Close only the known common-source diffusion between mirrored
            # rows: BL (left N), VSS (right N), VDD (right P).
            if r%2:
                if shared is not None:
                    for vx in (-2.6,22.8,37):d.via(col*X+vx,ty-S/2)
                for layer,x in [('AN',0),('AN',45.6),('AP',25.2)]:
                    d.box(layer,col*X+x-1.7,ty-S+9.6,col*X+x+1.7,ty-9.6)
        wl=ty+(4 if r%2 else -4)
        d.label('M1',f'WL{r}',0,wl)
    low=-15.4;highest=max(ty+(1.3 if r%2 else 10.9) for r,ty in enumerate(transforms))
    high=highest+14.1
    for col in range(cols):
        x=col*X
        d.box('WN',x+11.7,low-7,x+33.9,high+7)
        for y in (low,high):
            d.contact(x+22.8,y,'AN')
            d.wire('M1',[(x+22.8,y),(x+22.8,y+3.2)],1.8);d.via(x+22.8,y+3.2)
            for tx,vx in ((0,5.8),(45.6,37)):
                d.contact(x+tx,y-5.4,'AP')
                d.wire('M1',[(x+tx,y-5.4),(x+vx,y-5.4)],1.8);d.via(x+vx,y-5.4)
            d.box('M1',-4.9,y+2.3,cols*X-2,y+4.1)
            d.box('M1',-4.9,y-6.3,cols*X-2,y-4.5)
        for vx in (5.8,22.8,37):d.box('M2',x+vx-1.5,low-7.1,x+vx+1.5,high+4.9)
        for name,vx in [('BL',-2.6),('BLB',42.4)]:
            d.box('M2',x+vx-1.5,-5.1,x+vx+1.5,highest+1.7)
            d.label('M2',f'{name}{col}',x+vx,0)
    d.label('M1','VDD',0,low+3.2);d.label('M1','VSS',0,low-5.4)
    if rows==cols==1:
        d.label('M1','Q',16.8,4);d.label('M1','QB',28.8,5.6)
    close_notches(l,top,recursive=True)
    return top


def array(l,c,rows,cols):
    top=l.create_cell(f't4_dualwl_{rows}x{cols}');d=Drawing(l,top)
    for r in range(rows):
        for col in range(cols):
            top.insert(db.CellInstArray(c.cell_index(),db.Trans(round(col*X/l.dbu),round(r*H/l.dbu))))
        lo=r*H-4.2;hi=r*H+13.8
        for y,vy in ((lo,lo+1.1),(hi,hi-1.1)):
            d.wire('M1',[(-2,y),(-10,y),(-10,vy)],1.8);d.via(-10,vy)
        d.wire('M2',[(-10,lo+1.1),(-10,hi-1.1)],3.4)
        d.label('M1',f'WL{r}',-10,lo)
    # Terminal/tap rows physically join column power spines. Contacts are
    # placed within/outside each vertical well stripe as required.
    low=-15.4;high=(rows-1)*H+25.0
    for col in range(cols):
        x=col*X
        d.box('WN',x+11.7,low-7,x+33.9,high+7)
        for y in (low,high):
            d.contact(x+22.8,y,'AN')
            # Offset via in y; VDD rail is separated from the VSS rail below.
            d.wire('M1',[(x+22.8,y),(x+22.8,y+3.2)],1.8);d.via(x+22.8,y+3.2)
            for tx,vx in ((0,8.6),(45.6,37)):
                d.contact(x+tx,y-5.4,'AP')
                d.wire('M1',[(x+tx,y-5.4),(x+vx,y-5.4)],1.8);d.via(x+vx,y-5.4)
            d.box('M1',-1.7,y+2.3,cols*X-2,y+4.1)
            d.box('M1',-1.7,y-6.3,cols*X-2,y-4.5)
        for vx in (8.6,22.8,37):d.box('M2',x+vx-1.5,low-7.1,x+vx+1.5,high+4.9)
        for name,vx in [('BL',3.2),('BLB',42.4)]:d.label('M2',f'{name}{col}',x+vx,0)
    d.label('M1','VDD',0,low+3.2);d.label('M1','VSS',0,low-5.4)
    if rows==cols==1:
        d.label('M1','Q',14,4.8);d.label('M1','QB',31.6,4.8)
    close_notches(l,top)
    return top


def add_probe(l,original,single):
    """Probe labels only; the verified array polygons remain unchanged."""
    name=original.name.replace('_2x2','_probe_2x2')
    top=l.create_cell(name);top.insert(db.CellInstArray(original.cell_index(),db.Trans()))
    for li in (l.layer(48,0),l.layer(49,0)):
        for shape in original.shapes(li).each():
            if shape.is_text():top.shapes(li).insert(shape.text)
    d=Drawing(l,top)
    for r in range(2):
        for col in range(2):
            points=(('Q',16.8,4),('QB',28.8,5.6)) if single else (('Q',14,4.8),('QB',31.6,4.8))
            for name,x,y in points:
                yy=(S-y if r else y) if single else r*H+y
                d.label('M1',f'{name}{r}{col}',col*X+x,yy)
    return top


def reference(top,r,c):
    text=dense.reference(top,r,c)
    if '_probe_' in top:
        for rr in range(r):
            for cc in range(c):
                for q in ('Q','QB'):text=text.replace(f'{q}_{rr}_{cc}',f'{q}{rr}{cc}')
        lines=text.splitlines()
        lines[1]+=' '+' '.join(f'{q}{rr}{cc}' for rr in range(r) for cc in range(c) for q in ('Q','QB'))
        text='\n'.join(lines)+'\n'
    return text


def main():
    HERE.mkdir(exist_ok=True);l=db.Layout();l.dbu=.1;c=core(l);dims={}
    for r,n in ((1,1),(2,2),(4,4),(16,16)):
        top=array(l,c,r,n);b=top.dbbox()
        dims[top.name]=dict(bits=r*n,width_um=b.width(),height_um=b.height(),area_um2=b.area())
    add_probe(l,l.cell('t4_dualwl_2x2'),False)
    l.write(str(HERE/'t4_dualwl.gds'))
    (HERE/'dimensions.json').write_text(json.dumps(dict(pitch_um=[X,H],core_area_um2=X*H,arrays=dims),indent=2)+'\n')
    out=ROOT/'build/sram_t4';out.mkdir(parents=True,exist_ok=True)
    for name,dim in dims.items():
        r,n=map(int,name.rsplit('_',1)[1].split('x'));(out/(name+'.spice')).write_text(reference(name,r,n))
    print(json.dumps(dims,indent=2))
    l=db.Layout();l.dbu=.1;c=single_core(l);shared=single_core(l,True);single={}
    for r,n in ((1,1),(2,2),(4,4),(16,16),(16,32),(32,8),(32,32)):
        top=single_array(l,c,r,n,shared=shared);b=top.dbbox()
        single[top.name]=dict(bits=r*n,width_um=b.width(),height_um=b.height(),area_um2=b.area())
        (out/(top.name+'.spice')).write_text(reference(top.name,r,n))
    add_probe(l,l.cell('t4_singlewl_2x2'),True)
    l.write(str(HERE/'t4_singlewl.gds'))
    for variant in ('dualwl','singlewl'):
        name=f't4_{variant}_probe_2x2'
        (out/(name+'.spice')).write_text(reference(name,2,2))
    (HERE/'single_dimensions.json').write_text(json.dumps(dict(column_pitch_um=X,row_pair_pitch_um=P,
        mirrored_row_translation_um=S,core_area_um2=X*P/2,arrays=single),indent=2)+'\n')
    print(json.dumps(single,indent=2))


if __name__=='__main__':main()
