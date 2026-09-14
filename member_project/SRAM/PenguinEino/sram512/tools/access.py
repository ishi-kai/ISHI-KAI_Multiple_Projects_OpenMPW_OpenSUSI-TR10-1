#!/usr/bin/env python3
"""Add legal metal pin access to design copies of dev standard cells.

Original transistor dimensions and active/implant geometry are retained.
Metal access is added; DFFR also receives a reset contact and a field-poly
extension, outside active regions. Every resulting leaf is compared to its
original Xschem transistor circuit with strict official LVS.
"""
import heapq,argparse
from routing import *
from prepare import KINDS
from layout_analog import pc

def lift_output(cell,l,report):
    """Route the output along M2 to open M1 access for enclosed input pins.

    This is an ordinary cell-interconnect redesign. It retains every original
    transistor, contact and non-metal mask and must pass an independent LVS.
    """
    v=db.LayoutVsSchematic();v.read(str(report));circ=v.netlist().circuit_by_name(cell.name)
    n=next(n for n in circ.each_net() if n.name.lower()=='y');old=v.polygons_of_net(n,6,True)
    contacts=db.Region(cell.begin_shapes_rec(l.layer(*CO))).interacting(old)
    centers=[p.bbox().center() for p in contacts.each()]
    assert centers and all(abs(p.y-27500)>10000 for p in centers)
    metal=db.Region(cell.begin_shapes_rec(l.layer(*M1)))-old+contacts.sized(800)
    cell.shapes(l.layer(*M1)).clear();cell.shapes(l.layer(*M1)).insert(metal)
    width=cell.dbbox().width()-12.6;d=pc.Drawing(l,cell)
    for upper,vy in [(False,11),(True,49.5)]:
        pts=[p for p in centers if (p.y>27500)==upper]
        assert pts and len({p.x for p in pts})==1
        x=pts[0].x/1000;ys=[p.y/1000 for p in pts];y=(min(ys)+max(ys))/2
        d.wire('M1',[(x,min(ys)),(x,max(ys))],2.6)
        d.wire('M1',[(x,y),(width-2.75,y),(width-2.75,vy)],1.8)
        d.via(width-2.75,vy);d.wire('M2',[(width-2.75,vy),(width,vy)],3.4)
    d.wire('M2',[(width,11),(width,49.5)],3.4)
    for s in list(cell.shapes(l.layer(48,0)).each()):
        if s.is_text() and s.text.string.lower()=='y':s.delete()
    d.label('M2','Y',width,33);pc.fill_metal_notches(l,cell)

def composite_and4(cell,l):
    """Same ten schematic MOS, physically using NAND4 and INV_X1 layouts."""
    n=l.cell('NAND4');w=WORK/'library/nand4';w.mkdir(parents=True,exist_ok=True)
    source=netlist(LIB/'TR-1um_5_stdcell/NAND4.sch',w)
    ref=w/'reference.spice';ref.write_text(re.sub(r'(?im)^X(M\S+)\s+',r'\1 ',source.read_text()))
    path=w/'cell.gds';n.write(str(path));result=verify_layout(path,'NAND4',ref,w)
    assert all(result[k]['passed'] for k in ('drc','lvs')),result
    info=access(n,l,w/'NAND4.lvsdb');pc.fill_metal_notches(l,n)
    nw=WORK/'library/access/NAND4';nw.mkdir(parents=True,exist_ok=True)
    n.write(str(nw/'cell.gds'));result=verify_layout(nw/'cell.gds','NAND4',ref,nw)
    assert all(result[k]['passed'] for k in ('drc','lvs')),result
    cell.clear();inv=l.cell('INV_X1');cell.insert(db.CellInstArray(n.cell_index(),db.Trans()))
    tr=db.Trans(27500,0);cell.insert(db.CellInstArray(inv.cell_index(),tr))
    router=Router(l,cell,(0,-5.5,44,60.5))
    # The two library schematics number the NAND stack in opposite directions.
    mapping={'a':'D','b':'C','c':'B','d':'A','y':'XB','vdd':'VDD','gnd':'GND'}
    router.add_extracted(n,nw/'NAND4.lvsdb',db.Trans(),mapping,'nand4')
    router.add_extracted(inv,WORK/'library/access/INV_X1/INV_X1.lvsdb',tr,
                         {'a':'XB','y':'Y','vdd':'VDD','gnd':'GND'},'inv')
    for pin,(z,p) in physical_labels(n,l).items():
        if pin=='y':continue
        cell.shapes(l.layer(48 if z==0 else 49,0)).insert(db.Text(mapping[pin],db.Trans(p)))
    z,p=physical_labels(inv,l)['y'];cell.shapes(l.layer(48 if z==0 else 49,0)).insert(db.Text('Y',db.Trans(tr*db.Point(p.x,p.y))))
    for name in ('vdd','gnd'):router.pins[router.netid(name)]=[]
    assert router.route(WORK/'library/access/AND4_connection')
    pc.fill_metal_notches(l,cell)
    return dict(implementation='NAND4 + INV_X1',same_schematic_transistor_count=10,nand4_access=info)

def access(cell,l,report):
    width=cell.dbbox().width()-12.6
    r=Router(l,cell,(0,-5.5,width,60.5),step=250)
    labels=physical_labels(cell,l)
    r.add_extracted(cell,report,db.Trans(),{n:n for n in labels},cell.name)
    pads={};log=[]
    # Signals first; supply rails have many equivalent access locations.
    priority={'c':0,'d':1,'ck':2,'rst':3,'s':4,'a':5,'b':6,'q':7,'qb':8,'y':9,'gnd':10,'vdd':11}
    names=sorted(labels,key=lambda n:priority.get(n,9))
    if cell.name=='AND4_X1':names=sorted(labels,key=lambda n:(n in ('gnd','vdd'),n))
    if cell.name=='DFFR':names=sorted(labels,key=lambda n:0 if n=='rst' else priority.get(n,9)+1)
    for name in names:
        nid=r.ids[name];fixed,via,vm,pins=r.prepare()
        f=fixed.reshape(2,r.sy,r.sx);plane=r.nx*r.ny
        regs=r.pins[nid][0][1];seeds=[]
        for z,reg in enumerate(regs):
            cand=raster(reg,r.step,r.nx,r.ny,(r.ox,r.oy))
            ix=(cand//r.nx)*2*r.sx+(cand%r.nx)*2
            good=cand[(fixed[z,ix]==nid)|(fixed[z,ix]==0)]
            seeds.extend((good+z*plane).tolist())
        parent={u:None for u in seeds};distance={u:0 for u in seeds};pq=[(0,u) for u in seeds];heapq.heapify(pq);goal=None
        while pq:
            cost,u=heapq.heappop(pq)
            if distance[u]!=cost:continue
            z=u//plane;p=u%plane;x=p%r.nx;y=p//r.nx
            X=r.ox+x*r.step;Y=r.oy+y*r.step
            if z==1 and X%5500==0 and Y%5500==0 and 5500<=X<=round(width*1000)-5500:
                ymin,ymax=(49500,55000) if name=='vdd' else (0,5500) if name=='gnd' else (5500,49500)
                if ymin<=Y<=ymax:goal=u;break
            for dx,dy,dz in [(-1,0,0),(1,0,0),(0,-1,0),(0,1,0),(0,0,1)]:
                xx=x+dx;yy=y+dy;zz=1-z if dz else z
                if not(0<=xx<r.nx and 0<=yy<r.ny):continue
                v=zz*plane+yy*r.nx+xx
                if f[zz,2*yy,2*xx] not in (0,nid):continue
                if dz:
                    if via[p] or vm[p] not in (0,nid):continue
                elif f[z,yy+y,xx+x] not in (0,nid):continue
                # Keep new signal metal within a safe abutment boundary.
                newx=r.ox+xx*r.step
                if name not in ('vdd','gnd') and not 2000<=newx<=width*1000-2000:continue
                step=15 if dz else 1
                nc=cost+step
                if nc<distance.get(v,1e20):distance[v]=nc;parent[v]=u;heapq.heappush(pq,(nc,v))
        if goal is None:raise RuntimeError(f'{cell.name}.{name}: no pin access')
        edges=[];u=goal
        while parent[u] is not None:edges.append((u,parent[u]));u=parent[u]
        extra=r.draw({nid:edges})
        r.add_geometry(extra,name)
        # Future pin routing must treat the complete connected new wire as part
        # of this same pin, not a new independent terminal.
        terminal,regs=r.pins[nid][0];r.pins[nid][0]=(terminal,[regs[z]+extra[z] for z in range(2)])
        z,point=r.point(goal);pads[name]=[point.x/1000,point.y/1000]
        log.append(dict(pin=name,access_um=pads[name],added_edges=len(edges)))
    return log

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--start',choices=KINDS);args=ap.parse_args()
    l=db.Layout();l.read(str(WORK/'library/design_library.gds'));l.technology_name='TR-1um'
    out=WORK/'library/access';out.mkdir(parents=True,exist_ok=True)
    results=[]
    for kind in KINDS:
        if args.start and KINDS.index(kind)<KINDS.index(args.start):
            w=out/kind;result=json.loads((w/'result.json').read_text())
            assert all(result[k]['passed'] for k in ('drc','lvs')) and result['gds_sha256']==sha(w/'cell.gds')
            old=db.Layout();old.read(str(w/'cell.gds'));cell=l.cell(kind);cell.clear();cell.copy_tree(old.cell(kind))
            results.append(result);continue
        cell=l.cell(kind);base=WORK/f'library/interfaces/{kind}/{kind}.lvsdb'
        if kind=='AND4_X1':
            d=pc.Drawing(l,cell)
            for points in [[(14.1,50.5),(14.1,60.5)],
                           [(18.1,50.5),(18.1,52),(19.25,52),(19.25,60.5)],
                           [(6.1,50.5),(6.1,52.8),(8.25,52.8),(8.25,60.5)],
                           [(10.1,4.5),(10.1,2.2),(13.75,2.2),(13.75,-5.5)]]:
                d.wire('GC',points,1);d.contact(*points[-1],'GC')
            w=WORK/'library/and4_escape_final';w.mkdir(parents=True,exist_ok=True)
            path=w/'cell.gds';cell.write(str(path))
            check=verify_layout(path,kind,WORK/f'library/interfaces/{kind}/reference.spice',w)
            assert all(check[k]['passed'] for k in ('drc','lvs')),check
            info=access(cell,l,w/(kind+'.lvsdb'))
            # Also expose C and D above the power rail for horizontal buses.
            # The existing interior contacts remain connected and unchanged.
            d.wire('M1',[(14.1,60.5),(14.1,66),(16.5,66)],1.8);d.via(16.5,66)
            d.wire('M1',[(19.25,60.5),(27.5,60.5)],1.8);d.via(27.5,60.5)
        elif kind=='AND3_X1':
            d=pc.Drawing(l,cell)
            d.wire('GC',[(14.1,50.5),(14.1,60.5)],1)
            d.contact(14.1,60.5,'GC')
            w=WORK/f'library/metal_escape_base/{kind}';w.mkdir(parents=True,exist_ok=True)
            path=w/'cell.gds';cell.write(str(path))
            check=verify_layout(path,kind,WORK/f'library/interfaces/{kind}/reference.spice',w)
            print('metal escape',kind,check['drc'],check['lvs'],flush=True)
            if not all(check[k]['passed'] for k in ('drc','lvs')):raise SystemExit(1)
            base=w/(kind+'.lvsdb')
            info=access(cell,l,base)
        elif kind=='DFFR':
            d=pc.Drawing(l,cell)
            d.wire('GC',[(42.9,50.5),(42.9,52),(41.25,52),(41.25,60.5)],1)
            d.contact(41.25,60.5,'GC')
            w=WORK/'library/reset_escape';w.mkdir(parents=True,exist_ok=True)
            path=w/'cell.gds';cell.write(str(path))
            check=verify_layout(path,kind,WORK/f'library/interfaces/{kind}/reference.spice',w)
            assert all(check[k]['passed'] for k in ('drc','lvs')),check
            info=access(cell,l,w/(kind+'.lvsdb'))
        else:info=access(cell,l,base)
        pc.fill_metal_notches(l,cell)
        w=out/kind;w.mkdir(parents=True,exist_ok=True);path=w/'cell.gds';cell.write(str(path))
        result=verify_layout(path,kind,WORK/f'library/interfaces/{kind}/reference.spice',w)
        result['access']=info;results.append(result)
        write_json(w/'result.json',result)
        print(kind,result['drc'],result['lvs'],flush=True)
        if not all(result[k]['passed'] for k in ('drc','lvs')):break
    l.write(str(out/'library.gds'));write_json(REPORTS/'library_access.json',results)
    if len(results)!=len(KINDS) or not all(r[k]['passed'] for r in results for k in ('drc','lvs')):raise SystemExit(1)

if __name__=='__main__':main()
