#!/usr/bin/env python3
"""NANY: eight MOS + two diffusion resistors, using unmodified TR-1um PCells.

The default GDS is at the project root, metadata in layout/.
--out selects a candidate directory. Dimensions are um.
"""
import argparse
import hashlib
import json
from pathlib import Path
import klayout.db as db
from build_inverter import Drawing, PDK, ROOT
from gds_units import GDS_DBU, write_gds


def build(out):
    out.mkdir(parents=True, exist_ok=True)
    layout = db.Layout()
    layout.dbu = GDS_DBU
    layout.technology_name = 'TR-1um'
    top = layout.create_cell('nany')
    d = Drawing(layout, top)
    width, height = 148., 115.

    for role, kind, x, y, w in [
        ('XM5', 'fet_p', 20, 88, 34), ('XM3', 'fet_p', 35, 88, 34),
        ('XM6', 'fet_p', 50, 88, 14), ('XM8', 'fet_p', 65, 88, 14),
        ('XM2', 'fet_n', 20, 15, 11), ('XM1', 'fet_n', 35, 15, 11),
        ('XM7', 'fet_n', 50, 15, 8), ('XM9', 'fet_n', 65, 15, 8),
    ]:
        d.pcell(role, kind, x, y, dict(w=w, l=1., n=1,
                                     cont_between_gates=True, y0='c'))
    for role, y in [('R2', 72), ('R1', 42)]:
        d.pcell(role, 'res_diff', 112.5, y, dict(w=2.8, l=30.))

    d.box('WN', 6.3, 64, 75.3, 112)
    d.box('WN', 85, 30.6, 140, 83.4)
    d.pcell('PMOS well tap', 'cont_n', 12.6, 88)
    d.pcell('RR well tap', 'cont_n', 112.5, 57)
    for x in (8, 76):
        d.pcell('VSS bulk tap', 'cont_p', x, 15)
        d.wire('M1', [(x, 15), (x, 1.7)], 2.6)
    d.box('M1', 0, 111.6, width, 115)
    d.box('M1', 0, 0, width, 3.4)
    d.wire('M1', [(12.6, 88), (15, 88), (15, 113.3)], 2.6)
    d.wire('M1', [(112.5, 57), (112.5, 98), (135, 98), (135, 113.3)], 2.6)
    for y in (42, 72):
        # dev GC.R3: extend GC out of the RR recognition region before contacting it.
        d.wire('GC', [(133, y), (135, y)], 2.6)
        d.pcell('RR GC tie', 'cont_g', 135, y)
    d.wire('M1', [(135, 42), (135, 98)], 2.6)

    def via(x, y, role):
        d.pcell(role, 'via_1', x, y)

    def fanout(x0, y0, x):
        # Fill the same-net notch between the diffusion contact strip and trunk.
        w = (34 if x0 < 40 else 14) if y0 == 88 else (11 if x0 < 40 else 8)
        d.box('M1', min(x0,x)-1.3, y0-w/2, max(x0,x)+1.3, y0+w/2)

    def trunk(x0, y0, x, y, role):
        if y0 in (15,88) and x0 != x:
            fanout(x0, y0, x)
        d.wire('M1', [(x0, y0), (x, y0), (x, y)], 2.6)
        via(x, y, role)

    # Main series stacks. Left/right diffusion assignment is electrically
    # interchangeable; bulk is fixed to VDD or VSS by the well/tap structure.
    fanout(18, 88, 15)
    d.wire('M1', [(18, 88), (15, 88)], 2.6)
    d.wire('M1', [(22, 88), (33, 88)], 2.6)  # net1
    trunk(37, 88, 40, 64, 'net2')
    trunk(18, 15, 15, 32, 'net3')
    d.wire('M1', [(22, 15), (33, 15)], 2.6)  # net4
    fanout(37, 15, 40)
    d.wire('M1', [(37, 15), (40, 15), (40, 1.7)], 2.6)

    for x in (50, 65):
        trunk(x-2, 88, x-5, 58, 'vout clamp')
        trunk(x-2, 15, x-5, 38, 'VMID clamp')
        fanout(x+2, 88, x+5)
        fanout(x+2, 15, x+5)
        d.wire('M1', [(x+2, 88), (x+5, 88), (x+5, 15), (x+2, 15)], 2.6)

    # Main gates share vertical GC, since their p/n gate nets are identical.
    for x, y in [(20, 52), (35, 46)]:
        d.wire('GC', [(x, 15), (x, 88)], 1.)
        d.pcell('main input gate', 'cont_g', x, y)
        d.wire('M1', [(x,y), (x+3.3,y)], 2.6)
        via(x+3.3, y, 'main input access')
    # The two clamp stacks use opposite p/n gate nets.
    for x, track in [(50, 52), (65, 46)]:
        d.wire('GC', [(x, 88), (x, 76)], 1.)
        d.pcell('clamp p gate', 'cont_g', x, 76)
        trunk(x, 76, x, track, 'clamp p input')
    for x in (50, 65):
        d.wire('GC', [(x, 15), (x, 23)], 1.)
        d.pcell('clamp n gate', 'cont_g', x, 23)
    trunk(50, 23, 50, 46, 'clamp n b')
    d.wire('M1', [(65,23), (65,26.3)], 2.6)
    via(65, 26.3, 'clamp n a crossover')
    d.wire('M2', [(65, 26.3), (75, 26.3)], 3.4)
    via(75, 26.3, 'clamp n a return')
    trunk(75, 26.3, 75, 52, 'clamp n a')

    # RR terminals; SUB and both GC rings are already physically tied to VDD.
    trunk(97, 72, 97, 64, 'R2 input')
    trunk(97, 42, 97, 32, 'R1 input')
    d.wire('M1', [(128, 42), (128, 72)], 2.6)
    via(128, 58, 'RR output')
    for xa, xb, y in [(15, 97, 32), (40, 97, 64),
                       (45, width-1.7, 58), (1.7, 80, 38),
                       (1.7, 75, 52), (1.7, 65, 46)]:
        d.wire('M2', [(xa, y), (xb, y)], 3.4)

    ports = {}
    for name, layer, x, y, edge, direction in [
        ('a', 'M2', 2, 52, 'left', 'input'),
        ('b', 'M2', 2, 46, 'left', 'input'),
        ('vout', 'M2', width-2, 58, 'right', 'output'),
        ('VDD', 'M1', width/2, 113.3, 'top', 'power'),
        ('VSS', 'M1', width/2, 1.7, 'bottom', 'power'),
        ('VMID', 'M2', width/2, 38, 'left', 'power'),
    ]:
        d.label(layer, name, x, y)
        ports[name] = dict(layer=[13 if layer == 'M1' else 20, 0],
                           label_layer=[48 if layer == 'M1' else 49, 0],
                           position_um=[x,y], edge=edge, direction=direction,
                           access_box_um=[x-1.7,y-1.7,x+1.7,y+1.7])
    assert top.dbbox() == db.DBox(0,0,width,height), top.dbbox()
    target = out / 'nany.gds'
    write_gds(layout, target)
    meta = dict(top_cell='nany', gds=str(target), gds_sha256=hashlib.sha256(target.read_bytes()).hexdigest(),
                source_schematic=str(ROOT/'nany.sch'), pdk=str(PDK), dbu_um=GDS_DBU,
                width_um=width, height_um=height, area_um2=width*height,
                ports=ports, instances=d.instances,
                device_counts=dict(PMOS=4,NMOS=4,F_RR=2),
                placement=dict(gap_um=12, abutment=False, shared_bulk='VSS',
                               orientations=['R0','MY','MX','R180'],
                               qualification='12 um gap geometric check for four orientations; two R0 cells with real interconnect also verified. No zero-gap abutment.'))
    metadata_dir = ROOT/'layout' if out == ROOT else out
    (metadata_dir/'nany.ports.json').write_text(json.dumps(meta,indent=2)+'\n')
    print(target)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out',type=Path,default=ROOT)
    build(parser.parse_args().out.resolve())
