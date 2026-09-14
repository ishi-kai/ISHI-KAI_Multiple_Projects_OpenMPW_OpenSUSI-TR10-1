#!/usr/bin/env python3
"""Extracted-circuit power-up, stopped-clock retention, and async reset tests."""
import argparse,time
import numpy as np
from common import *
from analog import spice_time,pwl,vectors,verify,load_raw
from postlayout import devices,device_lines

def scenario():
    period=1000;edge=5
    events={n:[(0,0)] for n in ('CLK','SDI','WE','RESET')};values=dict.fromkeys(events,0)
    operations=[];resets=[];invalid={};reset_before=[]
    def drive(n,t,value):
        if values[n]==value:return
        if t==0:events[n].append((edge,value))
        else:events[n]+=[(t,values[n]),(t+edge,value)]
        values[n]=value
    def clocks(first,wr,data,row=0,col=0,count=18):
        bits=[int(b) for b in f'{row:04b}{col:05b}{data}']
        drive('WE',first-.3*period,wr)
        for j in range(count):
            t=first+j*period
            drive('SDI',t-.25*period,bits[j] if j<10 else j%2)
            drive('CLK',t,1);drive('CLK',t+.5*period,0)
        return first+count*period
    def access(first,wr,data,row=0,col=0):
        operations.append(dict(first=first,e0=first+10*period,row=row,col=col,write=wr,data=data))
        return clocks(first,wr,data,row,col)
    # RESET follows the rising VDD through a behavioural TB source; the actual
    # SRAM and its control/reset transistors remain the extracted circuit.
    drive('RESET',0,1);drive('RESET',25000,0);t=27000
    for row,col,data in [(0,0,0),(0,31,1),(15,0,1),(15,31,0)]:t=access(t,1,data,row,col)
    hold_start=t;hold_end=t+1_000_000;t=hold_end
    for row,col,data in [(0,0,0),(0,31,1),(15,0,1),(15,31,0)]:t=access(t,0,data,row,col)
    # Digital tests cover all 18 states. These transistor-level interruptions
    # include receive, PC, release, write setup, active WL, and sense/capture.
    for wr,count in [(1,n) for n in (0,9,11,12,13,14,15,16)]+[(0,14),(0,16)]:
        first=t;t=clocks(t,wr,1,count=count)
        assertion=t+.2*period;drive('RESET',assertion,1)
        release=assertion+2*period;drive('RESET',release,0)
        resets.append(dict(clock_edges=count,write=wr,assert_ns=assertion,release_ns=release))
        invalid[len(operations)]=[(0,0)];reset_before.append(len(operations))
        t=release+period
        t=access(t,1,0);t=access(t,0,0)
    return dict(period_ns=period,edge_ns=edge,events=events,operations=operations,stop_ns=t,
                initial_check_ns=24000,reset_before=reset_before,invalidated_before=invalid,
                reset_intervals=resets,retention_interval_ns=[hold_start,hold_end],
                supply_ramp_ns=20000)

def extra_checks(path,case,vdd):
    t,w=load_raw(path);failures=[];checks=0
    def level(n,b,start,end):
        nonlocal checks
        checks+=1;v=w[f'v({n.lower()})'];a=v[(t>=start)&(t<=end)]
        assert len(a),(n,start,end)
        if (a.min()<.9*vdd if b else a.max()>.1*vdd):
            failures.append(dict(net=n,expected=b,start_ns=start,end_ns=end,min_v=float(a.min()),max_v=float(a.max())))
    for r in case['reset_intervals']:
        start=r['assert_ns']+200;end=r['release_ns']-100
        for n,b in [('PREB',1),('SAE',1),('WL_EN',0),('WRITE_EN',0),('SDO',0),('PD_Y',0),('PD_YB',0)]:level(n,b,start,end)
        for i in range(5):level(f'xctrl.xphase.c{i}',0,start,end)
        for row in range(16):
            for prefix in ('wl',):level(prefix+str(row),0,start,end)
        for row,col,data in [(0,31,1),(15,0,1),(15,31,0)]:
            for q,b in [('q',data),('qb',1-data)]:level(f'xarray.xr{row}c{col}.{q}',b,start,end)
    a,b=case['retention_interval_ns']
    for row,col,data in [(0,0,0),(0,31,1),(15,0,1),(15,31,0)]:
        for q,value in [('q',data),('qb',1-data)]:level(f'xarray.xr{row}c{col}.{q}',value,a,b)
    for n,value in [('clk',0),('wl_en',0),('write_en',0),('preb',1)]:level(n,value,a,b)
    return dict(passed=not failures,checks=checks,failure_count=len(failures),failures=failures[:40],
                asynchronous_interruptions=len(case['reset_intervals']),stopped_clock_retention_ns=b-a)

def simulate(folder,name='operational_hot',vdd=5,temp=85,recheck=False,solver='sparse',pivrel=None,stream=False):
    work=WORK/'analog'/name;work.mkdir(parents=True,exist_ok=True)
    records,provenance=devices(folder);case=scenario();lines=device_lines(records)
    lines.append(f'VVDD vdd 0 PWL(0 0 {spice_time(case["supply_ramp_ns"])} {vdd})')
    for n,ev in case['events'].items():
        if n=='RESET':
            lines+=['Vreset_logic reset_logic 0 '+pwl(ev).replace('VSUP','1'),
                    'Breset RESET 0 v=v(vdd)*v(reset_logic)']
        else:lines.append(f'V{n} {n} 0 {pwl(ev)}')
    for prefix,num,cap in [('BL',32,70),('BLB',32,70),('WL',16,400)]:
        for i in range(num):lines.append(f'Cwire_{prefix}{i} {prefix}{i} 0 {cap}f')
    lines+=['Cwire_Y Y 0 180f','Cwire_YB YB 0 180f','Cout SDO 0 10p',f'.param VSUP={vdd}',f'.temp {temp}',
            '.control','set num_threads=1','save i(VVDD) '+' '.join(f'v({n})' for n in vectors(case)),
            f'tran 20n {spice_time(case["stop_ns"])} 0 100n','write sram512_tb.raw','quit','.endc','.end']
    deck='\n'.join(lines)+'\n'
    assert solver in ('sparse','klu')
    if solver=='klu':deck=deck.replace('.control','.options klu\n.control',1)
    if pivrel is not None:
        assert 0<pivrel<=1
        deck=deck.replace('.control',f'.options pivrel={pivrel:.12g}\n.control',1)
    if stream:
        block=re.search(r'(?s)\.control\n(.*?)\.endc',deck)
        batch='\n'.join('.'+line for line in block[1].splitlines() if line.startswith(('save ','tran ')))
        deck=deck[:block.start()]+batch+deck[block.end():]
        local_init=work/'.spiceinit'
        if recheck:assert local_init.read_text()=='set num_threads=1\n'
        else:local_init.write_text('set num_threads=1\n')
    path=work/'test.spice';start=time.monotonic()
    if recheck:
        assert path.read_text()==deck;log=(work/'simulation.log').read_text()
    else:
        path.write_text(deck);print('ngspice',name,flush=True)
        _,log=run(['ngspice','-b']+(['-r','sram512_tb.raw'] if stream else [])+[path],work,'simulation.log')
    notices=simulation_diagnostics(log);result=verify(work/'sram512_tb.raw',case,vdd)
    extra=extra_checks(work/'sram512_tb.raw',case,vdd)
    result.update(operational_checks=extra,passed=result['passed'] and extra['passed'],
        checks=result['checks']+extra['checks'],failure_count=result['failure_count']+extra['failure_count'],
        source=provenance,voltage_v=vdd,temperature_c=temp,deck_sha256=sha(path),model_notices=notices,
        supply_ramp_ns=case['supply_ramp_ns'],elapsed_seconds=round(time.monotonic()-start,2),solver=solver,simulator_threads=1,numerical_pivrel=pivrel,
        waveform_storage='streamed binary file' if stream else 'control memory then write',local_init_sha256=sha(work/'.spiceinit') if stream else None)
    write_json(work/'scenario.json',case);write_json(work/'result.json',result);write_json(REPORTS/(name+'.json'),result)
    print(name,result['passed'],result['checks'],result['failure_count'],flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('--name',default='operational_hot')
    p.add_argument('--recheck',action='store_true');p.add_argument('--solver',choices=['sparse','klu'],default='sparse');p.add_argument('--pivrel',type=float);p.add_argument('--stream',action='store_true');a=p.parse_args()
    result=simulate(a.folder,a.name,recheck=a.recheck,solver=a.solver,pivrel=a.pivrel,stream=a.stream);raise SystemExit(0 if result['passed'] else 1)
