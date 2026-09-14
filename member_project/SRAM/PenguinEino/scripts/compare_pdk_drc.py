#!/usr/bin/env python3
"""Check identical saved GDS against both unmodified PDK profiles."""
from concurrent.futures import ThreadPoolExecutor
import json
from pdk_profiles import ROOT,run_drc

CASES=[
    ('learning/layout/sram.gds','sram_array'),
    ('learning/layout/sram_dense.gds','sram_dense_1x1'),
    ('klayout/sram_compact/compact.gds','compact_4x4'),
    ('klayout/sram_pcell/pcell.gds','pcell_4x4'),
    ('klayout/sram_compact/compact.gds','compact_20x76'),
    ('klayout/sram_pcell/pcell.gds','pcell_20x76'),
]

def main():
    def one(case):
        source,top,profile=case
        r=run_drc(ROOT/source,top,profile)
        print(f'{profile}: {top}: {r["items"]} items {r["categories"]}',flush=True)
        return r
    with ThreadPoolExecutor(max_workers=2) as pool:
        rows=list(pool.map(one,[(s,t,p) for s,t in CASES for p in ('original','dev')]))
    report=dict(scope='Unmodified saved GDS; Drawing Layer DRC only; violations retained, no layout repair.',results=rows)
    (ROOT/'pdk/drc_comparison.json').write_text(json.dumps(report,indent=2)+'\n')

if __name__=='__main__':main()
