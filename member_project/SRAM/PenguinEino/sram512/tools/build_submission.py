#!/usr/bin/env python3
"""Build a flat submission with SCH, SYM, GDS, Markdown and full previews."""
from datetime import datetime, timezone
import zipfile
from common import *
from validation_summary import main as summarize
from pdk_profiles import locked, tree_digest
from submission_layout import export_layout
from submission_previews import export_previews
from submission_figures import export_figures


def dependencies():
    pending = [SCHEMATICS/'sram512.sch', SCHEMATICS/'sram512_tb.sch']
    files = {SCHEMATICS/'sram512.sym'}
    while pending:
        p = pending.pop()
        if p in files:
            continue
        files.add(p)
        for symbol in re.findall(r'^C \{([^}]+)\}', p.read_text(), re.M):
            if symbol.startswith('devices/'):
                continue
            candidates=[p.parent/symbol, SCHEMATICS/symbol, LIB/symbol,
                        LIB/'TR-1umLIB'/symbol, LIB/'TR-1um_5_stdcell'/symbol]
            q=next((q for q in candidates if q.is_file()),None)
            if q is None and any((Path(base)/'devices'/symbol).is_file() for base in
                    ('/usr/local/share/xschem/xschem_library','/usr/share/xschem/xschem_library')):
                continue
            assert q is not None, (p, symbol)
            pending.append(q)
            child = q.with_suffix('.sch')
            if child.is_file():
                pending.append(child)
    return files


def build():
    summary = summarize()
    assert summary['all_required_reports_pass'], 'Current required checks must all pass.'
    preservation=json.loads((ROOT/'reviews/repository_organization.json').read_text())
    assert preservation['passed'] and preservation['source_gds_sha256']==summary['source_gds_sha256']
    for entry in preservation['source_files']:
        assert sha(ROOT/entry['current'])==entry['sha256'], (
            'Verified electrical sources changed; fresh verification evidence is required.',entry['current'])
    lock=locked()['profiles']['dev']
    assert subprocess.check_output(['git','-C',PDK,'rev-parse','HEAD'],text=True).strip()==lock['revision']
    assert tree_digest(PDK)==lock['tree_sha256'], 'PDK files changed.'
    output = ROOT/'submission'
    output.mkdir(exist_ok=True)
    payload = {}
    origins = {}
    def add(name, path):
        payload[name] = path.read_bytes()
        origins[name] = str(path.relative_to(ROOT))
    for path in sorted(dependencies()):
        if path.is_relative_to(SCHEMATICS):
            add(path.name, path)
    drawing = WORK/'submission/sram512.gds'
    layout_export = export_layout(HERE/'layout/sram512.gds', drawing)
    add('sram512.gds', drawing)
    previews = export_previews(drawing, drawing.parent)
    for kind in ('layout', 'schematic'):
        name = previews[kind]['image']
        add(name, drawing.parent/name)
    figures = export_figures(drawing, drawing.parent)
    for figure in [figures['pins'],*figures['layout_trials']]:
        add(figure['image'],drawing.parent/figure['image'])
    add('SPEC.md', HERE/'SPEC.md')
    add('README.md', HERE/'SUBMISSION_README.md')
    assert {name for name in payload if name.endswith('.md')} == {'README.md', 'SPEC.md'}
    assert all(Path(name).name==name and Path(name).suffix in ('.sch','.sym','.gds','.md','.png','.svg') for name in payload)
    manifest = dict(format_version=3, created_utc=datetime.now(timezone.utc).isoformat(),
                    source_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
                    status='CORE_VERIFIED_WITH_DOCUMENTED_MODEL_LIMITS',
                    pdk_revision=subprocess.check_output(['git','-C',PDK,'rev-parse','HEAD'],text=True).strip(),
                    source_gds_sha256=summary['source_gds_sha256'],
                    source_mask_sha256=summary['source_mask_sha256'],
                    layout_export=layout_export,
                    previews=previews,
                    figures=figures,
                    evidence_index='sram512/reports/validation_summary.json',
                    external_dependency='Unmodified TR-1um dev PDK: Xschem symbols, standard-cell schematics and SPICE models.',
                    sources=origins,
                    files={name:dict(bytes=len(data),sha256=hashlib.sha256(data).hexdigest())
                           for name,data in sorted(payload.items())})
    # Keep packaging metadata outside the requested flat submission.
    manifest_path=ROOT/'reviews/submission_manifest.json'
    legacy_manifest=output/'MANIFEST.json'
    old_manifest=legacy_manifest if legacy_manifest.exists() else manifest_path
    if old_manifest.exists():
        old=json.loads(old_manifest.read_text())
        for name,info in old['files'].items():
            path=output/name
            if path.exists() and sha(path)!=info['sha256']:
                raise RuntimeError(f'Export edited outside source: {path}; preserve/merge that edit before rebuilding.')
        actual={p.relative_to(output).as_posix() for p in output.rglob('*') if p.is_file()}
        # Ordinary Xschem/KLayout use creates these beside the submitted
        # files. Preserve the user's working outputs; never put them in ZIP.
        runtime={name for name in actual if name.startswith('simulation/')
                 or Path(name).suffix in ('.extracted', '.lvsdb', '.lyrdb')}
        unknown=actual-set(old['files'])-runtime-({'MANIFEST.json'} if legacy_manifest.exists() else set())
        if unknown:
            raise RuntimeError('Preserve unexpected export files before rebuilding: '+', '.join(sorted(unknown)))
        # The user requested removal of the previous nested export and auxiliary files.
        for name in set(old['files'])-set(payload):
            (output/name).unlink(missing_ok=True)
        legacy_manifest.unlink(missing_ok=True)
        for directory in sorted((p for p in output.rglob('*') if p.is_dir()),key=lambda p:len(p.parts),reverse=True):
            if not any(directory.iterdir()):
                directory.rmdir()
    for name,data in payload.items():
        path=output/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(data)
    folder=WORK/'submission';folder.mkdir(parents=True,exist_ok=True)
    archive=folder/f'sram512_submission_{sha(drawing)[:12]}.zip'
    temp=archive.with_suffix('.tmp')
    with zipfile.ZipFile(temp,'w',zipfile.ZIP_DEFLATED) as z:
        for name,data in sorted(payload.items()):
            z.writestr('submission/'+name,data)
    with zipfile.ZipFile(temp) as z:
        assert z.testzip() is None
        for name,info in manifest['files'].items():
            assert hashlib.sha256(z.read('submission/'+name)).hexdigest()==info['sha256'],name
    temp.replace(archive)
    manifest['archive']=dict(path=str(archive.relative_to(ROOT)),sha256=sha(archive),bytes=archive.stat().st_size)
    write_json(manifest_path,manifest)
    print(f'Created {output}: {len(payload)} files, {sum(map(len,payload.values())):,} bytes')
    print('ZIP:', archive)
    return output


if __name__ == '__main__':
    build()
