#!/usr/bin/env python3
"""Apply the earlier serial-peripheral budget to verified TR-1um PCell arrays."""
from pathlib import Path
import hashlib,importlib.util,json,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
spec=importlib.util.spec_from_file_location('compact_capacity',HERE.parent/'sram_compact/compare_capacity.py')
previous=importlib.util.module_from_spec(spec);spec.loader.exec_module(previous)
import macro_model

def footprint(rows,columns):
    return columns*22+((columns-1)//16)*21.2+43,rows*29.6+(12.2 if rows%2 else 0)

def main():
    dims=json.loads((HERE/'dimensions.json').read_text())
    for d in dims['arrays'].values():
        w,h=footprint(d['rows'],d['columns'])
        assert abs(w-d['width_um'])<1e-6 and abs(h-d['height_um'])<1e-6
        assert (w,h)==previous.footprint('pcell',d['rows'],d['columns'])
    tilings=[]
    for r in range(1,101):
        for c in range(1,101):
            w,h=footprint(r,c)
            if (w<=600 and h<=1800) or (w<=1800 and h<=600):
                tilings.append(dict(rows=r,columns=c,bits=r*c,width_um=round(w,1),height_um=round(h,1)))
    largest=max(tilings,key=lambda a:a['bits'])
    assert largest['bits']==dims['arrays'][f"pcell_{largest['rows']}x{largest['columns']}"]['bits']
    # Reuse standard-cell definitions from the fresh current-schematic netlist.
    netlist=ROOT/'build/sram_pcell/serial/netlist/sram_tb_serial.spice'
    source=netlist.read_text();macro_model.source_text=lambda:source
    cases=[previous.estimate('pcell',r,c,u,s) for u,s in ((.65,150),(.75,120),(.85,120))
           for r in (4,8,16,32,64) for c in (4,8,16,32,64) if r*c<=2048]
    best=[max((a for a in cases if a['utilization']==u and a['floorplan']['fits']),
              key=lambda a:(a['bits'],-a['floorplan']['height_um'])) for u in (.65,.75,.85)]
    paths=[Path(__file__),HERE/'dimensions.json',Path(previous.__file__),Path(previous.base.__file__),
           Path(macro_model.__file__),netlist,ROOT/'learning/schematics/sram_serial_controller.sch',ROOT/'sram512/schematics/write_control.sch',
           previous.base.PDK/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds']
    report=dict(gds_sha256=dims['gds_sha256'],array_only_best=largest,
                array_search='1..100 rows and columns, both orientations; 16-column tap interval.',
                peripheral_scope='Single array, binary address sizes; block budget, peripherals not laid out; pads/ESD excluded.',
                assumptions=['Same serial architecture and standard-cell dimensions as previous compact study.',
                             'Row-final region: 137.6 um for two alternating-row lanes and pitch conversion.',
                             'Column region depth: 120 or 150 um; common analog region: 120 x 60 um.',
                             'Logic row filling targets: 65%, 75%, 85%; not total die utilization.'],
                best=best,cases=[{k:v for k,v in a.items() if k not in
                    ('global_bom','row_final_bom','column_final_bom','controller')} for a in cases],
                input_sha256={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})
    (HERE/'capacity.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Array only:',largest)
    for b in best:print(b['utilization'],b['bits'],b['floorplan'])

if __name__=='__main__':main()
