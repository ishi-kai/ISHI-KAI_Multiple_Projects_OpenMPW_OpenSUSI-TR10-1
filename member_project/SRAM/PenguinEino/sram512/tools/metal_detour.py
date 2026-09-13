"""Resolve one obstructed net using fine-grid M1/M2 and real foundry vias."""
import numpy as np
import struct
from scipy.ndimage import distance_transform_edt
from common import *
from routing import raster

def detour(layout,core,router,name,start,goal,work,bounds=(1295,17,1348,78),allow_gc=False,reserved=None,emit=True):
    nid=router.ids[name];step=50
    x0,y0,x1,y1=[round(v*1000) for v in bounds]
    nx=(x1-x0)//step+1;ny=(y1-y0)//step+1;plane=nx*ny
    def actual(spec):return db.Region(core.begin_shapes_rec(layout.layer(*spec)))
    def blocked(region,half,spacing):
        # Square wire/cut footprint, followed by Euclidean process spacing.
        # A square exclusion of (half+spacing) rejects legal diagonal gaps.
        # The extra 36 nm bounds nearest-pixel error on this 50 nm grid.
        pad=80;sx=nx+2*pad;sy=ny+2*pad
        mask=np.ones(sx*sy,dtype=bool)
        mask[raster(region.sized(half),step,sx,sy,(x0-pad*step,y0-pad*step))]=False
        distances=distance_transform_edt(mask.reshape(sy,sx),sampling=step)
        return (distances[pad:pad+ny,pad:pad+nx]<spacing+36).ravel()
    foreign=[]
    for k,spec in enumerate(((13,0),(20,0))):
        own=router.regions[k].get(nid,db.Region())+router.drawn_regions[nid][k]
        foreign.append(actual(spec)-own)
    if reserved:
        for k,points,width in reserved:
            foreign[k]+=db.Region(db.DPath([db.DPoint(*p) for p in points],width,width/2,width/2).to_itype(.001).polygon())
    free=np.ones((3,plane),np.uint8)
    for k,(half,space) in enumerate(((900,1400),(1500,2000))):
        free[k,blocked(foreign[k],half,space)]=0
    vias=actual((19,0));contacts=actual((11,0));gc=actual((8,1))
    active=actual((3,1))+actual((3,2))
    own_gc=router.gate_regions[nid]+router.drawn_regions[nid][2]
    foreign_gc=gc-own_gc
    if allow_gc:
        # Existing gate material is allowed to remain next to/over active.
        # Only newly added GC must clear active by 0.45 um. A blanket halo
        # would disconnect the legal extension from the end of every gate.
        active_forbidden=np.zeros(plane,dtype=bool)
        active_forbidden[raster((active.sized(450)-own_gc).sized(499),step,nx,ny,(x0,y0))]=True
        forbidden_gc=blocked(foreign_gc,500,1200)|active_forbidden|blocked(vias,500,1200)
        free[2,forbidden_gc]=0
        # Traversal of an existing gate is an existing physical connection.
        # Emission below subtracts it and forbids any added GC near active.
        free[2,raster(own_gc.sized(-499),step,nx,ny,(x0,y0))]=1
    else:free[2,:]=0
    forbidden=blocked(foreign[0],1700,1400)|blocked(foreign[1],1700,2000)|blocked(gc,700,1200)|blocked(contacts,700,1000)|blocked(vias,700,1500)
    # Candidate sites are on the 0.05 um drawing grid. Check actual cut spacing
    # independently before emitting any of the selected vias.
    allowed=np.ones(plane,np.uint8)
    allowed[forbidden]=0
    co_allowed=np.ones(plane,np.uint8)
    co_forbidden=blocked(foreign[0],1300,1400)|blocked(foreign_gc,1300,1200)|blocked(active,1300,450)|blocked(contacts,500,1000)|blocked(vias,1300,1200)
    co_allowed[co_forbidden]=0
    if not allow_gc:co_allowed[:]=0
    for poly in vias.each():
        b=poly.bbox();p=b.center()
        if b.width()!=1400 or b.height()!=1400:continue
        if (p.x-x0)%step or (p.y-y0)%step:continue
        x=(p.x-x0)//step;y=(p.y-y0)//step
        if 0<=x<nx and 0<=y<ny and free[0,y*nx+x] and free[1,y*nx+x]:allowed[y*nx+x]=1
    if allow_gc:
        for poly in contacts.each():
            b=poly.bbox();p=b.center()
            if b.width()!=1000 or b.height()!=1000:continue
            if (p.x-x0)%step or (p.y-y0)%step:continue
            x=(p.x-x0)//step;y=(p.y-y0)//step
            if 0<=x<nx and 0<=y<ny and free[0,y*nx+x] and free[2,y*nx+x]:
                if not own_gc.interacting(db.Region(db.Box(p,p).enlarged(1))).is_empty():co_allowed[y*nx+x]=1
    def node(p):
        k,x,y=p;x=round(x*1000);y=round(y*1000)
        assert (x-x0)%step==0 and (y-y0)%step==0
        return k*plane+(y-y0)//step*nx+(x-x0)//step
    work=Path(work);work.mkdir(parents=True,exist_ok=True)
    inp=work/'detour.bin';out=work/'detour.txt'
    with inp.open('wb') as f:
        f.write(struct.pack('5i',nx,ny,node(start),node(goal),80));f.write(free.tobytes());f.write(allowed.tobytes());f.write(co_allowed.tobytes())
    binary=WORK/'metal_detour';source=TOOLS / 'metal_detour.cpp'
    if not binary.exists() or source.stat().st_mtime>binary.stat().st_mtime:
        run(['g++','-O3','-std=c++17',source,'-o',binary],WORK,'metal_detour_compile.log')
    code,log=run([binary,inp,out],work,'detour.log',False);print(log.strip(),flush=True)
    if code:raise RuntimeError('No legal metal detour within '+str(bounds))
    nodes=list(map(int,out.read_text().split()))
    def point(u):return db.Point(x0+(u%plane%nx)*step,y0+(u%plane//nx)*step)
    pieces=[];current=[nodes[0]];cuts=[]
    for u,v in zip(nodes,nodes[1:]):
        if u//plane==v//plane:current.append(v)
        else:pieces.append(current);current=[v];cuts.append((int(u//plane==2 or v//plane==2),point(u)))
    pieces.append(current);edits=[]
    cut_shapes=db.Region([db.Box(p.x-700,p.y-700,p.x+700,p.y+700) for k,p in cuts if k==0])
    assert cut_shapes.merged().space_check(1500).is_empty(),'Selected new vias need more spacing.'
    for segment in pieces:
        if len(segment)<2:continue
        keep=[segment[0]]
        for i in range(1,len(segment)-1):
            if segment[i]-segment[i-1]!=segment[i+1]-segment[i]:keep.append(segment[i])
        keep.append(segment[-1]);k=segment[0]//plane;width=(1800,3000,1000)[k]
        pts=[point(u) for u in keep]
        shape=db.Path(pts,width,width//2,width//2).polygon()
        addition=db.Region(shape)-(own_gc if k==2 else db.Region())
        if k==2:assert (addition&active.sized(450)).is_empty(),'Detour must not add or enlarge a transistor.'
        if emit:core.shapes(layout.layer(*((13,0),(20,0),(8,1))[k])).insert(addition)
        edits.append(dict(net=name,layer=('M1','M2','GC')[k],width_um=width/1000,points_um=[[p.x/1000,p.y/1000] for p in pts]))
    for kind,p in cuts:
        existing=contacts if kind else vias
        half_cut=500 if kind else 700
        cut=db.Region(db.Box(p.x-half_cut,p.y-half_cut,p.x+half_cut,p.y+half_cut))
        if (cut-existing).is_empty():continue
        layers=[((13,0),1700),((20,0),1700),((19,0),700)] if kind==0 else [((13,0),1300),((8,1),1300),((11,0),500)]
        for spec,half in layers:
            shape=db.Region(db.Box(p.x-half,p.y-half,p.x+half,p.y+half))
            if spec==(8,1):assert (shape&active.sized(450)).is_empty()
            if emit:core.shapes(layout.layer(*spec)).insert(shape)
    report=dict(paths=edits,contacts=[dict(kind=('V1','CO')[k],point_um=[p.x/1000,p.y/1000]) for k,p in cuts],bounds_um=bounds,grid_um=step/1000,log=log)
    write_json(work/'detour.json',report)
    return report

def draw_detour(layout,core,router,name,report):
    """Draw a reviewed path report, including separated real contact sites."""
    nid=router.ids[name];own_gc=router.gate_regions[nid]+router.drawn_regions[nid][2]
    active=sum((db.Region(core.begin_shapes_rec(layout.layer(*s))) for s in ((3,1),(3,2))),db.Region())
    for item in report['paths']:
        layer=item['layer'];w=item['width_um'];pts=[db.DPoint(*p) for p in item['points_um']]
        shape=db.Region(db.DPath(pts,w,w/2,w/2).to_itype(.001).polygon())
        if layer=='GC':
            shape-=own_gc
            assert (shape&active.sized(450)).is_empty()
        core.shapes(layout.layer(*{'M1':(13,0),'M2':(20,0),'GC':(8,1)}[layer])).insert(shape)
    for item in report['contacts']:
        x,y=item['point_um'];kind=item['kind'];h=.7 if kind=='V1' else .5
        spec=(19,0) if kind=='V1' else (11,0)
        cut=db.Region(db.DBox(x-h,y-h,x+h,y+h).to_itype(.001))
        if (cut-db.Region(core.begin_shapes_rec(layout.layer(*spec)))).is_empty():continue
        for layer,half in ([((13,0),1.7),((20,0),1.7),((19,0),.7)] if kind=='V1' else [((13,0),1.3),((8,1),1.3),((11,0),.5)]):
            shape=db.Region(db.DBox(x-half,y-half,x+half,y+half).to_itype(.001))
            if layer==(8,1):assert (shape&active.sized(450)).is_empty()
            core.shapes(layout.layer(*layer)).insert(shape)
