#!/usr/bin/env python3
"""Diagnostic isolated write-path sizing study; not a macro signoff result.

The bitcell and nominal devices come from the strict extracted layout.
Alternative peripheral widths are design proposals, with scaled junctions.
Worst common-line and local BL resistances use the existing RC3 sensitivity
assumptions. An ideal selected WL is held high to distinguish static write
strength from sequencer/wordline delay. Neither the PDK nor GDS is modified.
"""
import argparse,copy
from common import *
from postlayout import devices,device_lines


def main(wl_rise_ns=1):
    records,source=devices(WORK/'layout/final16x32')
    chosen=[]
    for r in records:
        if r['model'] not in ('NMOS','PMOS'):continue
        ns=r['nets'];g=ns['G']
        if any(n.startswith('xarray.xr0c0.') for n in ns.values()) or g in ('col0','pd_y','pd_yb') or (
                g=='preb' and set(ns.values())&{'y','yb','bl0','blb0'}):chosen.append(r)
    assert len(chosen)==14,len(chosen)
    results=[]
    for mux,pd in [(3.4,3.4),(5.1,3.4),(5.1,6.8),(6.8,3.4),(6.8,6.8),(10.2,6.8),(10.2,10.2)]:
        for bit in (0,1):
            rs=copy.deepcopy(chosen);work=WORK/'write_margin'/f'rise{wl_rise_ns:g}_mux{mux}_pd{pd}_bit{bit}';work.mkdir(parents=True,exist_ok=True)
            for r in rs:
                ns=r['nets'];width=mux if ns['G']=='col0' else pd if ns['G'] in ('pd_y','pd_yb') else None
                if width is not None:
                    scale=width/r['parameters']['W']
                    for k in ('W','AS','AD','PS','PD'):r['parameters'][k]*=scale
                if ns['G']=='col0':
                    for pin,n in list(ns.items()):
                        if n in ('y','yb'):ns[pin]='far_'+n
                for pin,n in list(ns.items()):
                    if n.startswith('xarray.xr0c0.'):
                        ns[pin]=n.rsplit('.',1)[1]
                    if ns[pin]=='wl0' and pin!='G':
                        raise AssertionError(r)
                if any(n in ('q','qb') for n in ns.values()):
                    for pin,n in list(ns.items()):
                        if n in ('bl0','blb0'):ns[pin]='cell_'+n
            lines=device_lines(rs)+['VVDD vdd 0 4.5','VPRE preb 0 4.5','VCOL col0 0 4.5',
                f'VWL wl0 0 PWL(0 0 20n 0 {20+wl_rise_ns:g}n 4.5)',
                f'VPDY pd_y 0 {4.5 if bit==0 else 0}',f'VPDYB pd_yb 0 {4.5 if bit==1 else 0}',
                'RY y far_y 2762.204793','RYB yb far_yb 3996.489652',
                'RBL bl0 cell_bl0 223.416667','RBLB blb0 cell_blb0 223.416667',
                'CBL cell_bl0 0 208.566f','CBLB cell_blb0 0 208.566f',
                'CY far_y 0 975.3378f','CYB far_yb 0 1451.4081f',
                f'.ic v(q)={4.5*(1-bit)} v(qb)={4.5*bit} v(bl0)=4.5 v(blb0)=4.5',
                '.temp 85','.options klu','.control','save v(q) v(qb) v(bl0) v(blb0) v(y) v(yb)',
                'tran 1n 2u 0 1n','meas tran q_end find v(q) at=1.99u',
                'meas tran qb_end find v(qb) at=1.99u','quit','.endc','.end']
            path=work/'test.spice';path.write_text('\n'.join(lines)+'\n')
            _,log=run(['ngspice','-b',path],work,'simulation.log');simulation_diagnostics(log)
            vals={k:float(re.search(rf'(?m)^{k}\s*=\s*(\S+)',log)[1]) for k in ('q_end','qb_end')}
            ok=(vals['q_end']>4.05 and vals['qb_end']<.45) if bit else (vals['q_end']<.45 and vals['qb_end']>4.05)
            result=dict(mux_width_um=mux,pulldown_width_um=pd,data=bit,passed=ok,**vals,deck_sha256=sha(path))
            results.append(result);print(result,flush=True)
    write_json(REPORTS/f'write_margin_sizing_study_{wl_rise_ns:g}ns.json',dict(source=source,conditions=dict(vdd_v=4.5,temperature_c=85,wordline_rise_ns=wl_rise_ns),
        scope=__doc__,results=results))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--wl-rise-ns',type=float,default=1);a=p.parse_args();main(a.wl_rise_ns)
