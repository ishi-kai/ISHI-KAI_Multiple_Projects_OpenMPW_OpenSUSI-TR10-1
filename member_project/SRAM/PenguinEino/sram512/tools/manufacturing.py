#!/usr/bin/env python3
"""Use the unmodified dev MDP exporter and full IP62 mask DRC."""
import argparse,shutil
from common import *

# Physical process layers listed in the official run_mdp.drc output section.
# 150/151 and the other DL* outputs are derived device-recognition drawings,
# not implant masks. Keep them in the file and in every official check, and
# report their complete extent separately from the fabrication footprint.
PROCESS_LAYERS=(36,141,25,26,33,148,143,144,145,146,147,3,35,7,12,9,28,
                8,11,13,19,20,14,121,122,80)

def freeze(folder):
    folder=Path(folder).resolve()
    result=json.loads((folder/'checks/result.json').read_text())
    assert all(result[k]['passed'] for k in ('drc','lvs'))
    assert sha(folder/'sram512.gds')==result['gds_sha256']
    dest=WORK/'extracted_sources'/result['gds_sha256']
    if not dest.exists():
        dest.mkdir(parents=True)
        for name in ('sram512.gds','reference.spice','placement.json','ports.json',
                     'array_geometry.json','coordinate_frames.json','geometry_audit.json','result.json'):
            if (folder/name).exists():shutil.copy2(folder/name,dest/name)
        shutil.copytree(folder/'checks',dest/'checks')
    assert sha(dest/'sram512.gds')==result['gds_sha256']
    return dest

def verify(folder):
    folder=freeze(folder);work=folder/'manufacturing';work.mkdir(exist_ok=True)
    source=folder/'sram512.gds';top='sram512_macro'
    l=db.Layout();l.read(str(source));c=l.cell(top)
    # No recognition/waiver regions may silently suppress source checks.
    for dtype in (0,1,2):
        assert db.Region(c.begin_shapes_rec(l.layer(63,dtype))).is_empty(),(63,dtype)
    mask=work/'sram512_mask.gds'
    run([klayout_binary(),'-b','-r',PDK/'libs.tech/klayout/tech/drc/run_mdp.drc',
         '-rd',f'input={source}','-rd',f'cellname={top}','-rd',f'output={mask}'],work,'mdp.log')
    report=work/'sram512_mask.drcdb';report.unlink(missing_ok=True)
    code,log=run([klayout_binary(),'-b','-r',PDK/'libs.tech/klayout/tech/drc/run_IP62.drc',
                 '-rd',f'input={mask}','-rd',f'top_cell={top}','-rd',f'report={report}'],
                work,'mask_drc.log',check=False)
    assert code==0 and report.exists(),log[-1500:]
    r=rdb.ReportDatabase();r.load(str(report))
    mask_layout=db.Layout();mask_layout.read(str(mask))
    mask_top=mask_layout.cell(top)
    complete_box=mask_top.dbbox()
    physical=db.Region()
    for number in PROCESS_LAYERS:
        physical+=db.Region(mask_top.begin_shapes_rec(mask_layout.layer(number,0)))
    mask_box=physical.bbox().to_dtype(mask_layout.dbu)
    drawing_box=c.dbbox()
    dimensions_passed=mask_box.width()<=1800+1e-6 and mask_box.height()<=600+1e-6
    result=dict(passed=r.num_items()==0 and dimensions_passed,items=r.num_items(),
                categories={c.name():c.num_items() for c in r.each_category() if c.num_items()},
                dimensions_passed=dimensions_passed,
                drawing_bbox_um=[drawing_box.left,drawing_box.bottom,drawing_box.right,drawing_box.top],
                mask_bbox_um=[mask_box.left,mask_box.bottom,mask_box.right,mask_box.top],
                mask_dimensions_um=[mask_box.width(),mask_box.height()],
                all_output_layers_bbox_um=[complete_box.left,complete_box.bottom,complete_box.right,complete_box.top],
                fabrication_layers=list(PROCESS_LAYERS),
                dimension_scope='Physical masks listed in unmodified run_mdp.drc; all derived recognition layers remain present and fully checked.',
                drawing_sha256=sha(source),mask_sha256=sha(mask),pdk=provenance('dev'),
                source=str(folder),waiver_regions=0,
                scope='Official MDP and complete IP62 mask DRC of the core; package/pad integration is separate.')
    write_json(work/'result.json',result);write_json(REPORTS/'manufacturing_mask.json',result)
    print(folder,flush=True);print(result['passed'],result['items'],result['categories'],flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);a=p.parse_args()
    result=verify(a.folder);raise SystemExit(0 if result['passed'] else 1)
