#!/usr/bin/env python3
"""Hold/read SNM from extracted MOS, using the earlier rotated-VTC procedure.
Teman SRAM lecture pp.33-53; no wire parasitics or mismatch model.
"""
from pathlib import Path
import json,re,sys,hashlib
import numpy as np
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
from verify import run,PDK
OUT=ROOT/'build/sram_compact/dc'
def dc_snm(variant,read):
    top='compact_1x1'
    path=ROOT/f'build/sram_compact/{top}.extracted'
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
    OUT.mkdir(parents=True,exist_ok=True)
    values=[dc_snm('compact',read) for read in (False,True)]
    result=dict(model_sha256=hashlib.sha256((PDK/'libs.tech/spice/models/models_IP62_mos_v2.lib').read_bytes()).hexdigest(),
        extracted_sha256=hashlib.sha256((ROOT/'build/sram_compact/compact_1x1.extracted').read_bytes()).hexdigest(),
        results=values)
    (HERE/'snm.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))


if __name__=='__main__':main()
