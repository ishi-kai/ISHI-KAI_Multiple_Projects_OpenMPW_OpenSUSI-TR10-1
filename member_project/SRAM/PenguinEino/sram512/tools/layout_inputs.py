#!/usr/bin/env python3
"""PDK diode pair for input gate antenna protection; no qualified pad ESD claim."""
import argparse
from common import *
from layout_analog import pc
from schematics import Sheet,symbol

def schematic():
    s=Sheet();s.text('INPUT GATE CLAMPS | dev PCell DP + DN, 3.6 x 3.6 um',-350,-270,.32)
    s.text('Connect to the shuttle pad / ESD network at chip integration.',-350,-210,.27)
    s.device('DP','upper',0,-120,dict(PLUS='IN',MINUS='VDD'),'model=DP w=3.6u l=3.6u m=1 spiceprefix=D')
    s.device('DN','lower',0,80,dict(PLUS='VSS',MINUS='IN'),'model=DN w=3.6u l=3.6u m=1 spiceprefix=D')
    s.link('upper','PLUS','lower','MINUS')
    s.named_port('IN',-250,0,'inout')
    s.wire([(-190,0),(0,0)],'IN')
    s.named_port('VDD',-250,-120,'inout');s.named_port('VSS',-250,140,'inout')
    s.finish();s.save('sram512_input_clamp.sch')
    symbol('sram512_input_clamp',[],[],inouts=('VDD','VSS'))
    # A bidirectional signal terminal expresses the diode load on the input.
    from schematics import custom_symbol
    pts={'IN':(-100,0),'VDD':(0,-120),'VSS':(0,120)}
    custom_symbol('sram512_input_clamp',pts,{n:'inout' for n in pts},(-80,-100,80,100))

def main(compact=False,row_compatible=False):
    compact=compact or row_compatible
    variant='input_clamp_compact_row' if row_compatible else 'input_clamp_compact' if compact else 'input_clamp'
    schematic();work=WORK/'layout'/variant;work.mkdir(parents=True,exist_ok=True)
    source=netlist(ROOT/'sram512/schematics/sram512_input_clamp.sch',work/'schematic',lvs=True)
    text=source.read_text()
    assert re.search(r'(?im)^Dxupper IN VDD DP A=12.96p P=14.4u$',text)
    assert re.search(r'(?im)^Dxlower VSS IN DN A=12.96p P=14.4u$',text)
    l=db.Layout();l.dbu=.001;l.technology_name='TR-1um';c=l.create_cell('sram512_input_clamp');d=pc.Drawing(l,c)
    if compact:
        # Put body taps on the standard-cell supply rails. The real diode
        # junctions retain their 3.6 x 3.6 um area and perimeter; no dummy
        # recognition layer or excluded geometry is used.
        d.pcell('diode_p',8.25,38.5,{'x':3.6,'y':3.6})
        # Some library gates start their N-well at y=23.2 um. Keep the
        # lower diode at least 10 um below that well when cells abut.
        dn_y=10.85 if row_compatible else 16.35
        d.pcell('diode_n',8.25,dn_y,{'x':3.6,'y':3.6})
        d.box('WN',-6.3,23.2 if row_compatible else 28.2,22.8,66.8)
        d.contact(8.25,55,'AN');d.contact(8.25,0,'AP')
        d.wire('M1',[(8.25,dn_y),(8.25,38.5)],1.8)
        d.wire('M1',[(8.25,27.5),(5.5,27.5)],1.8);d.via(5.5,27.5)
        d.box('M1',5.5,25.8,9.15,29.2)
        for name,y in [('VDD',55),('VSS',0)]:
            d.wire('M1',[(0,y),(16.5,y)],2.6);d.label('M1',name,0,y)
    else:
        d.pcell('diode_p',11,38.5,{'x':3.6,'y':3.6})
        d.pcell('diode_n',11,11,{'x':3.6,'y':3.6})
        d.box('WN',0,28.5,33,48.5)
        d.contact(22,38.5,'AN');d.contact(22,11,'AP')
        d.wire('M1',[(11,11),(11,38.5)],1.8)
        d.wire('M1',[(11,27.5),(5.5,27.5)],1.8);d.via(5.5,27.5)
        for name,y,tap in [('VDD',55,38.5),('VSS',0,11)]:
            d.wire('M1',[(22,tap),(22,y)],3.4)
            d.wire('M1',[(0,y),(33,y)],3.4);d.via(27.5,y);d.label('M1',name,0,y)
    d.label('M2','IN',5.5,27.5)
    gds=work/'cell.gds';c.write(str(gds))
    result=verify_layout(gds,c.name,source,work/'checks')
    print(result['drc'],result['lvs'],flush=True);write_json(REPORTS/(variant+'.json'),result)
    if not all(result[k]['passed'] for k in ('drc','lvs')):raise SystemExit(1)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--compact',action='store_true');p.add_argument('--row-compatible',action='store_true');a=p.parse_args();main(a.compact,a.row_compatible)
