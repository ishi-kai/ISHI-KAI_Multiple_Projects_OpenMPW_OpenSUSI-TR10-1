#!/usr/bin/env python3
"""Full 512-bit transistor simulation and voltage-window checks.

Lumped capacitors represent extra interconnect load, in addition to the MOS
model's intrinsic capacitances. They are TB elements, never LVS exceptions.
"""
import argparse,time
import numpy as np
from common import *
from waveform import WaveformError, validate_time, sample_window

def scenario(period=1000,edge=5,addresses=None):
    addresses=[0,31,480,511] if addresses is None else addresses
    operations=[]
    for invert in (0,1):
        for wr in (1,0):
            for a in addresses:operations.append(dict(row=a//32,col=a%32,write=wr,data=((a//32)^a)&1 ^ invert))
    events={n:[(0,0)] for n in ('CLK','SDI','WE')}
    previous={'SDI':0,'WE':0}
    for i,op in enumerate(operations):
        first=(2+18*i)*period;op.update(first=first,e0=first+10*period)
        bits=[int(x) for x in f'{op["row"]:04b}{op["col"]:05b}'+str(op['data'] if op['write'] else 0)]
        # WE is valid at E0; invert it later to check the held mode FF.
        for t,b in [(first-.3*period,op['write']),(op['e0']+.3*period,1-op['write'])]:
            events['WE'] += [(t,previous['WE']),(t+edge,b)];previous['WE']=b
        for j in range(18):
            t=first+j*period
            events['CLK'] += [(t,0),(t+edge,1),(t+.5*period,1),(t+.5*period+edge,0)]
            b=bits[j] if j<10 else (j%2)
            events['SDI'] += [(t-.25*period,previous['SDI']),(t-.25*period+edge,b)];previous['SDI']=b
    events['RESET']=[(0,0),(edge,1),(.75*period,1),(.75*period+edge,0)]
    return dict(period_ns=period,edge_ns=edge,operations=operations,events=events,stop_ns=(2+18*len(operations))*period)

def spice_time(ns):
    # Use seconds with sufficient precision. Scientific notation followed by
    # a suffix (e.g. 1.23457e+06n) is not a portable SPICE time literal, and
    # six significant digits collapse 5 ns edges in millisecond-long tests.
    return f'{ns * 1e-9:.12e}'

def pwl(events):
    assert all(b[0] > a[0] for a,b in zip(events,events[1:])), 'PWL times must increase'
    return 'PWL('+' '.join(f"{spice_time(t)} 'VSUP*{v}'" for t,v in events)+')'

def vectors(case):
    nets=['VDD','CLK','RESET','SDI','WE','SDO','PREB','SAE','WL_EN','WRITE_EN','DIN','PD_Y','PD_YB','Y','YB','SOUT','SOUTB']
    nets += [f'{p}{i}' for p,n in [('RA',4),('CA',5),('WL',16),('COL',32),('BL',32),('BLB',32)] for i in range(n)]
    nets += [f'xctrl.xphase.C{i}' for i in range(5)]+['xctrl.CKI','xctrl.RSTI','xctrl.xcontrol.W']
    for r,c in sorted({(op['row'],op['col']) for op in case['operations']}):
        nets += [f'xarray.xr{r}c{c}.{q}' for q in ('Q','QB')]
    return nets

def control(case,threads=1):
    lines=['.param VSUP=5 CBLWIRE=70f CWLWIRE=400f CYWIRE=180f CSDO=10p',
           '.temp 27','.control']
    if threads:
        assert 1<=threads<=4
        lines.append(f'set num_threads={threads}')
    lines+=['save '+' '.join('v('+n+')' for n in vectors(case)),
           f'tran 5n {spice_time(case["stop_ns"])} 0 20n','let failures=0']
    last_read=0
    for i,op in enumerate(case['operations']):
        if not op['write']:last_read=op['data']
        ns=op['e0']+7.8*case['period_ns']
        for j,(n,b) in enumerate([(f'xarray.xr{op["row"]}c{op["col"]}.Q',op['data']),('SDO',last_read)]):
            m=f'check_{i}_{j}'
            lines += [f'meas tran {m} find v({n}) at={spice_time(ns)}',
                f'if {m} {"<" if b else ">"} {0.9 if b else 0.1} * v(VDD)[0]',
                ' let failures=failures+1','end']
    lines += ['if failures=0',f"echo 'PASS: {len(case['operations'])} accesses; stored cell and SDO checks'",'else',
              "echo 'FAIL: inspect failures and waveforms'",'print failures','end','write sram512_tb.raw',
           "plot v(SDO) v(SOUT) v(SOUTB) title '512 bit: read result is captured at E6'",
           "plot v(Y) v(YB) v(SAE) title 'Shared lines and sense enable'",
           "plot v(WL0) v(WL15) v(PREB) v(WRITE_EN) title 'Registered access sequence'",'.endc']
    return '\n'.join(lines)

def load_raw(path):
    path=Path(path)
    with path.open('rb') as f:
        lines=[]
        while True:
            line=f.readline()
            if line==b'Binary:\n':break
            assert line,'Missing binary waveform header'
            lines.append(line)
        offset=f.tell()
    header=b''.join(lines).decode('ascii');assert 'Flags: real' in header
    nv=int(re.search(r'No. Variables:\s*(\d+)',header)[1]);npnt=int(re.search(r'No. Points:\s*(\d+)',header)[1])
    # Measurements and counters added by the GUI checks are scalar vectors;
    # ngspice writes them without the voltage/time unit field.
    variables=[line.split() for line in header.rsplit('Variables:',1)[1].splitlines() if line.strip()]
    assert [int(v[0]) for v in variables]==list(range(nv))
    names=[v[1].lower() for v in variables]
    size=path.stat().st_size-offset
    assert len(names)==nv and size==nv*npnt*8,(len(names),nv,size,npnt)
    data=np.memmap(path,dtype='<f8',mode='r',offset=offset,shape=(npnt,nv))
    for first in range(0,npnt,2048):assert np.isfinite(data[first:first+2048]).all()
    return data[:,0]*1e9,{n:data[:,i] for i,n in enumerate(names)}

def verify(path,case,vdd=5):
    t,w=load_raw(path)
    return verify_samples(t,w,case,vdd)

def verify_samples(t,w,case,vdd=5):
    """Apply the same checks to explicit samples; final callers require load_raw."""
    failures=[];checks=0;observations=[]
    try:
        validate_time(t, 0, case['stop_ns'])
    except WaveformError as error:
        return dict(passed=False, checks=1, failure_count=1,
                    failures=[dict(kind='waveform_time', message=str(error))],
                    read_observations=[], points=len(t), operations=len(case['operations']))
    def vec(n):return w['v('+n.lower()+')']
    def level(n,b,a,z=None,fraction=.1):
        nonlocal checks
        checks+=1
        try:
            values=sample_window(t,vec(n),a,z)
        except WaveformError as error:
            failures.append(dict(net=n,kind='measurement_range',message=str(error)))
            return
        low=float(values.min());high=float(values.max())
        if (low<(1-fraction)*vdd if b else high>fraction*vdd):
            failures.append(dict(net=n,expected=b,start_ns=a,end_ns=z,min_v=low,max_v=high))
    period=case['period_ns'];known={};sdo=0
    # Async RESET establishes a safe control state, without resetting the array.
    for n,b in [('PREB',1),('SAE',1),('WL_EN',0),('WRITE_EN',0),('SDO',0)]:level(n,b,case.get('initial_check_ns',.6*period))
    for i,op in enumerate(case['operations']):
        if i in case.get('reset_before',[]):sdo=0
        for address in case.get('invalidated_before',{}).get(i,[]):known.pop(tuple(address),None)
        first=op['first'];e=op['e0'];r=op['row'];c=op['col'];wr=op['write'];data=op['data']
        for p,num,v in [('RA',4,r),('CA',5,c)]:
            for k in range(num):level(f'{p}{k}',(v>>k)&1,e-.1*period,e+7.8*period)
        for rr in range(16):
            for prefix in ('WL',):
                level(f'{prefix}{rr}',0,first+.3*period,e+2.9*period)
                level(f'{prefix}{rr}',int(rr==r),e+3.3*period,e+4.9*period)
                level(f'{prefix}{rr}',0,e+5.3*period,e+7.8*period)
        for cc in range(32):level(f'COL{cc}',int(cc==c),e+.3*period,e+7.8*period)
        for n in ['PREB']:level(n,0,e+.7*period,e+.9*period);level(n,1,e+1.3*period,e+7.8*period)
        for cc in range(32):
            for b in ('BL','BLB'):level(f'{b}{cc}',1,e+.8*period)
        for n in ('Y','YB'):level(n,1,e+.8*period)
        for n,b in [('PD_Y',wr and not data),('PD_YB',wr and data)]:
            level(n,0,first+.3*period,e+1.9*period)
            level(n,b,e+2.3*period,e+5.9*period)
            level(n,0,e+6.3*period,e+7.8*period)
        level('xctrl.xcontrol.W',wr,e+.3*period,e+7.8*period)
        for (rr,cc),value in known.items():
            for q,b in [('Q',value),('QB',1-value)]:
                level(f'xarray.xr{rr}c{cc}.{q}',b,first-.1*period,e-.1*period,fraction=.3)
                if (rr,cc)!=(r,c) or not wr:
                    level(f'xarray.xr{rr}c{cc}.{q}',b,e,e+7.8*period,fraction=.3)
        if wr:known[r,c]=data
        else:
            assert known[r,c]==data
            sdo=data
            for n,b in [('SOUT',data),('SOUTB',1-data)]:level(n,b,e+4.8*period,e+6.8*period)
            mask=(t>=e+4*period)&(t<=e+4.3*period)
            ti=t[mask];sa=vec('SAE')[mask]
            idx=np.flatnonzero(sa>=vdd/2)
            assert len(idx),(i,'no SAE rise')
            when=float(ti[idx[0]])
            observations.append(dict(operation=i,row=r,col=c,sae_half_ns=when,
                y_difference_v=float(np.interp(when,t,vec('Y')-vec('YB')))))
        for q,b in [('Q',known[r,c]),('QB',1-known[r,c])]:level(f'xarray.xr{r}c{c}.{q}',b,e+7.8*period)
        level('SDO',sdo,e+6.8*period,e+7.8*period)
    # SDO may change only after a read capture or an asynchronous RESET.
    # The external read convention allows settling until E6 + 0.8 cycle;
    # the rest of reception, writes and stopped-clock time must retain data.
    updates=[(op['e0']+6*period,op['data'],.8*period,'read_capture')
             for op in case['operations'] if not op['write']]
    updates += [(r['assert_ns'],0,.2*period,'reset') for r in case.get('reset_intervals',[])]
    start=case.get('initial_check_ns',.6*period);expected=0;hold_checks=0
    for when,bit,settling,reason in sorted(updates):
        if when>=start:
            level('SDO',expected,start,when);hold_checks+=1
        start=when+settling;expected=bit
    if start<=case['stop_ns']:
        level('SDO',expected,start,case['stop_ns']);hold_checks+=1
    return dict(passed=not failures,checks=checks,failure_count=len(failures),failures=failures[:40],
                read_observations=observations,points=len(t),operations=len(case['operations']),
                sdo_hold_checks=hold_checks, sdo_read_settling_ns=.8*period,
                required_time_range_ns=[0,case['stop_ns']])

def simulate(name='shared_wl_nominal',vdd=5,temp=27,bl='70f',wl='400f',y='180f',sdo='10p',period=1000,edge=5,vthmn=0,vthmp=0,addresses=None,solver='klu'):
    work=WORK/'analog'/name;work.mkdir(parents=True,exist_ok=True)
    source=netlist(ROOT/'sram512/schematics/sram512_tb.sch',work,subckt=False)
    deck=re.sub(r'\n\+\s*',' ',source.read_text());case=scenario(period,edge,addresses)
    for n,events in case['events'].items():
        deck,count=re.subn(r'(?m)^V'+n+r' \S+ \S+ PWL\([^\n]+\)$',f'V{n} {n} 0 {pwl(events)}',deck)
        assert count==1,(n,count)
    deck=re.sub(r'(?s)\.control.*?\.endc',lambda _:'.control'+control(case).split('.control',1)[1],deck)
    deck=re.sub(r'^\.param VSUP=.*$',f'.param VSUP={vdd} CBLWIRE={bl} CWLWIRE={wl} CYWIRE={y} CSDO={sdo}',deck,flags=re.M)
    deck=re.sub(r'^\.temp .*$',f'.temp {temp}',deck,flags=re.M)
    deck=deck.replace('.control',f'.param vthMN={vthmn} vthMP={vthmp}\n.control')
    deck='\n'.join(line for line in deck.splitlines() if not line.startswith('plot '))+'\n'
    deck=deck.replace('.endc','quit\n.endc')
    if solver is not None:
        assert solver=='klu'
        deck=deck.replace('.control','.options klu\n.control')
    def electrical_key(text):
        # Plot/save/GUI measurements do not alter the simulated electrical circuit.
        # Keep the actual transient command, every device/source/parameter, and models.
        tran=re.search(r'(?m)^tran .*$',text)[0]
        circuit=re.sub(r'(?s)\.control.*?\.endc','',text)
        circuit='\n'.join(' '.join(l.lower().split()) for l in re.sub(r'\n\+\s*',' ',circuit).splitlines()
                          if l.strip() and not l.lstrip().startswith('*'))
        key=(circuit+'\n'+tran).encode()
        for model in sorted((PDK/'libs.tech/spice/models').glob('*')):
            if model.is_file():key+=model.read_bytes()
        return hashlib.sha256(key).hexdigest()
    path=work/'test.spice';key=electrical_key(deck)
    reuse=path.exists() and (work/'sram512_tb.raw').exists() and electrical_key(path.read_text())==key
    start=time.monotonic()
    if reuse:
        log=(work/'simulation.log').read_text();print('recheck existing electrical simulation',name,flush=True)
    else:
        path.write_text(deck);print('ngspice',name,flush=True)
        _,log=run(['ngspice','-b',path],work,'simulation.log')
    notices=simulation_diagnostics(log)
    result=verify(work/'sram512_tb.raw',case,vdd)
    result.update(name=name,voltage_v=vdd,temperature_c=temp,period_ns=period,extra_wire_loads={'BL':bl,'WL':wl,'Y':y},
        output_load=sdo,edge_ns=edge,vth_shift_v={'NMOS':vthmn,'PMOS':vthmp},
        elapsed_seconds=round(time.monotonic()-start,2),input_sha256=sha(path),electrical_sha256=key,
        reused_waveform=reuse,model_notices=notices,
        simulator_threads=(int(m[1]) if (m:=re.search(r'(?m)^set num_threads=(\d+)$',path.read_text())) else None))
    write_json(work/'result.json',result);write_json(REPORTS/f'analog_{name}.json',result)
    print(name,result['passed'],result['failure_count'],result['elapsed_seconds'],flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--matrix',action='store_true')
    p.add_argument('--name-prefix',default='shared_wl');p.add_argument('--jobs',type=int,default=2)
    p.add_argument('--period',type=float,default=1000)
    p.add_argument('--shard',help='Optional INDEX/COUNT partition, with a separate result file')
    args=p.parse_args()
    assert re.fullmatch(r'[a-zA-Z0-9_]+',args.name_prefix) and 1<=args.jobs<=4
    if args.matrix:
        from concurrent.futures import ThreadPoolExecutor
        cases=[dict(name='nominal'),dict(name='low_cold',vdd=4.5,temp=-20),dict(name='low_hot',vdd=4.5,temp=85),
               dict(name='high_cold',vdd=5.5,temp=-20),dict(name='high_hot',vdd=5.5,temp=85),
               dict(name='wire_3x',bl='210f',wl='1200f',y='540f',edge=20),
               dict(name='wire_1p_hot',vdd=4.5,temp=85,bl='1p',wl='2p',y='1p',edge=20),
               dict(name='vth_slow_n_fast_p',vthmn=.1,vthmp=.1,temp=85),
               dict(name='vth_fast_n_slow_p',vthmn=-.1,vthmp=-.1,temp=85)]
        for case in cases:
            case['name']=args.name_prefix+'_'+case['name'];case['period']=args.period
        suffix=''
        if args.shard:
            index,count=map(int,args.shard.split('/'));assert 0<=index<count<=len(cases)
            cases=cases[index::count];suffix=f'_shard{index}of{count}'
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:results=list(pool.map(lambda c:simulate(**c),cases))
        write_json(REPORTS/f'analog_{args.name_prefix}_matrix{suffix}.json',results)
        raise SystemExit(0 if all(r['passed'] for r in results) else 1)
    else:
        result=simulate(name=args.name_prefix+'_nominal',period=args.period)
        raise SystemExit(0 if result['passed'] else 1)
