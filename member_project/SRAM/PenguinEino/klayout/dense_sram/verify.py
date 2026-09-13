#!/usr/bin/env python3
"""Run the unmodified local PDK's DRC/LVS, fault controls, and SPICE regression.

No rule waivers, implicit connections, ignored ports, or W/L tolerances are
introduced here. Verification reads the saved GDS; it does not regenerate it.
"""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import argparse
from datetime import datetime, timezone
import hashlib
import json
import os
import re
import subprocess
import sys

import klayout.db as db
import klayout.rdb as rdb

from build import reference

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0,str(ROOT/'scripts'))
from pdk_profiles import pdk_path
PDK = pdk_path()
SHAPES = ((1,1),(2,2),(4,4),(8,8),(16,64))


def metadata(source):
    layout=db.Layout();layout.read(str(source))
    box=layout.cell('sram_dense_16x64').dbbox()
    if box.width()>1800 or box.height()>600:
        raise RuntimeError('The rotated 1 Kbit array exceeds 600 x 1800 um')
    return {'verified_at_utc':datetime.now(timezone.utc).isoformat(),
            'gds_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
            'pdk_directory':str(PDK),
            'array_1k_rotated_um':[round(box.height(),1),round(box.width(),1)],
            'array_1k_fits_600x1800':True}


def run(command, log, cwd=None):
    result = subprocess.run([str(a) for a in command],cwd=cwd,
        env={**os.environ,'QT_QPA_PLATFORM':'offscreen'},
        stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
    log.write_text(result.stdout)
    if result.returncode:
        raise RuntimeError(f'{command[0]} failed: {log}\n{result.stdout[-2500:]}')
    return result.stdout


def check(layout, top, kind, out, circuit=None):
    report=out/f'{top}.{kind}db'
    report.unlink(missing_ok=True)
    deck=PDK/f'libs.tech/klayout/tech/{kind}/run.{kind}'
    command=['klayout','-b','-r',deck,'-rd',f'input={layout}',
             '-rd',f'top_cell={top}','-rd',f'report={report}']
    if kind=='lvs':
        command += ['-rd',f'circuit={circuit}',
                    '-rd',f'extracted={out}/{top}.extracted']
    output=run(command,out/f'{top}.{kind}.log')
    if not report.is_file():
        raise RuntimeError(f'Missing fresh {report}')
    if kind=='drc':
        result=rdb.ReportDatabase();result.load(str(report))
        count=result.num_items()
        return count==0,{'pdk_directory':str(PDK),'deck_sha256':hashlib.sha256(deck.read_bytes()).hexdigest(),
                        'items':count,'categories':{
            c.name():c.num_items() for c in result.each_category() if c.num_items()}}
    result=db.LayoutVsSchematic();result.read(str(report))
    pairs=list(result.xref().each_circuit_pair())
    errors=[e.message for e in result.each_error()]
    ok=('INFO : Congratulations! Netlists match.' in output and pairs and
        all(p.status()==db.NetlistCrossReference.Match for p in pairs) and not errors)
    return bool(ok),{'pdk_directory':str(PDK),'deck_sha256':hashlib.sha256(deck.read_bytes()).hexdigest(),
                     'circuit_pairs':[str(p.status()) for p in pairs],'errors':errors}


def faults(source,out,circuit):
    results={}
    for kind in ('cut_feedback','short_bitlines'):
        work=out/kind;work.mkdir(exist_ok=True)
        layout=db.Layout();layout.read(str(source))
        core=layout.cell('sram_dense')
        if kind=='cut_feedback':
            layer=layout.layer(8,1)
            region=db.Region(core.shapes(layer))
            region-=db.Region(db.Box(10,120,22,130))
            core.shapes(layer).clear();core.shapes(layer).insert(region)
        else:
            layout.cell('sram_dense_1x1').shapes(layout.layer(20,0)).insert(
                db.Box(29,-17,187,17))
        path=work/'fault.gds';layout.write(str(path))
        ok,detail=check(path,'sram_dense_1x1','lvs',work,circuit)
        if ok:
            raise RuntimeError(f'LVS accepted intentional {kind}')
        results[kind]='rejected by LVS'
        print(f'Fault control {kind}: rejected by LVS',flush=True)
    return results


def spice(out):
    work=out/'spice';work.mkdir(exist_ok=True)
    rc=work/'xschemrc'
    rc.write_text(f'''set XSCHEM_LIBRARY_PATH {ROOT}/learning/schematics:{ROOT}/sram512/schematics
append XSCHEM_LIBRARY_PATH :${{XSCHEM_SHAREDIR}}/xschem_library
append XSCHEM_LIBRARY_PATH :${{XSCHEM_SHAREDIR}}/xschem_library/devices
append XSCHEM_LIBRARY_PATH :{PDK}/libs.tech/xschem
append XSCHEM_LIBRARY_PATH :{PDK}/libs.tech/xschem/TR-1umLIB
set LIB {PDK}/libs.tech/spice/models
set local_netlist_dir 0
set netlist_dir {work}
set spiceprefix 1
set lvs_netlist 0
set top_is_subckt 0
set flat_netlist 0
''')
    schematic=ROOT/'learning/schematics/sram_tb_array_write_control.sch'
    generated=work/'sram_tb_array_write_control.spice'
    generated.unlink(missing_ok=True)
    run(['xschem','-x','-q','--rcfile',rc,'-n','-o',work,schematic],work/'xschem.log')
    netlist=generated.read_text()
    extracted=(out/'sram_dense_1x1.extracted').read_text()
    pins=re.search(r'(?im)^\.subckt\s+sram_dense_1x1\s+([^\n]+)',extracted).group(1).split()
    port_map={'BL0':'BL','BLB0':'BLB','Q':'Q','QB':'QB',
              'VDD':'Vdd','VSS':'Vss','WL0':'WL'}
    assert set(pins)==set(port_map),pins
    wrapper=('.subckt sram WL Vdd BLB Q QB BL Vss\nXlayout '+
             ' '.join(port_map[p] for p in pins)+' sram_dense_1x1\n.ends sram\n')
    netlist,n=re.subn(r'(?ims)^\.subckt[ \t]+sram[ \t]+.*?^\.ends[^\n]*',
                      lambda _:extracted+'\n'+wrapper,netlist)
    assert n==1,n
    # Remove display and waveform storage only; preserve stimuli and assertions.
    netlist='\n'.join(s for s in netlist.splitlines()
                      if not s.lstrip().startswith(('plot ','write ')))+'\n'
    netlist=netlist.replace('.endc','quit\n.endc')
    batch=work/'extracted_cell_array_tb.spice';batch.write_text(netlist)
    log=work/'ngspice.log'
    run(['ngspice','-b','-o',log,batch],work/'ngspice_process.log',cwd=work)
    text=log.read_text()
    if not re.search(r'^PASS: write control',text,re.M) or re.search(
            r'(?im)(^FAIL|^Error|^Warning|measurement.*failed)',text):
        raise RuntimeError(f'Extracted-cell SPICE failed: {log}')
    print('SPICE: extracted devices/junction geometry in existing 2x2 analog TB PASS',flush=True)
    return {'result':'PASS','conditions':'5 V, 27 C, CBL=10 fF, CY=100 fF',
            'scope':'Extracted 6T topology, W/L and AS/AD/PS/PD; interconnect RC not extracted.'}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,default=ROOT/'build/dense_sram')
    parser.add_argument('--skip-spice',action='store_true')
    args=parser.parse_args()
    out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
    source=HERE/'sram_dense.gds'
    for rows,cols in SHAPES:
        top=f'sram_dense_{rows}x{cols}'
        (out/(top+'.spice')).write_text(reference(top,rows,cols))
    def one(case):
        kind,rows,cols=case;top=f'sram_dense_{rows}x{cols}'
        ok,detail=check(source,top,kind,out,out/(top+'.spice'))
        print(f'{top} {kind.upper()}: {"PASS" if ok else "FAIL"} {detail}',flush=True)
        return top,kind,ok,detail
    report={**metadata(source),'checks':[]}
    with ThreadPoolExecutor(max_workers=4) as pool:
        results=list(pool.map(one,[(k,r,c) for r,c in SHAPES for k in ('drc','lvs')]))
    report['checks']=[{'top':t,'kind':k,'pass':p,**d} for t,k,p,d in results]
    (out/'results.json').write_text(json.dumps(report,indent=2)+'\n')
    if not all(r[2] for r in results):
        raise RuntimeError(f'DRC/LVS failed; see {out}')
    report['fault_controls']=faults(source,out,out/'sram_dense_1x1.spice')
    if not args.skip_spice:
        report['spice']=spice(out)
    (out/'results.json').write_text(json.dumps(report,indent=2)+'\n')
    print(f'All checks PASS. Reports: {out}',flush=True)


if __name__=='__main__':
    main()
