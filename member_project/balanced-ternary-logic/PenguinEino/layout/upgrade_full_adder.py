"""Keep the user's FA signal routing; replace children and rebuild power feeds.

The checked-in JSON template is an exact snapshot of the pre-upgrade top cell.
Primitive dimensions come from the freshly generated child GDS, not the template.
"""
import argparse, hashlib, json
import klayout.db as db
from arithmetic_helpers import ROOT, Route, import_tree, port

TEMPLATE=ROOT/'layout/full_adder_signal_template.json'

def snapshot(path):
 ly=db.Layout();ly.read(str(path));c=ly.cell('full_adder');assert ly.dbu==.001
 data=dict(source_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
  shapes=[dict(layer=[info.layer,info.datatype],shape=s.to_s()) for info in ly.layer_infos() for s in c.shapes(ly.layer(info)).each()],
  instances=[dict(name=i.cell.name,transform=i.dcplx_trans.to_s(),properties=i.properties()) for i in c.each_inst()])
 assert not TEMPLATE.exists(),'Refuse to replace the saved manual routing template'
 TEMPLATE.write_text(json.dumps(data,indent=2)+'\n')

def build():
 data=json.loads(TEMPLATE.read_text());ly=db.Layout();ly.dbu=.001;ly.technology_name='TR-1um'
 top=ly.create_cell('full_adder');d=Route(ly,top)
 ha=import_tree(ly,ROOT/'half_adder.gds','half_adder');inv=ly.cell('inverter');nany=ly.cell('nany')
 cells={'half_adder':ha,'inverter':inv,'nany':nany}
 for row in data['instances']:
  # C1 now stays on M2 here: its old landing via would short the VDD bridge.
  if row['name'].startswith('via_1') and row['transform']=='r0 *1 1308.45,22.35':continue
  c=cells.get(row['name'])
  if c is None:c=ly.create_cell('via_1','TR-1um',{})
  tr=db.DCplxTrans.from_s(row['transform'])
  if row['name'].startswith('via_1') and abs(tr.disp.x-1554.15)<.001:tr.disp=db.DVector(1569,-59.75)
  top.insert(db.DCellInstArray(c.cell_index(),tr))
 removed=[]
 for row in data['shapes']:
  layer=row['layer'];s=row['shape']
  if layer==[13,0] and s.startswith('path (1555850,'):continue
  if layer==[13,0] and s.startswith('path (561650,59750;'):continue
  # All original power wires are M1 paths. Keep every signal shape verbatim.
  if layer==[13,0] and s.startswith('path'):
   path=db.Path.from_s(s[5:]);pts=list(path.each_point())
   power=(all(p.y==pts[0].y for p in pts) and pts[0].y in (-96550,15050,103450,215050))
   power|=pts[0]==db.Point(1444000,15050)
   if power:removed.append(s);continue
  if layer==[48,0] and s.startswith("text ('VDD'"):continue
  if layer==[48,0] and s.startswith("text ('VSS'"):continue
  shapes=top.shapes(ly.layer(*layer))
  if s.startswith('path'):shapes.insert(db.Path.from_s(s[5:]))
  elif s.startswith('box'):shapes.insert(db.Box.from_s(s[4:]))
  elif s.startswith('text'):shapes.insert(db.Text.from_s(s[5:]))
  else:raise ValueError(s)
 assert len(removed)==10,len(removed)
 d.route('cout','M2',[(1562.45,-59.75),(1569,-59.75)])
 d.route('cout','M1',[(1569,-59.75),(1577.6,-59.75)])
 # The wider lower-row VDD occupies the former C1 channel. Lift only C1
 # above the power trunks, retaining the original endpoints and logic.
 d.route('c1','M1',[(561.65,59.75),(568.5,59.75)]);d.via('c1',568.5,59.75)
 d.route('c1','M2',[(568.5,59.75),(568.5,330)]);d.via('c1',568.5,330)
 d.route('c1','M1',[(568.5,330),(1308.45,330)]);d.via('c1',1308.45,330)
 d.route('c1','M2',[(1308.45,330),(1308.45,20.65)])

 def array(net,x,y,nx=4,ny=2):
  for j in range(ny):
   for i in range(nx):d.via(net,x+4*(i-(nx-1)/2),y+4*(j-(ny-1)/2))
  for layer in ('M1','M2'):d.box(layer,x-2*(nx-1)-1.7,y-2*(ny-1)-1.7,x+2*(nx-1)+1.7,y+2*(ny-1)+1.7)

 # Uniform 44 um trunks, 60 um center spacing; no alternating-width overlay.
 for net,y in [('VDD',235),('VSS',295)]:d.box('M1',-132,y-22,1601,y+22)
 for hx in (-96.05,600.9):
  # Distributed VDD injection over the whole top row; lower-row feed has 3 cuts.
  d.box('M1',hx,213.35,hx+660,235)
  # VSS rises outside the HA so it cannot cross its M2 signal tracks.
  x=hx-20
  d.box('M1',x-8,89.15,hx+16,105.15)
  array('VSS',x,97.15)
  d.route('VSS','M2',[(x,97.15),(x,295)],4)
  array('VSS',x,295)
 # Stitch matching HA row supplies at the FA level; child cells remain reusable.
 # Upper VSS, lower VDD, and bottom VSS continue across the inter-HA gap.
 for low,high in [(89.15,105.15),(13.35,25.35),(-110.85,-94.85)]:
  d.box('M1',563.95,low,600.9,high)
 # Continue the bottom VSS to the carry-merge/output rail as well.
 d.box('M1',1260.9,-110.85,1312,-94.85)
 # Continue lower VDD into the merge NANY; C1 crosses on M2 without a via.
 d.box('M1',1260.9,13.35,1320,25.35)
 # The shorter output INV has a lower VDD edge; use its empty left gutter.
 d.route('VDD','M1',[(1460,15.05),(1464.4,15.05),(1464.4,-33.95),(1476.45,-33.95)])
 # Merge NANY and output INV share a widened bottom VSS rail, with a separate feed.
 d.box('M1',1312,-110.85,1593,-94.85)
 array('VSS',1585,-102.85)
 d.route('VSS','M2',[(1585,-102.85),(1585,295)],4)
 array('VSS',1585,295)
 for x,y,x0,x1 in [(1432,15.05,1312,1460),(1542,-33.95,1468.45,1564.45)]:
  d.box('M1',x0+8,y-1.7,x1,y+10.3)
  array('VDD',x,y+4)
  d.route('VDD','M2',[(x,y+4),(x,235)],3.4)
  array('VDD',x,235)
 ports={n:port(d,n,'M1',x,y) for n,x,y in [('a',-128.45,29.5),('b',-128.75,36.1),('cin',620.9,35.75),('sum',1340.9,78.1),('cout',1576.25,-59.1),('VMID',-121.65,83.8),('VDD',600,235),('VSS',650,295)]}
 d.save('full_adder',ports,[ROOT/'half_adder.gds',ROOT/'nany.gds',ROOT/'inverter.gds',TEMPLATE],dict(device_counts=dict(PMOS=49,NMOS=49,F_RR=32),manual_signal_routing_preserved_except=['C1 lifted over widened power rails','Cout via moved outside widened RR guard tie'],power_paths_replaced=removed))

if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--snapshot',type=lambda s:ROOT/s);a=p.parse_args()
 if a.snapshot:snapshot(a.snapshot)
 else:build()
