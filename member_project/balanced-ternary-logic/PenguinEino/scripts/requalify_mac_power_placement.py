"""Requalify a metal-only rail relocation using exact extracted-SPICE equality.

No transient runs are relabeled as new runs. The complete qualified circuit is
unchanged, including anonymous names and MOS junction parameters. Wire RC was
not extracted either before or after the move.
"""
from pathlib import Path
import argparse, copy, hashlib, json, subprocess
import klayout.db as db
import check_mac as logic
import review_mac as review

ROOT = logic.ROOT
BASELINE = '40b9cc7'


def sha_bytes(value):
    return hashlib.sha256(value).hexdigest()


def git_bytes(path):
    return subprocess.check_output(['git', 'show', f'{BASELINE}:{path}'], cwd=ROOT)


def main(backup):
    backup = Path(backup)
    old = json.loads(git_bytes('reports/mac_extracted.json'))
    old_layout = json.loads(git_bytes('reports/mac_layout.json'))
    current = json.loads((ROOT/'reports/mac_layout.json').read_text())
    raw = (ROOT/'mac.extracted').read_bytes()
    assert raw == git_bytes('mac.extracted') == (backup/'mac.extracted').read_bytes()
    assert old['passed'] and old['extracted_sha256'] == sha_bytes(raw)
    assert old == json.loads((backup/'mac_extracted.json').read_text())
    assert current['drawing_lvs_passed'] and current['gds_sha256'] == logic.sha(ROOT/'mac.gds')
    driver = json.loads((ROOT/'reports/mac_driver.json').read_text())
    assert driver['passed'] and driver['source_sha256'] == current['gds_sha256']
    assert current['mask_drc']['categories'] == {'WAR06: Floating SG Detected':14}
    assert current['rules_sha256'] == old_layout['rules_sha256']
    assert current['reference_sha256'] == old['reference_sha256'] == old_layout['reference_sha256']
    assert all(logic.sha(logic.PDK/p) == h for p,h in old['model_sha256'].items())
    assert [r['transitions'] for r in old['cases']] == [81,6480,648]
    assert all(r['passed'] and r['load_fF'] == 10000 for r in old['cases'])
    before = review.layout(backup/'mac.gds', 'mac')
    qualified = review.layout(backup/'qualified_submission.gds', 'mac')
    manifest = json.loads(git_bytes('reports/submission_manifest.json'))
    assert logic.sha(backup/'qualified_submission.gds') == manifest['files']['mac.gds']['sha256']
    assert not review.equal_shapes(before, qualified)
    after = review.layout(ROOT/'mac.gds', 'mac')
    a,at = before; b,bt = after
    assert a.dbu == b.dbu == .001
    instances = lambda c: sorted((i.cell.name,str(i.cell_inst.cplx_trans),str(i.properties())) for i in c.each_inst())
    assert instances(at) == instances(bt), 'Cell placement changed'
    for name in review.CELLS:
        if name != 'mac':
            assert not review.equal_shapes((a,a.cell(name)),(b,b.cell(name))), name
    changed = []
    allowed_region = db.Region(db.Box(0,722300,1800000,1000000))
    layers = {(i.layer,i.datatype) for ly in (a,b) for i in ly.layer_infos()}
    for spec in sorted(layers):
        delta = db.Region(at.begin_shapes_rec(a.layer(*spec))) ^ db.Region(bt.begin_shapes_rec(b.layer(*spec)))
        if delta.is_empty():
            continue
        assert spec in {(13,0),(19,0),(20,0)}, spec
        assert (delta-allowed_region).is_empty(), 'Change outside upper power routing'
        changed.append(list(spec))
    assert changed == [[13,0],[19,0],[20,0]]
    def labels(ly,c):
        return sorted((s.text.string,s.text.x,s.text.y) for s in c.shapes(ly.layer(48,0)).each() if s.is_text())
    expected = sorted((n,x,744300 if n=='VDD' else 804300 if n=='VSS' else y) for n,x,y in labels(a,at))
    assert labels(b,bt) == expected
    cuts = db.Region(bt.begin_shapes_rec(b.layer(19,0)))
    for x,y in [(880,358.2),(830,398.2),(880,744.3),(830,804.3)]:
        area = db.Region(db.Box(round((x-5.7)*1000),round((y-15.7)*1000),round((x+5.7)*1000),round((y+15.7)*1000)))
        assert sum(1 for _ in (cuts & area).each()) == 24, (x,y)
    proof = dict(passed=True,baseline_commit=BASELINE,baseline_report_sha256=sha_bytes(git_bytes('reports/mac_extracted.json')),
        baseline_gds_sha256=old['gds_sha256'],saved_user_gds_sha256=logic.sha(backup/'mac.gds'),
        saved_user_geometry_equals_qualified_submission=True,new_gds_sha256=logic.sha(ROOT/'mac.gds'),
        extracted_spice_byte_identical=True,extracted_sha256=sha_bytes(raw),models_reference_rules_identical=True,
        child_geometry_labels_and_placement_unchanged=True,changed_geometry_layers=changed,
        main_rail_width_um=44,main_spine_width_um=14,main_junction_cuts=24,
        old_rail_centers_um=dict(VDD=900,VSS=960),new_rail_centers_um=dict(VDD=744.3,VSS=804.3),
        rerun='Fresh Drawing DRC, strict LVS, mask DRC and driven-input fixture. No new transient run: exact same extracted SPICE.',
        reused_cases=[dict(transitions=r['transitions'],load_fF=r['load_fF'],passed=r['passed']) for r in old['cases']],
        limitation='No interconnect RC extraction; no timing improvement is claimed.',backup=str(backup))
    report = copy.deepcopy(old)
    report['gds_sha256'] = proof['new_gds_sha256']
    report['power_placement_equivalence'] = proof
    for case in report['cases']:
        case['requalified_by'] = 'reports/mac_improvements/power_placement_equivalence.json'
    for path,value in [(ROOT/'reports/mac_improvements/power_placement_equivalence.json',proof),(ROOT/'reports/mac_extracted.json',report)]:
        path.write_text(json.dumps(value,indent=2)+'\n')
    join = json.loads(git_bytes('reports/mac_improvements/power_join.json'))
    assert join['passed'] and join['gds_sha256'] == old['gds_sha256']
    target = db.Region(db.Box(520000,378200,870000,418200))
    assert (target-db.Region(bt.begin_shapes_rec(b.layer(13,0)))).is_empty()
    join['gds_sha256'] = proof['new_gds_sha256']
    join['requalified_by'] = 'reports/mac_improvements/power_placement_equivalence.json'
    (ROOT/'reports/mac_improvements/power_join.json').write_text(json.dumps(join,indent=2)+'\n')
    print('PASS: power-only relocation, unchanged cells and placements, 24-cut main junctions, byte-identical extracted SPICE.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('backup')
    main(parser.parse_args().backup)
