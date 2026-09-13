#!/usr/bin/env python3
"""Physical peripheral cells using untouched dev MOS/contact/via PCells."""
import importlib.util
from common import *
from verify_digital import parse

spec=importlib.util.spec_from_file_location('pcell512_analog',ROOT/'klayout/sram_pcell/build.py')
pc=importlib.util.module_from_spec(spec);spec.loader.exec_module(pc)
assert pc.PDK.resolve()==PDK.resolve()

def mos(d,kind,x,y,w=3.4):
    return d.pcell('fet_p' if kind=='p' else 'fet_n',x,y,dict(w=w,l=1.0,n=1,cont_between_gates=True,y0='c'))

def column_tile(l,minimum_pc=False,mux_width=5.1):
    c=l.create_cell('sram512_column_tile');d=pc.Drawing(l,c)
    py=20.6 if minimum_pc else 24;vdy=24.7 if minimum_pc else 31.5
    # Keep the original north diffusion edge and well spacing. The wider
    # pass devices grow into the unused space below, within the same pitch.
    for x in (2,16):mos(d,'n',x,-(mux_width-3.4)/2,mux_width)
    for x in (6,12):mos(d,'p',x,py,3.4 if minimum_pc else 10.2)
    # Pass nMOS: outer drains are BL/BLB; inner contacts go to Y/YB.
    for bx,nx,px in [(-.4,0,4),(18.4,18,14)]:
        d.wire('M1',[(nx,0),(bx,0),(bx,33.2 if minimum_pc else 40)],1.8)
        d.wire('M1',[(px,py),(bx,py)],1.8)
    d.wire('M1',[(4,0),(4,5.5)],1.8);d.via(4,5.5)
    d.wire('M1',[(14,0),(11,0)],1.8);d.via(11,0)
    # Common column gate below the nMOS active strip.
    for x in (2,16):d.wire('GC',[(x,-2.9),(x,-6.4),(9.6,-6.4)],1.0)
    d.contact(9.6,-6.4,'GC')
    d.wire('M1',[(9.6,-6.4),(9.6,-11),(11,-11)],1.8);d.via(11,-11)
    # PMOS common source and precharge gate. PREB is routed below the PMOS,
    # leaving the top edge free to meet the array's bitlines at 22 um pitch.
    d.wire('M1',[(8,py),(10,py)],1.8)
    d.wire('M1',[(9,py),(9,vdy)],1.8);d.via(9,vdy)
    for x in (6,12):d.wire('GC',[(x,17.7),(x,16),(9.6,16)],1.0)
    d.contact(9.6,16,'GC');d.wire('M1',[(9.6,16),(9.6,11.5)],1.8);d.via(9.6,11.5)
    d.box('GC',8.3,15.5,12.5,17.3)
    pc.fill_metal_notches(l,c)
    return c

def column_bank(l,cols=32,gap=21.2,ground_below_logic=False,ground_depth=77.5,logic_rail=None,minimum_pc=False):
    cell=column_tile(l,minimum_pc);top=l.create_cell(f'sram512_columns_{cols}');d=pc.Drawing(l,top)
    py=20.6 if minimum_pc else 24;vdy=24.7 if minimum_pc else 31.5
    cx=lambda c:c*22+(c//16)*gap
    width=cx(cols-1)+22
    for c in range(cols):
        x=cx(c)
        top.insert(db.CellInstArray(cell.cell_index(),db.Trans(round(x/l.dbu),0)))
        for n,dx,y,layer in [('BL',-.4,31.2 if minimum_pc else 38,'M1'),('BLB',18.4,31.2 if minimum_pc else 38,'M1'),('COL',11,-11,'M2')]:
            d.label(layer,f'{n}{c}',x+dx,y)
    # Continuous physical well; source/supply metal is likewise wired.
    d.box('WN',-12.4,11.9,width+12.4,29.3 if minimum_pc else 36.1)
    for n,y in [('Y',5.5),('YB',0),('PREB',11.5),('VDD',vdy)]:
        d.wire('M2',[(-14.4,y),(width+14.4,y)],3.4)
        d.label('M2',n,width+14.4,y)
    for bx,side in [(cx(i),-1) for i in range(0,cols,16)]+[(width,1)]:
        for y,active,spine in [(py,'AN',bx+side*14.4),(-18,'AP',bx+side*19.8)]:
            tap=bx+side*5.6;vx=bx+side*8.8
            d.contact(tap,y,active);d.via(vx,y)
            d.wire('M1',[(tap,y),(vx,y)],3.4)
            if active=='AP':
                d.wire('M2',[(vx,y),(spine,y)],3.4);d.via(spine,y)
            else:
                d.wire('M2',[(vx,y),(vx,vdy)],3.4);d.via(spine,vdy)
            # All substrate taps use a metal spine and a separate bottom strap.
            if active=='AP':
                if logic_rail is not None:
                    d.wire('M1',[(spine,y),(spine,logic_rail)],2.6)
                elif ground_below_logic:
                    dx=1.8 if bx>0 and side==-1 else 0
                    d.wire('M1',[(spine,y),(spine,-60),(spine+dx,-60),(spine+dx,-ground_depth)],1.8)
                else:
                    d.wire('M1',[(spine,y),(spine,-35)],1.8);d.via(spine,-35)
    if logic_rail is not None:
        # Join the logic ground rail in M1. Outside the logic row, cross
        # the separate VDD spines in M2 and reuse the existing tap vias.
        d.wire('M1',[(-2.75,logic_rail),(width+2.75,logic_rail)],2.6)
        for x,spine in [(-2.75,-19.8),(width+2.75,width+19.8)]:
            d.via(x,logic_rail)
            d.wire('M2',[(x,logic_rail),(spine,logic_rail),(spine,-18)],3.4)
        d.label('M1','VSS',-2.75,logic_rail)
    elif ground_below_logic:
        d.wire('M1',[(-19.8,-ground_depth),(width+19.8,-ground_depth)],3.4);d.label('M1','VSS',-19.8,-ground_depth)
    else:
        d.wire('M2',[(-19.8,-35),(width+19.8,-35)],3.4);d.label('M2','VSS',-19.8,-35)
    pc.fill_metal_notches(l,top)
    return top

def reference(top,cols):
    source=(WORK/'schematic/sram512.spice').read_text();flat=re.sub(r'\n\+\s*',' ',source)
    sub=re.search(r'(?ims)^\.subckt sram512_column .*?^\.ends[^\n]*',flat)[0]
    sub=re.sub(r'(?im)^X\S+ (\S+ \S+ \S+ \S+ (?:NMOS|PMOS) .*)$',lambda m:'M'+str(m.start())+' '+m[1],sub)
    pins=['Y','YB','COL','PREB','VDD','VSS']
    p=parse(source)['sram512_column']['pins']
    ports=[f'{b}{c}' for c in range(cols) for b in ('BL','BLB','COL')]+['Y','YB','PREB','VDD','VSS']
    lines=['* Independent actual column schematic; no behavioural devices',f'.subckt {top} '+' '.join(ports)]
    for c in range(cols):
        mapping={b.lower():f'{b}{c}' if b in ('BL','BLB','COL') else b for b in ('BL','BLB','COL','Y','YB','PREB','VDD','VSS')}
        lines.append(f'Xcol{c} '+' '.join(mapping[pin] for pin in p)+' sram512_column')
    return '\n'.join(lines+[f'.ends {top}',sub])+'\n'

def main():
    results=[]
    for cols in (1,32):
        work=WORK/f'layout/columns_{cols}';work.mkdir(parents=True,exist_ok=True)
        l=db.Layout();l.dbu=.05;l.technology_name='TR-1um'
        top=column_bank(l,cols);path=work/'columns.gds';top.write(str(path))
        ref=work/'reference.spice';ref.write_text(reference(top.name,cols))
        result=verify_layout(path,top.name,ref,work/'checks')
        result['bbox_um']=str(top.dbbox());results.append(result)
        print(cols,result['drc'],result['lvs'],flush=True)
    write_json(REPORTS/'column_layout.json',results)
    if not all(r[k]['passed'] for r in results for k in ('drc','lvs')):raise SystemExit(1)

if __name__=='__main__':main()
