#!/usr/bin/env python3
"""Abort writes to address 511 while RESET also clears row/column storage.

Separate cases exercise both data polarities and both external clock levels.
Only the actively written cell may become unspecified; every other cell must
retain. The existing ordinary-access retention checker is unchanged.
"""
import argparse
import numpy as np
from common import *
from analog import load_raw
from postlayout import simulate


def scenario(period=5000,write_data=1):
    edge=5
    events={n:[(0,int(n=='RESET'))] for n in ('CLK','SDI','WE','RESET')}
    values={n:v[-1][1] for n,v in events.items()}
    operations=[];resets=[]
    def drive(n,t,b):
        if values[n]==b:return
        assert t>events[n][-1][0]
        events[n]+=[(t,values[n]),(t+edge,b)];values[n]=b
    def clocks(first,row,col,data,count):
        bits=[int(b) for b in f'{row:04b}{col:05b}{data}']
        drive('WE',first-.3*period,1)
        for j in range(count):
            when=first+j*period
            drive('SDI',when-.25*period,bits[j] if j<10 else j%2)
            drive('CLK',when,1);drive('CLK',when+.5*period,0)
        return first+count*period
    drive('RESET',.75*period,0)
    first=2*period
    for polarity in (1-write_data,):
        for row,col,bit in ((0,0,0),(0,31,1),(15,0,1),(15,31,0)):
            data=bit^polarity
            operations.append(dict(first=first,e0=first+10*period,row=row,col=col,write=1,data=data))
            first=clocks(first,row,col,data,18)
        before=first-.1*period
        clocks(first,15,31,1-polarity,14)
        # E3 is the last supplied rising edge: WL and write drive are active.
        assertion=first+(13+(.25 if polarity==0 else .75))*period
        drive('RESET',assertion,1)
        release=assertion+2*period;drive('RESET',release,0)
        resets.append(dict(before_ns=before,assert_ns=assertion,release_ns=release,
            target=[15,31],write_data=1-polarity,clock_level_at_assertion=1-polarity))
        first=release+period
    return dict(period_ns=period,edge_ns=edge,events=events,operations=operations,
        stop_ns=first,reset_intervals=resets)


def verify(path,case,vdd):
    t,w=load_raw(path);failures=[];checks=0
    for index,reset in enumerate(case['reset_intervals']):
        before=reset['before_ns'];start=reset['assert_ns']+1000;end=reset['release_ns']-100
        mask=(t>=start)&(t<=end);assert mask.sum()>10
        def check(net,bit,when=None):
            nonlocal checks
            checks+=1
            waveform=w['v('+net.lower()+')']
            a=waveform[mask] if when is None else np.array([np.interp(when,t,waveform)])
            if (a.min()<.9*vdd if bit else a.max()>.1*vdd):
                failures.append(dict(reset=index,net=net,expected=bit,time_ns=when,
                    stage='reset_settled' if when is None else 'before_assertion',min_v=float(a.min()),max_v=float(a.max())))
        pre=reset['assert_ns']-100
        for net,bit in [('RESET',0),('CLK',reset['clock_level_at_assertion']),('WL_EN',1),
                        ('WRITE_EN',1),('DIN',reset['write_data']),
                        ('PD_Y',1-reset['write_data']),('PD_YB',reset['write_data'])]:check(net,bit,pre)
        for row in range(16):check('WL'+str(row),int(row==15),pre)
        for prefix,count in [('RA',4),('CA',5)]:
            for i in range(count):check(prefix+str(i),1,pre)
        for net,bit in [('PREB',1),('SAE',1),('WL_EN',0),('WRITE_EN',0),('SDO',0),('PD_Y',0),('PD_YB',0)]:check(net,bit)
        for prefix,count in [('WL',16),('RA',4),('CA',5),('xctrl.xphase.C',5)]:
            for i in range(count):check(prefix+str(i),0)
        for row in range(16):
            for col in range(32):
                if [row,col]==reset['target']:continue
                qnet=f'xarray.xr{row}c{col}.q';qbnet=qnet+'b'
                q=float(np.interp(before,t,w['v('+qnet+')']))
                qb=float(np.interp(before,t,w['v('+qbnet+')']))
                checks+=1
                high=q>=.9*vdd and qb<=.1*vdd
                low=qb>=.9*vdd and q<=.1*vdd
                if not (high or low):failures.append(dict(reset=index,cell=[row,col],stage='before_reset',q_v=q,qb_v=qb))
                check(qnet,int(high));check(qbnet,1-int(high))
    return dict(passed=not failures,checks=checks,failure_count=len(failures),failures=failures[:40],
        interruptions=len(case['reset_intervals']),unselected_cells_per_interruption=511,
        targets=[r['target'] for r in case['reset_intervals']],
        write_data=[r['write_data'] for r in case['reset_intervals']],
        clock_levels=[r['clock_level_at_assertion'] for r in case['reset_intervals']],
        settling_guard_ns=1000,scope=__doc__)


def main(folder,name,write_data,recheck=False):
    case=scenario(write_data=write_data)
    r=simulate(folder,name=name,period=5000,rc_scale=1,power_sheet=.1,power_mesh_grid=.25,
        physical_gate_paths=True,signal_mesh=True,voltage_envelope=True,startup_ramp_ns=1000,
        solver='sparse',stream=True,recheck=recheck,case_override=case)
    work=WORK/'analog'/name
    actual=json.loads((work/'scenario.json').read_text())
    extra=verify(work/'sram512_tb.raw',actual,5)
    r.update(reset_address_checks=extra,passed=r['passed'] and extra['passed'],
        checks=r['checks']+extra['checks'],failure_count=r['failure_count']+extra['failure_count'])
    write_json(work/'result.json',r);write_json(REPORTS/(name+'.json'),r)
    print(name,r['passed'],r['checks'],r['failure_count'],flush=True)
    return r


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('folder',type=Path)
    p.add_argument('--name',required=True);p.add_argument('--write-data',type=int,choices=(0,1),required=True)
    p.add_argument('--recheck',action='store_true')
    a=p.parse_args();raise SystemExit(0 if main(a.folder.resolve(),a.name,a.write_data,a.recheck)['passed'] else 1)
