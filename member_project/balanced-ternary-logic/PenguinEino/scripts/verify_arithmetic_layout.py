"""Official dev Drawing DRC, strict LVS and mask checks for generated arithmetic cells."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import argparse,json,re,shutil
import klayout.db as db
from verify_half_adder_layout import ROOT,PDK,TECH,BIN,run,sha,drc,mask
WORK=ROOT/'simulation/arithmetic_layout'
def reference(name,lvs=True):
 d=WORK/name/('reference' if lvs else 'simulation_reference');d.mkdir(parents=True,exist_ok=True)
 rc=d/'xschemrc';rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:{PDK}/libs.tech/xschem:{PDK}/libs.tech/xschem/TR-1umLIB}}\nset LIB {{{PDK}/libs.tech/spice/models}}\nset lvs_netlist {int(lvs)}\nset top_is_subckt 1\nset spiceprefix 1\n')
 code,log=run(['xschem','-r','-x','--rcfile',rc,'-s','--command','set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result','-o',d,ROOT/f'{name}.sch'],d,'netlist.log')
 if code or re.search(r'Error:|SKIPPING|IS MISSING',log):raise RuntimeError(log[-1500:])
 p=d/f'{name}.spice';s=p.read_text()
 if lvs:
  s=re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',r'M\1\2',s)
  p=d/'reference.spice';p.write_text(s)
  gui=ROOT/f'simulation/{name}.spice'
  if gui.exists() and gui.read_text()!=s:shutil.copy2(gui,d/f'previous_{sha(gui)[:16]}.spice')
  gui.write_text(s)
 return p

def lvs(name,gds,ref,d):
 d.mkdir(parents=True,exist_ok=True);out=d/'lvs.lvsdb';ext=d/f'{name}.extracted';out.unlink(missing_ok=True);ext.unlink(missing_ok=True)
 code,log=run([BIN,'-b','-r',TECH/'lvs/run.lvs','-rd',f'input={gds}','-rd',f'top_cell={name}','-rd',f'report={out}','-rd',f'circuit={ref}','-rd',f'extracted={ext}'],d,'lvs.log')
 if code or not out.exists():return dict(passed=False,error=log[-2000:])
 r=db.LayoutVsSchematic();r.read(str(out));pairs=list(r.xref().each_circuit_pair())
 logs=[str(e.message) for e in r.each_log_entry()];errors=[e.message for e in r.each_error()]
 return dict(passed=bool(pairs) and all(p.status()==db.NetlistCrossReference.Match for p in pairs) and not errors and 'Congratulations! Netlists match.' in log,
  circuits=[str(p.status()) for p in pairs],errors=errors,log_entries=logs,strict_ports=True,extracted=str(ext),report=str(out))

def check(name):
 gds=ROOT/f'{name}.gds';before=sha(gds);ref=reference(name);d=WORK/name
 ly=db.Layout();ly.read(str(gds));c=ly.cell(name);assert c is not None and ly.dbu==.001
 assert not any(db.Region(c.begin_shapes_rec(ly.layer(63,dt))).area() for dt in (0,1,2))
 with ThreadPoolExecutor(max_workers=3) as pool:
  fd=pool.submit(drc,gds,name,d/'drawing');fl=pool.submit(lvs,name,gds,ref,d/'lvs');fm=pool.submit(mask,gds,name,d/'manufacturing')
  drawing,compare,manufacturing=fd.result(),fl.result(),fm.result()
 assert sha(gds)==before,'GDS changed during verification'
 box=c.dbbox();r=dict(top=name,gds_sha256=before,schematic_sha256=sha(ROOT/f'{name}.sch'),reference_sha256=sha(ref),dbu_um=.001,bbox_um=[box.left,box.bottom,box.right,box.top],waiver_regions=0,
  drawing_drc=drawing,lvs=compare,mask_drc=manufacturing,
  rules_sha256={str(p.relative_to(PDK)):sha(p) for kind in ('drc','lvs') for p in sorted((TECH/kind).rglob('*')) if p.is_file()})
 r['drawing_lvs_passed']=drawing['passed'] and compare['passed'];r['all_rules_passed']=r['drawing_lvs_passed'] and manufacturing['passed']
 (ROOT/f'reports/{name}_layout.json').write_text(json.dumps(r,indent=2)+'\n')
 if compare['passed']:shutil.copy2(compare['extracted'],ROOT/f'{name}.extracted')
 print(json.dumps({k:v for k,v in r.items() if k!='rules_sha256'},indent=2),flush=True)
 return r
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('cells',nargs='+');args=p.parse_args();rr=[check(n) for n in args.cells]
 raise SystemExit(0 if all(r['drawing_lvs_passed'] for r in rr) else 1)
