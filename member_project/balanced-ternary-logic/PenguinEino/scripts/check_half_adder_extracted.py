#!/usr/bin/env python3
"""Fresh LVS extraction + ngspice: HA DC and all 72 directed transitions.
Run: python3 scripts/check_half_adder_extracted.py
Outputs: simulation/half_adder_layout/extracted_sim/{extracted,schematic}/.../view.spice
No interconnect RC is extracted by this PDK LVS deck.
"""
from pathlib import Path
import hashlib
import json
import re
import subprocess
from concurrent.futures import ThreadPoolExecutor
import numpy as np
import check_half_adder as logic
import verify_half_adder_layout as verify

ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'simulation/half_adder_layout/extracted_sim'
MODELS=verify.PDK/'libs.tech/spice/models/ip62_models'
NODES=['t','u','na','carry','d','nd','sum']

def subckts(text):
    return {m[1].lower():dict(pins=m[2].split(),text=m[0],lines=[s.split() for s in m[3].splitlines() if s and not s.startswith('*')])
            for m in re.finditer(r'^\.subckt\s+(\S+)\s+([^\n]+)\n(.*?)^\.ends[^\n]*',text,re.M|re.S|re.I)}

def prepare():
    WORK.mkdir(parents=True,exist_ok=True)
    ref=verify.reference()
    result=verify.lvs(ROOT/'half_adder.gds','half_adder',ref,WORK/'extraction')
    assert result['passed'],result
    raw=(WORK/'extraction/half_adder.extracted').read_text()
    # ngspice-safe anonymous identifiers; electrical connections are unchanged.
    ext=re.sub(r'\\\$(\d+)',r'n_ex_\1',raw)
    ext=re.sub(r'(?m)^(X\w*)\$(\d+)',r'\1_ex_\2',ext)
    defs=subckts(ext)
    assert set(defs)=={'half_adder','nany','inverter'}
    inst=[]
    for line in defs['half_adder']['lines']:
        kind=line[-1].lower()
        assert kind in ('nany','inverter'),line
        inst.append(dict(name=line[0].lower(),kind=kind,pins=dict(zip(defs[kind]['pins'],line[1:-1]))))
    def find(kind,**pins):
        found=[i for i in inst if i['kind']==kind and all(i['pins'][k]==v for k,v in pins.items())]
        assert len(found)==1,(kind,pins,found)
        return found[0]
    roles={};nets={}
    roles['x_t']=find('nany',a='a',b='b');nets['t']=roles['x_t']['pins']['vout']
    roles['x_u']=find('nany',a='b',b=nets['t']);nets['u']=roles['x_u']['pins']['vout']
    roles['x_na']=find('inverter',vin='a');nets['na']=roles['x_na']['pins']['vout']
    roles['x_c']=find('nany',a=nets['na'],b=nets['u']);assert roles['x_c']['pins']['vout']=='carry'
    roles['x_d']=find('nany',a=nets['t'],b='carry');nets['d']=roles['x_d']['pins']['vout']
    roles['x_nd']=find('inverter',vin=nets['d']);nets['nd']=roles['x_nd']['pins']['vout']
    roles['x_s']=find('nany',a=nets['nd'],b='carry');assert roles['x_s']['pins']['vout']=='sum'
    mapping={f'xdut.{k}':f'xdut.{v}' for k,v in nets.items()}
    for role,i in roles.items():
        devices=[d for d in defs[i['kind']]['lines'] if len(d)>5 and d[5] in ('PMOS','NMOS')]
        def other(model,width,gate,known):
            found=[d for d in devices if d[5]==model and d[2]==gate and f'W={width}u' in d and known in (d[1],d[3])]
            assert len(found)==1,(model,width,gate,known,found)
            d=found[0];return d[3] if d[1]==known else d[1]
        if i['kind']=='nany':
            child={'net1':other('PMOS',34,'a','VDD'),'net4':other('NMOS',11,'b','VSS'),
                   'net5':other('PMOS',14,'a','vout'),'net6':other('PMOS',14,'b','vout')}
            child['net2']=other('PMOS',34,'b',child['net1'])
            child['net3']=other('NMOS',11,'a',child['net4'])
        else:
            child={'net1':other('PMOS',13.5,'vin','VDD'),'net2':other('NMOS',5,'vin','VSS')}
        mapping.update({f'xdut.{role}.{k}':f'xdut.{i["name"]}.{v}' for k,v in child.items()})
    # Fresh simulation-mode schematic TB, independent of ignored setup files.
    netdir=WORK/'reference';netdir.mkdir(exist_ok=True)
    rc=netdir/'xschemrc';rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:{verify.PDK}/libs.tech/xschem:{verify.PDK}/libs.tech/xschem/TR-1umLIB}}\nset LIB {{{MODELS.parent}}}\nset lvs_netlist 0\nset top_is_subckt 0\nset spiceprefix 1\n')
    code,log=verify.run(['xschem','-r','-x','--rcfile',rc,'-s','--command','set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result','-o',netdir,ROOT/'half_adder_tb.sch'],netdir,'netlist.log')
    assert code==0 and not re.search(r'Error:|SKIPPING|IS MISSING',log),log[-2000:]
    base=re.sub(r'\n\+\s*',' ',(netdir/'half_adder_tb.spice').read_text())
    adapted=re.sub(r'^\.subckt\s+.*?^\.ends\b[^\n]*','',base,flags=re.M|re.S|re.I)
    adapted=re.sub(r'^xdut .*$', 'xdut '+' '.join(defs['half_adder']['pins'])+' half_adder',adapted,flags=re.M|re.I)
    adapted=re.sub(r'v\(([^)]+)\)',lambda m:'v('+mapping.get(m[1],m[1])+')',adapted,flags=re.I)
    include=WORK/'half_adder_extracted.spice';include.write_text(ext+'\n')
    adapted=re.sub(r'^\.end\s*$',lambda m:f'.include "{include}"\n.end',adapted,flags=re.M|re.I)
    (WORK/'extracted_tb.spice').write_text(adapted)
    (WORK/'node_mapping.json').write_text(json.dumps(mapping,indent=2)+'\n')
    probes=['v('+mapping.get('xdut.'+n,'xdut.'+n)+')' if n not in ('carry','sum') else 'v('+n+')' for n in NODES]
    reference_probes=['v(xdut.'+n+')' if n not in ('carry','sum') else 'v('+n+')' for n in NODES]
    return {'extracted':(adapted,probes),'schematic':(base,reference_probes)},result,raw

def simulate(path,s,columns=10):
    path.mkdir(parents=True,exist_ok=True)
    (path/'tb.spice').write_text(s)
    # Existing ngspice native plots, with the same measurements and data vectors.
    title='Extracted HA' if '/extracted/' in str(path) else 'Schematic HA'
    plots=f"\nplot v(a) v(b) v(sum) ylimit -5.5 5.5 title '{title} SUM'\nplot v(a) v(b) v(carry) ylimit -5.5 5.5 title '{title} CARRY'\n"
    (path/'view.spice').write_text(s.replace('\nquit\n',plots))
    p=subprocess.run(['ngspice','-b','tb.spice'],cwd=path,capture_output=True,text=True,timeout=240)
    log=p.stdout+p.stderr;(path/'run.log').write_text(log)
    if p.returncode or re.search(r'Error:|Timestep too small|doAnalyses:|singular matrix',log,re.I):
        raise RuntimeError(str(path)+' simulation failed: '+log[-2000:])
    data=np.loadtxt(path/'data.txt',skiprows=1,ndmin=2)
    assert data.shape[1]==columns and np.isfinite(data).all(),path
    assert np.max(abs(data[:,1:10]))<7,(path,'nonphysical output')
    return data

def control(s,commands,probes):
    value='.control\nsave all\nset wr_singlescale\nset wr_vecnames\n'+commands+'\nwrdata data.txt v(a) v(b) '+' '.join(probes)+'\nquit\n.endc'
    return re.sub(r'\.control.*?\.endc',lambda _:value,s,flags=re.S|re.I)

def run(job,bases):
    variant,mode,cap,skew=job;base,probes=bases[variant];path=WORK/variant/mode
    if mode=='dc':
        points=[]
        # Use a physically reached state as Newton's initial estimate for each independent DC solve.
        # No .ic, UIC, clamps, model edits, or forced output sources are used.
        seed_nodes=list(dict.fromkeys(re.findall(r'v\([^)]+\)', '\n'.join(line for line in base.splitlines() if line.lower().startswith('.nodeset')))))
        allprobes=list(dict.fromkeys(probes+seed_nodes))
        for idx,(a,b) in enumerate(logic.STATES):
            warm=base
            for name,value in [('a',a),('b',b)]:
                warm=re.sub(r'^V'+name.upper()+r' .*$',f'V{name.upper()} {name} 0 PWL(0 -5 20n -5 21n {value} 200n {value})',warm,flags=re.M)
            seed=simulate(path/f'point{idx}'/'seed',control(warm,'tran 0.2n 200n',allprobes),3+len(allprobes))
            guesses=dict(zip(allprobes,seed[-1,3:]))
            assert max(abs(v) for v in guesses.values())<7
            s=base
            for name,value in [('a',a),('b',b)]:
                s=re.sub(r'^V'+name.upper()+r' .*$',f'V{name.upper()} {name} 0 {value}',s,flags=re.M)
            for probe,val in guesses.items():
                s=re.sub(re.escape(probe)+r'=[^\s]+',lambda _:probe+'='+format(val,'.12g'),s,flags=re.I)
            data=simulate(path/f'point{idx}',control(s,f'dc VA {a} {a} 1',probes))
            assert len(data)==1
            actual=data[0,3:];expected=logic.values(a,b)
            points.append(dict(inputs=[a,b],sum_V=float(actual[6]),carry_V=float(actual[3]),
                output_error_V=float(max(abs(actual[[3,6]]-expected[[3,6]]))),internal_error_V=float(max(abs(actual-expected)))))
        result=dict(variant=variant,mode=mode,points=points,output_error_V=max(p['output_error_V'] for p in points),internal_error_V=max(p['internal_error_V'] for p in points))
    else:
        seq=logic.route();assert len(seq)==73 and len(set(zip(seq,seq[1:])))==72
        s=base;hold=100
        for col,name in enumerate(('a','b')):
            pts=[f'0 {logic.STATES[seq[0]][col]}']
            for k in range(1,len(seq)):
                edge=k*hold+(abs(skew) if (skew<0 and col==0) or (skew>0 and col==1) else 0)
                pts.extend([f'{edge}n {logic.STATES[seq[k-1]][col]}',f'{edge+1}n {logic.STATES[seq[k]][col]}'])
            s=re.sub(r'^V'+name.upper()+r' .*$',f'V{name.upper()} {name} 0 PWL('+ ' '.join(pts)+')',s,flags=re.M)
        for name in ('sum','carry'):s=re.sub(r'^C'+name+r' .*$',f'C{name} {name} 0 {cap}f',s,flags=re.M)
        data=simulate(path,control(s,f'tran 0.2n {len(seq)*hold}n',probes));t=data[:,0]*1e9;rows=[]
        for k in range(1,len(seq)):
            start=k*hold+1+abs(skew);end=(k+1)*hold-1
            target=logic.values(*logic.STATES[seq[k]])
            actual=np.array([np.interp(end,t,data[:,j]) for j in range(3,10)])
            m=(t>=start)&(t<=end);tt=t[m]
            bad=np.flatnonzero(np.any(abs(data[m][:,[6,9]]-target[[3,6]])>.5,axis=1))
            settle=0. if len(bad)==0 else float(tt[bad[-1]+1]-start) if bad[-1]<len(tt)-1 else None
            rows.append(dict(old=logic.STATES[seq[k-1]],new=logic.STATES[seq[k]],output_error_V=float(max(abs(actual[[3,6]]-target[[3,6]]))),internal_error_V=float(max(abs(actual-target))),settle_ns=settle))
        result=dict(variant=variant,mode=mode,load_fF=cap,input_skew_ns=skew,count=len(rows),output_error_V=max(r['output_error_V'] for r in rows),internal_error_V=max(r['internal_error_V'] for r in rows),unsettled=sum(r['settle_ns'] is None for r in rows),max_settle_ns=max((r['settle_ns'] for r in rows if r['settle_ns'] is not None),default=0),transitions=rows)
    result['passed']=result['output_error_V']<=.5 and result['internal_error_V']<=.5 and result.get('unsettled',0)==0
    print({k:v for k,v in result.items() if k not in ('points','transitions')},flush=True)
    return result

def main():
    bases,lvs,raw=prepare()
    cases=[('dc',10,0),('tran_10f',10,0),('tran_100f',100,0),('skew_a',10,-2),('skew_b',10,2)]
    with ThreadPoolExecutor(max_workers=3) as pool:results=list(pool.map(lambda job:run(job,bases),[(v,*c) for v in bases for c in cases]))
    sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
    summary=dict(passed=all(r['passed'] for r in results),scope='Fresh LVS-extracted device network with MOS junction geometry and PDK intrinsic capacitances. No interconnect RC.',gds_sha256=sha(ROOT/'half_adder.gds'),schematic_sha256=sha(ROOT/'half_adder.sch'),extracted_sha256=hashlib.sha256(raw.encode()).hexdigest(),model_sha256={p.name:sha(p) for p in MODELS.parent.iterdir() if p.is_file()},lvs=lvs,temperature_C=27,supplies_V=[-5,0,5],tolerance_V=.5,results=results)
    summary['dc_method']='Nine independent DC solves seeded with settled transient node voltages; continuous VTC is not qualified.'
    summary['source_sha256']={name:sha(ROOT/name) for name in ('half_adder.sch','half_adder_tb.sch','nany.sch','inverter.sch')}
    (WORK/'results.json').write_text(json.dumps(summary,indent=2)+'\n')
    brief=dict(summary,results=[{k:v for k,v in r.items() if k not in ('transitions',)} for r in results])
    (ROOT/'reports/half_adder_extracted.json').write_text(json.dumps(brief,indent=2)+'\n')
    assert summary['passed'],'Extracted/schematic HA verification failed; see results.json'
if __name__=='__main__':main()
