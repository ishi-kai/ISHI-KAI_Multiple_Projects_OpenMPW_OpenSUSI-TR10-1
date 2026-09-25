"""Self-contained hierarchical imports and orthogonal M1/M2 routing."""
import hashlib,json
import klayout.db as db
from build_inverter import Drawing,ROOT,LAYERS  # registers the current TR-1um PCells
from gds_units import write_gds

def import_tree(target,path,name):
 src=db.Layout();src.technology_name='TR-1um';src.read(str(path));assert src.dbu==.001
 original=src.cell(name);assert original is not None
 copied={}
 def rec(c):
  if c.cell_index() in copied:return copied[c.cell_index()]
  if c.is_pcell_variant():result=target.cell(target.add_pcell_variant(c.pcell_library(),c.pcell_id(),c.pcell_parameters()))
  else:
   # Saved BT library proxies carry their complete geometry; make local logical
   # cells rather than copying an unresolved library reference into the parent.
   nm=c.library_cell_name() if hasattr(c,'library_name') and c.library_name()=='BT' else c.name
   result=target.create_cell(nm);result.copy_shapes(c)
   copied[c.cell_index()]=result
   for inst in c.each_inst():
    child=rec(inst.cell);a=inst.cell_inst.dup();a.cell_index=child.cell_index();placed=result.insert(a);placed.set_properties(inst.properties())
  copied[c.cell_index()]=result
  return result
 out=rec(original)
 for info in src.layer_infos():
  assert (db.Region(out.begin_shapes_rec(target.layer(info)))^db.Region(original.begin_shapes_rec(src.layer(info)))).is_empty(),(name,str(info))
 return out

class Route(Drawing):
 def __init__(self,ly,cell):super().__init__(ly,cell);self.routes=[];self.placements=[]
 def route(self,net,layer,pts,w=3.4):self.wire(layer,pts,w);self.routes.append(dict(net=net,layer=layer,points_um=pts,width_um=w))
 def via(self,net,x,y):
  self.box('V1',x-.7,y-.7,x+.7,y+.7)
  for layer in ('M1','M2'):self.box(layer,x-1.7,y-1.7,x+1.7,y+1.7)
 def instance(self,c,role,x,y):
  assert abs(x/.05-round(x/.05))<1e-7 and abs(y/.05-round(y/.05))<1e-7
  inst=self.cell.insert(db.CellInstArray(c.cell_index(),db.Trans(self.coord(x),self.coord(y))));inst.set_property('role',role)
  self.placements.append(dict(role=role,cell=c.name,origin_um=[x,y],magnification=1))
 def save(self,name,ports,sources,extra=None):
  path=ROOT/f'{name}.gds';write_gds(self.layout,path);b=self.cell.dbbox()
  meta=dict(top_cell=name,dbu_um=.001,placement_grid_um=.05,bbox_um=[b.left,b.bottom,b.right,b.top],ports=ports,instances=self.placements,routes=self.routes,
   gds_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),sources={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in sources})
  if extra:meta.update(extra)
  (ROOT/f'layout/{name}.ports.json').write_text(json.dumps(meta,indent=2)+'\n');print(path,b,flush=True)

def port(d,net,layer,x,y):
 d.label(layer,net,x,y)
 return dict(layer=[13 if layer=='M1' else 20,0],label_layer=[48 if layer=='M1' else 49,0],position_um=[x,y])
