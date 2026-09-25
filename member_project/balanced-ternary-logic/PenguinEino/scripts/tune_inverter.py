"""Explore equal-RR dimensions; center DC by tuning PMOS width, then compare transients.
Run after netlisting inverter_tb.sch to simulation/tuning/inverter_tb.spice.
Outputs are exploratory nominal model results, not a global optimum or layout area.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import itertools, json, re, subprocess, tempfile
import numpy as np
from scipy.optimize import brentq
ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'simulation/tuning'
BASE=(WORK/'inverter_tb.spice').read_text().split('**** begin user architecture code')[0]
MODEL='/home/ishi-kai/pdk/TR-1um/libs.tech/spice/models/ip62_models'

def sim(p,n,rw,rl,kind='dc',cap=10,temp=27):
    s=BASE
    for name,w in [('XXM1',p),('XXM2',n)]:
        s=re.sub(r'(^'+name+r'.*? w=)\S+',lambda m:m[1]+f'{w}u',s,flags=re.M)
    for name in ['XR1','XR2']:
        s=re.sub(r'(^'+name+r'.*? w=)\S+ l=\S+',lambda m:m[1]+f'{rw}u l={rl}u',s,flags=re.M)
    s=re.sub(r'^Cload .*$',f'Cload vout 0 {cap}f',s,flags=re.M)
    if kind=='dc':
        control='dc VIN -5 5 0.03125\nwrdata data.txt v(vout) i(VDD)'
    else:
        # Every ordered pair of distinct input levels, with long settling windows.
        levels=[-5,0,5,0,-5,5,-5]
        points=['0 -5']
        for i,v in enumerate(levels):
            points.append(f'{(i+1)*100}n {v}')
            if i<6: points.append(f'{(i+1)*100+1}n {levels[i+1]}')
        s=re.sub(r'^VIN .*$', 'VIN vin 0 PWL('+' '.join(points)+')',s,flags=re.M)
        control='tran 0.1n 700n\nwrdata data.txt v(vin) v(vout)'
    s+=f'\n.include {MODEL}\n.temp {temp}\n.nodeset v(vout)=5\n.control\n{control}\nquit\n.endc\n.GLOBAL GND\n.end\n'
    with tempfile.TemporaryDirectory(dir=WORK) as d:
        d=Path(d);(d/'run.spice').write_text(s)
        run=subprocess.run(['ngspice','-b','run.spice'],cwd=d,capture_output=True,text=True)
        if run.returncode or re.search(r'Error:|failed',run.stdout+run.stderr,re.I):
            raise RuntimeError(run.stdout+run.stderr)
        data=np.loadtxt(d/'data.txt')
    if kind=='dc':
        x,y=data[:,0],data[:,1]
        zero=float(np.interp(0,x,y))
        center=abs(x)<=1
        slope=float(np.interp(0,x,np.gradient(y,x)))
        return dict(zero=zero,band_error=float(max(abs(y[center]))),slope=slope,
                    power_mw=float(-10*np.interp(0,x,data[:,3])*1000)),data
    t,y=data[:,0]*1e9,data[:,3]
    settling=[]
    for i,target in enumerate([0,5,0,-5,5,-5],1):
        # Inverter desired output is the negative of the input. Time after edge END.
        mask=(t>=i*100+1)&(t<=(i+1)*100)
        tt,yy=t[mask],y[mask]
        bad=np.flatnonzero(abs(yy+target)>0.5)
        settling.append(float(tt[bad[-1]+1]-i*100-1) if len(bad) and bad[-1]+1<len(tt) else (0.0 if not len(bad) else 100.0))
    return dict(settle_ns=max(settling),each_ns=settling),data

def explore(args):
    n,rw,rl=args
    def f(p):return sim(p,n,rw,rl)[0]['zero']
    a,b=f(3.4),f(30)
    if a*b>0:return None
    p=round(brentq(f,3.4,30,xtol=.003),2)
    dc,_=sim(p,n,rw,rl)
    return dict(p=p,n=n,rw=rw,rl=rl,area_proxy=p+n+2*rw*rl,**dc)

if __name__=='__main__':
    combos=list(itertools.product([3.4,5,6.8],[2.8,4,6],[13,20,30,40,60]))
    with ThreadPoolExecutor(max_workers=4) as pool:
        rows=[r for r in pool.map(explore,combos) if r is not None]
    (WORK/'dc_candidates.json').write_text(json.dumps(rows,indent=2))
    # Keep acceptable zero-band response; compare small candidates and stronger drive.
    good=[r for r in rows if r['band_error']<=.5]
    shortlist=sorted(good,key=lambda r:r['area_proxy'])[:12]
    for r in shortlist:
        for cap in [10,100]:r[f'tran_{cap}f']=sim(r['p'],r['n'],r['rw'],r['rl'],'tran',cap)[0]
    (WORK/'shortlist.json').write_text(json.dumps(shortlist,indent=2))
    print(json.dumps(shortlist,indent=2),flush=True)
