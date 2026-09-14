#!/usr/bin/env python3
"""Instrument the extracted circuit; optionally evaluate a PC sizing proposal.

The optional width experiment is explicitly not an extracted-layout signoff.
Existing junction A/P values are retained as extra conservative loading while
only PC gate width changes. A selected proposal requires new layout extraction.
"""
import argparse,time
import numpy as np
from analog import scenario,verify,load_raw
from common import *

def run_case(source,name,pc_width=None):
    source=Path(source);work=WORK/'analog'/name;work.mkdir(parents=True,exist_ok=True)
    original=json.loads((source/'result.json').read_text())
    assert original['passed'] and original['deck_sha256']==sha(source/'test.spice')
    records=json.loads((source/'physical_devices.json').read_text())
    deck=(source/'test.spice').read_text();lines=[];changed=0
    for line in deck.splitlines():
        m=re.match(r'^XM(\d+) ',line)
        if m:
            r=records[int(m[1])];fields=line.split()
            for i,pin in enumerate(('D','G','S','B'),1):
                if r['nets'][pin]=='vss':
                    fields[i]='vss_body' if pin=='B' else 'vss_lower' if r['position_um'][1]<80 else 'vss_upper'
            if r['model']=='PMOS' and r['nets']['G']=='preb':
                for i,pin in enumerate(('D','G','S','B'),1):
                    if r['nets'][pin]=='vdd':fields[i]='vdd_pc'
                changed+=1
                if pc_width is not None:
                    assert abs(r['parameters']['W']-10.2)<1e-6
                    fields=[f'W={pc_width}u' if token.startswith('W=') else token for token in fields]
            line=' '.join(fields)
        elif line.startswith('Dphysical'):
            fields=line.split()
            for j in (1,2):
                if fields[j]=='0':fields[j]='vss_body'
            line=' '.join(fields)
        elif line.startswith('Cwire_'):
            fields=line.split();assert fields[2]=='0';fields[2]='vss_body';line=' '.join(fields)
        elif line.startswith('save '):
            line=line.replace('save ','save i(VVSS) i(VPC) i(VUP) i(VLO) i(VBU) ',1)
        elif line=='.control':
            lines+=['VVSS vss_monitor 0 0','VPC vdd vdd_pc 0',
                    'VUP vss_upper vss_monitor 0','VLO vss_lower vss_monitor 0','VBU vss_body vss_monitor 0']
        lines.append(line)
    assert changed==66,changed
    path=work/'test.spice';path.write_text('\n'.join(lines)+'\n')
    start=time.monotonic();print(name,'PC width',pc_width,'ngspice',flush=True)
    _,log=run(['ngspice','-b',path],work,'simulation.log');notices=simulation_diagnostics(log)
    case=scenario(period=original['period_ns']);result=verify(work/'sram512_tb.raw',case,original['voltage_v'])
    t,w=load_raw(work/'sram512_tb.raw');dt=np.diff(t);currents={}
    for n,sign in [('vvdd',-1),('vvss',1),('vpc',1),('vup',1),('vlo',1),('vbu',1)]:
        current=w['i('+n+')']*sign;peak=int(np.argmax(np.abs(current)))
        currents[n]=dict(peak_abs_a=float(abs(current[peak])),peak_ns=float(t[peak]),
            time_mean_a=float(np.sum((current[1:]+current[:-1])*.5*dt)/(t[-1]-t[0])),
            rms_a=float(np.sqrt(np.sum((current[1:]**2+current[:-1]**2)*.5*dt)/(t[-1]-t[0]))))
    result.update(source_deck_sha256=original['deck_sha256'],deck_sha256=sha(path),
                  model_notices=notices,currents=currents,elapsed_seconds=round(time.monotonic()-start,2),
                  hypothetical_precharge_width_um=pc_width,
                  upper_ground_peak_bound_a=float(np.max(np.abs(w['i(vup)'])+np.abs(w['i(vbu)']))),
                  ground_partition='D/S returns below y=80 um are on the bottom M1 rail; all body/extra-wire-C current is included in the upper-path bound.',
                  scope='Supply-current measurements; proposed widths require new physical implementation and extraction.')
    write_json(work/'result.json',result);write_json(REPORTS/(name+'.json'),result)
    print(name,result['passed'],currents,flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('source',type=Path);p.add_argument('--name',required=True)
    p.add_argument('--precharge-width',type=float);a=p.parse_args()
    result=run_case(a.source,a.name,a.precharge_width);raise SystemExit(0 if result['passed'] else 1)
