"""Additional loaded transient diagnostics using the unchanged dev PDK.

DC solutions are Newton estimates only. Real startup tests omit all nodesets.
The all-transition, tight native and extracted tests are in check_mac*.py.
"""
import argparse,json,re
from concurrent.futures import ThreadPoolExecutor,as_completed
from pathlib import Path
import numpy as np
import review_mac as r

ROOT=r.ROOT;WORK=ROOT/'simulation/mac_improvements/corners';REPORT=ROOT/'reports/mac_improvements'

def seed(base,temp,rail):
    tag=(f'supply_T{float(temp)}_fixed0_num0_power0_2.0_2.5_0.05' if rail<=5 else
         f'supply_T{float(temp)}_fixed0_num1_power0_0.5_7.0_0.05')
    folder=ROOT/'simulation/mac_improvements'/tag/'0'
    path=folder/('up.txt' if rail>5 else 'down.txt')
    with path.open() as f:names=f.readline().split()
    data=np.atleast_2d(np.loadtxt(path,skiprows=1));row=data[np.argmin(abs(data[:,0]-rail))]
    assert abs(row[0]-rail)<1e-6,(row[0],rail)
    volts={n:float(v) for n,v in zip(names,row) if n.startswith('v(')}
    assert all(abs(v)<rail+.5 for v in volts.values())
    seeds='\n'.join(f'.nodeset {n}={v:.12g}' for n,v in volts.items())
    return re.sub(r'(?m)^\.nodeset[^\n]*','',base).replace('.control',seeds+'\n.control')

def main(group):
    r.WORK=WORK;r.REPORT=REPORT;_,base=r.netlist('mac_tb')
    base=base.replace('reltol=1e-4','reltol=1e-3 abstol=1e-9 vntol=1e-5 trtol=10')
    cases=[]
    if group=='supply':
        for temp,rail in [(27,2.2),(27,2.5),(-40,2.5),(125,2.5),(27,3),(27,7)]:
            cases.append((f'T{temp}_rail{rail}',seed(base,temp,rail),dict(temp=temp,rail=rail)))
    elif group=='integration':
        for value in (-1,0,1):
            cases.append((f'startup_{value}',base,dict(states=[(value,)*4],no_nodeset=True,power_ramp_ns=100)))
        for resistance in (10,25,50):
            cases.append((f'feed_{resistance}ohm',base,dict(supply_resistance=resistance)))
        for offset in (-.5,.5):cases.append((f'zero_{offset}',base,dict(zero_offset=offset)))
    elif group=='stress':
        mos=r.mos_instances(base)
        vectors=[f'@m.{m["name"]}.m1[id]' for m in mos]
        cases=[('cold_current',seed(base,-40,5),dict(temp=-40,stress=True,extra_vectors=vectors))]
    elif group=='boundary':
        for rail in (2.1,2.15):cases.append((f'T27_rail{rail}',seed(base,27,rail),dict(rail=rail)))
        cases.append(('slow_edge_100ns',base,dict(edge_ns=100)))
    elif group=='slew_stress':
        for edge in (10,100):
            cases.append((f'cold_edge_{edge}ns',seed(base,-40,5),dict(temp=-40,edge_ns=edge,stress=True)))
    else:raise ValueError(group)
    results={}
    with ThreadPoolExecutor(max_workers=2) as pool:
        futures={pool.submit(r.simulate_case,b,n,cap_ff=10000,hold_ns=1000,resistance=1e6,maximum_step_ns=10,**kwargs):n for n,b,kwargs in cases}
        for future in as_completed(futures):
            name=futures[future]
            try:result=future.result()
            except Exception as exc:result=dict(simulation_error=repr(exc))
            result['passed']=not result.get('simulation_error') and result.get('logic_fail_samples')==0 and result.get('tolerance_fail_samples')==0
            results[name]=result
            r.output('corners_'+group,dict(cases=results,source_sha256={str(p.relative_to(ROOT)):r.sha(p) for p in ROOT.glob('*.sch')},model_sha256={str(p.relative_to(r.PDK)):r.sha(p) for p in (r.PDK/'libs.tech/spice/models').rglob('*') if p.is_file()},scope='Unchanged PDK; nominal process; 10 pF || 1 Mohm, 1 us hold. Not a foundry PVT or voltage-survival qualification.'))
            print(name,{k:v for k,v in result.items() if k not in ('mos_stress','extra_vector_peaks','transient_vector_peaks','failure_examples')},flush=True)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('group',choices=['supply','integration','stress','boundary','slew_stress']);main(p.parse_args().group)
