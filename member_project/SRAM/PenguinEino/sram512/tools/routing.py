"""Physical routing over extracted metal shapes, followed by official checks.

Coordinates below use a 1 nm database. Grid rasterization is conservative;
this is a layout generator, not a replacement DRC or an LVS relaxation.
"""
from collections import defaultdict
import math, struct, time
import numpy as np
from common import *

M1=(13,0);M2=(20,0);VIA=(19,0);GC=(8,1);CO=(11,0)

def raster(region,step,nx,ny,origin=(0,0)):
    """Grid points inside a rectilinear expanded Region (including its edges)."""
    out=set();ox,oy=origin
    if step<2750:
        # A large power/obstacle polygon can have thousands of holes. Testing
        # every fine-grid point against that polygon is unnecessarily costly.
        # KLayout's exact trapezoid decomposition preserves the geometry and
        # allows rectangular spans to be rasterized as NumPy slices.
        mask=np.zeros((ny,nx),dtype=bool)
        pieces=region.merged().decompose_trapezoids()
        for shape in pieces.each():
            p=shape.polygon;b=p.bbox()
            xmin=max(0,math.ceil((b.left-ox)/step));xmax=min(nx-1,math.floor((b.right-ox)/step))
            ymin=max(0,math.ceil((b.bottom-oy)/step));ymax=min(ny-1,math.floor((b.top-oy)/step))
            if xmin>xmax or ymin>ymax:continue
            if p.is_box():mask[ymin:ymax+1,xmin:xmax+1]=True
            else:
                for y in range(ymin,ymax+1):
                    for x in range(xmin,xmax+1):
                        if p.inside(db.Point(ox+x*step,oy+y*step)):mask[y,x]=True
        return np.flatnonzero(mask.ravel()).astype(np.int32)
    for p in region.merged().each():
        b=p.bbox();xmin=max(0,math.ceil((b.left-ox)/step));xmax=min(nx-1,math.floor((b.right-ox)/step))
        ymin=max(0,math.ceil((b.bottom-oy)/step));ymax=min(ny-1,math.floor((b.top-oy)/step))
        isbox=p.is_box()
        for y in range(ymin,ymax+1):
            for x in range(xmin,xmax+1):
                if isbox or p.inside(db.Point(ox+x*step,oy+y*step)):out.add(y*nx+x)
    return np.fromiter(out,dtype=np.int32)

def assign(array,index,owner):
    old=array[index];array[index]=np.where((old==0)|(old==owner),owner,-1)

class Router:
    def __init__(self,layout,top,bounds,step=5500):
        assert layout.dbu==.001
        self.l=layout;self.top=top;self.step=step
        self.ox,self.oy,self.xmax,self.ymax=[round(v*1000) for v in bounds]
        self.nx=(self.xmax-self.ox)//step+1;self.ny=(self.ymax-self.oy)//step+1
        self.sx=2*self.nx-1;self.sy=2*self.ny-1
        self.regions=[defaultdict(db.Region),defaultdict(db.Region)]
        self.gate_regions=defaultdict(db.Region)
        self.pins=defaultdict(list);self.ids={};self.labels={};self._next=1
    def netid(self,name):
        name=name.lower()
        if name not in self.ids:self.ids[name]=self._next;self._next+=1
        return self.ids[name]
    def add_geometry(self,regions,name=None,terminal=None):
        nid=self.netid(name) if name is not None else -1
        for layer,r in enumerate(regions):self.regions[layer][nid]+=r
        if terminal is not None:self.pins[nid].append((terminal,regions))
    def add_extracted(self,gds_cell,lvsdb,transform,mapping,instance):
        """Map real leaf metal nets to named schematic connections."""
        v=db.LayoutVsSchematic();v.read(str(lvsdb));c=v.netlist().circuit_by_name(gds_cell.name)
        if c is None:c=next(v.netlist().each_circuit())
        mapping={k.lower():n for k,n in mapping.items()}
        scale=db.ICplxTrans(v.internal_layout().dbu/self.l.dbu,0,False,0,0)
        # Identify metal layers by geometry, never by an assumed deck variable.
        layers=[]
        for layer in (M1,M2):
            real=db.Region(gds_cell.begin_shapes_rec(self.l.layer(*layer)))
            matches=[i for i in v.layer_indexes() if (v.layer_by_index(i).transformed(scale)^real).is_empty()]
            if real.is_empty():layers.append(None)
            else:
                assert matches,(gds_cell.name,layer)
                layers.append(matches[0])
        covered=[db.Region(),db.Region()]
        actual_gc=db.Region(gds_cell.begin_shapes_rec(self.l.layer(*GC)))
        gc_matches=[i for i in v.layer_indexes() if (v.layer_by_index(i).transformed(scale)^actual_gc).is_empty()]
        gc_index=gc_matches[0] if gc_matches and not actual_gc.is_empty() else None
        for n in c.each_net():
            regs=[v.polygons_of_net(n,i,True).transformed(scale).transformed(transform) if i is not None else db.Region() for i in layers]
            for k,reg in enumerate(regs):covered[k]+=reg
            name=mapping.get(n.name.lower())
            self.add_geometry(regs,name,f'{instance}.{n.name}' if name is not None and any(not r.is_empty() for r in regs) else None)
            if name is not None and gc_index is not None:
                self.gate_regions[self.netid(name)]+=v.polygons_of_net(n,gc_index,True).transformed(scale).transformed(transform)
        # Child circuits also contain private nets (cell Q/QB, gate internal
        # nodes). They are not enumerated by the parent circuit's each_net().
        # Their actual metal must remain an obstacle to parent-level routing.
        private=[db.Region(gds_cell.begin_shapes_rec(self.l.layer(*layer))).transformed(transform)-covered[k]
                 for k,layer in enumerate((M1,M2))]
        self.add_geometry(private)
    def prepare(self):
        fixed=np.zeros((2,self.sx*self.sy),dtype=np.int32);viametal=np.zeros(self.nx*self.ny,dtype=np.int32)
        origin=(self.ox,self.oy)
        for k in range(2):
            for nid,r in self.regions[k].items():
                index=raster(r.sized(2300 if k==0 else 3700),self.step//2,self.sx,self.sy,origin)
                assign(fixed[k],index,nid)
                index=raster(r.sized(3100 if k==0 else 3700),self.step,self.nx,self.ny,origin)
                assign(viametal,index,nid)
        # Foundry V1 may not overlap CO or gate conductor; conservative spacing.
        forbidden=(db.Region(self.top.begin_shapes_rec(self.l.layer(*GC))).sized(1950)
                   +db.Region(self.top.begin_shapes_rec(self.l.layer(*CO))).sized(1750))
        cut=db.Region(self.top.begin_shapes_rec(self.l.layer(*VIA)))
        forbidden+=cut.sized(2200)
        via=np.zeros(self.nx*self.ny,dtype=np.int32)
        via[raster(forbidden,self.step,self.nx,self.ny,origin)]=1
        if self.step==1100:
            # New cuts on a 5.5 um lattice satisfy cut spacing even when two
            # cuts belong to the same routed net. Existing legal cuts below
            # remain reusable at their exact original coordinates.
            yy,xx=np.indices((self.ny,self.nx))
            via[((xx%5!=0)|(yy%5!=0)).ravel()]=1
        # Exactly coincident existing legal vias may be reused.
        for p in cut.each():
            b=p.bbox();pt=b.center()
            if b.width()==1400 and b.height()==1400 and (pt.x-self.ox)%self.step==0 and (pt.y-self.oy)%self.step==0:
                x=(pt.x-self.ox)//self.step;y=(pt.y-self.oy)//self.step
                if 0<=x<self.nx and 0<=y<self.ny:via[y*self.nx+x]=0
        pins={};plane=self.nx*self.ny
        for nid,terms in self.pins.items():
            nodes=[]
            for name,regs in terms:
                ns=[]
                for k,r in enumerate(regs):
                    candidate=raster(r,self.step,self.nx,self.ny,origin)
                    p=candidate//self.nx*(2*self.sx)+(candidate%self.nx)*2
                    good=candidate[(fixed[k,p]==0)|(fixed[k,p]==nid)]
                    ns.extend((good+k*plane).tolist())
                if not ns:raise RuntimeError(f'No legal routing access: {name}, net {nid}, bounds {[str(r.bbox()) for r in regs]}')
                nodes.append(ns)
            if len(nodes)>1:pins[nid]=nodes
        return fixed,via,viametal,pins
    def route(self,work,iterations=40):
        work=Path(work);work.mkdir(parents=True,exist_ok=True)
        start=time.time();fixed,via,viametal,pins=self.prepare()
        print('routing raster',round(time.time()-start,2),'s',len(pins),'nets',flush=True)
        inp=work/'router.bin'
        with inp.open('wb') as f:
            f.write(struct.pack('4i',self.nx,self.ny,len(pins),iterations))
            for a in (fixed,via,viametal):f.write(a.tobytes())
            for nid,terms in pins.items():
                f.write(struct.pack('2i',nid,len(terms)))
                for term in terms:f.write(struct.pack('i',len(term)));f.write(np.array(term,dtype=np.int32).tobytes())
        binary=WORK/'router';source=TOOLS / 'router.cpp'
        if not binary.exists() or source.stat().st_mtime>binary.stat().st_mtime:
            run(['g++','-O3','-std=c++17',source,'-o',binary],WORK,'router_compile.log')
        code,log=run([binary,inp,work/'routes.txt',self.step],work,'router.log',False)
        print(log[-2000:],flush=True)
        lines=(work/'routes.txt').read_text().splitlines();success=lines[0]=='1'
        paths={};i=1
        while i<len(lines):
            nid,n=map(int,lines[i].split());i+=1;paths[nid]=[tuple(map(int,s.split())) for s in lines[i:i+n]];i+=n
        self.draw(paths)
        write_json(work/'routing.json',dict(passed=success,nets=len(pins),grid_um=self.step/1000,elapsed_seconds=time.time()-start,
            node_names={v:k for k,v in self.ids.items()}))
        return success
    def point(self,u):
        plane=self.nx*self.ny;l=u//plane;p=u%plane
        return l,db.Point(self.ox+(p%self.nx)*self.step,self.oy+(p//self.nx)*self.step)
    def draw(self,paths):
        metals=[db.Region(),db.Region()];vias=set()
        for nid,edges in paths.items():
            own=[db.Region(),db.Region()];ownvias=set()
            for a,b in edges:
                la,pa=self.point(a);lb,pb=self.point(b)
                if la!=lb:ownvias.add((pa.x,pa.y))
                else:own[la].insert(db.Path([pa,pb],1800 if la==0 else 3400,900 if la==0 else 1700,900 if la==0 else 1700).polygon())
            for x,y in ownvias:
                for reg in own:reg.insert(db.Box(x-1700,y-1700,x+1700,y+1700))
            for k in range(2):
                native=self.regions[k].get(nid,db.Region())
                joined=native+own[k]
                # All additions belong to this one electrical net. Never
                # close a design-wide gap between two independent signals.
                radius=900 if k==0 else 1000
                filled=joined+joined.sized(radius).sized(-radius)
                metals[k]+=filled-native
            vias.update(ownvias)
        for x,y in vias:
            self.top.shapes(self.l.layer(*VIA)).insert(db.Box(x-700,y-700,x+700,y+700))
        for k,layer in enumerate((M1,M2)):self.top.shapes(self.l.layer(*layer)).insert(metals[k].merged())
        return metals

def physical_labels(cell,l):
    result={}
    for num,k in [(48,0),(49,1)]:
        for s in cell.shapes(l.layer(num,0)).each():
            if s.is_text():result[s.text.string.lower()]=(k,s.text.trans.disp)
    return result
