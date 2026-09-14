#!/usr/bin/env python3
"""Recalculate PCell macro capacity after receive/access register sharing.

Actual standard-cell dimensions, explicit gate counts, and rectangular block
budgets; this does not generate or verify routed peripheral layout.
"""
from collections import Counter
from functools import lru_cache
from pathlib import Path
import argparse
import csv
import hashlib
import json
import sys

import klayout.db as db

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path[:0] = [str(ROOT / 'scripts'), str(HERE.parent / 'sram_macro_study')]
import pdk_profiles
import macro_model
import estimate_capacity as base
import verify_serial

TARGETS = ((600, 1800), (1600, 800))
SCENARIOS = ((.65, 150), (.75, 120), (.85, 120))
WORK = ROOT / 'build/sram_pcell/shared_capacity'


def footprint(rows, columns):
    return (22 * columns + ((columns - 1) // 16) * 21.2 + 43,
            29.6 * rows + (12.2 if rows % 2 else 0))


def audit_schematic(source):
    definitions = macro_model.Circuit(source).defs
    block = definitions['sram_serial_controller'][2]
    instances = {}
    for line in block.splitlines():
        if line.lower().startswith('x'):
            name, *nodes, kind = line.split()
            pins = definitions[kind.lower()][1]
            assert len(pins) == len(nodes), line
            instances[name] = (kind, dict(zip(pins, nodes)))
    bom = Counter(kind for kind, _ in instances.values())
    assert bom == base.schematic_bom('sram_serial_controller.sch')
    assert bom['DFFR'] == 13 and bom['MUX2'] == 5, bom
    # Audit the actual wires: the three receive FFs directly drive DIN/CA/RA;
    # their feedback MUXes shift only during RX, and hold otherwise.
    chain = ['SDI', 'DIN', 'CA', 'RA']
    for i in range(3):
        ff = instances[f'xshift{i}_ff'][1]
        mux = instances[f'xshift{i}_mux'][1]
        assert (ff['Q'], ff['D'], ff['CK'], ff['RST']) == (
            chain[i + 1], mux['Y'], 'CLK', 'RESET')
        assert (mux['A'], mux['B'], mux['S']) == (chain[i + 1], chain[i], 'RX')
    return dict(bom=dict(bom),cells=sum(bom.values()),
                abut_area_um2=base.area(bom),shared_frame_wiring_checked=True,
                scope='Fresh 2x2 schematic netlist; scalable control decode uses macro_model, not synthesis.')


@lru_cache(None)
def architecture(rb, cb, shared):
    _, meta, groups = macro_model.digital(rb, cb, share_frame=shared)
    assert groups['controller']['DFFR'] == meta['flipflops']
    assert groups['controller']['MUX2'] == (rb + cb + 1) * (1 if shared else 2) + 2
    return meta, groups


@lru_cache(None)
def inventory(rows, columns, shared):
    rb, cb = (rows - 1).bit_length(), (columns - 1).bit_length()
    meta, groups = architecture(rb, cb, shared)
    row, col = Counter(groups['row_decoder']), Counter(groups['col_decoder'])
    row_kind = 'AND2_X1' if rb <= 3 else 'AND3_X1'
    row[row_kind] -= 2**rb - rows
    rf = Counter({row_kind: rows})
    if cb >= 4:
        col['AND2_X1'] -= 2**cb - columns
        cf = Counter(AND2_X1=columns)
    else:
        col['INV_X1'] -= 2 * (2**cb - columns)
        cf = Counter(INV_X1=2 * columns)
    assert all(row[n] >= v for n, v in rf.items())
    assert all(col[n] >= v for n, v in cf.items())
    control = Counter(groups['controller'])
    write = base.schematic_bom('write_control.sch')
    buffers = Counter(BUF_X4=12)
    global_bom = control + (row - rf) + (col - cf) + write + buffers
    total = global_bom + rf + cf
    areas = dict(controller=base.area(control),row_decoder=base.area(row),
                 column_decoder=base.area(col),write_control=base.area(write),
                 distribution_buffers=base.area(buffers))
    assert abs(sum(areas.values()) - base.area(total)) < 1e-6
    aw, ah = footprint(rows, columns)
    return dict(rows=rows,columns=columns,bits=rows*columns,controller=meta,
                array_width_um=round(aw,1),array_height_um=round(ah,1),
                array_area_um2=round(aw*ah,2),global_bom=dict(global_bom),
                row_final_bom=dict(rf),column_final_bom=dict(cf),total_bom=dict(total),
                digital_abut_area_um2=base.area(total),digital_groups_um2=areas,
                array_plus_digital_um2=round(aw*ah+base.area(total),2),
                analog_mos=4*columns+11,
                unused_address_codes=2**(rb+cb)-rows*columns)


@lru_cache(None)
def packed(bom, utilization, width):
    return base.pack_rows(dict(bom), utilization, width)


def estimate(rows, columns, shared, utilization, strip, target):
    item = inventory(rows, columns, shared)
    aw, ah = item['array_width_um'], item['array_height_um']
    alternatives = []
    # Permit the whole floorplan to rotate, so global standard-cell rows can
    # run along either target edge. Local decoder/periphery bands rotate with
    # the array; their budgets are identical before and after register sharing.
    for frame_rotation in (0, 90):
        tw, th = target if frame_rotation == 0 else target[::-1]
        p = packed(tuple(sorted(item['global_bom'].items())), utilization, tw - 20)
        for array_rotation in (0, 90):
            uw, uh = ((aw + 137.6, ah + strip) if array_rotation == 0
                      else (ah + strip, aw + 137.6))
            w, h = max(uw, tw - 20 + 12.6), uh + p['height_um'] + 100
            fits = w <= tw + 1e-6 and h <= th + 1e-6
            alternatives.append(dict(frame_rotation_deg=frame_rotation,
                array_rotation_deg=array_rotation,frame_target_um=[tw,th],
                frame_width_um=round(w,1),frame_height_um=round(h,1),
                width_um=round(w if frame_rotation == 0 else h,1),
                height_um=round(h if frame_rotation == 0 else w,1),
                upper_width_um=round(uw,1),upper_height_um=round(uh,1),
                global_logic_rows=len(p['rows']),global_logic_height_um=p['height_um'],
                global_logic_width_um=tw-20,global_actual_occupancy=p['occupancy'],
                fits=fits,relative_extent=max(w/tw,h/th)))
    floor = min(alternatives, key=lambda a:(not a['fits'],
        0 if a['fits'] else a['relative_extent'],a['width_um']*a['height_um']))
    return dict(**item,shared_frame=shared,utilization=utilization,
                column_strip_um=strip,target_um=list(target),floorplan=floor)


def binary(case):
    return all(n & (n-1) == 0 for n in (case['rows'],case['columns']))


def best(cases):
    return min(cases,key=lambda a:(-a['bits'],
        a['floorplan']['width_um']*a['floorplan']['height_um'])) if cases else None


def slim(case):
    return {k:v for k,v in case.items() if k not in
            ('global_bom','row_final_bom','column_final_bom','total_bom')} if case else None


def array_only(target):
    cases = []
    for r in range(1,101):
        for c in range(1,101):
            w,h = footprint(r,c)
            if any(w<=tw+1e-6 and h<=th+1e-6 for tw,th in (target,target[::-1])):
                cases.append(dict(rows=r,columns=c,bits=r*c,
                                  width_um=round(w,1),height_um=round(h,1)))
    return max(cases,key=lambda a:a['bits'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--profile',choices=['dev','original'],default='dev')
    args = parser.parse_args()
    pdk = pdk_profiles.pdk_path(args.profile)
    base.PDK = verify_serial.PDK = pdk
    base.LIB = db.Layout()
    library = pdk/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds'
    base.LIB.read(str(library))
    # Cache dimensions after selecting the requested PDK, not the imported
    # helper's historical default library.
    base.dimension = lru_cache(None)(base.dimension)
    verify_serial.WORK = WORK/'netlist'
    source = verify_serial.fresh_netlist()
    macro_model.source_text = lambda:source
    audit = audit_schematic(source)
    dims = json.loads((HERE/'dimensions.json').read_text())
    assert hashlib.sha256((HERE/'pcell.gds').read_bytes()).hexdigest() == dims['gds_sha256']
    for d in dims['arrays'].values():
        assert all(abs(a-b)<1e-6 for a,b in zip(footprint(d['rows'],d['columns']),
                    (d['width_um'],d['height_um'])))
    # Independent saving check over every address width in the search.
    pair_area = base.area({'DFFR':1,'MUX2':1})
    for rb in range(2,7):
        for cb in range(2,7):
            _, old = architecture(rb,cb,False)
            _, new = architecture(rb,cb,True)
            n = rb+cb+1
            assert Counter(old['controller'])-Counter(new['controller']) == Counter(DFFR=n,MUX2=n)
            assert not Counter(new['controller'])-Counter(old['controller'])
            assert abs(base.area(old['controller'])-base.area(new['controller'])-n*pair_area)<1e-6
    results = []
    with (WORK/'sweep.csv').open('w') as f:
        writer = csv.writer(f)
        writer.writerow(['target_w','target_h','shared_frame','utilization','column_strip',
                         'rows','columns','bits','macro_w','macro_h','fits'])
        for target in TARGETS:
            for u,strip in SCENARIOS:
                modes = {}
                for shared in (False,True):
                    cases = [estimate(r,c,shared,u,strip,target)
                             for r in range(4,65) for c in range(4,65)]
                    for x in cases:
                        p=x['floorplan']
                        writer.writerow([*target,shared,u,strip,x['rows'],x['columns'],
                                         x['bits'],p['width_um'],p['height_um'],p['fits']])
                    fits = [x for x in cases if x['floorplan']['fits']]
                    modes['shared' if shared else 'double'] = dict(
                        best=slim(best(fits)),best_binary=slim(best([x for x in fits if binary(x)])),
                        best_16_rows=slim(best([x for x in fits if x['rows']==16])),
                        comparisons=[estimate(r,c,shared,u,strip,target) for r,c in
                            ((16,16),(16,32),(16,64),(32,32),(32,16))])
                results.append(dict(target_um=target,utilization=u,column_strip_um=strip,**modes))
                print(target,u,'best',modes['shared']['best']['bits'],
                      'binary',modes['shared']['best_binary']['bits'],
                      '16 rows',modes['shared']['best_16_rows']['bits'],flush=True)
    archive_path = HERE/'capacity.json'
    archive = json.loads(archive_path.read_text())
    area_checks = size_checks = 0
    for s in results:
        if s['target_um'] != (600,1800):
            continue
        for x in s['double']['comparisons']:
            old = next(a for a in archive['cases'] if (a['rows'],a['columns'],a['utilization'])
                       == (x['rows'],x['columns'],x['utilization']))
            assert old['array_area_um2'] == x['array_area_um2']
            assert old['digital_abut_area_um2'] == x['digital_abut_area_um2']
            area_checks += 1
            # The 512-bit and 1-Kbit reference floorplans also reproduce the
            # prior dimensions. Other fits may choose a smaller-area rotation
            # than the legacy aspect-ratio tie-breaker selected.
            if (x['rows'],x['columns']) in ((16,32),(16,64)):
                assert all(old['floorplan'][k] == x['floorplan'][k]
                           for k in ('width_um','height_um','fits'))
                size_checks += 1
    types = {n for s in results for x in s['shared']['comparisons'] for n in x['total_bom']}
    original = db.Layout()
    original.read(str(pdk_profiles.pdk_path('original')/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds'))
    same_dimensions = all(original.cell(n).dbbox() == base.LIB.cell(n).dbbox() for n in types)
    inputs = [Path(__file__),Path(macro_model.__file__),Path(base.__file__),
              Path(verify_serial.__file__),ROOT/'scripts/verify_serial_spice.py',
              ROOT/'scripts/pdk_profiles.py',ROOT/'pdk/profiles.lock.json',
              ROOT/'learning/schematics/sram_serial_controller.sch',ROOT/'learning/schematics/sram_tb_serial.sch',
              ROOT/'sram512/schematics/write_control.sch',ROOT/'sram512/rtl/sram_serial_controller.v',
              HERE/'dimensions.json',HERE/'pcell.gds',archive_path,library,
              verify_serial.WORK/'sram_tb_serial.spice']
    report = dict(schema=1,date='2026-09-12',pdk_profile=args.profile,
        pdk_revision=pdk_profiles.locked()['profiles'][args.profile]['revision'],
        scope='PCell arrays plus shared-frame serial peripherals; block estimate, not routed GDS or timing signoff; pads/ESD excluded.',
        assumptions=dict(cell_pitch_um=[22,29.6],tap_interval_columns=16,
            tap_gap_um=21.2,array_edge_width_um=43,row_final_band_um=137.6,
            common_analog_region_um=[120,60],global_margin_height_um=100,
            distribution_buffer_budget={'BUF_X4':12},stdcell_row_pitch_um=55,
            logic_inner_width='target edge minus 20 um; real cell widths packed by FFD',
            search='4..64 rows x 4..64 columns; both array and complete-frame orientations',
            non_binary='Keep full address-width controller and all predecode terms; prune only unused final decoder outputs.',
            analog='Column depth 120/150 um reserves final decoder, two PMOS prechargers and two NMOS column switches per column; common 11 MOS reserve 120x60 um.',
            unimplemented_optimizations='No compact control decode, NAND/NOR decoder replacement, hierarchical column MUX or custom FF/MUX.'),
        current_2x2_audit=audit,pair_saving_um2=pair_area,
        verification=dict(fresh_schematic_netlist=True,frame_wire_checks=3,
                          saving_checks_address_width_pairs=25,gds_dimensions_checked=len(dims['arrays']),
                          legacy_area_cases=area_checks,legacy_512_1k_size_cases=size_checks,
                          used_stdcell_dimensions_equal_original=same_dimensions,
                          new_peripheral_drc_lvs=False,new_spice_simulation=False),
        library_dimensions={},
        array_only=[dict(target_um=t,best=array_only(t)) for t in TARGETS],scenarios=results,
        input_sha256={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs})
    report['library_dimensions']={n:base.dimension(n) for n in sorted(types)}
    (HERE/'shared_capacity.json').write_text(json.dumps(report,indent=2)+'\n')


if __name__ == '__main__':
    main()
