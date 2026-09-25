"""Check actual aligned trunk coverage, via arrays and seven-cell row in saved GDS."""
from pathlib import Path
import hashlib,json
import klayout.db as db
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 ly=db.Layout();ly.read(str(ROOT/'mac.gds'));assert ly.dbu==.001
 top=ly.cell('mac');m1=db.Region(top.begin_shapes_rec(ly.layer(13,0))).merged();m2=db.Region(top.begin_shapes_rec(ly.layer(20,0))).merged();via=db.Region(top.begin_shapes_rec(ly.layer(19,0))).merged()
 def box(b):return db.Region(db.Box(*(round(v/ly.dbu) for v in b)))
 rails=[]
 for name,left,right,y in [('upper_VDD',20,1790,744.6),('upper_VSS',20,1480,581.4),('FA_VDD',48,1781,358.2),('FA_VSS',48,1781,418.2)]:
  bounds=[left,y-22,right,y+22];assert (box(bounds)-m1).is_empty(),name
  rails.append(dict(name=name,box_um=bounds,width_um=44,missing_area_um2=0))
 spines=[]
 for name,x,low,high in [('VDD',880,358.2,744.6),('VSS',860,418.2,581.4)]:
  bounds=[x-7,low,x+7,high];assert (box(bounds)-m2).is_empty()
  landings=[]
  for y in (low,high):
   for j in range(8):
    for i in range(3):
     cx=x+4*(i-1);cy=y+4*(j-3.5);assert (box([cx-.7,cy-.7,cx+.7,cy+.7])-via).is_empty()
   window=box([x-5,y-15,x+5,y+15]);assert (via&window).count()==24
   landings.append(dict(center_um=[x,y],cuts=24))
  spines.append(dict(net=name,box_um=bounds,width_um=14,landings=landings))
 insts=list(top.each_inst());mul=next(i for i in insts if i.cell.name=='mul');upper=[]
 for k,i in enumerate(mul.cell.each_inst()):
  y=(mul.trans*i.trans).disp.y*ly.dbu;assert abs(y-600)<1e-8;upper.append(dict(cell=i.cell.name,index=k,y_um=y))
 for i in insts:
  if i.cell.name=='inverter':
   y=i.trans.disp.y*ly.dbu;assert abs(y-600)<1e-8;upper.append(dict(cell=i.cell.name,x_um=i.trans.disp.x*ly.dbu,y_um=y))
 assert len(upper)==7
 source=ROOT/'reports/mac_improvements/supply_T-40.0_fixed0_num0_power1_4.5_5.5_0.5.json';current=json.loads(source.read_text());row=next(r for r in current['rows'] if r['rail_V']==5)
 for name,digest in current['source_sha256'].items():assert sha(ROOT/name)==digest
 for name,digest in current['model_sha256'].items():assert sha(Path('/home/ishi-kai/pdk/TR-1um')/name)==digest
 assert row['max_supply_current_A']<.011
 result=dict(passed=True,gds_sha256=sha(ROOT/'mac.gds'),rails=rails,spines=spines,upper_cells=upper,dc_source=str(source.relative_to(ROOT)),dc_source_sha256=sha(source),maximum_total_dc_A=row['max_supply_current_A'],main_M1_conservative_capacity_A=.011,topology='Separate upper MUL/INV row and middle FA return; old 40 um shared return overlay removed.',scope='Actual geometric coverage and nominal +/-5 V DC screening; not wire RC, AC or EM signoff.')
 (ROOT/'reports/mac_alignment/power_geometry.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS: 4 uniform 44 um trunks, 14 um spines, 4 x 24 vias, 7 aligned cells')
if __name__=='__main__':main()
