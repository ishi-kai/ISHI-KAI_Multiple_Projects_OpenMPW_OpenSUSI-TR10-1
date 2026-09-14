#!/usr/bin/env python3
"""Dev PCell macros with a 22 um tap-bank gap for peripheral abutment."""
from layout_analog import *

def main():
    results=[]
    for name in ('array','columns'):
        work=WORK/f'layout/macros/{name}';work.mkdir(parents=True,exist_ok=True)
        l=db.Layout();l.dbu=.001;l.technology_name='TR-1um'
        if name=='array':
            core=pc.bitcell(l,family='six_single');top=pc.array(l,core,16,32,gap=22)
            source=pc.reference(top.name,16,32)
        else:top=column_bank(l,32,gap=22,ground_below_logic=True);source=reference(top.name,32)
        path=work/'macro.gds';top.write(str(path));ref=work/'reference.spice';ref.write_text(source)
        result=verify_layout(path,top.name,ref,work/'checks');result['bbox_um']=str(top.dbbox())
        results.append(result);print(name,result['drc'],result['lvs'],flush=True)
    write_json(REPORTS/'layout_macros.json',results)
    if not all(r[k]['passed'] for r in results for k in ('drc','lvs')):raise SystemExit(1)

if __name__=='__main__':main()
