#!/usr/bin/env python3
"""Build a compact, alternating-row 6T SRAM using the installed TR-1um rules.

Only writes this design's files. The hand-drawn sram.gds is never modified.
All dimensions below are micrometres, quantized to the PDK's 0.1 um grid.
"""
from pathlib import Path
import argparse
import json

import klayout.db as db

HERE = Path(__file__).resolve().parent
PITCH_X = 21.2
PITCH_Y = 34.0
TAP_INTERVAL = 16
TAP_GAP = 26.2
LAYERS = {'WN': (140, 0), 'AP': (3, 1), 'AN': (3, 2),
          'GC': (8, 1), 'CO': (11, 0), 'M1': (13, 0),
          'V1': (19, 0), 'M2': (20, 0),
          'M1_LABEL': (48, 0), 'M2_LABEL': (49, 0)}


class Drawing:
    def __init__(self, layout, cell):
        self.layout, self.cell = layout, cell

    def box(self, layer, x1, y1, x2, y2):
        coords = [round(v / self.layout.dbu) for v in (x1, y1, x2, y2)]
        self.cell.shapes(self.layout.layer(*LAYERS[layer])).insert(db.Box(*coords))

    def pad(self, layer, x, y, size):
        self.box(layer, x-size/2, y-size/2, x+size/2, y+size/2)

    def wire(self, layer, points, width):
        for (x1, y1), (x2, y2) in zip(points, points[1:]):
            assert x1 == x2 or y1 == y2
            self.box(layer, min(x1,x2)-width/2, min(y1,y2)-width/2,
                     max(x1,x2)+width/2, max(y1,y2)+width/2)

    def contact(self, x, y, active=None):
        self.pad('CO', x, y, 1.0)
        self.pad('M1', x, y, 2.6)
        if active:
            self.pad(active, x, y, 2.6)

    def via(self, x, y):
        self.pad('V1', x, y, 1.4)
        self.pad('M1', x, y, 3.4)
        self.pad('M2', x, y, 3.4)

    def label(self, metal, text, x, y):
        self.cell.shapes(self.layout.layer(*LAYERS[metal+'_LABEL'])).insert(
            db.Text(text, db.Trans(round(x/self.layout.dbu), round(y/self.layout.dbu))))


def bitcell(layout):
    cell = layout.create_cell('sram_dense')
    d = Drawing(layout, cell)
    # The well overhang is intentional. Mirrored rows share the VDD diffusion
    # and a continuous well. Each bit has a well contact; substrate contacts
    # connect the VSS row rails at the ends of each bounded array bank.
    d.box('WN', -3.7, 20.9, 25.3, PITCH_Y+8.3)
    for x in (5.9, 15.7):
        # NMOS: BL -- access -- Q -- pull-down -- VSS (shared Q diffusion).
        d.box('AN', x-1.7, -1.3, x+1.7, 10.9)
        for y in (0, 4.8, 9.6):
            d.contact(x, y)
        for y in (2.4, 7.2):
            d.box('GC', x-2.9, y-.5, x+2.9, y+.5)
    for x in (5.0,16.6):
        # Spread the PMOS pair just enough for a well tap between the sources.
        d.box('AP', x-1.7, 27.9, x+1.7, PITCH_Y+1.3)
        for y in (29.2, PITCH_Y):
            d.contact(x, y)
        d.box('GC', x-2.9, 31.1, x+2.9, 32.1)

    # Inverter gate poly stays outside the active columns.
    for nx, px, gate_x in ((5.9,5.0,1.6),(15.7,16.6,19.8)):
        d.wire('GC', [(nx,7.2),(gate_x,7.2),(gate_x,31.6),(px,31.6)], 1.0)
    # Common access gate, with a real contact to the horizontal M1 wordline.
    d.wire('GC', [(5.9,2.4),(15.7,2.4)],1.0)
    d.wire('GC', [(10.8,2.4),(10.8,16.6)],1.0)
    d.contact(10.8,16.6,'GC')
    d.box('M1',0,15.7,PITCH_X,17.5)
    d.contact(10.8,PITCH_Y,'AN')

    # Four M2 tracks: BL, internal Q, internal QB, BLB. No label-only joins.
    for x, bl, q in ((5.9,2.9,8.1),(15.7,18.7,13.5)):
        d.box('M1',min(x,bl)-1.7,-1.7,max(x,bl)+1.7,1.7)
        d.via(bl,0)
        d.box('M2',bl-1.5,-1.7,bl+1.5,PITCH_Y)
        for y,dx in ((4.8,x),(29.2,5.0 if x<10 else 16.6)):
            d.box('M1',min(dx,q)-1.3,y-1.7,max(dx,q)+1.3,y+1.7)
            d.via(q,y)
        d.wire('M2',[(q,4.8),(q,29.2)],3.4)
    # Cross coupling is M1 over the two internal M2 tracks.
    for q, gx, y in ((13.5,1.6,21.0),(8.1,19.8,25.0)):
        d.via(q,y)
        # Offset contacts 0.2 um for M1 spacing to QB and the next column.
        d.contact(gx,y-.2,'GC')
        d.wire('M1',[(gx,y),(q,y)],1.8)
    # Fill same-net pad notches between the Q feedback via and PMOS drain.
    d.box('M1',6.4,23.3,9.8,30.9)
    for y in (9.6,PITCH_Y):
        d.box('M1',0,y-.9,PITCH_X,y+.9)
    return cell


def array(layout, core, rows, cols):
    name = f'sram_dense_{rows}x{cols}'
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
        boundaries += [('left',column_x(first)),
                       ('right',column_x(min(first+TAP_INTERVAL,cols)-1)+PITCH_X)]
    for side,bx in boundaries:
        tx = bx+(-1.8 if side=='left' else 1.8)
        vd = bx+(-6.0 if side=='left' else 6.0)
        vs = bx+(-11.4 if side=='left' else 11.4)
        for y in vdd_rows:
            d.box('WN',min(vd-2.1,0),y-13.1,max(width,vd+2.1),y+8.3)
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
    # Adjacent bank-edge VSS straps are the same net. Fill their 0.4 um
    # intervening notches instead of leaving sub-rule gaps between via pads.
    for first in range(TAP_INTERVAL,cols,TAP_INTERVAL):
        gap_left=column_x(first-1)+PITCH_X
        d.box('M2',gap_left+9.7,min(vss_rows)-1.7,
              column_x(first)-9.7,max(vss_rows)+1.7)
    d.label('M2','VDD',-6.0,vdd_rows[0])
    d.label('M2','VSS',-11.4,vss_rows[0])
    for c in range(cols):
        d.label('M2',f'BL{c}',column_x(c)+2.9,0)
        d.label('M2',f'BLB{c}',column_x(c)+18.7,0)
    if rows==cols==1:
        d.label('M2','Q',8.1,10)
        d.label('M2','QB',13.5,10)
    return top


def reference(name, rows, cols):
    # Independent transistor connectivity, not a copy of the extracted GDS.
    pins = ['VDD','VSS']+[f'WL{r}' for r in range(rows)]
    pins += [n for c in range(cols) for n in (f'BL{c}',f'BLB{c}')]
    if rows==cols==1:
        pins += ['Q','QB']
    lines = ['* Six minimum-size MOS per SRAM bit; flat LVS reference.',
             '.subckt '+name+' '+' '.join(pins)]
    for r in range(rows):
        for c in range(cols):
            q,qb=('Q','QB') if rows==cols==1 else (f'Q_{r}_{c}',f'QB_{r}_{c}')
            for i,(dr,g,so,b,m) in enumerate([
                (q,qb,'VSS','VSS','NMOS'),(qb,q,'VSS','VSS','NMOS'),
                (q,qb,'VDD','VDD','PMOS'),(qb,q,'VDD','VDD','PMOS'),
                (q,f'WL{r}',f'BL{c}','VSS','NMOS'),
                (qb,f'WL{r}',f'BLB{c}','VSS','NMOS')]):
                lines.append(f'M{r}_{c}_{i} {dr} {g} {so} {b} {m} W=3.4u L=1u')
    return '\n'.join(lines+['.ends '+name,''])


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,default=HERE)
    args=parser.parse_args()
    args.output.mkdir(parents=True,exist_ok=True)
    layout=db.Layout();layout.dbu=.1
    core=bitcell(layout)
    footprints={}
    for rows,cols in ((1,1),(2,2),(4,4),(8,8),(16,64)):
        top=array(layout,core,rows,cols)
        b=top.dbbox()
        footprints[top.name]={'width_um':round(b.width(),1),'height_um':round(b.height(),1),
                              'bits':rows*cols}
    layout.write(str(args.output/'sram_dense.gds'))
    report={'pitch_x_um':PITCH_X,'pitch_y_um':PITCH_Y,
            'area_per_bit_um2':PITCH_X*PITCH_Y,
            'tap_interval_columns':TAP_INTERVAL,'tap_gap_um':TAP_GAP,
            'footprints':footprints}
    (args.output/'dimensions.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report,indent=2))


if __name__=='__main__':
    main()
