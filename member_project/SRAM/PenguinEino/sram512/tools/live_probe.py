#!/usr/bin/env python3
"""Read a running binary waveform without modifying it or issuing final PASS.

Only complete rows present at the initial file-size snapshot are read. Only
fully completed operations are assessed. The release checkers still require
the complete raw header, successful simulator exit and the entire sequence.
"""
import argparse
import copy
import numpy as np
from datetime import datetime, timezone
from common import *
from analog import verify_samples as functional
from electrical_limits import verify_samples as voltage_limits
from signal_mesh import verify_samples as gate_levels
from all_cell_retention import verify_samples as retention


def samples(path):
    with Path(path).open('rb') as stream:
        header=[]
        while True:
            line=stream.readline()
            assert line, 'Incomplete waveform header'
            if line==b'Binary:\n':break
            header.append(line)
        offset=stream.tell()
        size=os.fstat(stream.fileno()).st_size
    text=b''.join(header).decode('ascii')
    assert 'Flags: real' in text
    count=int(re.search(r'No. Variables:\s*(\d+)',text)[1])
    variables=[s.split() for s in text.rsplit('Variables:',1)[1].splitlines() if s.strip()]
    assert [int(s[0]) for s in variables]==list(range(count))
    rows=(size-offset)//(count*8)
    assert rows>1
    data=np.memmap(path,dtype='<f8',mode='r',offset=offset,shape=(rows,count))
    for first in range(0,rows,2048):assert np.isfinite(data[first:first+2048]).all()
    time=np.array(data[:,0])*1e9
    assert time[0]==0 and np.all(np.diff(time)>0)
    return time,{s[1].lower():data[:,i] for i,s in enumerate(variables)}


def remapped_devices(case):
    records=json.loads((case/'physical_devices.json').read_text())
    mapped=set()
    for line in (case/'test.spice').read_text().splitlines():
        if not re.match(r'XM\d+ ',line):continue
        fields=line.split();i=int(fields[0][2:])
        assert records[i]['model']==fields[5]
        records[i]['nets']=dict(zip('DGSB',fields[1:5]))
        mapped.add(i)
    assert mapped=={i for i,r in enumerate(records) if r['model'] in ('NMOS','PMOS')}
    return records


def probe(case):
    case=Path(case).resolve()
    t,w=samples(case/'sram512_tb.raw')
    spec=json.loads((case/'scenario.json').read_text())
    completed=[op for op in spec['operations'] if op['e0']+8*spec['period_ns']<=t[-1]]
    assert completed,'No complete access yet'
    partial=copy.deepcopy(spec);partial['operations']=completed
    partial['stop_ns']=completed[-1]['e0']+8*spec['period_ns']
    deck=(case/'test.spice').read_text()
    supply=re.search(r'(?m)^VVDD vdd 0 (.+)$',deck)[1]
    vdd=float(supply.rstrip(')').split()[-1])
    checks=dict(functional=functional(t,w,partial,vdd))
    if (case/'power_rc.json').exists():
        checks['voltage_limits']=voltage_limits(t,w,remapped_devices(case))
        checks['all_cell_retention']=retention(t,w,partial,vdd)
    wire=case/'wire_rc.json'
    if wire.exists():
        info=json.loads(wire.read_text())
        if 'signal_mesh' in info:
            checks['signal_mesh']=gate_levels(t,w,partial,vdd,info['signal_mesh'])
    report=dict(state='IN_PROGRESS',release_evidence=False,
        sampled_utc=datetime.now(timezone.utc).isoformat(),case=case.name,
        completed_operations=len(completed),planned_operations=len(spec['operations']),
        simulated_ns=float(t[-1]),planned_stop_ns=spec['stop_ns'],
        deck_sha256=sha(case/'test.spice'),
        observed_failure_count=sum(r['failure_count'] for r in checks.values()),checks=checks,
        scope=__doc__)
    output=WORK/'live'/f'{case.name}.json'
    write_json(output,report)
    print(case.name,report['state'],len(completed),'complete accesses;',
          report['observed_failure_count'],'observed failures',flush=True)
    for name,result in checks.items():
        print(name,result['failure_count'],result.get('failures',[])[:3],flush=True)
    return report


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('case',type=Path)
    probe(parser.parse_args().case)
