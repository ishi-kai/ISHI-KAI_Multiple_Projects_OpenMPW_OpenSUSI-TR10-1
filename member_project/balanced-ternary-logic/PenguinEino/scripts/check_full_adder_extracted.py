"""Simulate the verified FA extraction: 27 triples and 702 transitions at 10/100 fF.

Run verify_full_adder_layout.py first. This reuses its fresh, strict LVS result
and rejects stale GDS/reference data. No interconnect RC is extracted by this deck.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import re
import check_full_adder as logic
from check_half_adder_extracted import subckts
import verify_full_adder_layout as verify

ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'simulation/full_adder_layout/extracted_sim'


def normalized(raw):
    raw=re.sub(r'\\\$(\w+)',r'n_ex_\1',raw)
    return re.sub(r'(?m)^(X\w*)\$(\w+)',r'\1_ex_\2',raw)


def mapping_for(defs):
    def instances(kind):
        return [dict(name=line[0].lower(),kind=line[-1].lower(),
                     pins=dict(zip(defs[line[-1].lower()]['pins'],line[1:-1])))
                for line in defs[kind]['lines'] if line[-1].lower() in defs]
    def find(inst,kind,**pins):
        rows=[i for i in inst if i['kind']==kind and all(i['pins'][k]==v for k,v in pins.items())]
        assert len(rows)==1,(kind,pins,rows)
        return rows[0]
    primitive={}
    for kind in ('nany','inverter'):
        devices=[d for d in defs[kind]['lines'] if len(d)>5 and d[5] in ('PMOS','NMOS')]
        def other(model,width,gate,known):
            matches=[d for d in devices if d[5]==model and d[2]==gate and f'W={width}u' in d and known in (d[1],d[3])]
            assert len(matches)==1,(model,width,gate,known)
            d=matches[0];return d[3] if d[1]==known else d[1]
        if kind=='nany':
            nodes=dict(net1=other('PMOS',34,'a','VDD'),net4=other('NMOS',11,'b','VSS'),
                       net5=other('PMOS',14,'a','vout'),net6=other('PMOS',14,'b','vout'))
            nodes['net2']=other('PMOS',34,'b',nodes['net1'])
            nodes['net3']=other('NMOS',11,'a',nodes['net4'])
        else:
            nodes=dict(net1=other('PMOS',13.5,'vin','VDD'),net2=other('NMOS',5,'vin','VSS'))
        primitive[kind]=nodes
    ha=instances('half_adder');roles={};nets={}
    roles['x_t']=find(ha,'nany',a='a',b='b');nets['t']=roles['x_t']['pins']['vout']
    roles['x_u']=find(ha,'nany',a='b',b=nets['t']);nets['u']=roles['x_u']['pins']['vout']
    roles['x_na']=find(ha,'inverter',vin='a');nets['na']=roles['x_na']['pins']['vout']
    roles['x_c']=find(ha,'nany',a=nets['na'],b=nets['u']);assert roles['x_c']['pins']['vout']=='carry'
    roles['x_d']=find(ha,'nany',a=nets['t'],b='carry');nets['d']=roles['x_d']['pins']['vout']
    roles['x_nd']=find(ha,'inverter',vin=nets['d']);nets['nd']=roles['x_nd']['pins']['vout']
    roles['x_s']=find(ha,'nany',a=nets['nd'],b='carry');assert roles['x_s']['pins']['vout']=='sum'
    fa=instances('full_adder')
    h1=find(fa,'half_adder',a='a',b='b')
    h2=find(fa,'half_adder',a=h1['pins']['sum'],b='cin');assert h2['pins']['sum']=='sum'
    merge=find(fa,'nany',a=h1['pins']['carry'],b=h2['pins']['carry'])
    inv=find(fa,'inverter',vin=merge['pins']['vout'],vout='cout')
    fmap={'s1':h1['pins']['sum'],'c1':h1['pins']['carry'],'c2':h2['pins']['carry'],'nc':merge['pins']['vout']}
    mapping={f'xdut.{k}':f'xdut.{v}' for k,v in fmap.items()}
    for role,h in [('x_ha1',h1),('x_ha2',h2)]:
        old=f'xdut.{role}';new=f'xdut.{h["name"]}'
        mapping.update({f'{old}.{k}':f'{new}.{v}' for k,v in nets.items()})
        for name,i in roles.items():
            mapping.update({f'{old}.{name}.{k}':f'{new}.{i["name"]}.{v}' for k,v in primitive[i['kind']].items()})
    for name,i in [('x_cmerge',merge),('x_cout',inv)]:
        mapping.update({f'xdut.{name}.{k}':f'xdut.{i["name"]}.{v}' for k,v in primitive[i['kind']].items()})
    return mapping


def prepare():
    WORK.mkdir(parents=True,exist_ok=True)
    report=json.loads((ROOT/'reports/full_adder_layout.json').read_text())
    assert report['lvs']['passed'],'Strict LVS must pass before simulation'
    assert report['gds_sha256']==verify.sha(ROOT/'full_adder.gds'),'Stale LVS GDS'
    assert report['schematic_sha256']==verify.sha(ROOT/'full_adder.sch'),'Stale schematic'
    ref=verify.reference()
    assert report['reference_sha256']==verify.sha(ref),'Child schematic changed since LVS'
    for name,digest in report['rule_sha256'].items():
        assert verify.sha(verify.PDK/name)==digest,('PDK changed',name)
    raw=Path(report['lvs']['extracted']).read_text()
    assert raw==(ROOT/'full_adder.extracted').read_text(),'Root extraction is stale'
    extracted=normalized(raw);defs=subckts(extracted)
    assert set(defs)=={'full_adder','half_adder','nany','inverter'}
    assert set(defs['full_adder']['pins'])=={'a','b','cin','sum','cout','VDD','VSS','VMID'}
    mapping=mapping_for(defs)
    logic.WORK=WORK/'schematic_reference'
    base=logic.netlist()
    base=re.sub(r'^\.subckt\s+.*?^\.ends\b[^\n]*','',base,flags=re.M|re.S|re.I)
    base=re.sub(r'^xdut .*$', 'xdut '+' '.join(defs['full_adder']['pins'])+' full_adder',base,flags=re.M|re.I)
    base=re.sub(r'v\(([^)]+)\)',lambda m:'v('+mapping.get(m[1],m[1])+')',base,flags=re.I)
    include=WORK/'full_adder_extracted.spice';include.write_text(extracted+'\n')
    base=re.sub(r'^\.end\s*$',lambda _:f'.include "{include}"\n.end',base,flags=re.M|re.I)
    (WORK/'node_mapping.json').write_text(json.dumps(mapping,indent=2)+'\n')
    (WORK/'extracted_tb.spice').write_text(base)
    logic.WORK=WORK
    logic.VECTORS=' '.join(f'v({mapping.get(n,n)})' for n in logic.PROBES)
    return base,report,raw


def main():
    base,layout,raw=prepare()
    folder=WORK/'tb_sequence'
    batch=re.sub(r'^plot .*\n','',base,flags=re.M).replace('.endc','quit\n.endc')
    log=logic.simulate(folder,batch)
    assert 'PASS: Full Adder' in log and 'const.failures = 0.000000e+00' in log
    assert len(re.findall(r'^tran_\d+_\w+\s+=',log,re.M))==28*6
    tb=logic.evaluate(folder/'full_adder_tran.txt',logic.STATES+[logic.STATES[0]])
    (folder/'view.spice').write_text(base)
    (folder/'results.json').write_text(json.dumps(tb,indent=2)+'\n')
    results=[dict(mode='tb_sequence',load_ff=10,maximum_timestep_ns=.5,**{k:v for k,v in tb.items() if k!='rows'})]
    print(results[0],flush=True)
    with ThreadPoolExecutor(max_workers=2) as pool:
        for r in pool.map(lambda cap:logic.exhaustive(base,cap),(10,100)):
            results.append(r);print(r,flush=True)
    baseline=json.loads((ROOT/'reports/full_adder.json').read_text())
    baseline_valid=all(Path(p).exists() and verify.sha(p)==h for p,h in baseline['source_sha256'].items())
    result=dict(passed=all(r['passed'] for r in results),gds_sha256=layout['gds_sha256'],
                extracted_sha256=hashlib.sha256(raw.encode()).hexdigest(),lvs=layout['lvs'],
                source_sha256={str(ROOT/name):verify.sha(ROOT/name) for name in ('full_adder.sch','full_adder_tb.sch','half_adder.sch','nany.sch','inverter.sch')},
                model_sha256={str(p):verify.sha(p) for p in sorted((verify.PDK/'libs.tech/spice/models').rglob('*')) if p.is_file()},
                temperature_c=27,supplies_v=dict(VDD=5,VMID=0,VSS=-5),tolerance_v=.5,edge_ns=1,hold_ns=logic.HOLD_NS,
                scope='LVS-extracted device network with MOS junction geometry and intrinsic PDK capacitances; no interconnect RC.',
                cases=results,schematic_baseline_valid=baseline_valid,
                schematic_baseline=baseline['cases'] if baseline_valid else None)
    assert verify.sha(ROOT/'full_adder.gds')==result['gds_sha256'],'GDS changed during simulation'
    (ROOT/'reports/full_adder_extracted.json').write_text(json.dumps(result,indent=2)+'\n')
    if not result['passed']:raise RuntimeError('Extracted FA failed')


if __name__=='__main__':main()
