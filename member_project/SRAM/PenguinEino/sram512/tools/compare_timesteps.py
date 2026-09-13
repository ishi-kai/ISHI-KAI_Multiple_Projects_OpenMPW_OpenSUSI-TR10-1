#!/usr/bin/env python3
"""Compare identical full-array circuits under different numerical settings."""
import numpy as np
from common import *
from analog import load_raw,scenario


def main(coarse='pd102_rc3_addr0_5us',fine='pd102_rc3_addr0_5us_fine',output='pd102_timestep_comparison'):
    names=(coarse,fine)
    dirs=[WORK/'analog'/n for n in names]
    results=[json.loads((d/'result.json').read_text()) for d in dirs]
    assert all(r['passed'] for r in results)
    assert results[0]['physical_extraction']['gds_sha256']==results[1]['physical_extraction']['gds_sha256']
    def without_step(d):
        deck=re.sub(r'(?m)^(tran \S+ \S+ 0) \S+$',r'\1 MAXSTEP',(d/'test.spice').read_text())
        deck=re.sub(r'(?m)^\.options reltol=\S+\n','',deck)
        return re.sub(r'(?m)^set num_threads=\d+\n','',deck)
    assert without_step(dirs[0])==without_step(dirs[1])
    waves=[load_raw(d/'sram512_tb.raw') for d in dirs];case=scenario(period=5000,addresses=[0])
    rows=[];edges=[]
    for i,op in enumerate(case['operations']):
        point=op['e0']+7.8*5000
        for n in ('xarray.xr0c0.q','xarray.xr0c0.qb','sdo'):
            values=[float(np.interp(point,t,w[f'v({n})'])) for t,w in waves]
            rows.append(dict(operation=i,net=n,voltages_v=values,difference_v=abs(values[1]-values[0])))
        if not op['write']:continue
        crossings=[]
        for t,w in waves:
            mask=(t>=op['e0']+3*5000)&(t<=op['e0']+5*5000)
            q=w['v(xarray.xr0c0.q)'][mask];ti=t[mask]
            ix=np.flatnonzero((q[:-1]<2.25)&(q[1:]>=2.25) if op['data'] else (q[:-1]>2.25)&(q[1:]<=2.25))
            crossings.append(None if not len(ix) else float(ti[ix[0]]+(2.25-q[ix[0]])*(ti[ix[0]+1]-ti[ix[0]])/(q[ix[0]+1]-q[ix[0]])))
        assert (crossings[0] is None)==(crossings[1] is None)
        if crossings[0] is not None:edges.append(dict(operation=i,times_ns=crossings,difference_ns=abs(crossings[1]-crossings[0])))
    assert edges
    result=dict(passed=max(r['difference_v'] for r in rows)<.02 and max(r['difference_ns'] for r in edges)<5,
                source_gds_sha256=results[0]['physical_extraction']['gds_sha256'],
                compared_maximum_steps_ns=[r['maximum_timestep_ns'] for r in results],physical_mos=4953,
                compared_reltol=[r.get('numerical_reltol') or .001 for r in results],
                voltage_checks=rows,write_threshold_crossings=edges,
                scope='Identical full 512-bit circuit and stimuli, RCx3 at 4.5 V / 85 C. Both independent functional/RC test runs also pass.')
    write_json(REPORTS/(output+'.json'),result)
    print(result['passed'],result['compared_maximum_steps_ns'],result['write_threshold_crossings'],flush=True)
    return result


if __name__=='__main__':
    import argparse
    p=argparse.ArgumentParser();p.add_argument('--coarse',default='pd102_rc3_addr0_5us');p.add_argument('--fine',default='pd102_rc3_addr0_5us_fine');p.add_argument('--output',default='pd102_timestep_comparison');a=p.parse_args()
    raise SystemExit(0 if main(a.coarse,a.fine,a.output)['passed'] else 1)
