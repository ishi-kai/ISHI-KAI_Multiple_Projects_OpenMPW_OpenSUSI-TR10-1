#!/usr/bin/env python3
"""Control experiment: original bitcell with one shared tap column per 16 bits.

The array generator is adapted from ../dense_sram/build.py. Only bank gaps and
redundant interior edge tap/strap pairs change. The cell polygons are preserved.
"""
from pathlib import Path
import sys,json
import klayout.db as db
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/'dense_sram'))
from build import Drawing
PITCH_X=21.2
PITCH_Y=34.0
TAP_INTERVAL=16
TAP_GAP=14.4

def shared_array(layout, core, rows, cols):
    name = f'baseline_shared_{rows}x{cols}'
    top = layout.create_cell(name)
    d = Drawing(layout,top)
    def column_x(c):
        return c*PITCH_X+(c//TAP_INTERVAL)*TAP_GAP
    width = column_x(cols-1)+PITCH_X
    # Rows alternate R0 / mirror in X axis. At the boundary either BL
    # diffusion or VDD diffusion is shared; storage nodes are never shared.
    for r in range(rows):
        ty = (r if r%2 == 0 else r+1)*PITCH_Y
        for first in range(0,cols,TAP_INTERVAL):
            tr = db.Trans(db.Trans.M0 if r%2 else db.Trans.R0,
                          round(column_x(first)/layout.dbu),round(ty/layout.dbu))
            top.insert(db.CellInstArray(core.cell_index(),tr,
                       db.Vector(round(PITCH_X/layout.dbu),0),db.Vector(),
                       min(cols-first,TAP_INTERVAL),1))
        y = ty-16.6 if r%2 else ty+16.6
        d.box('M1',-3,y-.9,width,y+.9)
        d.label('M1',f'WL{r}',-2,y)

    vdd_rows = sorted({(r//2*2+1)*PITCH_Y for r in range(rows)})
    vss_rows = [(r if r%2 == 0 else r+1)*PITCH_Y +
                (-9.6 if r%2 else 9.6) for r in range(rows)]
    for y in vdd_rows+vss_rows:
        d.box('M1',0,y-.9,width,y+.9)
    # Taps and vertical power straps at both array edges are included in
    # the verification layout and its measured (non-core) footprint.
    boundaries=[]
    for first in range(0,cols,TAP_INTERVAL):
        boundaries.append(('left',column_x(first)))
        if first+TAP_INTERVAL>=cols:
            boundaries.append(('right',width))
    for side,bx in boundaries:
        tx = bx+(-1.8 if side=='left' else 1.8)
        vd = bx+(-6.0 if side=='left' else 6.0)
        vs = bx+(-11.4 if side=='left' else 11.4)
        for y in vdd_rows:
            # Fill the mirrored-row well overhang across the shared tap column.
            well_top=y+(13.1 if y<rows*PITCH_Y else 8.3)
            d.box('WN',min(vd-2.1,0),y-13.1,max(width,vd+2.1),well_top)
            d.contact(tx,y,'AN')
            d.box('M1',min(vd,tx)-1.7,y-1.7,max(vd,tx)+1.7,y+1.7)
            d.wire('M1',[(tx,y),(bx,y)],1.8)
            d.via(vd,y)
        for y in vss_rows:
            d.contact(tx,y,'AP')
            d.wire('M1',[(vs,y),(bx,y)],1.8)
            d.via(vs,y)
        for x,ys in ((vd,vdd_rows),(vs,vss_rows)):
            d.box('M2',x-1.5,min(ys)-1.7,x+1.5,max(ys)+1.7)
    d.label('M2','VDD',-6.0,vdd_rows[0])
    d.label('M2','VSS',-11.4,vss_rows[0])
    for c in range(cols):
        d.label('M2',f'BL{c}',column_x(c)+2.9,0)
        d.label('M2',f'BLB{c}',column_x(c)+18.7,0)
    if rows==cols==1:
        d.label('M2','Q',8.1,10)
        d.label('M2','QB',13.5,10)
    return top


def main(output=HERE):
    l=db.Layout();l.read(str(HERE.parent/'dense_sram/sram_dense.gds'))
    core=l.cell('sram_dense');dims={}
    for r,c in ((1,1),(4,17),(16,64),(17,80)):
        top=shared_array(l,core,r,c);b=top.dbbox()
        dims[top.name]={'bits':r*c,'width_um':round(b.width(),1),'height_um':round(b.height(),1)}
    # Keep only the new control arrays and their shared core.
    for cell in list(l.top_cells()):
        if not cell.name.startswith('baseline_shared_'):l.delete_cell(cell.cell_index())
    l.write(str(output/'baseline_shared.gds'))
    (output/'baseline_shared_dimensions.json').write_text(json.dumps(dims,indent=2)+'\n')
    print(json.dumps(dims,indent=2))


if __name__=='__main__':main()
