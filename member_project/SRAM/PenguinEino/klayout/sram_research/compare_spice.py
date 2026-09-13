#!/usr/bin/env python3
"""Compare actual extracted 2x2 arrays under the existing read/write testbench.

No interconnect R/C extractor is available here. MOS geometry and junction
AS/AD/PS/PD are extracted; external bitline capacitance is swept explicitly.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib,json,re,sys
import numpy as np
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
from verify import run,PDK
OUT=ROOT/'build/sram_research/spice'
MODEL_NEWEST=max(p.stat().st_mtime for p in (PDK/'libs.tech/spice/models').rglob('*') if p.is_file())


def netlist_tb():
    OUT.mkdir(parents=True,exist_ok=True)
    rc=OUT/'xschemrc'
    rc.write_text(f'''set XSCHEM_LIBRARY_PATH {ROOT}
append XSCHEM_LIBRARY_PATH :${{XSCHEM_SHAREDIR}}/xschem_library
append XSCHEM_LIBRARY_PATH :${{XSCHEM_SHAREDIR}}/xschem_library/devices
append XSCHEM_LIBRARY_PATH :{PDK}/libs.tech/xschem
append XSCHEM_LIBRARY_PATH :{PDK}/libs.tech/xschem/TR-1umLIB
set LIB {PDK}/libs.tech/spice/models
set local_netlist_dir 0
set netlist_dir {OUT}
set spiceprefix 1
set lvs_netlist 0
set top_is_subckt 0
set flat_netlist 0
''')
    schematic=ROOT/'learning/schematics/sram_tb_array_write_control.sch'
    run(['xschem','-x','-q','--rcfile',rc,'-n','-o',OUT,schematic],OUT/'xschem.log')
    text=(OUT/'sram_tb_array_write_control.spice').read_text()
    text='\n'.join(s for s in text.splitlines() if not s.lstrip().startswith(('plot ','write ')))+'\n'
    return text.replace('.endc','quit\n.endc')


def probe_tb(template,variant):
    folder='baseline_fit' if variant=='baseline' else 'euler_shared'
    top=variant+'_probe_2x2'
    path=ROOT/f'build/sram_research/verified/{folder}/{top}.extracted'
    extracted=path.read_text()
    pins=re.search(r'(?im)^\.subckt\s+\S+\s+([^\n]+)',re.sub(r'\n\+\s*',' ',extracted)).group(1).split()
    wanted={'VDD','VSS','WL0','WL1','BL0','BLB0','BL1','BLB1'}|{f'{q}{r}{c}' for r in range(2) for c in range(2) for q in ('Q','QB')}
    assert set(pins)==wanted,pins
    text,n=re.subn(r'(?im)^xc[01][01]\s+[^\n]+\bsram\s*$', '',template)
    assert n==4,n
    instance='Xmemory '+' '.join('GND' if p=='VSS' else p for p in pins)+' '+top+'\n'
    text,n=re.subn(r'(?ims)^\.subckt[ \t]+sram[ \t]+.*?^\.ends[^\n]*',lambda _:extracted,text)
    assert n==1,n
    return text.replace('**** begin user architecture code',instance+'**** begin user architecture code')


def simulate(case):
    variant,template,temp,cap=case
    out=OUT/f'{variant}_{temp}_{cap}';out.mkdir(exist_ok=True)
    text=template.replace('.param CBL=10f CY=100f',f'.param CBL={cap} CY=100f\n.temp {temp}')
    assert f'CBL={cap}' in text
    path=out/'test.spice';log=out/'ngspice.log'
    cached=path.exists() and path.read_text()==text and log.exists() and 'PASS: write control' in log.read_text() and log.stat().st_mtime>=max(path.stat().st_mtime,MODEL_NEWEST)
    if not cached:
        path.write_text(text)
        run(['ngspice','-b','-o',log,path],out/'process.log',cwd=out)
    output=log.read_text()
    passed=bool(re.search(r'^PASS: write control',output,re.M)) and not re.search(r'(?im)(^FAIL|^Error|^Warning|measurement.*failed)',output)
    # Collect the sensing differential before SAE for all eight read cycles.
    diffs={m.group(1):float(m.group(2)) for m in re.finditer(r'(?im)^(diff_\d+)\s*=\s*([-+\d.eE]+)',output)}
    result={'variant':variant,'vdd_v':5,'temperature_c':temp,'cbl':cap,'cy':'100f','pass':passed,
            'min_abs_read_diff_v':min(map(abs,diffs.values())) if diffs else None,
            'read_differentials_v':diffs,'log':str(log.relative_to(ROOT))}
    print(f'{variant} {temp} C CBL={cap}: {"PASS" if passed else "FAIL"}',flush=True)
    return result


def dc_snm(variant,read):
    folder,top=('baseline_fit','sram_dense_1x1') if variant=='baseline' else ('euler_shared','euler_shared_1x1')
    path=ROOT/f'build/sram_research/verified/{folder}/{top}.extracted'
    extracted=path.read_text()
    pins=re.search(r'(?im)^\.subckt\s+\S+\s+([^\n]+)',re.sub(r'\n\+\s*',' ',extracted)).group(1).split()
    curves=[]
    for force,output in (('Q','QB'),('QB','Q')):
        out=OUT/f'{variant}_{"read" if read else "hold"}_{force}';out.mkdir(exist_ok=True)
        port_map={'VDD':'vdd','VSS':'0','BL0':'vdd','BLB0':'vdd','WL0':'wl','Q':'q','QB':'qb'}
        text=f'''DC transfer curve for static noise margin
.include {PDK}/libs.tech/spice/models/ip62_models
.temp 27
VDD vdd 0 5
VWL wl 0 {5 if read else 0}
Vforce {force.lower()} 0 0
Xcell {' '.join(port_map[p] for p in pins)} {top}
{extracted}
.control
set wr_singlescale
set wr_vecnames
dc Vforce 0 5 0.0025
wrdata curve.txt v({force.lower()}) v({output.lower()})
quit
.endc
.end
'''
        deck=out/'dc.spice';deck.write_text(text)
        (out/'curve.txt').unlink(missing_ok=True)
        run(['ngspice','-b',deck],out/'dc.log',cwd=out)
        if re.search(r'(?im)^(error|warning)',(out/'dc.log').read_text()):
            raise RuntimeError(f'DC simulation error: {out}')
        a=np.loadtxt(out/'curve.txt',skiprows=1)
        x,y=a[:,1],a[:,2]
        curves.append((x,y) if force=='Q' else (y,x))
    # Rotate (Q,QB) so square diagonals become vertical distances, as in Teman.
    root2=np.sqrt(2);rot=[]
    for x,y in curves:
        u=(x-y)/root2;v=(x+y)/root2;order=np.argsort(u)
        rot.append((u[order],v[order]))
    u=np.linspace(max(a[0][0] for a in rot),min(a[0][-1] for a in rot),10001)
    diff=np.interp(u,*rot[0])-np.interp(u,*rot[1])
    lobes=[float(max(diff)/root2),float(-min(diff)/root2)]
    assert min(lobes)>0,lobes
    dest=OUT/f'{variant}_{"read" if read else "hold"}_vtc.csv'
    np.savetxt(dest,np.column_stack([*curves[0],*curves[1]]),delimiter=',',header='q_1,qb_1,q_2,qb_2',comments='',fmt='%.7g')
    return {'variant':variant,'mode':'read' if read else 'hold','vdd_v':5,'temperature_c':27,
            'snm_v':min(lobes),'lobes_v':lobes,'dc_step_v':.0025}


def main():
    tb=netlist_tb()
    templates={v:probe_tb(tb,v) for v in ('baseline','euler_shared')}
    cases=[(v,t,temp,cap) for v,t in templates.items() for temp in (-40,27,85) for cap in ('10f','100f','1p')]
    with ThreadPoolExecutor(max_workers=3) as p:transient=list(p.map(simulate,cases))
    static=[dc_snm(v,read) for v in templates for read in (False,True)]
    report={'model_file':str(PDK/'libs.tech/spice/models/models_IP62_mos_v2.lib'),
            'model_sha256':hashlib.sha256((PDK/'libs.tech/spice/models/models_IP62_mos_v2.lib').read_bytes()).hexdigest(),
            'testbench_sha256':hashlib.sha256((ROOT/'learning/schematics/sram_tb_array_write_control.sch').read_bytes()).hexdigest(),
            'scope':'Actual 2x2 GDS extracted MOS including junction geometry; nominal process model; no wire RC or mismatch.',
            'transient':transient,'static_noise_margin':static}
    (HERE/'spice_comparison.json').write_text(json.dumps(report,indent=2)+'\n')
    if any(not x['pass'] for x in transient if x['temperature_c']==27 and x['cbl']=='10f'):
        raise RuntimeError('Nominal existing testbench failed')


if __name__=='__main__':main()
