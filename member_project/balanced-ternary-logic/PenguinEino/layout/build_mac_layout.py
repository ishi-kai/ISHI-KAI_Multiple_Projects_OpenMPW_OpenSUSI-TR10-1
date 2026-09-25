"""Aligned MUL/output gate row and uniform supply trunks above the hierarchical FA."""
import json
import klayout.db as db
from arithmetic_helpers import ROOT,import_tree,Route,port
from silicon_art import add_art

ALLOCATION_UM=(0,0,1800,1000)
ROW_Y=600
VDD_Y=744.6
VSS_Y=581.4
MAIN_WIDTH=44
RAIL_LEFT=20
RAIL_RIGHT=1480

def build():
 ly=db.Layout();ly.dbu=.001;ly.technology_name='TR-1um';top=ly.create_cell('mac');d=Route(ly,top)
 sources=[ROOT/'mul.gds',ROOT/'full_adder.gds',ROOT/'inverter.gds']
 mul=import_tree(ly,sources[0],'mul');fa=import_tree(ly,sources[1],'full_adder')
 inv=ly.cell('inverter');assert inv is not None
 d.instance(mul,'x_mul',20,500);d.instance(fa,'x_fa',180,123.2)
 for role,x in [('x_and',960),('x_or1',1160),('x_or2',1360)]:
  d.instance(inv,role,x,ROW_Y)
  d.route('VDD','M1',[(x+94.3,ROW_Y+64.3),(x+114,ROW_Y+64.3),(x+114,VDD_Y)])
 # All upper logic gates share the same baseline and the same straight supplies.
 for net,y in [('VDD',VDD_Y),('VSS',VSS_Y)]:d.box('M1',RAIL_LEFT,y-22,RAIL_RIGHT,y+22)
 d.route('nmin','M1',[(816,512),(940,512)]);d.via('nmin',940,512)
 d.route('nmin','M2',[(940,512),(940,625)]);d.via('nmin',940,625)
 d.route('nmin','M1',[(940,625),(962,625)])
 d.route('or_raw','M1',[(816,524),(1140,524)]);d.via('or_raw',1140,524)
 d.route('or_raw','M2',[(1140,524),(1140,625)]);d.via('or_raw',1140,625)
 d.route('or_raw','M1',[(1140,625),(1162,625)])
 d.route('or_n','M2',[(1254,638.5),(1280,638.5)]);d.via('or_n',1280,638.5)
 d.route('or_n','M1',[(1280,638.5),(1280,625),(1362,625)])
 for net,start,end in [('and_out',1054,1080),('or_out',1454,1480)]:
  d.route(net,'M2',[(start,638.5),(end,638.5)]);d.via(net,end,638.5)
  d.route(net,'M1',[(end,638.5),(end+6,638.5)])
 # Product enters FA.b through the left perimeter, below the FA VDD trunk.
 d.route('p','M1',[(816,530),(810,530)]);d.via('p',810,530)
 d.route('p','M2',[(810,530),(810,385)]);d.via('p',810,385)
 d.route('p','M1',[(24,385),(810,385)]);d.via('p',24,385)
 d.route('p','M2',[(24,385),(24,159.3)]);d.via('p',24,159.3)
 d.route('p','M1',[(24,159.3),(51.25,159.3)])
 d.route('x','M1',[(51.55,152.7),(32,152.7)]);d.via('x',32,152.7)
 d.route('x','M2',[(32,152.7),(32,485)])
 d.via('cin',800.9,158.95);d.route('cin','M2',[(800.9,158.95),(800.9,485)])
 d.route('cout','M1',[(1756.25,64.1),(1770,64.1)])
 def array(net,x,y,nx=3,ny=8):
  for j in range(ny):
   for i in range(nx):d.via(net,x+4*(i-(nx-1)/2),y+4*(j-(ny-1)/2))
  for layer in ('M1','M2'):d.box(layer,x-2*(nx-1)-1.7,y-2*(ny-1)-1.7,x+2*(nx-1)+1.7,y+2*(ny-1)+1.7)
 for net,x,low,high in [('VDD',880,358.2,VDD_Y),('VSS',860,418.2,VSS_Y)]:
  d.route(net,'M2',[(x,low),(x,high)],14);array(net,x,low);array(net,x,high)
 d.route('VMID','M1',[(58.35,207),(8,207)]);d.via('VMID',8,207)
 d.route('VMID','M2',[(8,207),(8,790)]);d.via('VMID',8,790)
 d.route('VMID','M1',[(8,790),(100,790)])
 # Right-edge access: M2 signal routes cross the existing M1 supply connections.
 d.box('M1',1480,VDD_Y-22,1790,VDD_Y+22)
 d.route('and_out','M2',[(1080,638.5),(1080,715),(1780,715)])
 d.route('or_out','M2',[(1480,638.5),(1480,705),(1780,705)])
 add_art(ly,top)
 # Shuttle access: inputs leave the left edge, outputs and supplies the right.
 # Cross existing internal vertical M2 trunks on M1, without adding vias there.
 d.route('a','M1',[(40,500),(5,500)])
 d.route('b','M1',[(40,506),(20,506),(20,530),(5,530)])
 d.via('x',32,485);d.route('x','M1',[(32,485),(5,485)])
 d.via('cin',800.9,475);d.route('cin','M1',[(800.9,475),(5,475)])
 d.route('sum','M1',[(1520.9,201.3),(1790,201.3)])
 d.route('cout','M1',[(1770,64.1),(1790,64.1)])
 d.box('M1',1781,396.2,1790,440.2)
 for net,y in [('and_out',715),('or_out',705)]:
  d.route(net,'M2',[(1780,y),(1790,y)])
 for net,x,y in [('a',10,500),('b',10,530),('x',10,485),('cin',10,475),('sum',1780,201.3),('cout',1780,64.1),('VMID',10,790)]:
  d.box('M1',x-3.2,y-3.2,x+3.2,y+3.2)
 for y in (705,715):d.box('M2',1776.8,y-3.2,1783.2,y+3.2)
 ports={n:port(d,n,l,x,y) for n,l,x,y in [('and_out','M2',1780,715),('or_out','M2',1780,705),('a','M1',10,500),('b','M1',10,530),('x','M1',10,485),('cin','M1',10,475),('sum','M1',1780,201.3),('cout','M1',1780,64.1),('VDD','M1',1780,VDD_Y),('VSS','M1',1780,418.2),('VMID','M1',10,790)]}
 b=top.dbbox();assert b.left>=0 and b.bottom>=0 and b.right<=1800 and b.top<=1000,b
 sources.append(ROOT/'layout/art/original_inverter_art.gds')
 d.save('mac',ports,sources,dict(device_counts=dict(PMOS=59,NMOS=59,F_RR=46),allocation_um=list(ALLOCATION_UM),fits_allocation=True,aligned_upper_cell_origin_y_um=ROW_Y,main_supply_width_um=MAIN_WIDTH,silicon_art=dict(cell='silicon_art',layer=[20,0],name=['EINOSUKE','OKAZAKI'],drawing='Penguin from original inverter GDS'),scope='Core macro without pad frame or interconnect RC extraction'))
if __name__=='__main__':build()
