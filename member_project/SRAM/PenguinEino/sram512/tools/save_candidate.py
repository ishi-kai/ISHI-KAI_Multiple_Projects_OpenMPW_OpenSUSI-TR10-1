#!/usr/bin/env python3
"""Save a physically checked candidate; full electrical release remains separate."""
import argparse
import shutil
from common import *
from verify_saved_layout import main as recheck_saved
from pcell_preservation import verify as verify_pcell
from render_layout import render


def save(folder, diagnostic):
    folder = Path(folder).resolve()
    digest = sha(folder/'sram512.gds')
    checks = json.loads((folder/'checks/result.json').read_text())
    assert checks['gds_sha256']==digest and all(checks[k]['passed'] for k in ('drc','lvs'))
    test = json.loads(Path(diagnostic).read_text())
    assert test['passed'] and test['physical_extraction']['gds_sha256']==digest
    assert test['signal_mesh'] and test['voltage_limits']['passed'] and test['signal_mesh_checks']['passed']
    manufacturing = WORK/'extracted_sources'/digest/'manufacturing'
    masks = json.loads((manufacturing/'result.json').read_text())
    assert masks['passed'] and masks['drawing_sha256']==digest
    assert sha(manufacturing/'sram512_mask.gds')==masks['mask_sha256']
    target = HERE/'layout'
    for name in ('sram512.gds','reference.spice','placement.json','ports.json',
                 'array_geometry.json','coordinate_frames.json'):
        shutil.copy2(folder/name,target/name)
    shutil.copy2(folder/'checks/result.json',target/'drawing_lvs.json')
    shutil.copy2(manufacturing/'sram512_mask.gds',target/'sram512_mask.gds')
    shutil.copy2(manufacturing/'result.json',target/'manufacturing.json')
    result = recheck_saved()
    assert result['passed']
    write_json(target/'geometry_audit.json',result['geometry'])
    assert verify_pcell(target/'sram512.gds')['passed']
    render(target,target/'overview.png')
    record = dict(source_gds_sha256=digest,diagnostic_report_sha256=sha(diagnostic),
        saved_layout_recheck_sha256=sha(REPORTS/'saved_layout_recheck.json'),
        release_status='Candidate only: full electrical verification is evaluated separately by validation_summary.py.')
    write_json(REPORTS/'candidate_snapshot.json',record)
    return record


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('folder',type=Path)
    parser.add_argument('diagnostic',type=Path);args=parser.parse_args()
    print(save(args.folder,args.diagnostic))
