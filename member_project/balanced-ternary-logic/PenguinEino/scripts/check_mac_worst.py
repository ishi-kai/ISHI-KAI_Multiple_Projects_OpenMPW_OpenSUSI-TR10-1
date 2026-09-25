"""Recheck measured worst transitions with tighter tolerances and 2 ns steps."""
from pathlib import Path
import argparse,json,re
import check_mac as c

def main(scope):
    root=c.WORK/scope
    rows=[]
    for path in (root/'all_6480_10000f').glob('chunk_*/results.json'):
        data=json.loads(path.read_text());assert data['passed']
        rows.extend(r for r in data['rows'][1:] if r['old']!=r['new'])
    assert len(list((root/'all_6480_10000f').glob('chunk_*/results.json')))==16
    pairs=[]
    for field in ('settle_ns','output_error_V','product_error_V','sum_cout_error_V','and_or_error_V'):
        row=max(rows,key=lambda r:r[field]);pair=(row['old'],row['new'])
        if pair not in pairs:pairs.append(pair)
    sequence=[c.STATES[0]]
    for old,new in pairs:sequence.extend([old,new,old,new])
    if scope=='schematic':base=c.netlist();vectors=c.VECTORS
    else:
        base=(root/'extracted_tb.spice').read_text();mapping=json.loads((root/'node_mapping.json').read_text())
        vectors=' '.join(f'v({mapping.get(n,n)})' for n in c.PROBES)
    for j,net in enumerate(c.PROBES[:4]):
        pts=[f'0 {sequence[0][j]}']
        for k in range(1,len(sequence)):pts.extend([f'{1000*k}n {sequence[k-1][j]}',f'{1000*k+1}n {sequence[k][j]}'])
        pts.append(f'{len(sequence)*1000}n {sequence[-1][j]}')
        base,n=re.subn(r'(?m)^V'+net.upper()+r' .*$',f'V{net.upper()} {net} 0 PWL('+' '.join(pts)+')',base);assert n==1
    base=base.replace('reltol=1e-4','reltol=1e-5 abstol=1e-12 vntol=1e-6 trtol=7')
    ctrl=f'.control\nsave {vectors}\nset wr_singlescale\nset wr_vecnames\ntran 2n {len(sequence)*1000}n 0 2n\nwrdata data.txt {vectors}\nquit\n.endc'
    base=re.sub(r'\.control.*?\.endc',lambda _:ctrl,base,flags=re.S)
    folder=root/'worst_tight';c.simulate(folder,base);result=c.evaluate(folder/'data.txt',sequence,1000)
    report=dict(scope=scope,pairs=pairs,solver=dict(reltol=1e-5,abstol_A=1e-12,vntol_V=1e-6,max_step_ns=2),
        deck_sha256=c.sha(folder/'tb.spice'),wave_sha256=c.sha(folder/'data.txt'),
        results={k:v for k,v in result.items() if k!='rows'},gds_sha256=c.sha(c.ROOT/'mac.gds'))
    path=c.ROOT/f'reports/mac_improvements/worst_tight_{scope}.json';path.write_text(json.dumps(report,indent=2)+'\n')
    print(report,flush=True);assert result['passed']

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('scope',choices=['schematic','extracted']);main(p.parse_args().scope)
