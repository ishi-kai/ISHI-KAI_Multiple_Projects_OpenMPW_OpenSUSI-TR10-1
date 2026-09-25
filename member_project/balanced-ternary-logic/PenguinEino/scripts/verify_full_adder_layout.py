"""Check the saved FA with the official dev DRC/LVS decks and refresh its extraction."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import argparse
import json
import re
import shutil
import klayout.db as db
from verify_half_adder_layout import ROOT, PDK, TECH, BIN, run, sha, drc, mask

WORK=ROOT/'simulation/full_adder_layout/verify'


def reference():
    d=WORK/'reference';d.mkdir(parents=True,exist_ok=True)
    rc=d/'xschemrc'
    rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:{PDK}/libs.tech/xschem:{PDK}/libs.tech/xschem/TR-1umLIB}}\nset lvs_netlist 1\nset top_is_subckt 1\nset spiceprefix 1\n')
    code,log=run(['xschem','-r','-x','--rcfile',rc,'-s','--command','set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result','-o',d,ROOT/'full_adder.sch'],d,'netlist.log')
    if code or re.search(r'Error:|SKIPPING|IS MISSING',log):
        raise RuntimeError('Reference netlisting failed: '+log[-2000:])
    text=(d/'full_adder.spice').read_text()
    text=re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',r'M\1\2',text)
    ref=d/'reference.spice';ref.write_text(text)
    gui=ROOT/'simulation/full_adder.spice'
    if gui.exists() and gui.read_text()!=text:
        shutil.copy2(gui,d/f'previous_gui_{sha(gui)[:16]}.spice')
    shutil.copy2(ref,gui)
    return ref


def lvs(gds,ref,d,top='full_adder'):
    d.mkdir(parents=True,exist_ok=True)
    out=d/'lvs.lvsdb';out.unlink(missing_ok=True)
    ext=d/'full_adder.extracted';ext.unlink(missing_ok=True)
    code,log=run([BIN,'-b','-r',TECH/'lvs/run.lvs','-rd',f'input={gds}','-rd',f'top_cell={top}','-rd',f'report={out}','-rd',f'circuit={ref}','-rd',f'extracted={ext}'],d,'lvs.log')
    if code or not out.exists():
        return dict(passed=False,exit_code=code,error=log[-3000:])
    result=db.LayoutVsSchematic();result.read(str(out))
    pairs=list(result.xref().each_circuit_pair());errors=[e.message for e in result.each_error()]
    return dict(passed=bool(pairs) and all(p.status()==db.NetlistCrossReference.Match for p in pairs) and not errors and 'Congratulations! Netlists match.' in log,
                circuits=[str(p.status()) for p in pairs],errors=errors,strict_ports=True,extracted=str(ext))


def check(gds=ROOT/'full_adder.gds'):
    gds=Path(gds).resolve();before=sha(gds);ref=reference()
    layout=db.Layout();layout.read(str(gds));cell=layout.cell('full_adder')
    assert cell is not None and layout.dbu==.001
    assert not any(db.Region(cell.begin_shapes_rec(layout.layer(63,dt))).area() for dt in (0,1,2))
    with ThreadPoolExecutor(max_workers=3) as pool:
        f_drc=pool.submit(drc,gds,'full_adder',WORK/'drawing')
        f_lvs=pool.submit(lvs,gds,ref,WORK/'lvs')
        f_mask=pool.submit(mask,gds,'full_adder',WORK/'manufacturing')
        drawing,comparison,manufacturing=f_drc.result(),f_lvs.result(),f_mask.result()
    assert sha(gds)==before,'GDS changed during verification; rerun against the saved revision'
    box=cell.dbbox()
    result=dict(gds=str(gds),gds_sha256=before,schematic_sha256=sha(ROOT/'full_adder.sch'),reference_sha256=sha(ref),
                pdk=str(PDK),dbu_um=layout.dbu,bbox_um=[box.left,box.bottom,box.right,box.top],waiver_regions=0,
                rule_sha256={str(p.relative_to(PDK)):sha(p) for kind in ('drc','lvs') for p in sorted((TECH/kind).rglob('*')) if p.is_file()},
                drc=drawing,lvs=comparison,mask_drc=manufacturing)
    result['passed']=all(result[k]['passed'] for k in ('drc','lvs','mask_drc'))
    (ROOT/'reports/full_adder_layout.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='rule_sha256'},indent=2),flush=True)
    if comparison['passed']:
        ext=ROOT/'full_adder.extracted'
        if ext.exists():shutil.copy2(ext,WORK/f'previous_{sha(ext)[:16]}.extracted')
        shutil.copy2(comparison['extracted'],ext)
    return result


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--gds',type=Path,default=ROOT/'full_adder.gds')
    args=p.parse_args()
    raise SystemExit(0 if check(args.gds)['passed'] else 1)
