"""Independent, non-mutating MAC review. All generated decks stay under simulation/.

Run --physical, --simulate, or --audit. Does not rewrite design or previous reports.
Additional conditions are diagnostic probes, not qualified operating specifications.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import argparse
import collections
import hashlib
import itertools
import json
import re
import subprocess
import time

import klayout.db as db
import numpy as np
import verify_arithmetic_layout as verification
from check_half_adder_extracted import subckts

ROOT = Path(__file__).resolve().parents[1]
PDK = verification.PDK
WORK = ROOT / 'simulation/review_mac'
REPORT = ROOT / 'reports/review_mac'
CELLS = ['inverter', 'nany', 'half_adder', 'full_adder', 'mul_nand',
         'mul_nor', 'mul_inv', 'mul', 'mac']
STATES = list(itertools.product((-1, 0, 1), repeat=4))


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def output(name, value):
    REPORT.mkdir(parents=True, exist_ok=True)
    (REPORT / (name + '.json')).write_text(json.dumps(value, indent=2) + '\n')


def netlist(name, source=ROOT, lvs=False):
    folder = WORK / ('submission' if source != ROOT else 'root') / name / ('lvs_ref' if lvs else 'sim_ref')
    folder.mkdir(parents=True, exist_ok=True)
    rc = folder / 'xschemrc'
    rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{source}:/usr/local/share/xschem/xschem_library:{PDK}/libs.tech/xschem}}\nset LIB {{{PDK}/libs.tech/spice/models}}\nset lvs_netlist {int(lvs)}\nset top_is_subckt {int(lvs)}\nset spiceprefix 1\n')
    cmd = ['xschem', '-r', '-x', '--rcfile', str(rc), '-s', '--command',
           'set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result',
           '-o', str(folder), str(source / (name + '.sch'))]
    p = subprocess.run(cmd, capture_output=True, text=True, timeout=60)
    log = p.stdout + p.stderr
    (folder / 'netlist.log').write_text(log)
    if p.returncode or re.search(r'Error:|SKIPPING|IS MISSING', log):
        raise RuntimeError(log)
    path = folder / (name + '.spice')
    text = re.sub(r'\n\+\s*', ' ', path.read_text())
    if lvs:
        text = re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)', r'M\1\2', text)
        path = folder / 'reference.spice'
        path.write_text(text)
    return path, text


def physical_one(name, source=ROOT):
    gds = source / (name + '.gds')
    before = sha(gds)
    ref, _ = netlist(name, source, True)
    folder = WORK / ('submission' if source != ROOT else 'root') / name
    result = dict(gds=str(gds), sha256=before, reference_sha256=sha(ref))
    result['drawing'] = verification.drc(gds, name, folder / 'drawing')
    result['lvs'] = verification.lvs(name, gds, ref, folder / 'lvs')
    result['mask'] = verification.mask(gds, name, folder / 'mask')
    assert sha(gds) == before
    print(name, 'submission' if source != ROOT else 'root', {k: v.get('passed') for k, v in result.items() if isinstance(v, dict)}, flush=True)
    return result


def physical():
    result = {}
    with ThreadPoolExecutor(max_workers=3) as pool:
        jobs = {pool.submit(physical_one, n): n for n in CELLS}
        jobs[pool.submit(physical_one, 'mac', ROOT / 'submission')] = 'submission/mac'
        for future in as_completed(jobs):
            name = jobs[future]
            try:
                result[name] = future.result()
            except Exception as exc:
                result[name] = dict(error=str(exc))
            output('physical', result)


def layout(path, name):
    ly = db.Layout()
    ly.read(str(path))
    return ly, ly.cell(name)


def equal_shapes(first, second):
    la, ca = first
    lb, cb = second
    differences = []
    layers = set((i.layer, i.datatype) for l in (la, lb) for i in l.layer_infos())
    for layer, datatype in sorted(layers):
        ia, ib = la.layer(layer, datatype), lb.layer(layer, datatype)
        delta = db.Region(ca.begin_shapes_rec(ia)) ^ db.Region(cb.begin_shapes_rec(ib))
        if not delta.is_empty():
            differences.append(dict(layer=[layer, datatype], xor_area_um2=delta.area() * la.dbu ** 2))
        def texts(c, index):
            labels=collections.Counter();iterator=c.begin_shapes_rec(index)
            while not iterator.at_end():
                shape=iterator.shape()
                if shape.is_text():labels[str(shape.text.transformed(iterator.trans()))]+=1
                iterator.next()
            return labels
        ta,tb=texts(ca,ia),texts(cb,ib)
        if ta!=tb:
            differences.append(dict(layer=[layer,datatype],text_difference_count=sum((ta-tb).values())+sum((tb-ta).values())))
    return differences


def pcell_audit():
    cold={name:layout(ROOT/(name+'.gds'),name) for name in CELLS}
    # Register current dev PCells only after the saved geometry has been read.
    import sys
    sys.path.insert(0,str(ROOT/'layout'))
    import build_inverter  # noqa: F401; registration is the intended side effect
    result={}
    for name,original in cold.items():
        current=db.Layout();current.technology_name='TR-1um';current.read(str(ROOT/(name+'.gds')))
        differences=equal_shapes(original,(current,current.cell(name)))
        result[name]=dict(differences=differences,live_pcell_variants=sum(c.is_pcell_variant() for c in current.each_cell()),passed=not differences)
    output('pcell',result)
    print('PCell:',result,flush=True)


def audit():
    files = {str(p.relative_to(ROOT)): sha(p) for folder in (ROOT, ROOT / 'submission')
             for p in folder.iterdir() if p.suffix in ('.gds', '.sch', '.sym', '.extracted')}
    result = dict(files=files, git_status=subprocess.check_output(['git', 'status', '--short'], cwd=ROOT, text=True),
                  pdk_revision=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd='/home/ishi-kai/src/TR-1um', text=True).strip())
    pdk_files = [p for category in ('klayout/tech/drc', 'klayout/tech/lvs', 'spice/models')
                 for p in (PDK / 'libs.tech' / category).rglob('*') if p.is_file()]
    result['pdk_hashes'] = {str(p.relative_to(PDK)): sha(p) for p in pdk_files}
    result['pdk_source_differences'] = [str(p.relative_to(PDK)) for p in pdk_files
         if not (Path('/home/ishi-kai/src/TR-1um') / p.relative_to(PDK)).exists()
         or sha(p) != sha(Path('/home/ishi-kai/src/TR-1um') / p.relative_to(PDK))]
    ly, top = layout(ROOT / 'mac.gds', 'mac')
    box = top.dbbox()
    result['geometry'] = dict(dbu_um=ly.dbu, bbox_um=[box.left, box.bottom, box.right, box.top],
                              fits=box.left >= 0 and box.bottom >= 0 and box.right <= 1800 and box.top <= 1000)
    result['placement_problems'] = []
    result['global_origin_problems'] = []
    def walk(cell, transform, hierarchy):
        for inst in cell.each_inst():
            for local in inst.cell_inst.each_cplx_trans():
                absolute=transform*local
                x,y=absolute.disp.x*ly.dbu,absolute.disp.y*ly.dbu
                path=hierarchy+'/'+inst.cell.name
                if not (0<=x<=1800 and 0<=y<=1000):
                    result['global_origin_problems'].append(dict(path=path,origin_um=[x,y]))
                walk(inst.cell,absolute,path)
    walk(top,db.ICplxTrans(),'mac')
    result['off_grid_polygon_points'] = 0
    for layer in ly.layer_indexes():
        for polygon in db.Region(top.begin_shapes_rec(layer)).each():
            rings = [list(polygon.each_point_hull())] + [list(polygon.each_point_hole(h)) for h in range(polygon.holes())]
            result['off_grid_polygon_points'] += sum(p.x % 50 != 0 or p.y % 50 != 0 for ring in rings for p in ring)
    for cell in ly.each_cell():
        for inst in cell.each_inst():
            tr = inst.dcplx_trans
            if abs(tr.mag - 1) > 1e-12 or any(abs(v / .05 - round(v / .05)) > 1e-8 for v in (tr.disp.x, tr.disp.y)):
                result['placement_problems'].append(dict(cell=cell.name, child=inst.cell.name, transform=str(tr)))
    result['submission_shape_differences'] = equal_shapes((ly, top), layout(ROOT / 'submission/mac.gds', 'mac'))
    result['embedded_cell_shape_differences'] = {n: equal_shapes((ly, ly.cell(n)), layout(ROOT / (n + '.gds'), n)) for n in CELLS if n != 'mac'}
    result['ports'] = []
    for name, meta in json.loads((ROOT / 'layout/mac.ports.json').read_text())['ports'].items():
        x, y = meta['position_um']
        layer = ly.layer(*meta['layer'])
        probe = db.Box(round(x / ly.dbu) - 1, round(y / ly.dbu) - 1, round(x / ly.dbu) + 1, round(y / ly.dbu) + 1)
        hit = not (db.Region(top.begin_shapes_rec(layer)) & db.Region(probe)).is_empty()
        result['ports'].append(dict(name=name, coordinate_um=[x, y], on_metal=hit))
    result['existing_report_hash_mismatches'] = {}
    for name in CELLS:
        p = ROOT / ('reports/' + name + '_layout.json')
        if p.exists():
            r = json.loads(p.read_text())
            if r.get('gds_sha256') != sha(ROOT / (name + '.gds')):
                result['existing_report_hash_mismatches'][name] = dict(recorded=r.get('gds_sha256'), current=sha(ROOT / (name + '.gds')))
    output('audit', result)
    print('Audit:', result['geometry'], 'stale:', list(result['existing_report_hash_mismatches']), flush=True)


def verify_logic():
    _, text = netlist('mac_tb')
    defs = subckts(text)
    def cell(kind, inputs):
        if kind in ('inverter', 'mul_inv'):
            return dict(vout=-inputs['vin'])
        if kind == 'mul_nand':
            return dict(vout=-min(inputs['a'], inputs['b']))
        if kind == 'mul_nor':
            return dict(vout=-max(inputs['a'], inputs['b']))
        if kind == 'nany':
            return dict(vout=-max(-1,min(1,inputs['a']+inputs['b'])))
        values = {**inputs, 'VDD':1, 'VSS':-1, 'VMID':0}
        todo = [p for p in defs[kind]['lines'] if p[0].lower().startswith('x')]
        while todo:
            progress = False
            for p in list(todo):
                child = p[-1].lower()
                pins = dict(zip(defs[child]['pins'],p[1:-1]))
                names = ('vin',) if child in ('inverter','mul_inv') else ('x','a','b','cin') if child=='mac' else ('a','b','cin') if child=='full_adder' else ('a','b')
                if all(pins[k] in values for k in names):
                    out = cell(child,{k:values[pins[k]] for k in names})
                    values.update({pins[k]:v for k,v in out.items() if k in pins})
                    todo.remove(p);progress=True
            assert progress, (kind,todo)
        return values
    errors=[]
    for state in STATES:
        result=cell('mac',dict(zip(('x','a','b','cin'),state)))
        actual=tuple(result[k] for k in ('sum','cout','and_out','or_out','p'))
        if actual!=oracle(state):errors.append(dict(state=state,actual=actual,expected=oracle(state)))
    output('logic',dict(states=81,errors=errors,passed=not errors,
        method='Interpret fresh hierarchical schematic connectivity using ideal primitive truth tables; independently enumerate balanced-ternary output pairs.'))
    print('Ideal logic:',len(errors),'errors / 81 states',flush=True)


def recheck_saved_transitions():
    results={}
    for scope in ('schematic','extracted'):
        report=json.loads((ROOT/f'reports/mac{"_extracted" if scope=="extracted" else ""}.json').read_text())
        if scope=='schematic':
            assert all(sha(ROOT/n)==h for n,h in report['source_sha256'].items())
        else:
            assert sha(ROOT/'mac.gds')==report['gds_sha256'] and sha(ROOT/'mac.extracted')==report['extracted_sha256']
        assert all(sha(PDK/n)==h for n,h in report['model_sha256'].items())
        for mode in ('all_6480_10f','single_input_648_100f'):
            folder=ROOT/'simulation/mac'/scope/mode
            paths=sorted(folder.glob('chunk_*/data.txt')) if mode.startswith('all') else [folder/'data.txt']
            coverage=collections.Counter();maxerr=np.zeros(5);sample_count=0
            for path in paths:
                deps=json.loads((path.parent/'input_dependencies.json').read_text())
                assert all(sha(p)==h for p,h in deps.items())
                assert 'ngspice-46+ done' in (path.parent/'run.log').read_text()
                data=np.loadtxt(path,skiprows=1)
                assert np.isfinite(data).all() and data.shape[1]==10 and abs(data[:,1:]).max()<7
                hold=120;count=round(data[-1,0]*1e9/hold)
                sample=np.array([[np.interp((k+1)*hold-1,data[:,0]*1e9,data[:,j]) for j in range(1,10)] for k in range(count)])
                states=np.rint(sample[:,:4]/5).astype(int)
                assert abs(sample[:,:4]-states*5).max()<1e-5
                targets=np.array([oracle(s) for s in states])*5
                # Saved column order: four inputs, SUM, COUT, P, AND, OR.
                obs=sample[:,[4,5,7,8,6]]
                maxerr=np.maximum(maxerr,abs(obs-targets).max(axis=0))
                sample_count+=count
                first=1 if mode.startswith('all') else 0
                for a,b in zip(states[first:-1],states[first+1:]):coverage[(tuple(a),tuple(b))]+=1
            expected={(a,b) for a in STATES for b in STATES if a!=b and (mode.startswith('all') or sum(x!=y for x,y in zip(a,b))==1)}
            assert set(coverage)==expected and all(v==1 for v in coverage.values())
            results[scope+'/'+mode]=dict(samples=sample_count,unique_transitions=len(coverage),all_once=True,
                max_errors_V=dict(zip(('sum','cout','and_out','or_out','product'),maxerr.tolist())),
                passed=bool(np.max(maxerr)<=.5),provenance='Re-evaluated existing raw waveforms, with current source/model/extraction hashes and independent oracle; not newly simulated.')
            output('saved_transitions',results)
            print(scope,mode,results[scope+'/'+mode],flush=True)


def oracle(state):
    x, a, b, cin = state
    total = x + a * b + cin
    # Independent enumeration avoids sharing the TB generation formula.
    answers = [(s, c) for s, c in itertools.product((-1, 0, 1), repeat=2) if s + 3 * c == total]
    assert len(answers) == 1
    return (*answers[0], min(a, b), max(a, b), a * b)


def mos_instances(base):
    defs = subckts(base)
    found = []
    def descend(kind, prefix, bindings):
        def node(n):
            return bindings.get(n.lower(), prefix + '.' + n.lower())
        for parts in defs[kind]['lines']:
            if parts[0].startswith('*') or parts[0].startswith('.'):
                continue
            model = next((p.lower() for p in parts[1:] if p.lower() in defs or p.lower() in ('pmos', 'nmos')), None)
            if not model:
                continue
            if model in ('pmos', 'nmos'):
                found.append(dict(name=prefix + '.' + parts[0].lower(), model=model,
                                  terminals=[node(p) for p in parts[1:5]]))
            elif model in defs:
                count = len(defs[model]['pins'])
                descend(model, prefix + '.' + parts[0].lower(), dict(zip((p.lower() for p in defs[model]['pins']), (node(p) for p in parts[1:count+1]))))
    descend('mac', 'xdut', {p.lower(): p.lower() for p in defs['mac']['pins']})
    return found


def simulate_case(base, name, temp=27, rail=5, cap_ff=10, hold_ns=200,
                  edge_ns=1, no_nodeset=False, resistance=None, zero_offset=0,
                  supply_resistance=0, stress=False, extra='', extra_vectors=(),
                  product_node='xdut.p', states=None, power_ramp_ns=0, maximum_step_ns=None):
    folder = WORK / 'simulations' / name
    folder.mkdir(parents=True, exist_ok=True)
    text = re.sub(r'\.control.*?\.endc', '', base, flags=re.S | re.I)
    text = re.sub(r'(?im)^\.temp .*$', f'.temp {temp}', text)
    if no_nodeset:
        text = re.sub(r'(?im)^\.nodeset[^\n]*\n', '', text)
    for net, value in [('VDD', rail), ('VSS', -rail), ('VMID', 0)]:
        target = net if not supply_resistance else net + '_external'
        source_value = str(value) if not power_ramp_ns else f'PWL(0 0 {power_ramp_ns}n {value})'
        text = re.sub(r'(?im)^' + net + r' .*$', f'{net} {target} 0 {source_value}', text)
        if supply_resistance:
            extra += f'\nRfeed_{net} {target} {net} {supply_resistance}\n'
    sequence = (STATES + [STATES[0]]) if states is None else states
    for j, net in enumerate(('x', 'a', 'b', 'cin')):
        def voltage(state):
            return state[j] * rail if state[j] else zero_offset
        points = [f'0 {voltage(sequence[0])}']
        if power_ramp_ns:
            points = ['0 0', f'{power_ramp_ns}n {voltage(sequence[0])}']
        for k in range(1, len(sequence)):
            points.extend([f'{hold_ns*k}n {voltage(sequence[k-1])}', f'{hold_ns*k+edge_ns}n {voltage(sequence[k])}'])
        points.append(f'{hold_ns*len(sequence)}n {voltage(sequence[-1])}')
        text = re.sub(r'(?im)^V' + net.upper() + r' .*$', f'V{net.upper()} {net} 0 PWL(' + ' '.join(points) + ')', text)
    for net in ('sum', 'cout', 'and_out', 'or_out'):
        text = re.sub(r'(?im)^C' + net + r' .*$', f'C{net} {net} 0 {cap_ff}f', text)
        text = re.sub(r'(?im)^Rload_' + net + r' .*\n', '', text)
        if resistance:
            extra += f'\nRload_{net} {net} 0 {resistance}\n'
    nodes = ['x', 'a', 'b', 'cin', 'sum', 'cout', 'and_out', 'or_out', product_node]
    mos = mos_instances(base) if stress else []
    if stress:
        nodes += sorted(set(n for m in mos for n in m['terminals']) - set(nodes))
    vectors = [f'v({n})' for n in nodes] + list(extra_vectors) + ['i(vdd)', 'i(vss)', 'i(vmid)']
    maximum_step = maximum_step_ns or min(2, edge_ns if edge_ns > 0 else 1)
    ctrl = '\n.control\nset wr_singlescale\nset wr_vecnames\nsave ' + ' '.join(vectors)
    ctrl += f'\ntran {maximum_step}n {len(sequence)*hold_ns}n 0 {maximum_step}n\nwrdata data.txt ' + ' '.join(vectors) + '\nquit\n.endc\n'
    text = re.sub(r'(?im)^\.end\s*$', lambda _: extra + '\n' + ctrl + '.end', text)
    (folder / 'tb.spice').write_text(text)
    start = time.time()
    with (folder / 'run.log').open('w') as log:
        try:
            proc = subprocess.run(['ngspice', '-b', 'tb.spice'], cwd=folder, stdout=log, stderr=subprocess.STDOUT, timeout=600)
        except subprocess.TimeoutExpired:
            return dict(name=name, simulation_error='timeout', elapsed_s=time.time()-start)
    log = (folder / 'run.log').read_text()
    # Failed intermediate gmin/source stepping can recover with a successful
    # transient OP. Do not classify those warnings as an aborted analysis.
    if proc.returncode or re.search(r'Error:|Timestep too small|simulation\(s\) aborted', log, re.I) or not (folder / 'data.txt').exists():
        return dict(name=name, simulation_error=log[-2500:], elapsed_s=time.time()-start)
    data = np.loadtxt(folder / 'data.txt', skiprows=1)
    if data.shape[1] != len(vectors) + 1 or not np.isfinite(data).all() or data[-1, 0] < len(sequence)*hold_ns*1e-9 - 1e-14:
        return dict(name=name, simulation_error='invalid or truncated data')
    t = data[:, 0]*1e9
    samples = np.array([[np.interp((k+1)*hold_ns-1, t, data[:, j+1]) for j in range(len(vectors))] for k in range(len(sequence))])
    expected = np.array([oracle(state) for state in sequence])*rail
    errors = abs(samples[:, 4:9] - expected)
    logical = np.where(samples[:, 4:9] < -rail/2, -1, np.where(samples[:, 4:9] > rail/2, 1, 0))
    logical_errors = np.any(logical != expected/rail, axis=1)
    bad = np.any(errors > .5, axis=1)
    worst = np.unravel_index(np.argmax(errors), errors.shape)
    outnames = ['sum', 'cout', 'and_out', 'or_out', 'product']
    result = dict(name=name, temperature_C=temp, rail_V=rail, load_fF=cap_ff, hold_ns=hold_ns,
                  edge_ns=edge_ns, no_nodeset=no_nodeset, load_resistance_ohm=resistance,
                  zero_offset_V=zero_offset, supply_resistance_ohm=supply_resistance,
                  power_ramp_ns=power_ramp_ns, samples=len(sequence),
                  elapsed_s=time.time()-start, max_errors_V=dict(zip(outnames, errors.max(axis=0).tolist())),
                  tolerance_fail_samples=int(bad.sum()), logic_fail_samples=int(logical_errors.sum()),
                  worst=dict(state_trits=sequence[worst[0]], output=outnames[worst[1]], actual_V=float(samples[worst[0],4+worst[1]]), expected_V=float(expected[worst])),
                  current_mA=dict(zip(('VDD','VSS','VMID'), np.max(abs(samples[:,-3:]),axis=0).tolist())),
                  power_mW_max=float(np.max(-rail*samples[:,-3]+rail*samples[:,-2])*1000),
                  failure_examples=[dict(state_trits=sequence[k], actual_V=samples[k,4:9].tolist(), expected_V=expected[k].tolist()) for k in np.where(bad)[0][:6]])
    result['current_mA'] = {k: v*1000 for k,v in result['current_mA'].items()}
    result['solver_warnings'] = [l for l in log.splitlines() if l.startswith('Warning:')]
    result['max_abs_saved_node_V'] = float(np.max(abs(data[:,1:len(nodes)+1])))
    if extra_vectors:
        result['extra_vector_peaks'] = {n: dict(max_abs=float(np.max(abs(samples[:,len(nodes)+j]))),
            state_trits=sequence[int(np.argmax(abs(samples[:,len(nodes)+j])))]) for j,n in enumerate(extra_vectors)}
        result['transient_vector_peaks']={n:float(np.max(abs(data[:,len(nodes)+j+1]))) for j,n in enumerate(extra_vectors)}
    if stress:
        terminal_index = {n:i for i,n in enumerate(nodes)}
        device_rows = []
        for m in mos:
            v = samples[:, [terminal_index[n] for n in m['terminals']]]
            row = dict(name=m['name'], model=m['model'], terminals=m['terminals'])
            for label, i, j in [('VDS',0,2),('VGS',1,2),('VDB',0,3),('VSB',2,3),('VGD',1,0),('VGB',1,3)]:
                dv=abs(v[:,i]-v[:,j]);k=int(np.argmax(dv))
                row[label] = dict(max_abs_V=float(dv[k]), state_trits=sequence[k])
            device_rows.append(row)
        result['mos_stress'] = dict(devices=len(mos), VDS_over_8V=sum(r['VDS']['max_abs_V']>8 for r in device_rows),
                                  any_terminal_over_5_75V=sum(any(r[k]['max_abs_V']>5.75 for k in ('VDS','VGS','VDB','VSB','VGD','VGB')) for r in device_rows), rows=device_rows)
        (folder/'sampled_states.json').write_text(json.dumps(dict(vectors=vectors, states=sequence, samples=samples.tolist()),indent=2)+'\n')
    (folder / 'results.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


def extra_simulations(only_extracted=False):
    from check_full_adder_extracted import normalized, mapping_for
    _, base = netlist('mac_tb')
    # Instrument supply branches with ideal 0 V current probes, only in this deck.
    body = base
    probes = []
    for role, rail_tokens in [('x_fa', ('VDD','VSS','VMID')), ('x_mul', ('VDD','VSS')), ('x_and', ('VDD','VSS'))]:
        match=re.search(r'(?im)^'+role+r' .+$',body)
        assert match
        parts=match[0].split()
        for rail in rail_tokens:
            pos=parts.index(rail)
            net=role+'_'+rail
            parts[pos]=net
            probes.append('v.xdut.vprobe_'+net.lower()+'#branch')
        replacement=' '.join(parts)+'\n'+'\n'.join(f'Vprobe_{role}_{rail} {rail} {role}_{rail} 0' for rail in rail_tokens)
        body=body[:match.start()]+replacement+body[match.end():]
    # Resolve roles from fresh extracted connectivity, not from anonymous net IDs.
    raw=(WORK/'root/mac/lvs/mac.extracted').read_text()
    ext=normalized(raw)
    defs=subckts(ext)
    def instances(kind):
        return [dict(name=p[0].lower(),kind=p[-1].lower(),pins=dict(zip(defs[p[-1].lower()]['pins'],p[1:-1])))
                for p in defs[kind]['lines'] if p[-1].lower() in defs]
    def find(rows,kind,**pins):
        hit=[r for r in rows if r['kind']==kind and all(r['pins'][k]==v for k,v in pins.items())]
        assert len(hit)==1,(kind,pins,hit)
        return hit[0]
    mac=instances('mac');fa=find(mac,'full_adder',a='x',cin='cin');mul=find(mac,'mul',a='a',b='b')
    assert fa['pins']['b']==mul['pins']['p']
    mapping={k.replace('xdut.','xdut.x_fa.',1):v.replace('xdut.',f'xdut.{fa["name"]}.',1) for k,v in mapping_for(defs).items()}
    mapping['xdut.p']='xdut.'+mul['pins']['p']
    mapping['xdut.nmin']='xdut.'+mul['pins']['t1']
    t2=find(instances('mul'),'mul_nor',a='a',b='b')
    mapping['xdut.x_mul.t2']=f'xdut.{mul["name"]}.'+t2['pins']['vout']
    extbase=re.sub(r'^\.subckt\s+.*?^\.ends\b[^\n]*','',base,flags=re.M|re.S|re.I)
    extbase=re.sub(r'(?im)^xdut .*$', 'xdut '+' '.join(defs['mac']['pins'])+' mac',extbase)
    extbase=re.sub(r'(?im)^\.nodeset[^\n]*\n','',extbase)
    # Solve the fresh schematic OP, then map its estimates to extracted nodes.
    seed_folder=WORK/'extracted_seed';seed_folder.mkdir(parents=True,exist_ok=True)
    op=re.sub(r'\.control.*?\.endc','.control\nop\nprint all\nquit\n.endc',base,flags=re.S)
    (seed_folder/'tb.spice').write_text(op)
    proc=subprocess.run(['ngspice','-b','tb.spice'],cwd=seed_folder,capture_output=True,text=True,timeout=60)
    log=proc.stdout+proc.stderr;(seed_folder/'run.log').write_text(log)
    assert proc.returncode==0
    values={m[1].lower():float(m[2]) for m in re.finditer(r'(?m)^(\S+)\s+=\s+([-+]?\d[\d.eE+-]*)\s*$',log)}
    assert values and all(abs(v)<6 for k,v in values.items() if not k.endswith('#branch'))
    seeds='\n'.join(f'.nodeset v({new})={values[old]:.12g}' for old,new in mapping.items())
    extbase=re.sub(r'(?im)^\.end\s*$',lambda _: ext+'\n'+seeds+'\n.end',extbase)
    params = [
        (body, 'supply_branches', dict(extra_vectors=probes)),
        (extbase, 'extracted_nominal', dict(stress=True, product_node=mapping['xdut.p'])),
        (base, 'rail_2_5_slow', dict(rail=2.5,hold_ns=1000)),
    ]
    previous=REPORT/'extra_simulations.json'
    result=json.loads(previous.read_text()) if only_extracted and previous.exists() else {}
    if only_extracted:params=[p for p in params if p[1]=='extracted_nominal']
    with ThreadPoolExecutor(max_workers=3) as pool:
        fs={pool.submit(simulate_case,b,n,**p):n for b,n,p in params}
        for f in as_completed(fs):
            name=fs[f]
            try:r=f.result()
            except Exception as e:r=dict(name=name,simulation_error=repr(e))
            result[name]=r
            output('extra_simulations',result)
            print(name,{k:v for k,v in r.items() if k not in ('mos_stress','failure_examples')},flush=True)


def simulations():
    _, base = netlist('mac_tb')
    cases = [('nominal', dict(stress=True)), ('no_nodeset', dict(no_nodeset=True)),
             ('cold_m40', dict(temp=-40)), ('hot_85', dict(temp=85)), ('hot_125', dict(temp=125)),
             ('rail_4_5', dict(rail=4.5)), ('rail_5_5', dict(rail=5.5)), ('rail_2_5', dict(rail=2.5)),
             ('load_1p', dict(cap_ff=1000)), ('load_10p', dict(cap_ff=10000)),
             ('load_10p_slow', dict(cap_ff=10000, hold_ns=1000)), ('load_1meg', dict(resistance=1e6)),
             ('load_50ohm', dict(resistance=50)), ('slow_edge_100ns', dict(edge_ns=100,hold_ns=500)),
             ('zero_plus_0_5', dict(zero_offset=.5)), ('zero_minus_0_5', dict(zero_offset=-.5)),
             ('supply_R_10', dict(supply_resistance=10)), ('supply_R_50', dict(supply_resistance=50))]
    results = {}
    with ThreadPoolExecutor(max_workers=3) as pool:
        jobs = {pool.submit(simulate_case, base, name, **params): name for name, params in cases}
        for future in as_completed(jobs):
            name=jobs[future]
            try:
                r=future.result()
            except Exception as exc:
                r=dict(name=name, simulation_error=repr(exc))
            results[name]=r
            output('simulations', results)
            print(name, {k:v for k,v in r.items() if k not in ('mos_stress','failure_examples')},flush=True)


def integration_tests(startup_only=False):
    _,base=netlist('mac_tb')
    previous=REPORT/'integration.json'
    result=json.loads(previous.read_text()) if startup_only and previous.exists() else {}
    trials=[
        ('or_only_50ohm',dict(extra='Rprobe_or or_out 0 50')),
        ('or_only_10k',dict(extra='Rprobe_or or_out 0 10k')),
        ('startup_zero',dict(states=[(0,0,0,0)],power_ramp_ns=100,hold_ns=2000,no_nodeset=True,stress=True)),
        ('startup_negative',dict(states=[(-1,-1,-1,-1)],power_ramp_ns=100,hold_ns=2000,no_nodeset=True)),
        ('startup_positive',dict(states=[(1,1,1,1)],power_ramp_ns=100,hold_ns=2000,no_nodeset=True)),
    ]
    if startup_only:trials=[(n,p) for n,p in trials if n.startswith('startup')]
    with ThreadPoolExecutor(max_workers=2) as pool:
        fs={pool.submit(simulate_case,base,n,**p):n for n,p in trials}
        for f in as_completed(fs):
            n=fs[f]
            try:r=f.result()
            except Exception as e:r=dict(name=n,simulation_error=repr(e))
            result[n]=r;output('integration',result)
            print(n,{k:v for k,v in r.items() if k not in ('mos_stress','failure_examples')},flush=True)


def dc_current_check():
    base=(WORK/'simulations/supply_branches/tb.spice').read_text()
    snapshot=json.loads((WORK/'simulations/nominal/sampled_states.json').read_text())
    currents=['i(vdd)','i(vss)','i(vmid)']+[f'v.xdut.vprobe_{role}_{rail}#branch'
        for role,rails in [('x_fa',('vdd','vss','vmid')),('x_mul',('vdd','vss')),('x_and',('vdd','vss'))] for rail in rails]
    result={}
    for state in [(0,0,0,0),(0,0,-1,0)]:
        index=snapshot['states'].index(list(state))
        seeds='\n'.join(f'.nodeset {n}={v:.14g}' for n,v in zip(snapshot['vectors'],snapshot['samples'][index]) if n.startswith('v('))
        text=re.sub(r'(?im)^\.nodeset[^\n]*\n','',base)
        for n,v in zip(('X','A','B','CIN'),state):
            text=re.sub(r'(?im)^V'+n+r' .*$',f'V{n} {n.lower()} 0 {v*5}',text)
        text=re.sub(r'(?is)\.control.*?\.endc',lambda _:seeds+'\n.control\nop\nprint '+' '.join(currents)+'\nquit\n.endc',text)
        folder=WORK/'dc'/('_'.join(map(str,state)));folder.mkdir(parents=True,exist_ok=True)
        (folder/'tb.spice').write_text(text)
        p=subprocess.run(['ngspice','-b','tb.spice'],cwd=folder,capture_output=True,text=True,timeout=60)
        log=p.stdout+p.stderr;(folder/'run.log').write_text(log)
        assert p.returncode==0 and not re.search(r'Error:|failed',log,re.I),log[-1000:]
        values={m[1].lower():float(m[2]) for m in re.finditer(r'(?m)^(\S+)\s+=\s+([-+]?\d[\d.eE+-]*)\s*$',log)}
        assert len(values)==len(currents),values
        result[str(state)]=dict(state_trits=state,dc_currents_A=values,power_W=5*(values['i(vss)']-values['i(vdd)']))
    output('dc_currents',result)
    print(json.dumps(result,indent=2),flush=True)


def manifest():
    initial=json.loads((REPORT/'audit.json').read_text())
    assert all(sha(ROOT/p)==h for p,h in initial['files'].items()),'A design file changed during review'
    assert all(sha(PDK/p)==h for p,h in initial['pdk_hashes'].items()),'PDK changed during review'
    files={str(p.relative_to(ROOT)):sha(p) for p in WORK.rglob('*') if p.is_file() and p.suffix in ('.spice','.log','.txt','.json','.extracted')}
    for scope in ('schematic','extracted'):
        for mode in ('all_6480_10f','single_input_648_100f'):
            for p in (ROOT/'simulation/mac'/scope/mode).rglob('data.txt'):
                files[str(p.relative_to(ROOT))]=sha(p)
    output('manifest',dict(design_unchanged=True,pdk_unchanged=True,script_sha256=sha(Path(__file__)),
        source_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
        artifacts=files,scope='Read-only design review; generated diagnostic files under simulation/review_mac; no circuit or PDK modifications.'))


if __name__ == '__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--audit',action='store_true')
    parser.add_argument('--physical',action='store_true')
    parser.add_argument('--simulate',action='store_true')
    parser.add_argument('--extra',action='store_true')
    parser.add_argument('--logic',action='store_true')
    parser.add_argument('--saved-transitions',action='store_true')
    parser.add_argument('--integration',action='store_true')
    parser.add_argument('--dc',action='store_true')
    parser.add_argument('--startup',action='store_true')
    parser.add_argument('--extracted',action='store_true')
    parser.add_argument('--manifest',action='store_true')
    parser.add_argument('--pcell',action='store_true')
    args=parser.parse_args()
    if args.audit:audit()
    if args.physical:physical()
    if args.simulate:simulations()
    if args.extra:extra_simulations()
    if args.logic:verify_logic()
    if args.saved_transitions:recheck_saved_transitions()
    if args.integration:integration_tests()
    if args.dc:dc_current_check()
    if args.startup:integration_tests(startup_only=True)
    if args.extracted:extra_simulations(only_extracted=True)
    if args.manifest:manifest()
    if args.pcell:pcell_audit()
