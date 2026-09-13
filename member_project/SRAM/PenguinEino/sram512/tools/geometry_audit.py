#!/usr/bin/env python3
"""Check the physical 16 x 32 grid and real seven-pin macro boundary."""
import argparse
from collections import defaultdict
from postlayout import devices
from common import *

def audit(folder,require_origin=False):
    folder=Path(folder).resolve();records,source=devices(folder)
    bits=defaultdict(list)
    for record in records:
        if record['model'] not in ('NMOS','PMOS'):continue
        identities={tuple(map(int,m.groups())) for n in record['nets'].values()
                    if (m:=re.fullmatch(r'xarray\.xr(\d+)c(\d+)\.qb?',n))}
        if not identities:continue
        assert len(identities)==1,(record,'MOS joins storage nodes of different cells')
        assert record['fingers']==1 and abs(record['parameters']['W']-3.4)<1e-6
        assert abs(record['parameters']['L']-1)<1e-6
        bits[next(iter(identities))].append(record)
    assert set(bits)=={(row,col) for row in range(16) for col in range(32)}
    assert all(len(devices)==6 for devices in bits.values())
    mux=[r for r in records if r['model']=='NMOS' and re.fullmatch(r'col\d+',r['nets']['G'])]
    assert len(mux)==64
    assert all(abs(r['parameters']['W']-5.1)<1e-6 and abs(r['parameters']['L']-1)<1e-6 for r in mux)
    pulldowns=[r for r in records if r['model']=='NMOS' and r['nets']['G'] in ('pd_y','pd_yb')]
    assert len(pulldowns)==2 and all(abs(r['parameters']['L']-1)<1e-6 for r in pulldowns)
    centers={key:[sum(d['position_um'][k] for d in group)/6 for k in range(2)] for key,group in bits.items()}
    for row in range(16):
        assert max(centers[row,c][1] for c in range(32))-min(centers[row,c][1] for c in range(32))<1e-6
        for col in range(31):
            delta=centers[row,col+1][0]-centers[row,col][0]
            assert delta>0,(row,col,'logical columns are not ordered left to right')
            if col!=15:assert abs(delta-22)<1e-6,(row,col,delta)
    for row in range(15):assert centers[row+1,0][1]>centers[row,0][1]
    # Mirrored alternating cell rows have alternating transistor centroids,
    # while their two-row physical pitch remains exactly 2 x 29.6 um.
    for row in range(14):assert abs(centers[row+2,0][1]-centers[row,0][1]-59.2)<1e-6
    layout=db.Layout();layout.read(str(folder/'sram512.gds'));top=layout.cell('sram512_macro');box=top.dbbox()
    assert box.width()<=1800+1e-6 and box.height()<=600+1e-6
    if require_origin:assert box.left>=-1e-6 and box.bottom>=-1e-6 and box.right<=1800+1e-6 and box.top<=600+1e-6
    pins={}
    for number,metal in ((48,13),(49,20)):
        conductor=db.Region(top.begin_shapes_rec(layout.layer(metal,0)))
        for shape in top.shapes(layout.layer(number,0)).each():
            if not shape.is_text():continue
            label=shape.text;name=label.string.upper();point=label.trans.disp
            assert name not in pins,name
            assert not conductor.interacting(db.Region(db.Box(point.x-1,point.y-1,point.x+1,point.y+1))).is_empty(),(name,'label is not on metal')
            x,y=point.x*.001,point.y*.001
            assert min(abs(x-box.left),abs(x-box.right),abs(y-box.bottom),abs(y-box.top))<=7.01,(name,'pin is not near the outside edge')
            pins[name]=dict(layer=f'M{number-47}',x_um=x,y_um=y)
    assert set(pins)=={'VDD','VSS','CLK','RESET','SDI','WE','SDO'}
    result=dict(passed=True,source=source,physical_rows=16,physical_columns=32,cells=512,
        mos_per_cell=6,cell_mos_width_um=3.4,cell_mos_length_um=1,cell_pitch_um=[22,29.6],
        column_mux_devices=len(mux),column_mux_width_um=5.1,column_mux_length_um=1,
        write_pulldown_devices=2,write_pulldown_widths_um=sorted({round(r['parameters']['W'],6) for r in pulldowns}),
        row_direction='horizontal',column_direction='vertical',logical_columns_increase_left_to_right=True,
        dimensions_um=[box.width(),box.height()],bbox_um=[box.left,box.bottom,box.right,box.top],
        pins=pins,origin_required=require_origin,
        scope='Device centroids and electrical cell identities from strict LVS; actual top-level metal pin locations.')
    write_json(folder/'geometry_audit.json',result);write_json(REPORTS/'geometry_audit.json',result)
    print(result['dimensions_um'],result['pins'],flush=True)
    return result

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('--require-origin',action='store_true');a=p.parse_args()
    audit(a.folder,a.require_origin)
