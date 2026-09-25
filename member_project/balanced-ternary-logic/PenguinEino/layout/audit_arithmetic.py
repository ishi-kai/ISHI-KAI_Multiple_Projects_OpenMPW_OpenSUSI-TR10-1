"""Audit saved geometry cold, then verify current dev PCell regeneration and grid."""
import hashlib,json
from pathlib import Path
import klayout.db as db
ROOT=Path(__file__).resolve().parents[1]
def regions(ly,c):return {str(ly.get_info(i)):db.Region(c.begin_shapes_rec(i)).merged() for i in ly.layer_indexes()}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 names=('inverter','nany','half_adder','full_adder','mul_nand','mul_nor','mul_inv','mul','mac');cold={}
 for name in names:
  ly=db.Layout();ly.read(str(ROOT/f'{name}.gds'));assert ly.dbu==.001
  assert not any(c.is_pcell_variant() for c in ly.each_cell());cold[name]=ly
 from build_inverter import PDK
 result={}
 for name in names:
  old=cold[name];new=db.Layout();new.technology_name='TR-1um';new.read(str(ROOT/f'{name}.gds'))
  a=regions(old,old.cell(name));b=regions(new,new.cell(name));delta={k:(a.get(k,db.Region())^b.get(k,db.Region())).area() for k in set(a)|set(b)}
  assert not any(delta.values()),(name,delta)
  variants=[];placements=0;bad=[]
  for c in new.each_cell():
   assert '<defunct>' not in c.name,c.name
   if c.is_pcell_variant():variants.append(dict(cell=c.name,parameters=c.pcell_parameters_by_name()))
   for i in c.each_inst():
    tr=i.dcplx_trans;assert abs(tr.mag-1)<1e-12,(c.name,tr)
    placements+=1
    for v in (tr.disp.x,tr.disp.y):assert abs(v/.05-round(v/.05))<1e-6,(c.name,tr)
  for li in old.layer_indexes():
   reg=db.Region(old.cell(name).begin_shapes_rec(li))
   for poly in reg.each():
    for pt in poly.each_point_hull():
     if pt.x%50 or pt.y%50:bad.append([str(old.get_info(li)),pt.x,pt.y])
    for h in range(poly.holes()):
     for pt in poly.each_point_hole(h):
      if pt.x%50 or pt.y%50:bad.append([str(old.get_info(li)),pt.x,pt.y])
  assert not bad,(name,bad[:10]);assert variants
  b=old.cell(name).dbbox()
  if name=='mac':
   assert b.left>=0 and b.bottom>=0 and b.right<=1800 and b.top<=1000,('Outside 1800 x 1000 um allocation',b)
   def origins(cell,transform):
    for inst in cell.each_inst():
     for local in inst.cell_inst.each_cplx_trans():
      tr=transform*local;x,y=tr.disp.x*old.dbu,tr.disp.y*old.dbu
      assert 0<=x<=1800 and 0<=y<=1000,(cell.name,inst.cell.name,x,y)
      origins(inst.cell,tr)
   origins(old.cell(name),db.ICplxTrans())
  result[name]=dict(gds_sha256=sha(ROOT/f'{name}.gds'),dbu_um=.001,grid_um=.05,saved_vs_regenerated_xor_um2=0,off_grid_polygon_points=0,placements=placements,all_magnifications_one=True,pcell_variants=variants,logical_cells=[c.name for c in new.each_cell() if not c.is_pcell_variant()])
 result['mac']['allocation_um']=[0,0,1800,1000]
 result['mac']['fits_allocation']=True
 r=dict(passed=True,cold_read_before_library_registration=True,cells=result,pdk_sources_sha256={str(p):sha(p) for p in sorted((PDK/'libs.tech/klayout/tech/python/cells').glob('*.py'))})
 (ROOT/'reports/arithmetic_pcell_audit.json').write_text(json.dumps(r,indent=2)+'\n');print('PASS: cold geometry, live PCells, grid, hierarchy, and unit magnifications')
if __name__=='__main__':main()
