#!/usr/bin/env python3
"""Bounded, reproducible PCell layout search with actual 4x4 DRC/LVS."""
from pathlib import Path
import json
from build import make,HERE,ROOT
from verify import verify

CASES=[
    ('wide_split','split',23.2,29.6,2.0),
    ('split','split',22.0,29.6,2.0),
    ('six_single','six_single',22.0,29.6,2.0),
    ('column_21p9','six_single',21.9,29.6,2.0),
    ('row_29p5','six_single',22.0,29.5,2.0),
    ('contact_1p9','six_single',21.9,29.6,1.9),
    ('row_28p5','six_single',22.0,28.5,2.0),
    ('single_strip','single_strip',22.0,29.6,0.0),
]

def main():
    results=[]
    for name,family,x,y,sep in CASES:
        out=ROOT/'build/sram_pcell/scan'/name
        dims=make(out,x,y,sep,family,shapes=((4,4),))
        checks=verify(out,'pcell_4x4',verbose=False)
        row=dict(name=name,family=family,pitch_um=[x,y],area_per_bit_um2=x*y,
                 shared_contact_separation_um=sep,**checks)
        results.append(row)
        print(json.dumps(row),flush=True)
        (HERE/'scan.json').write_text(json.dumps(results,indent=2)+'\n')

if __name__=='__main__':main()
