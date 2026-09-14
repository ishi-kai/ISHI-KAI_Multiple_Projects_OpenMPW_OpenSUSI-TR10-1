#!/usr/bin/env python3
"""Collect the actual core, editable schematics and verification evidence.

No simulation or physical check is replaced by packaging. A review archive
can be made explicitly with --draft; a release archive requires all current
mandatory reports and their source hashes to match.
"""
import argparse
import ast
from datetime import datetime, timezone
from importlib.metadata import version
import zipfile
from common import *
from validation_summary import main as summarize, source_files
from evidence import design_inputs
from submission_figures import source_files as figure_sources
from pdk_profiles import locked, tree_digest


ENTRY_POINTS = ('open', 'verify_saved_layout', 'verify_digital', 'analog',
    'postlayout', 'operational_tests', 'startup_tests', 'startup_summary',
    'pcell_preservation', 'validation_summary', 'compare_timesteps',
    'verification_jobs', 'signal_resolution', 'route_waveforms', 'power_wire_audit',
    'save_candidate', 'strengthen_signal_routes', 'reinforce_decoder_routes',
    'widen_decoder_poly', 'live_probe', 'decoder_route_waveforms', 'reset_address_test',
    'operation_waveforms',
    'review_recheck', 'test_verification',
    'export_schematics', 'package', 'build_submission', 'submission_runner',
    'submission_lvs', 'submission_gui_lvs')


def python_dependencies(initial):
    """Include local Python imports, including imports inside functions."""
    pending = list(initial)
    seen = set()
    while pending:
        path = pending.pop().resolve()
        if path in seen:
            continue
        assert path.is_relative_to(ROOT) and path.is_file(), path
        seen.add(path)
        for node in ast.walk(ast.parse(path.read_text(), filename=str(path))):
            names = ([node.module] if isinstance(node, ast.ImportFrom) and node.module
                     else [x.name for x in node.names] if isinstance(node, ast.Import) else [])
            for name in names:
                if '.' in name:
                    continue  # external packages; no dotted local imports are used
                for base in (path.parent, TOOLS, ROOT / 'scripts'):
                    target = base / (name + '.py')
                    if target.is_file():
                        pending.append(target)
                        break
    return seen


def selected_files(summary):
    files = {ROOT / n for n in source_files()}
    files.update(design_inputs())
    files.update(figure_sources())
    # PCell code loads the dense drawing helper dynamically, not with import.
    python = [TOOLS / (n + '.py') for n in ENTRY_POINTS]
    python += [ROOT / 'klayout/sram_pcell/build.py', ROOT / 'klayout/dense_sram/build.py']
    files |= python_dependencies(python)
    files.update(HERE / n for n in ('README.md', 'SPEC.md', 'SUBMISSION.md', 'EXPERIMENTS.md',
        'APPEAL.md', 'VERIFICATION.md', 'SUBMISSION_README.md',
        'run.py', 'design.json', 'analog_scenario.json'))
    files.add(ROOT/'reviews/repository_organization.json')
    files.add(ROOT/'reviews/sram512_review_2026-09-13_results.json')
    files.add(ROOT/'reviews/sram512_review_response_2026-09-13.md')
    files.update((HERE/'diagrams').glob('*.svg'))
    files.update(p for p in (HERE / 'layout').iterdir() if p.is_file())
    files.update(REPORTS.glob('*.json'))
    files.update((REPORTS/'evidence').glob('*.json'))
    files.update((REPORTS/'rechecks').glob('*.json'))
    files.update(REPORTS.glob('*.png'))
    # Router source files are only needed if an included exploratory layout
    # helper is used; no router is used by saved-GDS DRC/LVS verification.
    files.update(TOOLS.glob('*.cpp'))
    return sorted(files)


def readme(draft, digest):
    state = '検証途中のレビュー用。製造リリースではありません。' if draft else (
        '同梱の必須コア検証は全件合格しています。共通フレームへ統合後のチップ全体の検証は統合側で行ってください。')
    return f'''# 16行 × 32列・512 bit SRAM

{state}

提出対象は `sram512/layout/sram512.gds`、最上位セルは `sram512_macro`。
横1776.7 × 縦600.0 µm、外部7端子。GDS SHA-256: `{digest}`。

- 接続指示と操作手順：`sram512/SUBMISSION.md`、`sram512/SPEC.md`
- 編集可能な回路図：`sram512/schematics/sram512_macro.sch` → `sram512.sch`
- MOSシミュレーション用回路図：`sram512/schematics/sram512_tb.sch`
- 検証の一覧：`sram512/reports/validation_summary.json`
- レイアウト図：`sram512/layout/overview.png`
- 全同梱ファイルのSHA-256：`MANIFEST.json`

`sram512_mask.gds` は公式MDPによる変換結果です。Drawing用GDSとの区別を保ち、
変換済みのマスクGDSへMDPを再適用しないでください。
履歴の不合格レポートも比較根拠として残しています。現提出候補の判定は
`validation_summary.json` が列挙するレポートで確認してください。

## 別の環境で再検証する場合

Xschem、ngspice、KLayout、Icarus Verilog、およびPythonの
numpy、scipy、matplotlib、networkx、shapely、scikit-image、klayoutが必要です。
使用バージョンとPDKは `MANIFEST.json` と各検証結果に記録しています。
PDK自体は同梱せず、無改変のTR-1um devを次の位置に用意します。

```sh
git clone https://github.com/OpenSUSI/TR-1um.git .pdk/dev/TR-1um
git -C .pdk/dev/TR-1um checkout --detach 6afbd918951f2ea0dcd11c5a46986b4c20f9e6f9
# SRAM_KLAYOUT_BINを、その環境のklayout実行ファイルの絶対パスへ設定する
python3 sram512/run.py layout-check
python3 sram512/tools/evidence.py --report pcell_preservation -- python3 sram512/tools/pcell_preservation.py
python3 sram512/run.py digital
python3 sram512/tools/evidence.py --report analog_pd102_nominal -- python3 sram512/tools/analog.py --name-prefix pd102
```

回路図を開く場合は `python3 sram512/tools/open.py`。
保存GDSの再検証後、抽出回路は `build/sram512/layout/rechecked16x32` にあります。
抽出後の試験を再実行するときは `sram512/README.md` のコマンドのレイアウト引数を
このパスに置き換えてください。波形データは再生成するため同梱していません。

寄生RCの係数と全体Vthシフトは、明示した仮定に基づく感度試験です。
校正済みのファウンドリPEXや統計的な歩留まり認定ではありません。
パッド配線とパッドESDは共通フレーム側を利用します。
'''


def build(draft=False):
    summary = summarize()
    if not draft and not summary['all_required_reports_pass']:
        missing = [r['test'] for r in summary['tests'] if r['state'] != 'PASS']
        raise RuntimeError('Required checks are incomplete: ' + ', '.join(missing))
    layout_report = json.loads((REPORTS / 'saved_layout_recheck.json').read_text())
    assert layout_report['saved_mask_comparison']['passed']
    assert layout_report['saved_mask_comparison']['saved_mask_sha256'] == summary['source_mask_sha256']
    lock = locked()['profiles']['dev']
    actual_revision = subprocess.check_output(['git', '-C', str(PDK), 'rev-parse', 'HEAD'], text=True).strip()
    assert actual_revision == lock['revision'], 'PDK revision changed'
    assert tree_digest(PDK) == lock['tree_sha256'], 'PDK tree changed'
    files = selected_files(summary)
    payload = {p.relative_to(ROOT).as_posix():p.read_bytes() for p in files}
    for name, digest in summary['source_snapshot'].items():
        assert hashlib.sha256(payload[name]).hexdigest() == digest, name
    for r in summary['tests']:
        if 'report_sha256' in r:
            assert hashlib.sha256(payload[r['report']]).hexdigest() == r['report_sha256'], r['test']
    digest = summary['source_gds_sha256']
    assert hashlib.sha256(payload['sram512/layout/sram512.gds']).hexdigest() == digest
    assert hashlib.sha256(payload['sram512/layout/sram512_mask.gds']).hexdigest() == summary['source_mask_sha256']
    payload['README.md'] = readme(draft, digest).encode()
    manifest = dict(format_version=1, created_utc=datetime.now(timezone.utc).isoformat(),
        status='DRAFT' if draft else 'CORE_VERIFIED',
        git_head=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
        source_gds_sha256=digest, pdk_revision=actual_revision, pdk_tree_sha256=lock['tree_sha256'],
        python_packages={name:version(name) for name in
            ('numpy','scipy','matplotlib','networkx','shapely','scikit-image','klayout')},
        tools={n:subprocess.check_output(command, text=True, stderr=subprocess.STDOUT).splitlines()[:8]
            for n,command in [('python',[sys.executable,'--version']),
                              ('ngspice',['ngspice','--version']),
                              ('klayout',[klayout_binary(),'-v'])]},
        files={name:dict(bytes=len(data), sha256=hashlib.sha256(data).hexdigest())
               for name,data in sorted(payload.items())})
    payload['MANIFEST.json'] = (json.dumps(manifest,indent=2,ensure_ascii=False)+'\n').encode()
    work = WORK / 'submission'
    work.mkdir(parents=True, exist_ok=True)
    revision = manifest['git_head'][:7]
    path = work / f'sram512_{"review" if draft else "core"}_{digest[:12]}_{revision}.zip'
    temp = path.with_suffix('.tmp')
    with zipfile.ZipFile(temp, 'w', compression=zipfile.ZIP_DEFLATED) as archive:
        for name,data in sorted(payload.items()):
            archive.writestr(name,data)
    # Verify the actual archive bytes, not just the source directory listing.
    with zipfile.ZipFile(temp) as archive:
        assert archive.testzip() is None
        assert set(archive.namelist()) == set(payload)
        for name,info in manifest['files'].items():
            assert hashlib.sha256(archive.read(name)).hexdigest() == info['sha256'], name
    temp.replace(path)
    print(manifest['status'], len(payload), 'files:', path, flush=True)
    return path


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--draft', action='store_true')
    args = parser.parse_args()
    build(args.draft)
