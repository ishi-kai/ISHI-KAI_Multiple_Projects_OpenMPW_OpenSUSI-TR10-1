"""Single aligned row of four qualified MUL gates above a shared signal channel."""
import json
import klayout.db as db
from arithmetic_helpers import ROOT,import_tree,Route,port

ROW_Y=100
WIDTH=820

def build():
 ly=db.Layout();ly.dbu=.001;ly.technology_name='TR-1um';top=ly.create_cell('mul');d=Route(ly,top)
 sources=[ROOT/f'mul_{k}.gds' for k in ('nand','nor','inv')]
 cells={k:import_tree(ly,ROOT/f'mul_{k}.gds','mul_'+k) for k in ('nand','nor','inv')}
 meta={k:json.loads((ROOT/f'layout/mul_{k}.ports.json').read_text()) for k in cells}
 tracks={n:6*i for i,n in enumerate(('a','b','t1','t2','t3','p'))};ends={n:[] for n in tracks}
 places=[('x_t1','nand',40,{'a':'a','b':'b','vout':'t1'}),('x_t2','nor',240,{'a':'a','b':'b','vout':'t2'}),('x_t3','inv',440,{'vin':'t2','vout':'t3'}),('x_p','nand',640,{'a':'t1','b':'t3','vout':'p'})]
 for role,kind,x,pins in places:
  y=ROW_Y;d.instance(cells[kind],role,x,y);ports=meta[kind]['ports'];width=meta[kind]['width_um']
  for pin,net in pins.items():
   px,py=ports[pin]['position_um'];px+=x;py+=y;layer='M1' if ports[pin]['layer']==[13,0] else 'M2'
   ex=x+width+8 if pin=='vout' else x-12 if pin=='a' else x-18
   d.route(net,layer,[(px,py),(ex,py)])
   if layer=='M1':d.via(net,ex,py)
   d.route(net,'M2',[(ex,py),(ex,tracks[net])]);d.via(net,ex,tracks[net]);ends[net].append(ex)
  if kind=='inv':
   yy=y+64.3
   d.route('VDD','M1',[(x+width-1.7,yy),(x+width+18,yy),(x+width+18,y+124.3)])
 # Shared straight supply rails; parent MAC widens them outward to 44 um.
 d.box('M1',0,ROW_Y-12.6,WIDTH,ROW_Y+3.4)
 d.box('M1',0,ROW_Y+122.6,WIDTH,ROW_Y+134)
 ports={}
 for net,yy in tracks.items():
  xs=ends[net].copy()
  if net in ('a','b'):xs.append(20)
  if net in ('p','t1','t3'):xs.append(796)
  d.route(net,'M1',[(min(xs),yy),(max(xs),yy)])
  if net in ('a','b','p','t1','t3'):ports[net]=port(d,net,'M1',20 if net in ('a','b') else 796,yy)
 for net,yy in [('VDD',ROW_Y+124.3),('VSS',ROW_Y+1.7)]:ports[net]=port(d,net,'M1',WIDTH-4,yy)
 d.save('mul',ports,sources,dict(device_counts=dict(PMOS=7,NMOS=7,F_RR=8),aligned_cell_origin_y_um=ROW_Y))
if __name__=='__main__':build()
