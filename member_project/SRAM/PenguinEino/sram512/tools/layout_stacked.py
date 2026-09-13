#!/usr/bin/env python3
"""600 x 1800 um floorplan with two unrotated, verified 16x16 banks."""
import argparse
from layout_analog import pc
from routing import *
from verify_digital import parse,digital_parts
from placement import improve
from physical_top import named_macro,verify_and_repair

def build():
    work=WORK/'layout/stacked_compact_control';work.mkdir(parents=True,exist_ok=True)
    l=db.Layout();l.read(str(WORK/'layout/bank/bank.gds'));l.technology_name='TR-1um'
    source=db.Layout();source.read(str(WORK/'library/access/library.gds'))
    parts=digital_parts(parse((WORK/'schematic/sram512.spice').read_text()));lib={}
    for kind in sorted({p['kind'].upper() for p in parts}):
        c=l.cell(kind)
        if c is None:c=l.create_cell(kind);c.copy_tree(source.cell(kind))
        lib[kind]=c
    for name,path in [('sram512_shared','layout/sense/shared.gds'),('sram512_input_clamp','layout/input_clamp/cell.gds')]:
        s=db.Layout();s.read(str(WORK/path));c=l.create_cell(name);c.copy_tree(s.cell(name));lib[name.upper()]=c
    clamp=lib['SRAM512_INPUT_CLAMP'];shared=lib['SRAM512_SHARED'];bank=l.cell('sram512_bank')
    parts += [dict(name='input_'+n.lower(),kind=clamp.name,
                   nets={'IN':n.lower(),'VDD':'vdd','VSS':'vss'}) for n in ('CLK','RESET','SDI','WE')]
    top=l.create_cell('sram512');d=pc.Drawing(l,top);r=Router(l,top,(0,0,594,1793),step=5500)
    byname={p['name']:p for p in parts};placed=set();placements=[];anchors=defaultdict(list)
    def width(p):return 33 if p['kind']==clamp.name else lib[p['kind'].upper()].dbbox().width()-12.6
    def place(p,x,y):
        c=lib[p['kind'].upper()];tr=db.Trans(round(x*1000),round(y*1000));top.insert(db.CellInstArray(c.cell_index(),tr));placed.add(p['name'])
        check=WORK/'layout/input_clamp/checks/sram512_input_clamp.lvsdb' if c==clamp else WORK/f'library/access/{c.name}/{c.name}.lvsdb'
        r.add_extracted(c,check,tr,p['nets'],p['name'])
        placements.append(dict(instance=p['name'],kind=c.name,x=x,y=y,mirror=False))
        for n in set(p['nets'].values()):anchors[n].append((x+width(p)/2,y+27.5))
    for b in range(2):
        x=220;y=511.5+660*b;tr=db.Trans(round(x*1000),round(y*1000))
        top.insert(db.CellInstArray(bank.cell_index(),tr))
        mapping={n:n for n in ('y','yb','preb','vdd','vss')}
        mapping.update({f'wl{i}':f'wl{i}' if b==0 else f'wl_r{i}' for i in range(16)})
        mapping.update({f'cl{i}':f'xcol_decode__cl{i}' for i in range(4)})
        mapping.update({f'ch{i}':f'xcol_decode__ch{i+4*b}' for i in range(4)})
        r.add_extracted(bank,WORK/'layout/bank/checks/sram512_bank.lvsdb',tr,mapping,f'bank{b}')
        placements.append(dict(instance=f'bank{b}',kind=bank.name,x=x,y=y,rotation=0))
        for pin,(layer,point) in physical_labels(bank,l).items():
            if pin in mapping:
                p=tr*db.Point(point.x,point.y);anchors[mapping[pin]].append((p.x/1000,p.y/1000))
        placed.update(f'xcol_decode__xselect{c}' for c in range(b*16,(b+1)*16))
        for row in range(16):
            p=byname[f'xrow__xdriver{row}' if b==0 else f'xrow__xdriver_right{row}']
            place(p,110+(row%2)*27.5,489.5+660*b+(row//2)*82.5)
    tr=db.Trans(db.Trans.R90,596000,22000);top.insert(db.CellInstArray(shared.cell_index(),tr))
    r.add_extracted(shared,WORK/'layout/sense/checks/sram512_shared.lvsdb',tr,
                    {n:n for n in physical_labels(shared,l)},'sense')
    placements.append(dict(instance='sense',kind=shared.name,x=596,y=22,rotation=90))
    for n in ('y','yb','preb','vdd','vss','sae','sout','pd_y','pd_yb'):anchors[n].append((566,88))
    remain=[p for p in parts if p['name'] not in placed]
    caps=[511.5]*2+[566.5]*4+[99]*16
    ys=[11+82.5*i for i in range(6)]+[489.5+82.5*i for i in range(16)]
    rows=[[] for _ in caps];used=[0.]*len(caps)
    # Keep receive/hold pairs adjacent in the initial packing; the annealer
    # subsequently optimizes wire span using all fixed bank/driver terminals.
    groups=[];seen=set()
    for p in remain:
        if p['name'] in seen:continue
        pair=byname.get(p['name'][:-5]) if p['name'].endswith('_hold') else None
        group=[p,pair] if pair is not None and pair in remain else [p]
        groups.append(group);seen.update(v['name'] for v in group)
    def main_logic(p):
        name=p['name']
        return name.startswith('xctrl__') and not re.search(r'__xphase__x(?:phase[0-7]|rx)',name)
    allowed={p['name']:set(range(6) if main_logic(p) else range(6,22)) for p in remain}
    for group in sorted(groups,key=lambda g:-sum(width(p) for p in g)):
        amount=sum(width(p) for p in group)
        choices=[j for j in set.intersection(*(allowed[p['name']] for p in group)) if used[j]+amount<=caps[j]+1e-6]
        if not choices:
            assert len(group)==2
            for p in group:
                choices=[j for j in allowed[p['name']] if used[j]+width(p)<=caps[j]+1e-6];assert choices
                j=max(choices,key=lambda j:used[j]);rows[j].append(p);used[j]+=width(p)
        else:
            j=max(choices,key=lambda j:used[j]);rows[j]+=group;used[j]+=amount
    rows=improve(rows,remain,width,anchors,x0=11,y0=ys,capacity=caps,allowed_rows=allowed)
    for j,ps in enumerate(rows):
        x=11
        for p in ps:place(p,x,ys[j]);x+=width(p)
        if j>=6:x=max(x,165)
        for name,y in [('vss',ys[j]),('vdd',ys[j]+55)]:
            poly=db.DPath([db.DPoint(11,y),db.DPoint(x,y)],4,2,2).to_itype(.001).polygon()
            top.shapes(l.layer(*M1)).insert(poly);r.add_geometry([db.Region(poly),db.Region()],name)
    assert placed==set(byname),set(byname)-placed
    for i,name in enumerate(['VSS','VDD','CLK','RESET','SDI','WE','SDO']):
        x=5.5;y=22+i*77;pad=db.Region(db.Box(round((x-1.7)*1000),round((y-1.7)*1000),round((x+1.7)*1000),round((y+1.7)*1000)))
        top.shapes(l.layer(*M2)).insert(pad);d.label('M2',name,x,y);r.add_geometry([db.Region(),pad],name,'PORT.'+name)
    write_json(work/'placement.json',placements);top.write(str(work/'placed.gds'))
    return l,top,r,work

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--place-only',action='store_true');ap.add_argument('--iterations',type=int,default=1800);a=ap.parse_args()
    l,c,r,w=build()
    if not a.place_only:
        success=r.route(w/'routing',a.iterations);c=named_macro(l,c,w)
        result=verify_and_repair(l,c,w);result.update(router_passed=success,bbox_um=str(c.dbbox()))
        write_json(REPORTS/'layout_stacked_compact_control.json',result);print(result['drc'],result['lvs'],flush=True)
        raise SystemExit(0 if success and all(result[k]['passed'] for k in ('drc','lvs')) else 1)
