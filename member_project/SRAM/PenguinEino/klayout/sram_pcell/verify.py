#!/usr/bin/env python3
"""Run unchanged TR-1um DRC/LVS on saved PCell layouts."""
from pathlib import Path
import argparse,hashlib,json,subprocess,sys
import klayout.db as db
import klayout.rdb as rdb
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(ROOT/'scripts'))
from pdk_profiles import pdk_path
PDK=pdk_path()
KLAYOUT='/home/ishi-kai/bin/klayout/klayout'

def check(source,top,kind,out):
    report=out/(top+'.'+kind+'db');report.unlink(missing_ok=True)
    cmd=[KLAYOUT,'-b','-r',str(PDK/f'libs.tech/klayout/tech/{kind}/run.{kind}'),
         '-rd',f'input={source}','-rd',f'top_cell={top}','-rd',f'report={report}']
    if kind=='lvs':cmd+=['-rd',f'circuit={out}/{top}.spice','-rd',f'extracted={out}/{top}.extracted']
    p=subprocess.run(cmd,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    (out/(top+'.'+kind+'.log')).write_text(p.stdout)
    if p.returncode or not report.exists():raise RuntimeError(p.stdout[-2000:])
    if kind=='drc':
        r=rdb.ReportDatabase();r.load(str(report))
        return dict(passed=r.num_items()==0,items=r.num_items(),categories={c.name():c.num_items() for c in r.each_category() if c.num_items()})
    r=db.LayoutVsSchematic();r.read(str(report));pairs=list(r.xref().each_circuit_pair());errors=[e.message for e in r.each_error()]
    return dict(passed=bool(pairs) and all(p.status()==db.NetlistCrossReference.Match for p in pairs) and not errors and 'Congratulations! Netlists match.' in p.stdout,
                circuit_pairs=[str(p.status()) for p in pairs],errors=errors)

def verify(out,top,verbose=True):
    out=Path(out).resolve();source=out/'pcell.gds'
    result=dict(top=top,gds_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),pdk_directory=str(PDK),
                drc_deck_sha256=hashlib.sha256((PDK/'libs.tech/klayout/tech/drc/run.drc').read_bytes()).hexdigest())
    for kind in ('drc','lvs'):result[kind]=check(source,top,kind,out)
    (out/(top+'.result.json')).write_text(json.dumps(result,indent=2)+'\n')
    if verbose:print(json.dumps(result,indent=2),flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--out',type=Path,default=ROOT/'build/sram_pcell/tr_split')
    p.add_argument('--top',default='pcell_2x2');a=p.parse_args();verify(a.out,a.top)
