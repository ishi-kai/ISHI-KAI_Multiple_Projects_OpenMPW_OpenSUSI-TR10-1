"""Inspect every extracted MOS terminal pair against the published 5.75 V level."""
import numpy as np
from analog import load_raw

def nodes(records):
    return sorted({n for r in records for n in r['nets'].values()}-{'0','vss'})

def verify(path,records):
    t,w=load_raw(path)
    return verify_samples(t,w,records)

def verify_samples(t,w,records):
    zero=np.zeros(len(t));checks=0;failures=[];maxima={}
    def voltage(n):return zero if n in ('0','vss') else w['v('+n.lower()+')']
    for i,r in enumerate(records):
        if r['model'] not in ('NMOS','PMOS'):continue
        for pair in ('DS','GS','SB','DB','GD','GB'):
            value=np.abs(voltage(r['nets'][pair[0]])-voltage(r['nets'][pair[1]]))
            index=int(value.argmax());peak=float(value[index]);checks+=1
            record=dict(device=i,model=r['model'],cell=r['cell'],instance=r['instance'],
                        pair=pair,peak_abs_v=peak,time_ns=float(t[index]),position_um=r['position_um'])
            if pair not in maxima or peak>maxima[pair]['peak_abs_v']:maxima[pair]=record
            if peak>5.75:failures.append(record)
    return dict(passed=not failures,checks=checks,failure_count=len(failures),failures=failures[:40],
                maximum_by_pair=maxima,limit_abs_v=5.75,
                source='Unmodified dev OS00 reference manual rev1.1, table I-2-3 (recommended MOS operating voltages).',
                scope='Absolute terminal-pair amplitudes. This does not replace current, ESD, or statistical-corner qualification.')
