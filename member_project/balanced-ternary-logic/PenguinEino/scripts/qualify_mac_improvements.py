"""Electrical candidates and supply-range characterization; no source edits."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import argparse, hashlib, itertools, json, re, subprocess
import numpy as np
import review_mac as review
from check_half_adder_extracted import subckts

ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'simulation/mac_improvements'
REPORT=ROOT/'reports/mac_improvements'
STATES=list(itertools.product((-1,0,1),repeat=4))


def save(name,data):
    REPORT.mkdir(parents=True,exist_ok=True)
    (REPORT/(name+'.json')).write_text(json.dumps(data,indent=2)+'\n')


def write_native_seed():
    path=WORK/'rr30.0_buf1_T27_fixed0/0/down.txt'
    with path.open() as f: names=f.readline().split();values=f.readline().split()
    assert float(values[0])==5
    voltages={n:float(v) for n,v in zip(names,values) if n.startswith('v(')}
    assert all(abs(v)<=5.1 for v in voltages.values())
    assert abs(voltages['v(sum)']+5)<.1 and abs(voltages['v(cout)'])<.1
    data=dict(scope='Newton estimates, never fixed IC/UIC; RR30 + buffered OR, 27 C, first input state (-1,-1,-1,-1).',
              source=str(path.relative_to(ROOT)),source_sha256=review.sha(path),voltages=voltages)
    (ROOT/'design/mac_op_seed.json').write_text(json.dumps(data,indent=2)+'\n')


def write_seed_bank():
    """Retain only reusable Newton estimates, not DC scans/waveforms."""
    tag='rr30.0_buf1_T27_fixed0';rows=[];hashes=[];vectors=None
    for i,state in enumerate(STATES):
        path=WORK/tag/str(i)/'down.txt'
        with path.open() as f:names=f.readline().split();values=list(map(float,f.readline().split()))
        assert values[0]==5
        vv={n:v for n,v in zip(names,values) if n.startswith('v(')}
        if vectors is None:vectors=list(vv)
        assert list(vv)==vectors and all(abs(v)<6 for v in vv.values())
        assert max(abs(vv[f'v({n})']-e*5) for n,e in zip(('sum','cout','and_out','or_out','xdut.p'),review.oracle(state)))<.5
        rows.append(list(vv.values()));hashes.append(review.sha(path))
    data=dict(scope='Newton starting estimates for each input state at +/-5 V, 27 C, RR30 and buffered OR. Never fixed IC/UIC.',
              provenance=tag,source_wave_sha256=hashes,states=STATES,vectors=vectors,values=rows)
    (ROOT/'design/mac_dc_seeds.json').write_text(json.dumps(data,separators=(',',':'))+'\n')


def candidate(base,length=0,buffer=False):
    text=base
    if length:
        text=re.sub(r'(?im)^([^\n]*\bF_RR\b[^\n]*)$',
                    lambda m:re.sub(r'\bl=[^\s]+',f'l={length}u',m[0],flags=re.I),text)
    if buffer:
        if re.search(r'(?im)^x_or1 or_raw or_n VDD VSS inverter$',text):return text
        text,n=re.subn(r'(?im)^x_mul a b p VDD VSS nmin or_out mul$',
                       'x_mul a b p VDD VSS nmin or_raw mul\nx_or1 or_raw or_n VDD VSS inverter\nx_or2 or_n or_out VDD VSS inverter',text)
        assert n==1
    return text


def power_probes(base):
    defs=subckts(base);probes={};replacements={}
    for kind,definition in defs.items():
        names=[]
        for parts in definition['lines']:
            if parts[-1].lower() not in defs or not parts[0].lower().startswith('x'):continue
            child=defs[parts[-1].lower()];new=parts.copy();extras=[]
            for index,pin in enumerate(child['pins'],1):
                if pin not in ('VDD','VSS','VMID','V+','V-'):continue
                rail=parts[index];name=f'probe_{parts[0]}_{rail}'.lower();node='sense_'+name
                new[index]=node;extras.append(f'V{name} {rail} {node} 0');names.append(name)
            if extras:replacements[' '.join(parts)]=' '.join(new)+'\n'+'\n'.join(extras)
        probes[kind]=names
    for old,new in replacements.items():base=re.sub(r'(?im)^'+re.escape(old)+'$',lambda _:new,base)
    vectors=[]
    def walk(kind,path):
        vectors.extend(f'v.{path}.v{n}#branch' for n in probes[kind])
        for p in defs[kind]['lines']:
            if p[-1].lower() in defs and p[0].lower().startswith('x'):walk(p[-1].lower(),path+'.'+p[0].lower())
    walk('mac','xdut');return base,vectors


def sweep_state(base,tag,state,temp=27,low=2.5,high=6.5,step=.05,buffer=False,fixed_inputs=False,branch_vectors=()):
    folder=WORK/tag/str(STATES.index(state));folder.mkdir(parents=True,exist_ok=True)
    text=re.sub(r'\.control.*?\.endc','',base,flags=re.S|re.I)
    text=re.sub(r'(?im)^\.nodeset[^\n]*\n','',text)
    text=re.sub(r'(?im)^\.temp .*$',f'.temp {temp}',text)
    extra=['VRAIL railref 0 5']
    for net,gain in [('VDD',1),('VSS',-1)]:
        text=re.sub(r'(?im)^'+net+r' .*$',f'{net} {net} {net}_ref 0',text)
        extra.append(f'E{net} {net}_ref 0 railref 0 {gain}')
    for net,value in zip(('x','a','b','cin'),state):
        if fixed_inputs:
            source=f'V{net.upper()} {net} 0 {value*5}'
        else:
            source=f'V{net.upper()} {net} {net}_ref 0'
            extra.append(f'E{net} {net}_ref 0 railref 0 {value}')
        text=re.sub(r'(?im)^V'+net.upper()+r' .*$',source,text)
    for net in ('sum','cout','and_out','or_out'):
        text=re.sub(r'(?im)^Rload_'+net+r' .*\n','',text)
        extra.append(f'Rload_{net} {net} 0 1meg')
    old=json.loads((ROOT/'design/mac_dc_seeds.json').read_text())
    idx=old['states'].index(list(state))
    for vector,value in zip(old['vectors'],old['values'][idx]):
        if not vector.startswith('v('):continue
        extra.append(f'.nodeset {vector}={value:.12g}')
    devices=review.mos_instances(base)
    nodes=['sum','cout','and_out','or_out','xdut.p']
    nodes+=sorted(set(n for m in devices for n in m['terminals'])-set(nodes))
    vectors=[f'v({n})' for n in nodes]+list(branch_vectors)+['i(vdd)','i(vss)','i(vmid)']
    ctrl='.control\nset wr_singlescale\nset wr_vecnames\nsave '+' '.join(vectors)
    scans=[]
    if low<=5:scans.append(('down',low,-step))
    if high>=5:scans.append(('up',high,step))
    for name,end,increment in scans:
        (folder/(name+'.txt')).unlink(missing_ok=True)
        ctrl+=f'\ndc VRAIL 5 {end} {increment}\nwrdata {name}.txt '+' '.join(vectors)
    ctrl+='\nquit\n.endc\n'
    text=re.sub(r'(?im)^\.end\s*$',lambda _:'\n'.join(extra)+'\n'+ctrl+'.end',text)
    (folder/'tb.spice').write_text(text)
    p=subprocess.run(['ngspice','-b','tb.spice'],cwd=folder,capture_output=True,text=True,timeout=180)
    log=p.stdout+p.stderr;(folder/'run.log').write_text(log)
    arrays=[];problems=[]
    for name,_,_ in scans:
        path=folder/(name+'.txt')
        if not path.exists():problems.append(name+' missing');continue
        a=np.atleast_2d(np.loadtxt(path,skiprows=1))
        if a.shape[1]!=len(vectors)+1:problems.append(name+' invalid columns');continue
        arrays.append(a)
    rows={}
    for a in arrays:
        for row in a:
            v=round(float(row[0]),5)
            target=np.array(review.oracle(state))*v
            actual=row[1:6]
            node_max=np.max(abs(row[1:len(nodes)+1]))
            physical=bool(p.returncode==0 and np.isfinite(row).all() and node_max<max(7,1.3*v))
            error=abs(actual-target)
            decode=np.where(actual<-v/2,-1,np.where(actual>v/2,1,0))
            rows[v]=dict(state=state,rail_V=v,actual_V=actual.tolist(),expected_V=target.tolist(),
                         error_V=error.tolist(),logic_ok=bool(np.array_equal(decode,review.oracle(state))),
                         accuracy_ok=bool(error.max()<=.5),physical=physical,
                         max_internal_V=float(node_max),supply_current_A=abs(float(row[-3])),
                         branch_currents_A=dict(zip(branch_vectors,row[len(nodes)+1:-3].tolist())))
    expected={round(v,5) for v in np.arange(low,high+step/2,step)}
    return dict(state=state,rows=rows,missing=sorted(expected-set(rows)),problems=problems,
                exit_code=p.returncode,solver_errors=[l for l in log.splitlines() if re.search('Error:|failed|aborted',l,re.I)])


def sweep(length=0,buffer=False,temp=27,low=2.5,high=6.5,step=.05,fixed=False,numeric=False,power=False):
    review.WORK=WORK/'netlist'
    _,base=review.netlist('mac_tb')
    base=candidate(base,length,buffer)
    buffer='x_or1 or_raw or_n' in base
    if numeric:
        from rr_numeric import apply
        base=apply(base)
    probes=[]
    if power:base,probes=power_probes(base)
    tag=f'supply_T{temp}_fixed{int(fixed)}_num{int(numeric)}_power{int(power)}_{low}_{high}_{step}'
    done=[]
    with ThreadPoolExecutor(max_workers=4) as pool:
        fs={pool.submit(sweep_state,base,tag,s,temp,low,high,step,buffer,fixed,probes):s for s in STATES}
        for f in as_completed(fs):
            s=fs[f]
            try:r=f.result()
            except Exception as e:r=dict(state=s,error=repr(e),rows={})
            done.append(r)
            if len(done)%9==0:print(tag,len(done),'/81',flush=True)
    summary=[]
    for v in np.arange(low,high+step/2,step):
        v=round(float(v),5);rr=[r['rows'][v] for r in done if v in r['rows']]
        valid=len(rr)==81 and all(r['physical'] for r in rr)
        worst=max(rr,key=lambda r:max(r['error_V'])) if rr else None
        summary.append(dict(rail_V=v,total_supply_V=2*v,states=len(rr),valid=valid,
            logic_pass=valid and all(r['logic_ok'] for r in rr),accuracy_pass=valid and all(r['accuracy_ok'] for r in rr),
            max_error_V=max((max(r['error_V']) for r in rr),default=None),
            max_output_error_V=max((max(r['error_V'][:4]) for r in rr),default=None),
            max_supply_current_A=max((r['supply_current_A'] for r in rr),default=None),worst=worst,
            branch_peak_A={p:max(abs(r['branch_currents_A'][p]) for r in rr) for p in probes} if rr else {}))
    (WORK/tag/'all_states.json').write_text(json.dumps(done)+'\n')
    save(tag,dict(length_override_um=length or None,rr_length_parameters=sorted(set(re.findall(r'(?im)^.*\bF_RR\b.*\bl=(\S+)',base))),or_buffer=buffer,temperature_C=temp,fixed_inputs=fixed,
         numeric_rr=numeric,power_probes=power,netlist_sha256=hashlib.sha256(base.encode()).hexdigest(),seed_bank_sha256=review.sha(ROOT/'design/mac_dc_seeds.json'),
         model_sha256={str(p.relative_to(review.PDK)):review.sha(p) for p in (review.PDK/'libs.tech/spice/models').rglob('*') if p.is_file()},
         source_sha256={str(p.relative_to(ROOT)):review.sha(p) for p in ROOT.glob('*.sch')},
         rows=summary,failures=[{k:v for k,v in d.items() if k!='rows'} for d in done if d.get('error') or d.get('missing') or d.get('problems') or d.get('exit_code')],scope='DC continuation per input state; nominal model; 1 Mohm output loads; supply tracking inputs unless fixed_inputs=true.'))
    for r in summary:
        if abs(r['rail_V']*4-round(r['rail_V']*4))<1e-6:print({k:v for k,v in r.items() if k not in ('worst','branch_peak_A')},flush=True)


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--length',type=float,default=0)
    p.add_argument('--buffer',action='store_true');p.add_argument('--temp',type=float,default=27)
    p.add_argument('--low',type=float,default=2.5);p.add_argument('--high',type=float,default=6.5)
    p.add_argument('--step',type=float,default=.05);p.add_argument('--fixed',action='store_true')
    p.add_argument('--numeric',action='store_true');p.add_argument('--power',action='store_true')
    a=p.parse_args();sweep(a.length,a.buffer,a.temp,a.low,a.high,a.step,a.fixed,a.numeric,a.power)
