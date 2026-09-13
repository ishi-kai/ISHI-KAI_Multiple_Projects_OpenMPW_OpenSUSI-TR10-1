"""Reproducible tools for the 512-bit design; never patch a PDK deck."""
from pathlib import Path
import hashlib, json, os, re, subprocess, sys
import klayout.db as db
import klayout.rdb as rdb

TOOLS = Path(__file__).resolve().parent
HERE = TOOLS.parent
ROOT = HERE.parent
SCHEMATICS = HERE / 'schematics'
WORK = ROOT / 'build/sram512'
REPORTS = HERE / 'reports'
sys.path.insert(0, str(ROOT / 'scripts'))
from pdk_profiles import pdk_path, environment, provenance, klayout_binary
PDK = pdk_path('dev')
ENV = environment('dev')
LIB = PDK / 'libs.tech/xschem'

def write_json(path, data):
    path = Path(path); path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + '\n')

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def extracted_layer_index(extraction,layout,core,spec):
    """Identify a raw extracted layer after an ordinary top-wrapper shift.

    layer_by_index uses the submitted top's coordinates; polygons_of_net
    uses its circuit's local coordinates. Match full physical geometry in
    the first frame without translating circuit-local RC geometry twice.
    """
    actual=db.Region(core.begin_shapes_rec(layout.layer(*spec)))
    wrapper=layout.cell('sram512_macro')
    if wrapper is not None and wrapper.cell_index()!=core.cell_index():
        instances=[i for i in wrapper.each_inst() if i.cell_index==core.cell_index()]
        assert len(instances)==1
        actual=actual.transformed(instances[0].trans)
    matches=[i for i in extraction.layer_indexes()
             if (extraction.layer_by_index(i)^actual).is_empty()]
    assert len(matches)==1,(spec,matches,'Extracted layer differs from submitted geometry')
    return matches[0]

def run(cmd, work, log, check=True):
    work = Path(work); work.mkdir(parents=True, exist_ok=True)
    with (work / log).open('w') as f:
        p = subprocess.run(list(map(str, cmd)), cwd=work, env=ENV, stdout=f, stderr=subprocess.STDOUT)
    text = (work / log).read_text()
    if check and p.returncode:
        raise RuntimeError(f'{work/log}: exit {p.returncode}\n{text[-2000:]}')
    return p.returncode, text

def simulation_diagnostics(log):
    """Keep dev diode model diagnostics visible; reject all other warnings.

    ngspice does not implement the published diode IMAX/IMELT limit fields.
    The original model file is still included verbatim. Normal I/V and C/V
    are simulated; damage limits and ESD qualification are not simulated.
    """
    notices=[]
    def diode_notice(match):
        block=match[0]
        model=re.search(r'(?i)\.model (dn|dp) d ',block)
        params=re.findall(r'unrecognized parameter \((\w+)\) - ignored',block)
        if model and params==['imax','imelt']:
            notices.append(dict(model=model[1].upper(),unsupported_parameters=params,
                                consequence='Diode current/melting limit flags are not implemented by ngspice.'))
            return ''
        return block
    remaining=re.sub(r'(?m)^Warning: Model issue on line \d+ :\n  \.model [^\n]+\n(?:unrecognized parameter \([^\n]+\) - ignored\n)+',diode_notice,log)
    # A preflight RAM estimate is not an electrical diagnostic. Preserve it
    # in the report; callers still require a successful process exit and a
    # complete, finite binary waveform before any circuit check can pass.
    def memory_notice(match):
        notices.append(dict(kind='simulation_memory_estimate',message=match[0].strip(),
                            consequence='Estimated waveform storage exceeds currently free RAM; runtime may increase.'))
        return ''
    remaining=re.sub(r'(?m)^Warning: memory required \([^\n]+\), made of\n'
                     r' +[^\n]+nodes and approximately [^\n]+time steps,\n'
                     r' +is more than the DRAM memory available \([^\n]+\)!\n'
                     r' +Swapping data to SSD may slow down the simulation\.\n',memory_notice,remaining)
    if re.search(r'(?im)^error|^warning|timestep too small|doanalyses:|not enough memory|unrecognized parameter|too many args',remaining):
        lines=[line for line in remaining.splitlines() if re.search(r'error|warning|ignored|timestep too small|doanalyses:|too many args',line,re.I)]
        raise RuntimeError('Unexpected ngspice diagnostic:\n'+'\n'.join(lines)[:3000])
    return notices

def netlist(schematic, work, subckt=True, erc=True, lvs=False):
    schematic = Path(schematic).resolve(); work = Path(work).resolve()
    work.mkdir(parents=True, exist_ok=True)
    paths = [schematic.parent, SCHEMATICS, ROOT/'learning/schematics', Path('/usr/local/share/xschem/xschem_library'),
             Path('/usr/local/share/xschem/xschem_library/devices'), LIB,
             LIB/'TR-1umLIB', LIB/'TR-1um_5_stdcell']
    rc = work/'xschemrc'
    rc.write_text('set XSCHEM_LIBRARY_PATH {'+':'.join(map(str, paths))+'}\n'
        +f'set LIB {{{PDK}/libs.tech/spice/models}}\nset lvs_netlist {int(lvs)}\n'
        +f'set top_is_subckt {int(subckt)}\nset spiceprefix 1\n')
    command='set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result'
    _, log = run(['xschem','-r','-x','--rcfile',rc,'-s','--command',command,
                  '-o',work,schematic],work,'netlist.log')
    if erc and re.search(r'(?im)error:|warning:|symbol not found|SKIPPING', log):
        raise RuntimeError(f'ERC failed: {work}/netlist.log\n{log[-2000:]}')
    result=work/(schematic.stem+'.spice')
    if 'IS MISSING' in result.read_text():
        raise RuntimeError(f'Unresolved symbol in {result}')
    return result

def verify_layout(gds, top, ref, work):
    """Run original dev entry points, including the default strict port mode."""
    work=Path(work).resolve(); work.mkdir(parents=True, exist_ok=True)
    gds=Path(gds).resolve(); ref=Path(ref).resolve()
    result={'top':top,'gds_sha256':sha(gds),'reference_sha256':sha(ref),
            'pdk':provenance('dev')}
    for kind in ('drc','lvs'):
        report=work/(top+'.'+kind+'db'); report.unlink(missing_ok=True)
        cmd=[klayout_binary(),'-b','-r',PDK/f'libs.tech/klayout/tech/{kind}/run.{kind}',
             '-rd',f'input={gds}','-rd',f'top_cell={top}','-rd',f'report={report}']
        if kind=='lvs':
            cmd+=['-rd',f'circuit={ref}','-rd',f'extracted={work}/{top}.extracted']
        code, log=run(cmd,work,kind+'.log',check=False)
        if code or not report.exists():
            result[kind]={'passed':False,'exit_code':code,'error':log[-1500:]};continue
        if kind=='drc':
            r=rdb.ReportDatabase();r.load(str(report))
            result[kind]={'passed':r.num_items()==0,'items':r.num_items(),
                'categories':{c.name():c.num_items() for c in r.each_category() if c.num_items()}}
        else:
            r=db.LayoutVsSchematic();r.read(str(report))
            pairs=list(r.xref().each_circuit_pair());errors=[e.message for e in r.each_error()]
            result[kind]={'passed':bool(pairs) and all(p.status()==db.NetlistCrossReference.Match for p in pairs)
                and not errors and 'Congratulations! Netlists match.' in log,
                'circuit_pairs':[str(p.status()) for p in pairs],'errors':errors}
    write_json(work/'result.json',result)
    return result
