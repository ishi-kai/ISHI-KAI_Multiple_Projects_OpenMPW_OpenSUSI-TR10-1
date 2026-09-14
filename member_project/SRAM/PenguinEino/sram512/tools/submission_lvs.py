#!/usr/bin/env python3
"""Check the flat export using ordinary Xschem and GUI LVS settings."""
import shutil
import tempfile
from datetime import datetime, timezone
from common import *
from pdk_profiles import prepare_gui, run_drc, locked, tree_digest


def main():
    lock = locked()['profiles']['dev']
    assert tree_digest(PDK) == lock['tree_sha256'], 'Pinned dev PDK was modified.'
    parent = WORK/'submission_lvs'
    parent.mkdir(parents=True, exist_ok=True)
    work = Path(tempfile.mkdtemp(prefix='default_flow_', dir=parent))
    source = ROOT/'submission'
    manifest = json.loads((ROOT/'reviews/submission_manifest.json').read_text())
    for name, info in manifest['files'].items():
        assert sha(source/name) == info['sha256'], name
        shutil.copy2(source/name, work/name)
    standard = next(Path(p) for p in ('/usr/local/share/xschem/xschem_library',
        '/usr/share/xschem/xschem_library') if (Path(p)/'devices/lab_wire.sym').is_file())
    paths = [work, standard, standard/'devices', LIB, LIB/'TR-1umLIB', LIB/'TR-1um_5_stdcell']
    rc = work/'xschemrc'
    rc.write_text('set XSCHEM_LIBRARY_PATH {'+':'.join(map(str, paths))+'}\n'
        +f'set LIB {{{PDK}/libs.tech/spice/models}}\n'
        +'set local_netlist_dir 1\nset lvs_netlist 1\nset top_is_subckt 1\n'
        +'set spiceprefix 1\nset flat_netlist 0\n')
    # These are the values of the standard GUI menu settings. Do not edit
    # the emitted SPICE, override a device format or patch the PDK.
    command = ('set lvs_netlist 1; set top_is_subckt 1; set flat_netlist 0; '
        'xschem set flat_netlist 0; set local_netlist_dir 1; set_netlist_dir 0; '
        'set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result')
    _, log = run(['xschem', '-r', '-x', '--rcfile', rc, '-s', '--command', command,
                   work/'sram512.sch'], work, 'netlist.log')
    assert not re.search(r'(?im)error:|warning:|symbol not found|SKIPPING', log), log
    reference = work/'simulation/sram512.spice'
    deck = reference.read_text()
    assert re.search(r'(?im)^\.subckt sram512 CLK RESET SDI WE SDO VDD VSS$', deck)
    assert re.search(r'(?im)^M\S+ .*\bNMOS\b', deck)
    config = prepare_gui('dev')
    env = dict(ENV, QT_QPA_PLATFORM='offscreen', SRAM_SUBMISSION_CHECK_DIR=str(work))
    with (work/'gui_lvs.log').open('w') as output:
        process = subprocess.run([klayout_binary(), '-c', str(config), '-n', 'TR-1um',
            '-r', str(TOOLS/'submission_gui_lvs.py')], cwd=work, env=env,
            stdout=output, stderr=subprocess.STDOUT)
    assert process.returncode == 0, f'GUI LVS failed: {work}/gui_lvs.log'
    lvs = json.loads((work/'gui_lvs.json').read_text())
    assert lvs['passed'], lvs
    drc = run_drc(work/'sram512.gds', 'sram512', 'dev', work/'drc')
    assert drc['passed'], drc
    result = dict(passed=True, checked_utc=datetime.now(timezone.utc).isoformat(),
        scope='Isolated flat export; standard Xschem LVS settings and unmodified current-view GUI LVS macro with default reference lookup.',
        work=str(work.relative_to(ROOT)), gds_sha256=sha(source/'sram512.gds'),
        schematic_sha256=sha(source/'sram512.sch'), reference_sha256=sha(reference),
        pdk_revision=lock['revision'], erc=True, lvs=lvs,
        drc=dict(passed=drc['passed'], items=drc['items']),
        files={name:info['sha256'] for name,info in manifest['files'].items()
               if Path(name).suffix in ('.sch', '.sym', '.gds')})
    write_json(ROOT/'reviews/submission_lvs.json', result)
    print('PASS: default GUI LVS,', len(lvs['circuit_pairs']), 'matching circuits; DRC 0', flush=True)
    print('Logs:', work, flush=True)
    return result


if __name__ == '__main__':
    main()
