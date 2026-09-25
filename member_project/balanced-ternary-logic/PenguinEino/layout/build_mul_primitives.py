"""Build selected MUL gate variants with unmodified PDK PCells, DBU 0.001 um."""
from pathlib import Path
import json,hashlib
import klayout.db as db
from build_inverter import Drawing,ROOT,PDK
from gds_units import write_gds

def build(kind,p,n,rl):
 if kind=='inv':
  assert (p,n,rl)==(13.5,5,30)
  ly=db.Layout();ly.technology_name='TR-1um';ly.read(str(ROOT/'inverter.gds'))
  ly.cell('inverter').name='mul_inv';out=ROOT/'mul_inv.gds';write_gds(ly,out)
  meta=json.loads((ROOT/'layout/inverter.ports.json').read_text())
  meta.update(top_cell='mul_inv',source_schematic='../mul_inv.sch',gds_sha256=hashlib.sha256(out.read_bytes()).hexdigest())
  (ROOT/'layout/mul_inv.ports.json').write_text(json.dumps(meta,indent=2)+'\n');return
 name='mul_'+kind;ly=db.Layout();ly.dbu=.001;ly.technology_name='TR-1um';top=ly.create_cell(name);d=Drawing(ly,top)
 if kind=='inv':
  width,height=84,66
  d.pcell('MP','fet_p',13.2,44,dict(w=p,l=1.,n=1,cont_between_gates=True,y0='c'))
  d.pcell('MN','fet_n',13.2,14,dict(w=n,l=1.,n=1,cont_between_gates=True,y0='c'))
  for role,y in [('R1',45),('R2',32)]:d.pcell(role,'res_diff',58,y,dict(w=2.8,l=rl))
  d.box('WN',2.9,30.25,23.5,61.3);d.box('WN',35.5,20.6,80.5,65.3)
  for role,cell,x,y in [('PMOS well','cont_n',13.2,55),('RR well','cont_n',58,54),('NMOS bulk','cont_p',5.8,14)]:d.pcell(role,cell,x,y)
  d.box('M1',0,62.6,width,66);d.box('M1',0,0,width,3.4)
  for pts in [[(11.2,44),(11.2,64.3)],[(11.2,55),(13.2,55)],[(11.2,14),(11.2,1.7)],[(5.8,14),(5.8,1.7)],[(58,54),(58,64.3)]]:d.wire('M1',pts,2.6)
  guard=58+rl/2+5.5;tie=guard+2
  for y in (32,45):d.wire('GC',[(guard,y),(tie,y)],2.6);d.pcell('RR GC tie','cont_g',tie,y)
  d.wire('M1',[(tie,32),(tie,54),(58,54)],2.6)
  d.wire('GC',[(13.2,14),(13.2,44)],1.);d.pcell('input contact','cont_g',13.2,25);d.box('M1',0,23.7,13.2,26.3)
  lterm=58-rl/2-.5;rterm=58+rl/2+.5
  d.wire('M1',[(15.2,44),(30,44),(30,45),(lterm,45)],2.6)
  d.wire('M1',[(15.2,14),(30,14),(30,32),(lterm,32)],2.6)
  d.wire('M1',[(rterm,32),(rterm,45)],2.6);d.pcell('output access','via_1',rterm,38.5)
  d.box('M2',rterm,36.8,width,40.2)
  plist=[('vin','M1',2,25),('vout','M2',82,38.5),('VDD','M1',42,64.3),('VSS','M1',42,1.7)]
 else:
  width,height=132,126
  assert rl==30
  left,right,tie=74.5,105.5,112.5
  for x,tag in [(20,'a'),(35,'b')]:
   for cell,y,w in [('fet_p',96,p),('fet_n',16,n)]:d.pcell(cell+'_'+tag,cell,x,y,dict(w=w,l=1.,n=1,cont_between_gates=True,y0='c'))
  for role,y in [('Rtop',78),('Rbottom',42)]:d.pcell(role,'res_diff',90,y,dict(w=2.8,l=rl))
  d.box('WN',6.3,70.5,45.3,121.5);d.box('WN',62.5,30.6,117.5,89.4)
  d.pcell('PMOS well tap','cont_n',12.6,96);d.pcell('RR well tap','cont_n',90,60);d.pcell('bulk tap','cont_p',8,16)
  d.box('M1',0,122.6,width,126);d.box('M1',0,0,width,3.4)
  d.wire('M1',[(8,16),(8,1.7)],2.6);d.wire('M1',[(12.6,96),(15,96),(15,124.3)],2.6)
  d.wire('M1',[(90,60),(90,100),(tie,100),(tie,124.3)],2.6)
  for y in (42,78):d.wire('GC',[(tie-2,y),(tie,y)],2.6);d.pcell('RR GC tie','cont_g',tie,y)
  d.wire('M1',[(tie,42),(tie,100)],2.6)
  def via(x,y,role):d.pcell(role,'via_1',x,y)
  def fan(x0,y,x,w):d.box('M1',min(x0,x)-1.3,y-w/2,max(x0,x)+1.3,y+w/2)
  def trunk(x0,y,x,yy,w,role):fan(x0,y,x,w);d.wire('M1',[(x0,y),(x,y),(x,yy)],2.6);via(x,yy,role)
  if kind=='nand':
   for x in (20,35):
    fan(x-2,96,x-5,p);d.wire('M1',[(x-2,96),(x-5,96),(x-5,124.3)],2.6)
    trunk(x+2,96,x+5,65,p,'parallel P drain')
   d.wire('M2',[(25,65),(left,65)],3.4)
   trunk(18,16,15,30,n,'series N drain');d.wire('M1',[(22,16),(33,16)],2.6)
   fan(37,16,40,n);d.wire('M1',[(37,16),(40,16),(40,1.7)],2.6)
   d.wire('M2',[(15,30),(left,30)],3.4)
  else:
   fan(18,96,15,p);d.wire('M1',[(18,96),(15,96)],2.6);d.wire('M1',[(22,96),(33,96)],2.6)
   trunk(37,96,40,65,p,'series P drain');d.wire('M2',[(40,65),(left,65)],3.4)
   for x in (20,35):
    fan(x-2,16,x-5,n);d.wire('M1',[(x-2,16),(x-5,16),(x-5,1.7)],2.6)
    trunk(x+2,16,x+5,30,n,'parallel N drain')
   d.wire('M2',[(25,30),(left,30)],3.4)
  for x,y in [(20,46),(35,52)]:
   d.wire('GC',[(x,16),(x,96)],1.);d.pcell('input gate','cont_g',x,y)
   d.wire('M1',[(x,y),(x+3.3,y)],2.6);via(x+3.3,y,'input access');d.wire('M2',[(1.7,y),(x+3.3,y)],3.4)
  for y,track in [(78,65),(42,30)]:d.wire('M1',[(left,y),(left,track)],2.6);via(left,track,'RR input')
  d.wire('M1',[(right,42),(right,78)],2.6);via(right,59,'output access');d.wire('M2',[(right,59),(width-1.7,59)],3.4)
  plist=[('a','M2',2,46),('b','M2',2,52),('vout','M2',width-2,59),('V+','M1',width/2,124.3),('V-','M1',width/2,1.7)]
 ports={}
 for net,layer,x,y in plist:
  d.label(layer,net,x,y);ports[net]=dict(layer=[13 if layer=='M1' else 20,0],label_layer=[48 if layer=='M1' else 49,0],position_um=[x,y])
 assert top.dbbox()==db.DBox(0,0,width,height),(name,top.dbbox())
 out=ROOT/f'{name}.gds';write_gds(ly,out)
 meta=dict(top_cell=name,dbu_um=.001,placement_grid_um=.05,bbox_um=[0,0,width,height],width_um=width,height_um=height,ports=ports,instances=d.instances,schematic=str(ROOT/f'{name}.sch'),gds_sha256=hashlib.sha256(out.read_bytes()).hexdigest())
 (ROOT/f'layout/{name}.ports.json').write_text(json.dumps(meta,indent=2)+'\n');print(out,flush=True)
if __name__=='__main__':
 cfg=json.loads((ROOT/'design/mul_sizes.json').read_text())['selected']
 for k,kind in enumerate(('nand','nor','inv')):build(kind,*cfg[3*k:3*k+3])
