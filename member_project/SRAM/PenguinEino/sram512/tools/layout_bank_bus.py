#!/usr/bin/env python3
"""Compact 16x16 bank with three explicit field-GC decode buses."""
import layout_bank as bank
from routing_poly import RouterPoly
from common import *

bank.COMPACT=True;bank.DECODE_GC_BUS=True;bank.AY=125;bank.CY=82.5
bank.macros();l,top,original,work=bank.build()
r=RouterPoly.from_router(original,2750);success=r.route(work/'routing',800)
gds=work/'bank.gds';top.write(str(gds));ref=work/'reference.spice';ref.write_text(bank.ref(top.name))
result=verify_layout(gds,top.name,ref,work/'checks');result['router_passed']=success
write_json(REPORTS/'layout_bank_compact_bus.json',result);print(result['drc'],result['lvs'],flush=True)
raise SystemExit(0 if success and all(result[k]['passed'] for k in ('drc','lvs')) else 1)
