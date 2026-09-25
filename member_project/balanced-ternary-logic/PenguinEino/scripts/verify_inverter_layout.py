"""Verify INV GDS against the current Xschem cell and unmodified TR-1um decks.
Run after layout generation: python3 scripts/verify_inverter_layout.py
Reports: simulation/inverter_layout/verify and reports/inverter_layout.json.
"""
from pathlib import Path
import argparse,hashlib,json,os,re,subprocess,shutil
import klayout.db as db
import klayout.rdb as rdb
ROOT=Path(__file__).resolve().parents[1]
PDK=Path('/home/ishi-kai/pdk/TR-1um');TECH=PDK/'libs.tech/klayout/tech'
BIN='/home/ishi-kai/bin/klayout/klayout'
WORK=ROOT/'simulation/inverter_layout/verify'
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def run(cmd,d,log):
 d.mkdir(parents=True,exist_ok=True)
 env=dict(os.environ,QT_QPA_PLATFORM='offscreen');env.pop('KLAYOUT_PATH',None)
 with (d/log).open('w') as f:p=subprocess.run(list(map(str,cmd)),cwd=d,env=env,stdout=f,stderr=subprocess.STDOUT,timeout=240)
 return p.returncode,(d/log).read_text()
def reference():
 d=WORK/'reference';d.mkdir(parents=True,exist_ok=True)
 rc=d/'xschemrc';rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:{PDK}/libs.tech/xschem:{PDK}/libs.tech/xschem/TR-1umLIB}}\nset lvs_netlist 1\nset top_is_subckt 1\nset spiceprefix 1\n')
 code,log=run(['xschem','-r','-x','--rcfile',rc,'-s','--command','set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result','-o',d,ROOT/'inverter.sch'],d,'netlist.log')
 if code or re.search(r'Error:|SKIPPING|IS MISSING',log):raise RuntimeError('Reference netlisting failed: '+log[-1000:])
 text=(d/'inverter.spice').read_text()
 # Xschem's MOS symbols wrap SPICE simulation models; LVS reads native MOS devices.
 text=re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',r'M\1\2',text)
 out=d/'reference.spice';out.write_text(text);return out

def prepare_gui_reference(ref):
 # The official GUI LVS resolves simulation/<top>.spice beside the GDS.
 out=ROOT/'simulation/inverter.spice';out.parent.mkdir(parents=True,exist_ok=True)
 if out.exists() and out.read_bytes()!=Path(ref).read_bytes():
  shutil.copy2(out,out.with_name(f'inverter.{sha(out)[:16]}.spice.bak'))
 shutil.copy2(ref,out)
 return out

def drc(gds,top,d,deck='run.drc'):
 out=d/'drc.lyrdb';d.mkdir(parents=True,exist_ok=True);out.unlink(missing_ok=True)
 code,log=run([BIN,'-b','-r',TECH/'drc'/deck,'-rd',f'input={gds}','-rd',f'top_cell={top}','-rd',f'report={out}'],d,'drc.log')
 if code or not out.exists():return dict(passed=False,exit_code=code,error=log[-1500:])
 r=rdb.ReportDatabase();r.load(str(out))
 return dict(passed=r.num_items()==0,items=r.num_items(),categories={c.name():c.num_items() for c in r.each_category() if c.num_items()})
def lvs(gds,top,ref,d):
 out=d/'lvs.lvsdb';d.mkdir(parents=True,exist_ok=True);out.unlink(missing_ok=True)
 code,log=run([BIN,'-b','-r',TECH/'lvs/run.lvs','-rd',f'input={gds}','-rd',f'top_cell={top}','-rd',f'report={out}','-rd',f'circuit={ref}','-rd',f'extracted={d}/inverter.extracted'],d,'lvs.log')
 if code or not out.exists():return dict(passed=False,exit_code=code,error=log[-1500:])
 r=db.LayoutVsSchematic();r.read(str(out));pairs=list(r.xref().each_circuit_pair());errors=[e.message for e in r.each_error()]
 return dict(passed=bool(pairs) and all(p.status()==db.NetlistCrossReference.Match for p in pairs) and not errors and 'Congratulations! Netlists match.' in log,circuits=[str(p.status()) for p in pairs],errors=errors,strict_ports=True)
def mask(gds,top,d):
 d.mkdir(parents=True,exist_ok=True);out=d/'mask.gds'
 code,log=run([BIN,'-b','-r',TECH/'drc/run_mdp.drc','-rd',f'input={gds}','-rd',f'cellname={top}','-rd',f'output={out}'],d,'mdp.log')
 if code or not out.exists():return dict(passed=False,error=log[-1500:])
 result=drc(out,top,d/'check','run_IP62.drc');result['gds_sha256']=sha(out);return result

def check(gds,top='inverter'):
 gds=Path(gds).resolve();ref=reference();prepare_gui_reference(ref);layout=db.Layout();layout.read(str(gds));cell=layout.cell(top)
 if cell is None:raise RuntimeError('Missing cell '+top)
 forbidden={f'63/{dt}':db.Region(cell.begin_shapes_rec(layout.layer(63,dt))).area() for dt in [0,1,2]}
 assert not any(forbidden.values()),'No waiver regions permitted'
 rules={str(p.relative_to(PDK)):sha(p) for kind in ['drc','lvs'] for p in sorted((TECH/kind).rglob('*')) if p.is_file()}
 result=dict(gds=str(gds),gds_sha256=sha(gds),schematic_sha256=sha(ROOT/'inverter.sch'),reference_sha256=sha(ref),top=top,pdk=str(PDK),rule_sha256=rules,waiver_regions=0)
 result['drc']=drc(gds,top,WORK/'drawing');result['lvs']=lvs(gds,top,ref,WORK/'lvs');result['mask_drc']=mask(gds,top,WORK/'manufacturing')
 box=cell.dbbox();result['bbox_um']=[box.left,box.bottom,box.right,box.top]
 result['passed']=all(result[k]['passed'] for k in ['drc','lvs','mask_drc'])
 (ROOT/'reports').mkdir(exist_ok=True);(ROOT/'reports/inverter_layout.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({k:v for k,v in result.items() if k!='rule_sha256'},indent=2))
 return result
if __name__=='__main__':
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--gds',type=Path,default=ROOT/'inverter.gds')
 p.add_argument('--prepare-gui-reference',action='store_true',help='Regenerate only the schematic reference for the official GUI LVS')
 a=p.parse_args()
 if a.prepare_gui_reference:
  print(prepare_gui_reference(reference()));raise SystemExit(0)
 raise SystemExit(0 if check(a.gds)['passed'] else 1)
