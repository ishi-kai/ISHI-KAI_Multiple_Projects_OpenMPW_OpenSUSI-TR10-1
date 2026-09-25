"""Check four isolated NANY placements (R0/MY/MX/R180) with a declared gap.
This is a geometry/spacing fixture, not an electrically wired FA or abutment proof.
"""
from pathlib import Path
import argparse,json
import klayout.db as db
from verify_nany_layout import ROOT,WORK,drc,mask,sha

def check(gap=12,source=None):
 source=Path(source or ROOT/'nany.gds');l=db.Layout();l.read(str(source));inv=l.cell('nany');b=inv.dbbox()
 assert abs(b.left)<1e-6 and abs(b.bottom)<1e-6,'Cell requires positive-origin bbox'
 w,h=b.width(),b.height();top=l.create_cell('nany_placement_check');transforms=[]
 for name,rot,x,y in [('R0',db.Trans.R0,0,0),('MY',db.Trans.M90,2*w+gap,0),('MX',db.Trans.M0,0,2*h+gap),('R180',db.Trans.R180,2*w+gap,2*h+gap)]:
  tr=db.Trans(rot,round(x/l.dbu),round(y/l.dbu));top.insert(db.CellInstArray(inv.cell_index(),tr));transforms.append(dict(orientation=name,origin_um=[x,y]))
 d=WORK/'placement';d.mkdir(parents=True,exist_ok=True);gds=d/'nany_placement.gds';l.write(str(gds))
 result=dict(source_sha256=sha(source),gap_um=gap,placements=transforms,drc=drc(gds,top.name,d/'drawing'),mask_drc=mask(gds,top.name,d/'manufacturing'),scope='Four isolated replicas: geometric spacing with mirrors/rotation, no inter-cell routing. No zero-gap abutment claim.')
 result['passed']=result['drc']['passed'] and result['mask_drc']['passed']
 result['spacing_only_passed']=set(result['drc']['categories'])<={'GC.ANT:GC must electrically connect to Substrate (or text if not chip level)'} and set(result['mask_drc']['categories'])<={'WAR06: Floating SG Detected'}
 result['open_input_warning_note']='Isolated replicas intentionally have no input discharge path. Raw Drawing/mask failures are retained; spacing-only is not manufacturing acceptance.'
 (ROOT/'reports/nany_placement.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2));return result
if __name__=='__main__':
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--gap',type=float,default=12);p.add_argument('--gds');a=p.parse_args();raise SystemExit(0 if check(a.gap,a.gds)['passed'] else 1)
