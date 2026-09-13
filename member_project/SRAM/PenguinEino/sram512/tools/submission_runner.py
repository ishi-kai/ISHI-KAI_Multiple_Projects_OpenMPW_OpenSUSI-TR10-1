#!/usr/bin/env python3
"""Open/netlist/simulate the flat submission with an installed TR-1um dev PDK."""
import argparse
import os
from pathlib import Path
import re
import subprocess
import sys

PROJECT = Path(__file__).resolve().parents[2]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=('circuit', 'tb', 'erc', 'simulate'))
    parser.add_argument('--directory', type=Path, default=PROJECT/'submission')
    parser.add_argument('--pdk', type=Path, default=PROJECT/'.pdk/dev/TR-1um')
    parser.add_argument('--output', type=Path, default=PROJECT/'build/sram512/submission_check')
    args = parser.parse_args()
    root=args.directory.resolve()
    pdk=args.pdk.resolve()
    if not (pdk/'libs.tech/spice/models/ip62_models').is_file():
        parser.error('TR-1um PDK not found; specify its installation with --pdk.')
    work = args.output.resolve()
    work.mkdir(parents=True, exist_ok=True)
    # User-wide customizations must not select a different PDK or flatten this circuit.
    candidates = [Path(p) for p in os.environ.get('XSCHEM_LIBRARY_PATH', '').split(':') if p]
    candidates += [Path('/usr/local/share/xschem/xschem_library'), Path('/usr/share/xschem/xschem_library')]
    standard = next((p for p in candidates if (p/'devices/lab_wire.sym').is_file()), None)
    if standard is None:
        parser.error('Xschem standard library not found; set XSCHEM_LIBRARY_PATH to its xschem_library directory.')
    paths = [root, pdk/'libs.tech/xschem',
             pdk/'libs.tech/xschem/TR-1umLIB', pdk/'libs.tech/xschem/TR-1um_5_stdcell',
             standard, standard/'devices']
    rc = work/'xschemrc'
    rc.write_text('set XSCHEM_LIBRARY_PATH {'+':'.join(map(str, paths))+'}\n'
                  +f'set LIB {{{pdk}/libs.tech/spice/models}}\nset netlist_dir {{{work}}}\n'
                  +'set lvs_netlist 0\nset spiceprefix 1\nset top_is_subckt 0\n')
    circuit = root/'sram512.sch'
    tb = root/'sram512_tb.sch'
    if args.command in ('circuit', 'tb'):
        source = circuit if args.command == 'circuit' else tb
        os.chdir(work)
        os.execvp('xschem', ['xschem', '--rcfile', str(rc), str(source)])
    sources = [circuit, tb] if args.command == 'erc' else [tb]
    for source in sources:
        command = 'set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result'
        with (work/(source.stem+'_netlist.log')).open('w') as log:
            p = subprocess.run(['xschem', '-r', '-x', '--rcfile', str(rc), '-s', '--command', command,
                                '-o', str(work), str(source)], cwd=work, stdout=log, stderr=subprocess.STDOUT)
        output = (work/(source.stem+'_netlist.log')).read_text()
        if p.returncode or re.search(r'(?im)error:|warning:|symbol not found|SKIPPING', output):
            raise RuntimeError(output)
        print('ERC PASS:', source.name, flush=True)
    if args.command == 'erc':
        return
    # Only interactive plot commands are removed. Devices, stimuli and measurements remain intact.
    deck = (work/'sram512_tb.spice').read_text()
    deck = '\n'.join(line for line in deck.splitlines() if not line.startswith('plot '))+'\n'
    deck = deck.replace('.endc', 'quit\n.endc')
    (work/'test.spice').write_text(deck)
    with (work/'simulation.log').open('w') as log:
        p = subprocess.run(['ngspice', '-b', 'test.spice'], cwd=work, stdout=log, stderr=subprocess.STDOUT)
    output = (work/'simulation.log').read_text()
    unexpected = re.sub(r'(?m)^Warning: Model issue on line \d+ :\n  \.model (?:dn|dp) d [^\n]+\n'
                        r'unrecognized parameter \(imax\) - ignored\n'
                        r'unrecognized parameter \(imelt\) - ignored\n', '', output, flags=re.I)
    if p.returncode or 'PASS: 16 accesses; stored cell and SDO checks' not in output or re.search(
            r'(?im)^error|^warning|FAIL:|timestep too small|doanalyses:', unexpected):
        raise RuntimeError(f'Simulation failed; inspect {work}/simulation.log\n{output[-3000:]}')
    print('PASS: 16 accesses; stored cell and SDO checks', flush=True)
    print('Log and waveform:', work, flush=True)
    print('Original PDK diode IMAX/IMELT fields are unsupported by ngspice.', flush=True)


if __name__ == '__main__':
    main()
