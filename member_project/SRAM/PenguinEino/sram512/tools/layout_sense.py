#!/usr/bin/env python3
"""Physical shared precharge, write drivers and seven-transistor sense latch."""
from layout_analog import pc,mos
from routing import *

DEVICES=[
 ('piso_l','p',0,3.4,('SOUT','SAE','Y','VDD')),
 ('pl','p',1,3.4,('SOUT','SOUTB','VDD','VDD')),
 ('pr','p',2,3.4,('SOUTB','SOUT','VDD','VDD')),
 ('piso_r','p',3,3.4,('SOUTB','SAE','YB','VDD')),
 ('pcy','p',4,10.2,('Y','PREB','VDD','VDD')),
 ('pcyb','p',5,10.2,('YB','PREB','VDD','VDD')),
 ('tail','n',0,3.4,('TAIL','SAE','VSS','VSS')),
 ('nl','n',1,3.4,('SOUT','SOUTB','TAIL','VSS')),
 ('nr','n',2,3.4,('SOUTB','SOUT','TAIL','VSS')),
 ('pdy','n',4,10.2,('Y','PD_Y','VSS','VSS')),
 ('pdyb','n',5,10.2,('YB','PD_YB','VSS','VSS')),
]
PORTS=['Y','YB','SOUT','SAE','PREB','PD_Y','PD_YB','VDD','VSS']

def fixture(l):
    c=l.create_cell('sense_fixture');d=pc.Drawing(l,c);mapping={}
    for name,kind,slot,w,nets in DEVICES:
        x=22*slot+5.5;y=44.8 if kind=='p' else 6.8
        mos(d,kind,x,y,w)
        sy=55 if kind=='p' else 11
        gy=33 if kind=='p' else 16.5;vy=27.5 if kind=='p' else 22
        for role,off in [('D',-1),('S',1)]:
            vx=x+off*5.5;dx=x+off*2
            d.wire('M1',[(dx,y),(vx,y),(vx,sy)],1.8);d.via(vx,sy)
            port=f'{name}_{role}';d.label('M2',port,vx,sy);mapping[port.lower()]=nets[0 if role=='D' else 2]
        d.wire('GC',[(x,y+(-1 if kind=='p' else 1)*(w/2+1.2)),(x,gy)],1)
        d.contact(x,gy,'GC');d.wire('M1',[(x,gy),(x,vy)],1.8);d.via(x,vy)
        port=f'{name}_G';d.label('M2',port,x,vy);mapping[port.lower()]=nets[1]
    d.box('WN',-19.6,32.7,129.9,56.9)
    for y,active,name in [(44,'AN','VDD'),(5.5,'AP','VSS')]:
        d.contact(-11,y,active);d.wire('M1',[(-11,y),(-16.5,y)],1.8);d.via(-16.5,y)
        d.label('M2',name,-16.5,y);mapping[name.lower()]=name
    pc.fill_metal_notches(l,c)
    return c,mapping

def reference(name,fixture=False):
    pins=[f'{d[0]}_{p}' for d in DEVICES for p in ('D','G','S')]+['VDD','VSS'] if fixture else PORTS
    lines=[f'.subckt {name} '+' '.join(pins)]
    for device,kind,slot,w,nets in DEVICES:
        nodes=[f'{device}_{p}' for p in ('D','G','S')]+[nets[3]] if fixture else nets
        lines.append(f'M{device} '+' '.join(nodes)+f' {"PMOS" if kind=="p" else "NMOS"} W={w}u L=1u')
    return '\n'.join(lines+[f'.ends {name}'])+'\n'

def main():
    work=WORK/'layout/sense';work.mkdir(parents=True,exist_ok=True)
    l=db.Layout();l.dbu=.001;l.technology_name='TR-1um'
    c,mapping=fixture(l);gds=work/'fixture.gds';c.write(str(gds))
    ref=work/'fixture.spice';ref.write_text(reference(c.name,True))
    baseline=verify_layout(gds,c.name,ref,work/'fixture_checks')
    print('fixture',baseline['drc'],baseline['lvs'],flush=True)
    if not all(baseline[k]['passed'] for k in ('drc','lvs')):raise SystemExit(1)
    top=l.create_cell('sram512_shared');top.insert(db.CellInstArray(c.cell_index(),db.Trans()))
    r=Router(l,top,(-27.5,-5.5,148.5,82.5))
    r.add_extracted(c,work/'fixture_checks/sense_fixture.lvsdb',db.Trans(),mapping,'analog')
    # The fixture's temporary terminal labels establish independent test nets;
    # remove them and keep only the actual shared-block schematic ports.
    old=physical_labels(c,l)
    for layer in (48,49):c.shapes(l.layer(layer,0)).clear()
    for name in PORTS:
        original=next(k for k,v in mapping.items() if v==name)
        k,point=old[original];top.shapes(l.layer(48 if k==0 else 49,0)).insert(db.Text(name,db.Trans(point)))
    ok=r.route(work/'routing',100)
    pc.fill_metal_notches(l,top)
    path=work/'shared.gds';top.write(str(path))
    if not ok:raise SystemExit(1)
    ref=work/'reference.spice';ref.write_text(reference(top.name))
    result=verify_layout(path,top.name,ref,work/'checks')
    result['bbox_um']=str(top.dbbox());write_json(REPORTS/'shared_layout.json',result)
    print('shared',result['drc'],result['lvs'],flush=True)
    if not all(result[k]['passed'] for k in ('drc','lvs')):raise SystemExit(1)

if __name__=='__main__':main()
