#!/usr/bin/env python3
"""Audit the actual dev array and leaf cells before implementing peripherals."""
from concurrent.futures import ThreadPoolExecutor
import argparse, importlib.util, re, sys
from common import *

KINDS=['INV_X1','INV_X2','INV_X4','BUF_X4','NAND2','NAND3','AND2_X1',
       'AND3_X1','AND4_X1','OR2','OR3','OR4','XOR2','MUX2','DFFR']

def library_source():
    work=WORK/'library';work.mkdir(parents=True,exist_ok=True)
    lines=['v {xschem version=3.4.8RC file_version=1.3}','G {}','K {}','V {}','S {}','E {}']
    for i,kind in enumerate(KINDS+['sense_amp_7t','write_control']):
        std=kind in KINDS
        sym=(LIB/'TR-1um_5_stdcell' if std else SCHEMATICS)/(kind+'.sym')
        x=(i%4)*600; y=(i//4)*500
        lines.append(f'C {{{"TR-1um_5_stdcell/" if std else ""}{kind}.sym}} {x} {y} 0 0 {{name=x{i}}}')
        for m in re.finditer(r'B 5 ([-\d.]+) ([-\d.]+) ([-\d.]+) ([-\d.]+) \{name=(\w+) dir=(\w+)\}',sym.read_text()):
            px=x+round((float(m[1])+float(m[3]))/2);py=y+round((float(m[2])+float(m[4]))/2)
            pin=m[5]; name=f'{kind}_{pin}'
            port={'in':'ipin','out':'opin','inout':'iopin'}[m[6]]
            lines.append(f'C {{devices/{port}.sym}} {px} {py} 0 0 {{name=p{i}_{pin} lab={name}}}')
    sch=work/'library_reference.sch';sch.write_text('\n'.join(lines)+'\n')
    return netlist(sch,work).read_text()

def array():
    sys.path.insert(0,str(ROOT/'klayout/sram_pcell'))
    spec=importlib.util.spec_from_file_location('pcell512',ROOT/'klayout/sram_pcell/build.py')
    mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
    assert mod.PDK.resolve()==PDK.resolve()
    out=WORK/'array';mod.make(out,family='six_single',shapes=((16,32),))
    result=verify_layout(out/'pcell.gds','pcell_16x32',out/'pcell_16x32.spice',out/'checks')
    write_json(REPORTS/'array_baseline.json',result)
    print('array',result['drc'],result['lvs']['passed'],flush=True)
    return result

def physical_library():
    """Correct interface text in the DESIGN COPY, based on transistor topology.

    No mask polygon, circuit device, PDK file, or verification setting changes.
    Missing power labels are placed on the existing, physically connected rails.
    Commutative OR input labels follow the schematic's transistor stack order.
    The resulting copies must pass the unmodified strict leaf LVS independently.
    """
    layout=db.Layout(); layout.read(str(PDK/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds'))
    edits=[]
    for kind,pin,y in [('BUF_X4','GND',0),('NAND3','VDD',55),('OR3','VDD',55)]:
        cell=layout.cell(kind)
        region=db.Region(cell.begin_shapes_rec(layout.layer(13,0)))
        pt=db.Point(0,round(y/layout.dbu))
        assert not (region & db.Region(db.Box(pt.x-1,pt.y-1,pt.x+1,pt.y+1))).is_empty()
        cell.shapes(layout.layer(48,0)).insert(db.Text(pin,db.Trans(pt.x,pt.y)))
        edits.append({'cell':kind,'add_m1_label':pin,'at_um':[0,y]})
    for kind,mapping in [('NAND3',{'A':'C','C':'A'}),('OR3',{'B':'C','C':'B'}),('OR4',{'A':'B','B':'A'})]:
        for shape in layout.cell(kind).shapes(layout.layer(48,0)).each():
            if shape.is_text() and shape.text.string in mapping:
                t=shape.text;t.string=mapping[t.string];shape.text=t
        edits.append({'cell':kind,'signal_label_mapping':mapping})
    out=WORK/'library';out.mkdir(parents=True,exist_ok=True)
    layout.write(str(out/'design_library.gds'))
    write_json(REPORTS/'library_interface_corrections.json',{
        'upstream_gds_sha256':sha(PDK/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds'),
        'design_gds_sha256':sha(out/'design_library.gds'),'edits':edits,
        'mask_geometry_changed':False,'pdk_or_verification_decks_changed':False})
    return layout

def cells(source, interfaces=False):
    defs={m[1].upper():m[0] for m in re.finditer(r'(?ims)^\.subckt\s+(\S+)[ \t]+[^\n]+\n.*?^\.ends[^\n]*',source)}
    if interfaces:layout=physical_library()
    else:
        layout=db.Layout(); layout.read(str(PDK/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds'))
    jobs=[]
    for kind in KINDS:
        work=WORK/'library'/('interfaces' if interfaces else 'original')/kind;work.mkdir(parents=True,exist_ok=True)
        layout.cell(kind).write(str(work/'original.gds'))
        ref=work/'reference.spice'
        ref.write_text('* Independent dev Xschem leaf netlist\n'+re.sub(r'(?im)^X(M\S+)\s+',r'\1 ',defs[kind.upper()])+'\n')
        jobs.append((work/'original.gds',kind,ref,work))
    def check(job):
        result=verify_layout(*job)
        print(job[1],result['drc'],result['lvs']['passed'],flush=True)
        return result
    with ThreadPoolExecutor(max_workers=2) as pool:results=list(pool.map(check,jobs))
    write_json(REPORTS/('library_interfaces.json' if interfaces else 'library_baseline.json'),results)
    if interfaces:assert all(r[k]['passed'] for r in results for k in ('drc','lvs'))
    return results

def main():
    p=argparse.ArgumentParser();p.add_argument('--section',choices=['all','array','cells','interfaces'],default='all');a=p.parse_args()
    write_json(REPORTS/'pdk_baseline.json',provenance('dev'))
    if a.section in ('all','array'):array()
    if a.section in ('all','cells'):cells(library_source())
    if a.section in ('all','interfaces'):cells(library_source(),True)

if __name__=='__main__':main()
