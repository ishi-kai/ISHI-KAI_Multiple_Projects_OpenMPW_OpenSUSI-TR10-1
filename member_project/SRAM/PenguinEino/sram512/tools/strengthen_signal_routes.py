#!/usr/bin/env python3
"""Add real low-resistance signal connections; keep the user's bitcell intact."""
import argparse
import shutil
from common import *
from layout_analog import pc
import networkx as nx


def move_column_bridge(layout):
    """Move one existing CH1 bridge below the new bank-1 WL0 tap."""
    core = layout.cell('sram512')
    drawing = pc.Drawing(layout, core)
    box = db.Box(485450, 122450, 488050, 125050)
    gc = [s for s in core.shapes(layout.layer(8,1)).each_overlapping(box)
          if s.bbox() == db.Box(468950,122450,488050,125050)]
    assert len(gc) == 1
    gc[0].transform(db.Trans(0,-2100))
    for x in (470250,486750):
        cut = db.Box(x-500,123250,x+500,124250)
        contacts = [s for s in core.shapes(layout.layer(11,0)).each_overlapping(cut)
                    if s.bbox() == cut]
        assert len(contacts) == 1
        contacts[0].transform(db.Trans(0,-2100))
        metal = [s for s in core.shapes(layout.layer(13,0)).each_overlapping(cut)
                 if s.bbox().top == 125050]
        assert len(metal) == 1
        metal[0].delete()
    for vx,vy,cx in ((456.5,121.,470.25),(489.5,118.25,486.75)):
        points = [(vx,vy),(vx,121.65),(cx,121.65)] if cx==470.25 else [(vx,vy),(cx,vy),(cx,121.65)]
        drawing.wire('M1',points,1.8)
        drawing.pad('M1',vx,vy,3.4)
        drawing.pad('M1',cx,121.65,2.6)
    return dict(net='COL_DECODE.CH1', moved_bridge_dy_um=-2.1)


def shunt_counter_poly(layout, source, work):
    """Connect C4B's existing metal islands with additional legal metal."""
    extraction = db.LayoutVsSchematic()
    extraction.read(str(source/'checks/sram512_macro.lvsdb'))
    original = db.Layout(); original.read(str(source/'sram512.gds'))
    original_core = original.cell('sram512')
    circuit = extraction.netlist().circuit_by_name('sram512')
    net = next(n for n in circuit.each_net() if n.name.upper()=='CTRL.PHASE.C4B')
    specs = ((13,0),(20,0),(19,0))
    indexes = [extracted_layer_index(extraction,original,original_core,s) for s in specs]
    parts = [[db.Region(p) for p in extraction.polygons_of_net(net,i,True).merged().each()]
             for i in indexes[:2]]
    graph = nx.Graph()
    for k,regions in enumerate(parts):
        graph.add_nodes_from((k,i) for i in range(len(regions)))
    for p in extraction.polygons_of_net(net,indexes[2],True).merged().each():
        cut = db.Region(p)
        ends = [next((k,i) for i,r in enumerate(parts[k]) if not r.interacting(cut).is_empty())
                for k in range(2)]
        graph.add_edge(*ends)
    components = list(nx.connected_components(graph))
    assert len(components)==4, len(components)
    core = layout.cell('sram512')
    own = [sum(regions,db.Region()) for regions in parts]
    actual = [db.Region(core.begin_shapes_rec(layout.layer(*s))) for s in specs[:2]]
    # Only bridge the driver and the OR2 load that exceeded VGB. Other
    # branches remain unchanged and are still included in the RC test.
    selected = []
    for x,y in ((1294.7,421.55),(1474.1,544.9)):
        point = db.Region(db.Box(round(x*1000)-1,round(y*1000)-1,
                                round(x*1000)+1,round(y*1000)+1))
        hits = [component for component in components
                if any(k==0 and not parts[k][i].interacting(point).is_empty() for k,i in component)]
        assert len(hits)==1
        selected.append(hits[0])
    assert selected[0] != selected[1]
    # The legal M1 corridor is only y=435.75..436.00 at this width. Use
    # the actual 50 nm manufacturing grid; a 1.1 um maze grid misses it.
    # Both endpoints already have contacts/vias on this same LVS net.
    points = [(1405.25,437.25),(1405.25,435.85),(1501.5,435.85),(1501.5,437.25)]
    path = db.Region(db.Path([db.Point(round(x*1000),round(y*1000)) for x,y in points],
                             1800,900,900).polygon())
    addition = path-own[0]
    assert (addition & (actual[0]-own[0]).sized(1400)).is_empty(), 'M1 clearance violation'
    for component in selected:
        metal = sum((parts[k][i] for k,i in component if k==0),db.Region())
        assert not path.interacting(metal).is_empty()
    core.shapes(layout.layer(13,0)).insert(path)
    return dict(net='CTRL.PHASE.C4B', original_metal_components=len(components),
                shunted_metal_components=2, added_metal_connection=True, original_poly_retained=True,
                m1_width_um=1.8, route_points_um=points, added_m1_area_um2=addition.area()*1e-6)


def add_wordline_end_taps(layout):
    array = layout.cell('pcell_16x16')
    assert array is not None
    drawing = pc.Drawing(layout, array)
    width, height = 352., 29.6
    # Mirror the original left-edge GC/contact/M1/via connection at the
    # opposite end. Both mirrored banks instantiate this array master.
    for row in range(16):
        ty = row*height+5.7 if row % 2 == 0 else (row+1)*height-5.7
        sign = 1 if row % 2 == 0 else -1
        py, cy, y = (ty+sign*a for a in (-4.6, -3.7, -3.0))
        drawing.box('GC', width, py-.5, width+6.4, py+.5)
        drawing.wire('GC', [(width+6.4, py), (width+6.4, cy)], 1.)
        drawing.contact(width+6.4, cy, 'GC')
        drawing.via(width+9.6, y)
        drawing.box('M1', width+5.1, min(y-1.7, cy-1.3),
                    width+11.3, max(y+1.7, cy+1.3))
    return dict(shared_array_master=array.name, taps_per_bank=16, banks=2,
                total_added_taps=32, original_bitcell_modified=False)


def main(source, name, counter=False):
    source = Path(source).resolve()
    old = json.loads((source/'checks/result.json').read_text())
    assert old['gds_sha256'] == sha(source/'sram512.gds')
    assert all(old[k]['passed'] for k in ('drc', 'lvs'))
    work = WORK/'layout'/name
    work.mkdir(parents=True, exist_ok=True)
    layout = db.Layout(); layout.read(str(source/'sram512.gds'))
    layout.technology_name = 'TR-1um'
    top = layout.cell('sram512_macro')
    original = layout.cell('pcell_core')
    before = {i: db.Region([p.dup() for p in db.Region(original.begin_shapes_rec(i)).each()])
              for i in layout.layer_indexes()}
    taps = add_wordline_end_taps(layout)
    bridge = move_column_bridge(layout)
    counter_change = shunt_counter_poly(layout, source, work) if counter else None
    pc.fill_metal_notches(layout, layout.cell('sram512'))
    assert all((region ^ db.Region(original.begin_shapes_rec(i))).is_empty()
               for i, region in before.items())
    assert top.dbbox().width() <= 1800 and top.dbbox().height() <= 600
    for filename in ('placement.json', 'ports.json', 'coordinate_frames.json', 'array_geometry.json'):
        shutil.copy2(source/filename, work/filename)
    generated = netlist(ROOT/'sram512/schematics/sram512_macro.sch', work/'schematic', lvs=True)
    reference = work/'reference.spice'
    reference.write_text(re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',
                                r'M\1\2', generated.read_text()))
    gds = work/'sram512.gds'; top.write(str(gds))
    result = verify_layout(gds, top.name, reference, work/'checks')
    result.update(source_gds_sha256=old['gds_sha256'], wordline_end_taps=taps,
                  column_bridge=bridge, counter_shunt=counter_change)
    result['passed'] = all(result[k]['passed'] for k in ('drc', 'lvs'))
    write_json(work/'signal_changes.json', result)
    print(result['drc'], result['lvs'], flush=True)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('source', type=Path)
    parser.add_argument('--name', default='signal_taps16x32')
    parser.add_argument('--counter', action='store_true')
    args = parser.parse_args()
    raise SystemExit(0 if main(args.source, args.name, args.counter)['passed'] else 1)
