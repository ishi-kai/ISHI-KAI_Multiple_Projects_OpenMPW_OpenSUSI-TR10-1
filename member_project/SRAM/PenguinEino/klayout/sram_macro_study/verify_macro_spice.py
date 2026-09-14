#!/usr/bin/env python3
"""Smoke test full 256/512-bit transistor macros with real serial peripherals.

Memory MOS/junction geometry comes from verified saved GDS. Peripherals use
schematic MOS models, without wire parasitics. Eight operations are a smoke
test, not exhaustive memory qualification or PVT signoff.
"""
from pathlib import Path
import hashlib,json,re,sys
import numpy as np
from macro_model import digital
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(ROOT/'scripts'))
from verify_rtl import run
PDK=Path('/home/ishi-kai/pdk/TR-1um')
WORK=ROOT/'build/sram_macro_study/full_macro'


def macro(rb,cb):
    rows,cols=2**rb,2**cb;c,_,_=digital(rb,cb)
    top=f'wlstrap16_{rows}x{cols}'
    extracted=(ROOT/f'build/sram_macro_study/layout/{top}/{top}.extracted').read_text()
    flat=re.sub(r'\n\+\s*',' ',extracted)
    pins=re.search(r'(?im)^\.subckt\s+'+top+r'\s+([^\n]+)',flat)[1].split()
    assert set(pins)=={'VDD','VSS'}|{f'WL{r}' for r in range(rows)}|{f'{b}{cc}' for cc in range(cols) for b in ['BL','BLB']}
    lines=[f'.subckt serial_macro_{rows}x{cols} CLK RESET SDI WE SDO VDD VSS']
    lines += [' '.join('VSS' if t=='0' else t for t in line.split()) for line in c.lines]
    lines.append('Xmemory '+' '.join(pins)+' '+top)
    for col in range(cols):
        for bl,y in [('BL','Y'),('BLB','YB')]:
            lines += [f'XP_{bl}{col} {bl}{col} PREB VDD VDD PMOS W=10.2u L=1u',
                      f'XM_{bl}{col} {bl}{col} COL{col} {y} VSS NMOS W=3.4u L=1u']
    for y,pd in [('Y','PD_Y'),('YB','PD_YB')]:
        lines += [f'XP_{y} {y} PREB VDD VDD PMOS W=10.2u L=1u',
                  f'XW_{y} {y} {pd} VSS VSS NMOS W=3.4u L=1u']
    c.gate('sense_amp_7t',BL='Y',BLB='YB',SAE='SAE',SOUT='SOUT',SOUTB='SOUTB',VSS='VSS')
    lines += [c.lines[-1],'.ends',extracted,c.definitions()]
    text='\n'.join(lines)+'\n';(HERE/f'macro_{rows}x{cols}.spice').write_text(text)
    return text


def simulate(rb,cb):
    rows,cols=2**rb,2**cb;work=WORK/f'{rows}x{cols}';work.mkdir(parents=True,exist_ok=True)
    memory=macro(rb,cb);n=rb+cb+1;count=n+8
    operations=[(0,0,1,0),(rows-1,cols-1,1,1),(0,0,0,0),(rows-1,cols-1,0,1),
                (0,0,1,1),(rows-1,cols-1,1,0),(0,0,0,1),(rows-1,cols-1,0,0)]
    events={s:[(0,0)] for s in ['CLK','SDI','WE']}
    checks=[];last=0
    for idx,(r,c,wr,bit) in enumerate(operations):
        first=400+idx*count*100;e0=first+n*100
        data=[int(v) for v in f'{r:0{rb}b}{c:0{cb}b}'+str(bit if wr else 0)]
        events['WE'] += [(first-51,0 if idx==0 else operations[idx-1][2]),(first-50,wr)]
        prev=0 if idx==0 else (operations[idx-1][3] if operations[idx-1][2] else 0)
        for j in range(count):
            t=first+j*100;events['CLK'] += [(t,0),(t+1,1),(t+50,1),(t+51,0)]
            if j<n:
                events['SDI'] += [(t-51,prev),(t-50,data[j])];prev=data[j]
        if not wr:last=bit
        checks.append(dict(operation=idx,row=r,col=c,write=wr,data=bit,expected_sdo=last,sample_ns=e0+750,
                           e0_ns=e0,selected_wl=f'xmacro.WL{r}'))
    lines=['Full transistor serial SRAM macro smoke test',f'.include {PDK}/libs.tech/spice/models/ip62_models',
        '.temp 27','VDD VDD 0 5','VRESET RESET 0 PWL(0 0 1n 5 250n 5 251n 0)',
        f'Xmacro CLK RESET SDI WE SDO VDD 0 serial_macro_{rows}x{cols}',memory]
    for s,ev in events.items():
        lines.append(f'V{s} {s} 0 PWL('+' '.join(f'{t}n {v*5}' for t,v in ev)+')')
    # Same explicit lumped load assumptions as the original small schematic.
    for col in range(cols):
        for bl in ('BL','BLB'):lines.append(f'C{bl}{col} xmacro.{bl}{col} 0 10f')
    lines += ['CY xmacro.Y 0 100f','CYB xmacro.YB 0 100f','CSDO SDO 0 10f',
              'CSOUT xmacro.SOUT 0 10f','CSOUTB xmacro.SOUTB 0 10f']
    # Hierarchical node names in a top-level element do not connect into SPICE
    # subcircuits. Insert these load capacitors INSIDE the macro definition.
    loads=[line for line in lines if line.startswith(('CBL','CY ','CYB ','CSOUT'))]
    lines=[line for line in lines if line not in loads]
    memory_with_loads=memory.replace('\n.ends\n','\n'+'\n'.join(line.replace('xmacro.','') for line in loads)+'\n.ends\n',1)
    lines[lines.index(memory)]=memory_with_loads
    lines+=['.control',f'tran 0.5n {checks[-1]["sample_ns"]+50}n',
            'set wr_singlescale','set wr_vecnames','wrdata values.txt v(SDO) v(xmacro.PREB) v(xmacro.WL0) '+f'v(xmacro.WL{rows-1})',
            'quit','.endc','.end']
    deck='\n'.join(lines)+'\n';keymaterial=deck.encode()
    for p in sorted((PDK/'libs.tech/spice/models').rglob('*')):
        if p.is_file():keymaterial+=p.read_bytes()
    keymaterial+=Path(__file__).read_bytes();key=hashlib.sha256(keymaterial).hexdigest()
    cached=work/'result.json'
    if cached.exists() and json.loads(cached.read_text()).get('input_sha256')==key:return json.loads(cached.read_text())
    (work/'test.spice').write_text(deck);print(f'Running full {rows} x {cols} transistor macro',flush=True)
    (work/'values.txt').unlink(missing_ok=True)
    log=run(['ngspice','-b','test.spice'],work,'simulation.log')
    assert not re.search(r'(?im)^error|^warning',log),log[-3000:]
    a=np.loadtxt(work/'values.txt',skiprows=1);t=a[:,0]*1e9
    failures=[]
    for ck in checks:
        value=float(np.interp(ck['sample_ns'],t,a[:,1]));ck['sdo_v']=value
        if (value<4.5 if ck['expected_sdo'] else value>.5):failures.append(ck)
        pre=float(np.interp(ck['e0_ns']+80,t,a[:,2]));ck['preb_v']=pre
        wl=float(np.interp(ck['e0_ns']+335,t,a[:,3 if ck['row']==0 else 4]));ck['wl_v']=wl
        if pre>.5 or wl<4.5:failures.append(ck)
    result=dict(rows=rows,columns=cols,bits=rows*cols,operations=checks,passed=not failures,
                failures=failures,input_sha256=key,clock_ns=100,vdd_v=5,temperature_c=27,
                scope='Full extracted memory MOS/junctions plus schematic serial/analog peripherals; no wire RC, no mismatch; two corner addresses, both data polarities')
    cached.write_text(json.dumps(result,indent=2)+'\n');return result


def main():
    results=[]
    for dims in ((4,4),(4,5)):
        result=simulate(*dims);results.append(result)
        (HERE/'macro_spice_results.json').write_text(json.dumps(results,indent=2)+'\n')
        print(result['bits'],'bits:',result['passed'],flush=True)
    assert all(x['passed'] for x in results)


if __name__=='__main__':main()
