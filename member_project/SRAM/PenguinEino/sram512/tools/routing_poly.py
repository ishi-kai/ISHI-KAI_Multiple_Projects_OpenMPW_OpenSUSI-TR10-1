"""M1/M2 router with additional GC wiring strictly outside active areas.

GC is a real process conductor with real CO connections to M1. No active
geometry, recognition layer, checking rule or device is removed or changed.
Power nets remain metal-only. Final DRC, LVS and GC resistance checks are
required independently of this generator's conservative geometric masks.
"""
from routing import *

# High-current analogue paths and the distributed clock/reset use metal.
# GC is reserved for other signal nets; its R/C is explicitly checked later.
METAL_ONLY={'vdd','vss','y','yb','preb','sae','sout','soutb','pd_y','pd_yb',
            'wl_en','clk','reset','sdo','xctrl__cki','xctrl__rsti'}

def read_paths(path):
    lines=Path(path).read_text().splitlines();i=1;paths={}
    while i<len(lines):
        nid,n=map(int,lines[i].split());i+=1
        assert nid not in paths and n>=0 and i+n<=len(lines)
        paths[nid]=[tuple(map(int,line.split())) for line in lines[i:i+n]]
        assert all(len(edge)==2 for edge in paths[nid])
        i+=n
    return paths

def route_connectivity(terminals,paths):
    """Independently check all terminal groups against emitted graph edges."""
    failures=[]
    for nid,groups in terminals.items():
        parent={}
        def root(u):
            parent.setdefault(u,u)
            while parent[u]!=u:
                parent[u]=parent[parent[u]];u=parent[u]
            return u
        def join(a,b):parent[root(a)]=root(b)
        for group in groups:
            assert group
            for u in group:join(group[0],u)
        for a,b in paths.get(nid,[]):join(a,b)
        first=root(groups[0][0])
        missing=[i for i,g in enumerate(groups) if root(g[0])!=first]
        if missing:failures.append(dict(net_id=nid,unconnected_terminal_groups=missing))
    return dict(passed=not failures,nets=len(terminals),
                terminal_groups=sum(map(len,terminals.values())),failures=failures)

class RouterPoly(Router):
    @classmethod
    def from_router(cls,source,step=5500,extra_um=(0,0)):
        assert source.step in (5500,2750,550)
        self=cls(source.l,source.top,(source.ox/1000,source.oy/1000,source.xmax/1000+extra_um[0],source.ymax/1000+extra_um[1]),step=step)
        self.regions=source.regions;self.pins=source.pins;self.ids=source.ids;self._next=source._next
        self.gate_regions=source.gate_regions
        self.via_pitch_nm=getattr(source,'via_pitch_nm',5500)
        return self
    def prepare(self):
        fixed,via,viametal,pins=super().prepare();origin=(self.ox,self.oy)
        if self.step==550:
            # Use the remaining field-GC track at the top boundary while
            # keeping even the larger M2/CO landings inside 600 x 1800 um.
            fy=(np.arange(self.sy)*(self.step//2)+self.oy)/1000
            fixed[1].reshape(self.sy,self.sx)[fy>596.6,:]=-1
        if self.step in (2750,550):
            pitch=getattr(self,'via_pitch_nm',5500);assert pitch in (2750,5500)
            yy,xx=np.indices((self.ny,self.nx));stride=pitch//self.step
            via[((xx%stride!=0)|(yy%stride!=0)).ravel()]=1
        def actual(layer):return db.Region(self.top.begin_shapes_rec(self.l.layer(*layer)))
        poly=actual(GC);active=actual((3,1))+actual((3,2));resistor=actual((8,2))
        cuts=actual(CO);v1=actual(VIA)
        fixedgc=np.zeros(self.sx*self.sy,np.int32)
        # A local repair may reuse its own retained field-GC wire. Only
        # explicitly owned routed GC is exempted from the foreign-wire
        # obstacle; device/resistor/active/via clearance remains blocked.
        owned_gc=getattr(self,'gc_owned',{})
        foreign_gc=poly-sum(owned_gc.values(),db.Region())
        forbidden=foreign_gc.sized(1750)+resistor.sized(1750)+active.sized(950)+v1.sized(1750)
        fixedgc[raster(forbidden,self.step//2,self.sx,self.sy,origin)]=-1
        for nid,reg in owned_gc.items():
            assign(fixedgc,raster(reg.sized(1750),self.step//2,self.sx,self.sy,origin),nid)
        cof=np.zeros(self.nx*self.ny,np.int32)
        forbidden=foreign_gc.sized(2550)+resistor.sized(2550)+active.sized(1750)+v1.sized(2550)+cuts.sized(1550)
        cof[raster(forbidden,self.step,self.nx,self.ny,origin)]=1
        if self.step==550:cof[((xx%5!=0)|(yy%5!=0)).ravel()]=1
        if self.step==550:
            high=((yy*self.step+self.oy)>596600).ravel();via[high]=1;cof[high]=1
        owners=np.zeros_like(cof)
        for nid,reg in self.regions[0].items():
            assign(owners,raster(reg.sized(2750),self.step,self.nx,self.ny,origin),nid)
        if owned_gc:
            # Reusing a real legal contact does not create a new stacked cut.
            # Both its M1 and retained GC must belong to the same signal.
            for p in cuts.each():
                b=p.bbox();pt=b.center()
                if b.width()!=1000 or b.height()!=1000:continue
                if (pt.x-self.ox)%self.step or (pt.y-self.oy)%self.step:continue
                x=(pt.x-self.ox)//self.step;y=(pt.y-self.oy)//self.step
                if not (0<=x<self.nx and 0<=y<self.ny):continue
                u=y*self.nx+x;nid=int(owners[u]);f=int(fixedgc[2*y*self.sx+2*x])
                if nid>0 and nid==f and nid in owned_gc:cof[u]=0
        return np.vstack((fixed,fixedgc)),np.concatenate((via,cof)),np.concatenate((viametal,owners)),pins
    def route(self,work,iterations=1000,selective=False):
        work=Path(work);work.mkdir(parents=True,exist_ok=True);start=time.time()
        fixed,via,viametal,pins=self.prepare();inp=work/'router.bin'
        with inp.open('wb') as f:
            f.write(struct.pack('4i',self.nx,self.ny,len(pins),iterations))
            for arr in (fixed,via,viametal):f.write(arr.tobytes())
            reverse={v:k for k,v in self.ids.items()}
            for nid,terms in pins.items():
                f.write(struct.pack('3i',nid,len(terms),int(reverse[nid] not in METAL_ONLY)))
                for term in terms:f.write(struct.pack('i',len(term)));f.write(np.array(term,np.int32).tobytes())
        print('three conductor routing',len(pins),'nets; raster',round(time.time()-start,2),'s',flush=True)
        write_json(work/'routing_input.json',dict(grid_um=self.step/1000,
            node_names={v:k for k,v in self.ids.items()},selective_reroute=selective,
            via_grid_um=getattr(self,'via_pitch_nm',5500)/1000))
        binary=WORK/'router_poly';source=TOOLS / 'router_poly.cpp'
        if not binary.exists() or source.stat().st_mtime>binary.stat().st_mtime:
            run(['g++','-O3','-std=c++17',source,'-o',binary],WORK,'router_poly_compile.log')
        code,log=run([binary,inp,work/'routes.txt',self.step,int(selective)],work,'router.log',False)
        print(log[-800:],flush=True);rows=(work/'routes.txt').read_text().splitlines();success=rows[0]=='1'
        paths={};i=1
        while i<len(rows):
            nid,n=map(int,rows[i].split());i+=1;paths[nid]=[tuple(map(int,s.split())) for s in rows[i:i+n]];i+=n
        connectivity=route_connectivity(pins,paths)
        write_json(work/'connectivity.json',connectivity)
        assert not success or connectivity['passed'],'Router completion omitted native terminals.'
        metrics=self.draw(paths)
        write_json(work/'routing.json',dict(passed=success,nets=len(pins),grid_um=self.step/1000,
            elapsed_seconds=time.time()-start,node_names={v:k for k,v in self.ids.items()},
            conductors=['M1','M2','GC'],gc_routes=metrics,graph_connectivity=connectivity))
        return success
    def draw(self,paths):
        metals=[db.Region(),db.Region(),db.Region()];vias=[set(),set()];metrics=[]
        self.drawn_regions={}
        for nid,edges in paths.items():
            own=[db.Region(),db.Region(),db.Region()];connectors=[set(),set()];length=0
            for a,b in edges:
                ka,pa=self.point(a);kb,pb=self.point(b)
                if ka!=kb:connectors[int(ka==2 or kb==2)].add((pa.x,pa.y))
                else:
                    width=(1800,3400,1000)[ka];own[ka].insert(db.Path([pa,pb],width,width//2,width//2).polygon())
                    if ka==2:length+=pa.distance(pb)/1000
            assert not (connectors[0]&connectors[1]),'A CO/V1 stack is illegal.'
            for kind,centers in enumerate(connectors):
                half=1700 if kind==0 else 1300
                for x,y in centers:
                    for k in ((0,1) if kind==0 else (0,2)):own[k].insert(db.Box(x-half,y-half,x+half,y+half))
            emitted=[]
            for k in range(3):
                native=self.regions[k].get(nid,db.Region()) if k<2 else db.Region()
                joined=native+own[k];radius=(900,1000,500)[k]
                add=joined+joined.sized(radius).sized(-radius)-native
                metals[k]+=add;emitted.append(add)
            self.drawn_regions[nid]=emitted
            for k in range(2):vias[k]|=connectors[k]
            if length:metrics.append(dict(net=next(n for n,i in self.ids.items() if i==nid),length_um=length,contacts=len(connectors[1])))
        for k,layer in enumerate((VIA,CO)):
            half=700 if k==0 else 500
            for x,y in vias[k]:self.top.shapes(self.l.layer(*layer)).insert(db.Box(x-half,y-half,x+half,y+half))
        for k,layer in enumerate((M1,M2,GC)):self.top.shapes(self.l.layer(*layer)).insert(metals[k].merged())
        return metrics
