#!/usr/bin/env python3
import sys
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/'dense_sram'))
from verify import check
from build import reference
import klayout.rdb as rdb
variant=sys.argv[1];r,c=map(int,sys.argv[2:4]) if len(sys.argv)>2 else (2,2)
top=f'{variant if variant.startswith(("euler","baseline_shared")) else "sram_dense"}_{r}x{c}'
out=HERE.parents[1]/'build/sram_research'/variant;out.mkdir(parents=True,exist_ok=True)
ref=out/(top+'.spice');ref.write_text(reference(top,r,c))
def one(k):
 result=check(HERE/(variant+'.gds'),top,k,out,ref)
 print(k,result,flush=True)
with ThreadPoolExecutor(max_workers=2) as p:list(p.map(one,('drc','lvs')))
rdbase=rdb.ReportDatabase();rdbase.load(str(out/(top+'.drcdb')))
for item in list(rdbase.each_item())[:60]:
 print(rdbase.category_by_id(item.category_id()).name(),[str(v) for v in item.each_value()])
