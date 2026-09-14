#!/usr/bin/env python3
"""Reroute conflicting global nets on a finer physical grid.

All other wires remain physical obstacles. Foundry checks and strict LVS are
run on the resulting GDS; a low router conflict score is never a signoff.
"""
import argparse,struct,shutil
from collections import defaultdict
from routing import *
from verify_digital import parse,digital_parts
from physical_top import named_macro,verify_and_repair

def read_routes(folder):
    info=json.loads((folder/'routing/routing.json').read_text())
    data=(folder/'routing/router.bin').read_bytes();nx,ny,nn,it=struct.unpack_from('4i',data)
    plane=nx*ny;offset=16+((2*nx-1)*(2*ny-1)*2+plane*2)*4;used=defaultdict(set)
    for _ in range(nn):
        nid,nt=struct.unpack_from('2i',data,offset);offset+=8
        for _ in range(nt):
            size=struct.unpack_from('i',data,offset)[0];offset+=4
            for u in struct.unpack_from(str(size)+'i',data,offset):used[u].add(nid)
            offset+=4*size
    lines=(folder/'routing/routes.txt').read_text().splitlines();paths={};i=1
    while i<len(lines):
        nid,n=map(int,lines[i].split());i+=1
        paths[nid]=[tuple(map(int,v.split())) for v in lines[i:i+n]];i+=n
        for edge in paths[nid]:
            for u in edge:used[u].add(nid)
    bad=set().union(*(ids for ids in used.values() if len(ids)>1))
    assert info['grid_um']==5.5,'This entry accepts the coarse global-routing result.'
    return info,paths,bad

def restore(folder,info):
    l=db.Layout();l.read(str(folder/'placed.gds'));top=l.cell('sram512')
    header=struct.unpack('4i',(folder/'routing/router.bin').read_bytes()[:16])
    spacing=info['grid_um']
    r=Router(l,top,(0,0,(header[0]-1)*spacing,(header[1]-1)*spacing),step=round(spacing*1000))
    r.ids={v:int(k) for k,v in info['node_names'].items()};r._next=max(r.ids.values())+1
    parts={p['name']:p for p in digital_parts(parse((WORK/'schematic/sram512.spice').read_text()))}
    for p in json.loads((folder/'placement.json').read_text()):
        c=l.cell(p['kind']);name=p['instance']
        tr=db.Trans(p.get('rotation',0)//90,p.get('mirror',False),round(p['x']*1000),round(p['y']*1000))
        if name.startswith('bank'):
            b=int(name[-1]);mapping={n:n for n in ('y','yb','preb','vdd','vss')}
            mapping.update({f'wl{i}':f'wl{i}' if b==0 else f'wl_r{i}' for i in range(16)})
            mapping.update({f'cl{i}':f'xcol_decode__cl{i}' for i in range(4)})
            mapping.update({f'ch{i}':f'xcol_decode__ch{i+4*b}' for i in range(4)})
            check=WORK/'layout/bank/checks/sram512_bank.lvsdb'
        elif name=='sense':
            mapping={n:n for n in physical_labels(c,l)};check=WORK/'layout/sense/checks/sram512_shared.lvsdb'
        elif name.startswith('input_'):
            mapping={'in':name[6:],'vdd':'vdd','vss':'vss'}
            leaf='input_clamp_compact' if c.dbbox().width()<30 else 'input_clamp'
            check=WORK/f'layout/{leaf}/checks/sram512_input_clamp.lvsdb'
        else:
            mapping=parts[name]['nets'];check=WORK/f'library/access/{c.name}/{c.name}.lvsdb'
        r.add_extracted(c,check,tr,mapping,name)
    labels=physical_labels(top,l)
    for k,layer in enumerate((M1,M2)):
        for poly in db.Region(top.shapes(l.layer(*layer))).merged().each():
            reg=db.Region(poly)
            owners={nid for nid,rr in r.regions[k].items() if nid!=-1 and not rr.interacting(reg).is_empty()}
            named={r.netid(n) for n,(ll,point) in labels.items() if ll==k and poly.inside(point)}
            owners|=named
            assert len(owners)==1,(k,poly.bbox(),owners)
            nid=owners.pop();r.regions[k][nid]+=reg
            if named:r.pins[nid].append(('top_port',[reg if j==k else db.Region() for j in range(2)]))
    return l,top,r

def main(folder,iterations=80,extra=(),neighbours=0,step_um=1.1):
    folder=Path(folder).resolve();info,paths,bad=read_routes(folder)
    names={int(k):v for k,v in info['node_names'].items()}
    bad|={k for k,v in names.items() if v in extra}
    if neighbours:
        nx,ny,_,_=struct.unpack('4i',(folder/'routing/router.bin').read_bytes()[:16]);plane=nx*ny
        owners=defaultdict(set)
        for nid,edges in paths.items():
            for edge in edges:
                for u in edge:owners[u].add(nid)
        conflicts=[u for u,ids in owners.items() if len(ids)>1]
        for u in conflicts:
            layer=u//plane;xy=u%plane;x=xy%nx;y=xy//nx
            for dy in range(-neighbours,neighbours+1):
                for dx in range(-neighbours,neighbours+1):
                    if 0<=x+dx<nx and 0<=y+dy<ny:
                        bad|={nid for nid in owners.get(layer*plane+(y+dy)*nx+x+dx,()) if names[nid] not in ('vdd','vss')}
    print('fine-grid nets',len(bad),[names[k] for k in sorted(bad)],flush=True)
    assert not ({names[k] for k in bad}&{'vdd','vss'}),'Power geometry must be resolved before this signal pass.'
    l,top,coarse=restore(folder,info)
    good={k:v for k,v in paths.items() if k not in bad};coarse.draw(good)
    # Keep the coarse wires' labels on their own actual first edge.
    for nid,edges in good.items():
        if not edges or names[nid].upper() in {'VDD','VSS','CLK','RESET','SDI','WE','SDO'}:continue
        layer,point=coarse.point(edges[0][0]);path=names[nid].split('__')
        label='.'.join([s[1:] if s.startswith('x') else s for s in path[:-1]]+path[-1:]).upper()
        top.shapes(l.layer(48+layer,0)).insert(db.Text(label,db.Trans(point)))
    fine=Router(l,top,(0,0,coarse.xmax/1000,coarse.ymax/1000),step=round(step_um*1000))
    fine.ids=coarse.ids.copy();fine._next=coarse._next
    for k,layer in enumerate((M1,M2)):
        actual=db.Region(top.begin_shapes_rec(l.layer(*layer)))
        own=sum((coarse.regions[k].get(nid,db.Region()) for nid in bad),db.Region())
        fine.regions[k][-1]=actual-own
        for nid in bad:fine.regions[k][nid]=coarse.regions[k].get(nid,db.Region())
    fine.pins.update({nid:terms for nid,terms in coarse.pins.items() if nid in bad})
    suffix='_detail'+(f'_n{neighbours}' if neighbours else '')+(f'_grid{step_um}' if step_um!=1.1 else '')
    work=WORK/'layout'/(folder.name+suffix);work.mkdir(parents=True,exist_ok=True)
    shutil.copy2(folder/'placement.json',work/'placement.json')
    success=fine.route(work/'routing',iterations);top=named_macro(l,top,work)
    result=verify_and_repair(l,top,work);result.update(router_passed=success,global_source=str(folder),
        detailed_nets=[names[k] for k in sorted(bad)],bbox_um=str(top.dbbox()))
    write_json(REPORTS/(folder.name+suffix+'.json'),result)
    print(result['drc'],result['lvs'],flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('--iterations',type=int,default=80)
    p.add_argument('--extra',nargs='*',default=[]);p.add_argument('--neighbours',type=int,default=0);p.add_argument('--step-um',type=float,default=1.1);a=p.parse_args();r=main(a.folder,a.iterations,a.extra,a.neighbours,a.step_um)
    raise SystemExit(0 if r['router_passed'] and all(r[k]['passed'] for k in ('drc','lvs')) else 1)
