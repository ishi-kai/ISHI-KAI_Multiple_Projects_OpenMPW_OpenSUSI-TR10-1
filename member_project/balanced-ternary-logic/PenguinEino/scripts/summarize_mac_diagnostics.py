"""Compact saved characterization and compare numerical/transient diagnostics."""
from pathlib import Path
import hashlib,json
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'simulation/mac_improvements'
REPORT=ROOT/'reports/mac_improvements'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(name,data):(REPORT/(name+'.json')).write_text(json.dumps(data,indent=2)+'\n')
def read(p):
    with p.open() as f:names=f.readline().split()
    return names,np.loadtxt(p,skiprows=1)

def main():
    # Raw per-state DC arrays belong with ignored waveforms, not in Git.
    for p in REPORT.glob('rr*.json'):
        data=json.loads(p.read_text())
        if 'states' not in data:continue
        raw=WORK/p.stem/'candidate_all_states.json'
        raw.parent.mkdir(parents=True,exist_ok=True)
        raw.write_text(json.dumps(data.pop('states'))+'\n')
        data['raw_state_archive']=str(raw.relative_to(ROOT));data['raw_state_sha256']=sha(raw)
        data['status']='Historical candidate characterization; consult source hashes, not current-layout signoff.'
        save(p.stem,data)
    tight=ROOT/'simulation/mac/schematic/tb_sequence/mac_tran.txt'
    loose=WORK/'tolerances/simulations/convergence_tolerance_check/data.txt'
    tn,t=read(tight);ln,l=read(loose);times=(np.arange(82)*1000+999)*1e-9
    delta={n:float(np.max(abs(np.interp(times,t[:,0],t[:,tn.index(n)])-np.interp(times,l[:,0],l[:,ln.index(n)])))) for n in ('v(sum)','v(cout)','v(and_out)','v(or_out)','v(xdut.p)')}
    assert max(delta.values())<.001,delta
    save('solver_comparison',dict(passed=True,max_settled_difference_V=delta,samples=82,
        wave_sha256={str(p.relative_to(ROOT)):sha(p) for p in (tight,loose)},
        scope='27 C, +/-5 V, 10 pF || 1 Mohm, 1 us. Tight reltol=1e-4/default abstol vs reltol=1e-3/abstol=1nA/vntol=10uV/trtol=10. Does not bound every transition timing error.'))
    p=WORK/'corners/simulations/cold_current/data.txt';names,a=read(p);t=a[:,0];duration=t[-1]-t[0]
    stats={}
    for j,n in enumerate(names):
        if not (n.startswith('@m.') or n.startswith('i(')):continue
        x=a[:,j];k=int(np.argmax(abs(x)))
        stats[n]=dict(peak_abs_A=float(abs(x[k])),peak_time_ns=float(t[k]*1e9),
            rms_A=float(np.sqrt(np.trapezoid(x*x,t)/duration)),mean_abs_A=float(np.trapezoid(abs(x),t)/duration))
    # Net-source differences are evaluated on the same transient samples.
    import sys
    sys.path.insert(0,str(ROOT/'scripts'))
    import review_mac as review
    mos=review.mos_instances((p.parent/'tb.spice').read_text());stress={}
    for m in mos:
        d,g,s,b=[a[:,names.index('v('+n+')')] for n in m['terminals']]
        stress[m['name']]={k:float(np.max(abs(x-y))) for k,x,y in [('VDS',d,s),('VGS',g,s),('VGD',g,d),('VGB',g,b),('VDB',d,b),('VSB',s,b)]}
    save('transient_stress_summary',dict(wave_sha256=sha(p),currents=stats,mos_terminal_peak_V=stress,
        scope='81-input sequence plus return, -40 C, +/-5 V, 10 pF || 1 Mohm, 1 us. Device drain currents are not a full metal/via current extraction; no EM signoff.'))
    slew={}
    for edge,name in [(1,'cold_current'),(10,'cold_edge_10ns'),(100,'cold_edge_100ns')]:
        q=WORK/'corners/simulations'/name/'data.txt'
        if not q.exists():continue
        labels,arr=read(q);peak={k:0. for k in ('VDS','VGS','VGD','VGB','VDB','VSB')}
        for m in mos:
            d,g,s,b=[arr[:,labels.index('v('+n+')')] for n in m['terminals']]
            for k,x,y in [('VDS',d,s),('VGS',g,s),('VGD',g,d),('VGB',g,b),('VDB',d,b),('VSB',s,b)]:peak[k]=max(peak[k],float(np.max(abs(x-y))))
        slew[edge]=dict(max_terminal_difference_V=peak,wave_sha256=sha(q))
    save('slew_stress_summary',dict(cases=slew,scope='Cold 81-state sequence, +/-5 V. Full transient terminal differences; not breakdown modeling.'))
    import klayout.db as db
    layout=db.Layout();layout.read(str(ROOT/'mac.gds'));top=layout.cell('mac')
    target=db.Region(db.Box(520000,378200,870000,418200))
    assert layout.dbu==.001 and (target-db.Region(top.begin_shapes_rec(layout.layer(13,0)))).is_empty()
    source=WORK/'supply_T-40.0_fixed0_num0_power1_4.5_5.5_0.5/all_states.json'
    states=json.loads(source.read_text());joins=[]
    for rail in ('5.0','5.5'):
        for label,roles in [('left branch',('x_mul','x_ha1','x_ha2')),('main landing',('x_mul','x_fa'))]:
            values=[]
            for state in states:
                row=state['rows'][rail];currents=row['branch_currents_A']
                terms={k:v for k,v in currents.items() if any(f'.vprobe_{role}_vss#' in k for role in roles)}
                assert len(terms)==len(roles)
                values.append(dict(current_A=abs(sum(terms.values())),state=row['state'],terms=terms))
            peak=max(values,key=lambda r:r['current_A'])
            joins.append(dict(rail_V=float(rail),segment=label,states=len(values),**peak))
    assert max(r['current_A'] for r in joins if r['rail_V']==5)<.010
    save('power_join',dict(passed=True,gds_sha256=sha(ROOT/'mac.gds'),m1_overlay_box_um=[520,378.2,870,418.2],width_um=40,conservative_continuous_capacity_A=.010,
        currents=joins,source_sha256=sha(source),scope='Correlated DC currents from all 81 states, -40 C; parent MAC VSS overlay only. No AC/current-crowding/EM signoff.'))
    print('solver differences',delta)
    print('largest RMS',sorted(stats.items(),key=lambda p:p[1]['rms_A'],reverse=True)[:7])

if __name__=='__main__':main()
