#!/usr/bin/env python3
"""600 x 1800 trial using field GC for signal routing, metal-only supplies."""
import argparse,shutil
import layout
from routing_poly import RouterPoly
from physical_top import named_macro,verify_and_repair
from common import *

def main(iterations,step,compact_bank=False):
    seed=WORK/'extracted_sources/ed805adb64e4d5fe7ab323934d04ffab32dd944637720a5f622d8122dbfc9c92/placement.json'
    l,top,r,placed=layout.build(600,row_clamps=True,compact_clamps=True,power_trunks=True,seed_placement=seed,compact_bank=compact_bank)
    work=WORK/('layout/poly_router600'+('_g2750' if step==2750 else '')+'_metal_critical'+('_cb' if compact_bank else ''));work.mkdir(parents=True,exist_ok=True)
    shutil.copy2(placed/'placement.json',work/'placement.json');top.write(str(work/'placed.gds'))
    r=RouterPoly.from_router(r,step);success=r.route(work/'routing',iterations)
    top=named_macro(l,top,work,array_y=125 if compact_bank else 147)
    if not success:
        top.write(str(work/'sram512.gds'));write_json(work/'routing_failure.json',dict(passed=False,stage='global routing'))
        return False
    result=verify_and_repair(l,top,work);result.update(router_passed=success,bbox_um=str(top.dbbox()))
    write_json(REPORTS/(work.name+'.json'),result);print(result['drc'],result['lvs'],flush=True)
    return all(result[k]['passed'] for k in ('drc','lvs'))

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--iterations',type=int,default=1200);p.add_argument('--step',type=int,choices=[5500,2750],default=5500);p.add_argument('--compact-bank',action='store_true');a=p.parse_args();raise SystemExit(0 if main(a.iterations,a.step,a.compact_bank) else 1)
