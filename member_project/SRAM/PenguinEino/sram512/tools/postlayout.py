#!/usr/bin/env python3
"""Simulate the actual MOS network from an unchanged-deck, matched LVS DB.

LVS correspondence supplies observation names only. Connections, dimensions,
junction areas/perimeters and physical finger counts come from extraction.
Interconnect RC is a separate analysis and is never claimed to be in LVS.
"""
import argparse,time,copy
import numpy as np
from collections import Counter
from analog import scenario,pwl,control,verify,load_raw
from common import *

def observation_name(name):
    parts=name.lower().split('.')
    return '.'.join(['x'+p for p in parts[:-1]]+parts[-1:])

def rc_summary(info,path):
    result={k:info[k] for k in ('kind','scale','coefficients','segments','assumptions')}
    result.update(geometry_nets=len(info['geometry']),detailed_parameters_sha256=sha(path),
                  detailed_parameters_file=str(path),clock=info['gate_loads']['xctrl.cki'])
    result['wire_groups']={}
    if 'signal_mesh' in info:
        mesh=info['signal_mesh']
        result['signal_topology']=dict(model=mesh['model'],scope=mesh['scope'],
            nets={n:{k:r[k] for k in ('sampled_nodes','reduced_nodes','cap_ff','maximum_path_ohm','observation_columns','dc_validation')}
                  for n,r in mesh['nets'].items()})
    for prefix,pattern in [('bitline',r'blb?\d+'),('wordline',r'wl(?:_r)?\d+'),('common',r'yb?')]:
        values=[v for n,v in info['ladder_nets'].items() if re.fullmatch(pattern,n)]
        result['wire_groups'][prefix]=dict(nets=len(values),
            resistance_ohm_range=[min(v['resistance_ohm'] for v in values),max(v['resistance_ohm'] for v in values)],
            capacitance_ff_range=[min(v['cap_ff'] for v in values),max(v['cap_ff'] for v in values)])
    return result

def devices(folder):
    result=json.loads((folder/'checks/result.json').read_text())
    assert result['lvs']['passed'] and result['drc']['passed']
    assert result['gds_sha256']==sha(folder/'sram512.gds')
    v=db.LayoutVsSchematic();v.read(str(folder/'checks/sram512_macro.lvsdb'))
    assert all(p.status()==db.NetlistCrossReference.Match for p in v.xref().each_circuit_pair())
    core=v.netlist().circuit_by_name('sram512');aliases={}
    for p in v.xref().each_net_pair(core):
        if p.first() is not None and p.second() is not None:
            aliases[p.first().cluster_id]=observation_name(p.second().name)
    assert len(set(aliases.values()))==len(aliases)
    records=[];sequence=0
    def walk(c,mapping,tr):
        nonlocal sequence
        sequence+=1;inst=sequence
        local={n.cluster_id:mapping.get(n.cluster_id,f'physical_{inst}_{n.cluster_id}') for n in c.each_net()}
        for dev in c.each_device():
            kind=dev.device_class().name.upper();assert kind in ('NMOS','PMOS','DP','DN')
            if kind in ('DP','DN'):
                assert abs(dev.parameter('A')-12.96)<1e-6
                xy=tr*dev.trans*db.DPoint(0,0)
                records.append(dict(model=kind,nets={p:local[dev.net_for_terminal(p).cluster_id] for p in ('A','C')},
                                    parameters={p:dev.parameter(p) for p in ('A','P')},fingers=1,
                                    instance=inst,cell=c.name,position_um=[xy.x,xy.y]))
                continue
            fingers=1+len(list(dev.each_combined_abstract()))
            width=dev.parameter('W')/fingers
            assert any(abs(width-w)<1e-6 for w in (3.4,5.1,6.8,10.2)),(c.name,kind,width,fingers)
            assert abs(dev.parameter('L')-1)<1e-6,(c.name,'unexpected combined length')
            xy=tr*dev.trans*db.DPoint(0,0)
            params={p:dev.parameter(p)/(fingers if p!='L' else 1) for p in ('W','L','AS','AD','PS','PD')}
            records.append(dict(model=kind,nets={p:local[dev.net_for_terminal(p).cluster_id] for p in ('D','G','S','B')},
                                parameters=params,fingers=fingers,instance=inst,cell=c.name,position_um=[xy.x,xy.y]))
        for sub in c.each_subcircuit():
            child=sub.circuit_ref()
            pins={child.net_for_pin(p.id()).cluster_id:local[sub.net_for_pin(p.id()).cluster_id] for p in child.each_pin()}
            walk(child,pins,tr*sub.trans)
    walk(core,aliases,db.DCplxTrans())
    assert {'vdd','vss','clk','reset','sdi','we','sdo'} <=set(aliases.values())
    return records,dict(gds_sha256=result['gds_sha256'],lvsdb_sha256=sha(folder/'checks/sram512_macro.lvsdb'),
                        mos_groups=sum(r['model'] in ('NMOS','PMOS') for r in records),
                        physical_fingers=sum(r['fingers'] for r in records if r['model'] in ('NMOS','PMOS')),
                        model_counts=dict(Counter(r['model'] for r in records)),source=str(folder))

def device_lines(records):
    lines=['* Physically extracted 512-bit SRAM',f'.include {PDK}/libs.tech/spice/models/ip62_models']
    for i,r in enumerate(records):
        if r['model'] in ('DP','DN'):
            lines.append(f'Dphysical{i} {r["nets"]["A"]} {r["nets"]["C"]} {r["model"]} m=1')
            continue
        suffix={'W':'u','L':'u','AS':'p','AD':'p','PS':'u','PD':'u'}
        pars=' '.join(f'{p}={val:.12g}{suffix[p]}' for p,val in r['parameters'].items())
        lines.append(f'XM{i} '+' '.join(r['nets'][p] for p in ('D','G','S','B'))+f" {r['model']} {pars} m={r['fingers']}")
    return [re.sub(r'(?i)\bvss\b','0',line) for line in lines]

def simulate(folder,name='postlayout_nominal',period=1000,vdd=5,temp=27,rc_scale=None,recheck=False,power_sheet=None,voltage_envelope=False,power_mesh_grid=None,solver='sparse',addresses=None,max_step_ns=20,physical_gate_paths=False,startup_ramp_ns=0,reltol=None,integration_method=None,initial_reset_high=False,threads=1,pivrel=None,stream=False,signal_mesh=False,signal_sections=4,access_limit=None,case_override=None):
    work=WORK/'analog'/name;work.mkdir(parents=True,exist_ok=True)
    records,provenance=devices(folder);write_json(work/'physical_devices.json',records)
    case=scenario(period=period,addresses=addresses) if case_override is None else copy.deepcopy(case_override)
    assert case['period_ns']==period
    if access_limit is not None:
        assert 0<access_limit<=len(case['operations'])
        case['operations']=case['operations'][:access_limit]
        case['stop_ns']=case['operations'][-1]['e0']+8*period
    if initial_reset_high:
        case['events']['RESET']=[(0,1),(.75*period,1),(.75*period+case['edge_ns'],0)]
    if startup_ramp_ns:
        assert startup_ramp_ns>0
        for op in case['operations']:
            for key in ('first','e0'):op[key]+=startup_ramp_ns
        case['stop_ns']+=startup_ramp_ns;case['initial_check_ns']=startup_ramp_ns+.6*period
        for n,events in case['events'].items():
            if n=='RESET' and case_override is not None:
                assert events[0]==(0,1)
                case['events'][n]=[(0,1)]+[(t+startup_ramp_ns,b) for t,b in events[1:]]
            elif n=='RESET':case['events'][n]=[(0,1),(startup_ramp_ns+.75*period,1),(startup_ramp_ns+.75*period+case['edge_ns'],0)]
            else:case['events'][n]=[(0,0)]+[(t+startup_ramp_ns,b) for t,b in events[1:]]
        for reset in case.get('reset_intervals',[]):
            for key in ('before_ns','assert_ns','release_ns'):reset[key]+=startup_ramp_ns
    write_json(work/'scenario.json',case)
    extra=[];wire_nodes=[];rc_info=None;power_info=None
    if rc_scale is not None:
        from wire_rc import add_rc
        records,extra,wire_nodes,rc_info=add_rc(folder,records,rc_scale,physical_gate_paths=physical_gate_paths,signal_mesh=signal_mesh,signal_sections=signal_sections)
        write_json(work/'wire_rc.json',rc_info)
    if power_sheet is not None:
        if power_mesh_grid is None:
            from power_rc import add_power_rc
            records,power_lines,power_nodes,power_info=add_power_rc(folder,records,power_sheet)
        else:
            from power_mesh import add_power_mesh
            records,power_lines,power_nodes,power_info=add_power_mesh(folder,records,power_sheet,step_um=power_mesh_grid)
        extra+=power_lines;wire_nodes+=power_nodes
        write_json(work/'power_rc.json',power_info)
    if voltage_envelope:
        from electrical_limits import nodes
        wire_nodes=sorted(set(wire_nodes+nodes(records)))
    lines=device_lines(records)
    if startup_ramp_ns:
        from analog import spice_time
        lines+=[f'VVDD vdd 0 PWL(0 0 {spice_time(startup_ramp_ns)} {vdd})']
    else:lines+=['VVDD vdd 0 5']
    for n,events in case['events'].items():
        if startup_ramp_ns and n=='RESET':
            lines+=['Vreset_logic reset_logic 0 '+pwl(events).replace('VSUP','1'),
                    'Breset reset 0 v=v(vdd)*v(reset_logic)']
        else:lines.append(f'V{n} {n} 0 {pwl(events)}')
    if rc_scale is None:
        for prefix,count,value in [('BL',32,'70f'),('BLB',32,'70f'),('WL',16,'400f')]:
            for i in range(count):lines.append(f'Cwire_{prefix}{i} {prefix}{i} 0 {value}')
        lines +=['Cwire_Y Y 0 180f','Cwire_YB YB 0 180f']
    lines +=extra+['Cout SDO 0 10p']
    ctl=control(case,threads=threads).replace('save ','save i(VVDD) '+' '.join(f'v({n})' for n in wire_nodes)+' ',1)
    if startup_ramp_ns:ctl=ctl.replace('v(VDD)[0]',f'{vdd:.12g}')
    assert 0<max_step_ns<=period/10
    ctl=ctl.replace(' 0 20n',f' 0 {max_step_ns:.12g}n',1)
    # ngspice's interactive save command has a finite argument count. Split
    # large observation lists; an overlong save silently falls back to all
    # circuit nodes after reporting "save: too many args".
    ctl='\n'.join('\n'.join('save '+' '.join(line.split()[1:][i:i+100])
            for i in range(0,len(line.split())-1,100)) if line.startswith('save ') else line
            for line in ctl.splitlines())
    ctl='\n'.join(s for s in ctl.splitlines() if not s.startswith('plot '))
    ctl=ctl.replace('.endc','quit\n.endc')
    deck='\n'.join(lines+[ctl,'.end'])+'\n'
    assert solver in ('sparse','klu')
    if solver=='klu':deck=deck.replace('.control','.options klu\n.control',1)
    # Numerical convergence experiments retain the same extracted circuit,
    # device models and stimuli. Defaults retain the original ngspice settings.
    if reltol is not None:
        assert 0<reltol<=1e-3
        deck=deck.replace('.control',f'.options reltol={reltol:.12g}\n.control',1)
    if integration_method is not None:
        assert integration_method in ('trap','gear')
        deck=deck.replace('.control',f'.options method={integration_method} maxord=2\n.control',1)
    if pivrel is not None:
        assert 0<pivrel<=1
        deck=deck.replace('.control',f'.options pivrel={pivrel:.12g}\n.control',1)
    deck=deck.replace('VVDD vdd 0 5',f'VVDD vdd 0 {vdd}').replace('VSUP=5',f'VSUP={vdd}').replace('.temp 27',f'.temp {temp}')
    if stream:
        # Native batch raw output writes every accepted point to disk instead
        # of retaining all waveforms in ngspice's control-language memory.
        # Python performs the same functional/RC/voltage/current checks below.
        block=re.search(r'(?s)\.control\n(.*?)\.endc',deck)
        batch='\n'.join('.'+line for line in block[1].splitlines() if line.startswith(('save ','tran ')))
        deck=deck[:block.start()]+batch+deck[block.end():]
        local_init=work/'.spiceinit'
        init_text=f'set num_threads={threads}\n' if threads else ''
        if recheck:assert local_init.read_text()==init_text
        else:local_init.write_text(init_text)
    path=work/'test.spice'
    start=time.monotonic();print('ngspice',name,provenance['physical_fingers'],'physical MOS',flush=True)
    if recheck:
        assert path.read_text()==deck,'Electrical deck differs; a fresh simulation is required.'
        log=(work/'simulation.log').read_text()
    else:
        path.write_text(deck)
        _,log=run(['ngspice','-b']+(['-r','sram512_tb.raw'] if stream else [])+[path],work,'simulation.log')
    notices=simulation_diagnostics(log)
    result=verify(work/'sram512_tb.raw',case,vdd)
    if voltage_envelope:
        from electrical_limits import verify as verify_limits
        limits=verify_limits(work/'sram512_tb.raw',records)
        result.update(voltage_limits=limits,passed=result['passed'] and limits['passed'],
                      failure_count=result['failure_count']+limits['failure_count'],checks=result['checks']+limits['checks'])
        from all_cell_retention import verify as verify_all_cells
        retention=verify_all_cells(work/'sram512_tb.raw',case,vdd)
        result.update(all_cell_retention=retention,passed=result['passed'] and retention['passed'],
                      failure_count=result['failure_count']+retention['failure_count'],checks=result['checks']+retention['checks'])
    if power_info is not None:
        from power_rc import verify_power
        result['power_supply_observations']=verify_power(work/'sram512_tb.raw',case,vdd)
        result['power_resistance_model']={k:power_info[k] for k in ('sheet_ohm','via_ohm','scope','source_gds_sha256')}
        if 'grid_um' in power_info:result['power_resistance_model']['grid_um']=power_info['grid_um']
        result['power_resistance_model']['detailed_parameters_sha256']=sha(work/'power_rc.json')
        if power_mesh_grid is not None:
            from power_mesh import verify_via_currents
            currents=verify_via_currents(work/'sram512_tb.raw',power_info)
            result.update(via_currents=currents,passed=result['passed'] and currents['passed'],
                          checks=result['checks']+currents['checks'],
                          failure_count=result['failure_count']+currents['failure_count'])
    if rc_scale is not None:
        from wire_rc import verify_rc
        rc_checks=verify_rc(work/'sram512_tb.raw',case,vdd)
        result.update(rc_checks=rc_checks,passed=result['passed'] and rc_checks['passed'])
        result['failure_count']+=rc_checks['failure_count']
        result['checks']+=rc_checks['checks']
        if signal_mesh:
            from signal_mesh import verify_waveform
            mesh_checks=verify_waveform(work/'sram512_tb.raw',case,vdd,rc_info['signal_mesh'])
            result.update(signal_mesh_checks=mesh_checks,passed=result['passed'] and mesh_checks['passed'],
                checks=result['checks']+mesh_checks['checks'],failure_count=result['failure_count']+mesh_checks['failure_count'])
    result.update(name=name,physical_extraction=provenance,period_ns=period,voltage_v=vdd,temperature_c=temp,
                  elapsed_seconds=round(time.monotonic()-start,2),deck_sha256=sha(path),
                  reused_waveform=recheck,model_notices=notices,
                  solver=solver,
                  simulator_threads=threads or None,
                  waveform_storage='streamed binary file' if stream else 'control memory then write',
                  local_init_sha256=sha(work/'.spiceinit') if stream else None,
                  numerical_reltol=reltol,numerical_pivrel=pivrel,integration_method=integration_method,
                  maximum_timestep_ns=max_step_ns,
                  signal_mesh=signal_mesh,signal_sections=signal_sections if signal_mesh else None,access_limit=access_limit,
                  physical_gate_paths=physical_gate_paths,startup_ramp_ns=startup_ramp_ns,
                  initial_reset_high=initial_reset_high,
                  startup_scope=('Supply ramps from zero with RESET tracking it.' if startup_ramp_ns else
                                 'DC supply and initially asserted RESET; power ramp is a separate test.' if initial_reset_high else
                                 'DC supply; RESET rises after the initial operating point.'),
                  interconnect=rc_summary(rc_info,work/'wire_rc.json') if rc_info else
                  'Extra lumped C only; wire resistance and distributed RC not yet included')
    t,w=load_raw(work/'sram512_tb.raw');current=-w['i(vvdd)']
    dt=np.diff(t)
    result['supply_current_a']={'max':float(current.max()),
        'time_mean':float(np.sum((current[1:]+current[:-1])*.5*dt)/(t[-1]-t[0])),
        'rms':float(np.sqrt(np.sum((current[1:]**2+current[:-1]**2)*.5*dt)/(t[-1]-t[0])))}
    write_json(work/'result.json',result);write_json(REPORTS/(name+'.json'),result)
    print(name,result['passed'],result['failure_count'],result['checks'],flush=True)
    return result

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('folder',type=Path);ap.add_argument('--name',default='postlayout_nominal');ap.add_argument('--rc-scale',type=float)
    ap.add_argument('--vdd',type=float,default=5);ap.add_argument('--temperature',type=float,default=27)
    ap.add_argument('--period',type=float,default=1000);ap.add_argument('--max-step-ns',type=float,default=20);ap.add_argument('--recheck',action='store_true');ap.add_argument('--power-sheet',type=float);ap.add_argument('--voltage-envelope',action='store_true');ap.add_argument('--power-mesh-grid',type=float);ap.add_argument('--solver',choices=['sparse','klu'],default='sparse');ap.add_argument('--decode-coverage',action='store_true');ap.add_argument('--addresses',help='Comma-separated physical addresses for a bounded diagnostic');ap.add_argument('--physical-gate-paths',action='store_true');ap.add_argument('--startup-ramp-ns',type=float,default=0);ap.add_argument('--reltol',type=float);ap.add_argument('--pivrel',type=float);ap.add_argument('--stream',action='store_true');ap.add_argument('--integration-method',choices=['trap','gear']);ap.add_argument('--initial-reset-high',action='store_true');ap.add_argument('--threads',type=int,choices=range(5),default=1,help='0 keeps the external ngspice setting for historical rechecks; default 1 avoids oversubscribing concurrent simulations')
    ap.add_argument('--signal-mesh',action='store_true',help='Retain actual WL/C4B branches and separate physical gate taps')
    ap.add_argument('--signal-sections',type=int,choices=(1,2,4,8,16),default=4)
    ap.add_argument('--access-limit',type=int,help='Bound a diagnostic to the first N complete accesses')
    a=ap.parse_args()
    if a.signal_mesh:assert a.rc_scale is not None,'Signal mesh requires --rc-scale.'
    if a.power_mesh_grid is not None:assert a.power_sheet is not None,'Mesh needs an explicit sheet-resistance assumption.'
    addresses=sorted(set([0,31,480,511]+[32*(c%16)+c for c in range(32)])) if a.decode_coverage else None
    if a.addresses:
        assert not a.decode_coverage
        addresses=[int(n) for n in a.addresses.split(',')]
        assert addresses and len(set(addresses))==len(addresses) and all(0<=n<512 for n in addresses)
    result=simulate(a.folder.resolve(),a.name,period=a.period,vdd=a.vdd,temp=a.temperature,rc_scale=a.rc_scale,recheck=a.recheck,power_sheet=a.power_sheet,voltage_envelope=a.voltage_envelope,power_mesh_grid=a.power_mesh_grid,solver=a.solver,addresses=addresses,max_step_ns=a.max_step_ns,physical_gate_paths=a.physical_gate_paths,startup_ramp_ns=a.startup_ramp_ns,reltol=a.reltol,integration_method=a.integration_method,initial_reset_high=a.initial_reset_high,threads=a.threads,pivrel=a.pivrel,stream=a.stream,signal_mesh=a.signal_mesh,signal_sections=a.signal_sections,access_limit=a.access_limit)
    raise SystemExit(0 if result['passed'] else 1)
