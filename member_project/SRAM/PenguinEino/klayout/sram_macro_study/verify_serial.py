#!/usr/bin/env python3
"""Netlist current serial schematic and substitute the LVS-verified GDS array.

Waveforms are regenerable and kept under build/. No schematic is regenerated.
This is the real 2x2 serial controller test, not a full-size macro simulation.
"""
from pathlib import Path
import hashlib, json, re, sys
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path[:0] = [str(ROOT/'scripts'), str(HERE.parent/'sram_research')]
import verify_serial_spice as serial
from compare_spice import probe_tb
WORK = ROOT/'build/sram_macro_study/serial'
PDK = Path('/home/ishi-kai/pdk/TR-1um')


def fresh_netlist():
    WORK.mkdir(parents=True, exist_ok=True)
    paths=[ROOT/'learning/schematics', ROOT/'sram512/schematics', Path('/usr/local/share/xschem/xschem_library'),
             Path('/usr/local/share/xschem/xschem_library/devices'),
             PDK/'libs.tech/xschem', PDK/'libs.tech/xschem/TR-1umLIB',
             PDK/'libs.tech/xschem/TR-1um_5_stdcell']
    rc = WORK/'xschemrc'
    rc.write_text('set XSCHEM_LIBRARY_PATH {'+':'.join(map(str, paths))+'}\n'
                  +f'set LIB {{{PDK}/libs.tech/spice/models}}\n'
                  +'set lvs_netlist 0\nset top_is_subckt 0\nset spiceprefix 1\n')
    command = 'set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result'
    serial.run(['xschem','-r','-x','--rcfile',rc,'-s','--command',command,
                '-o',WORK,ROOT/'learning/schematics/sram_tb_serial.sch'], WORK, 'netlist.log')
    net = (WORK/'sram_tb_serial.spice').read_text()
    flat = re.sub(r'\n\+\s*', ' ', net)
    case = serial.scenario()
    for name in ['CLK', 'RESET', 'SDI', 'WE']:
        m = re.search(r'^V'+name+r' \S+ \S+ (PWL\([^\n]+\))',flat,re.M)
        assert m and m[1].split() == serial.pwl(name,case['timeline']).split(), name
    return '\n'.join(l for l in net.splitlines() if not l.startswith(('plot ', 'write ')))+'\n'


def main():
    net = fresh_netlist()
    results = []
    # Added load is a sensitivity case, not an assertion of extracted wire C.
    cases = [('baseline',27,'10f','100f'), ('euler_shared',27,'10f','100f'),
             ('euler_shared',85,'10f','100f'), ('euler_shared',27,'1p','1p')]
    for variant,temp,cbl,cy in cases:
        work = WORK/f'{variant}_{temp}_{cbl}_{cy}';work.mkdir(exist_ok=True)
        deck = probe_tb(net, variant)
        deck = deck.replace('.param CBL=10f CY=100f',f'.param CBL={cbl} CY={cy}\n.temp {temp}')
        assert f'CBL={cbl} CY={cy}' in deck
        # A content key includes all model dependencies and verifier/stimulus code.
        source = deck.encode()+Path(__file__).read_bytes()
        for p in sorted((PDK/'libs.tech/spice/models').rglob('*')):
            if p.is_file(): source += p.read_bytes()
        for p in ['verify_serial_spice.py','serial_spice_stimulus.py']:
            source += (ROOT/'scripts'/p).read_bytes()
        source += (ROOT/'sram512/rtl/sram_serial_controller.v').read_bytes()
        key = hashlib.sha256(source).hexdigest()
        cache = work/'result.json'
        if cache.exists() and json.loads(cache.read_text()).get('input_sha256') == key:
            result = json.loads(cache.read_text())
        else:
            (work/'batch.spice').write_text(deck)
            (work/'serial_spice_waveforms.txt').unlink(missing_ok=True)
            print(f'Running {variant}, {temp} C, BL={cbl}, Y={cy}',flush=True)
            serial.run(['ngspice','-b','batch.spice'],work,'simulation.log')
            case = serial.scenario();serial.rtl_reference(work,case)
            try:
                checks = serial.verify(work,case);passed = True;failure = None
            except RuntimeError as error:
                checks = {};passed = False;failure = str(error)
            result = dict(variant=variant,temperature_c=temp,vdd_v=5,clock_ns=100,
                          cbl=cbl,cy=cy,passed=passed,checks=checks,failure=failure,
                          input_sha256=key,log=str((work/'simulation.log').relative_to(ROOT)))
            cache.write_text(json.dumps(result,indent=2)+'\n')
        results.append(result)
        (HERE/'serial_results.json').write_text(json.dumps(results,indent=2)+'\n')
        print(f'{variant} {temp} C BL={cbl} Y={cy}: {"PASS" if result["passed"] else "FAIL"}',flush=True)
    assert all(r['passed'] for r in results[:2]), 'Nominal extracted serial regression'


if __name__ == '__main__': main()
