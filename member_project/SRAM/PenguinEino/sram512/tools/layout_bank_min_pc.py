#!/usr/bin/env python3
"""Evaluate a shorter bank with 3.4 um bitline precharge PMOS devices."""
import layout_bank as bank
from routing_poly import RouterPoly
from common import *

bank.COMPACT=True;bank.DECODE_GC_BUS=True;bank.MINIMUM_PC=True
bank.AY=118.2;bank.CY=82.5
bank.macros();layout,top,base,work=bank.build()
router=RouterPoly.from_router(base,2750);success=router.route(work/'routing',150)
gds=work/'bank.gds';top.write(str(gds));ref=work/'reference.spice';ref.write_text(bank.ref(top.name))
result=verify_layout(gds,top.name,ref,work/'checks')
box=top.dbbox();result.update(router_passed=success,dimensions_um=[box.width(),box.height()],
    precharge_width_um=3.4,scope='Separate physical candidate; full-array electrical validation is required.')
write_json(REPORTS/'layout_bank_min_pc.json',result)
print(result['drc'],result['lvs'],result['dimensions_um'],flush=True)
raise SystemExit(0 if success and all(result[k]['passed'] for k in ('drc','lvs')) else 1)
