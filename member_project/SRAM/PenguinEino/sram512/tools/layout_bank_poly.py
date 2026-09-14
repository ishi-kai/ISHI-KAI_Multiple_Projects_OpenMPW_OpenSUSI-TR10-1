#!/usr/bin/env python3
"""Route the shorter half-bank using real field-GC decode connections."""
import layout_bank as bank
from routing_poly import RouterPoly
from common import *

bank.COMPACT=True;bank.AY=125;bank.CY=82.5
l,top,original,_=bank.build()
work=WORK/'layout/bank_compact_poly';work.mkdir(parents=True,exist_ok=True)
top.write(str(work/'placed.gds'))
r=RouterPoly.from_router(original,2750);success=r.route(work/'routing',800)
gds=work/'bank.gds';top.write(str(gds));ref=work/'reference.spice';ref.write_text(bank.ref(top.name))
if not success:raise SystemExit('Bank routing is incomplete')
result=verify_layout(gds,top.name,ref,work/'checks');result['router_passed']=success
write_json(REPORTS/'layout_bank_compact_poly.json',result);print(result['drc'],result['lvs'],flush=True)
raise SystemExit(0 if all(result[k]['passed'] for k in ('drc','lvs')) else 1)
