#!/usr/bin/env python3
"""Unrotated 16-row half-array; final column logic is placed beside it."""
from layout_analog import *

AY=42.5

def main():
    work=WORK/'layout/bank_core16';work.mkdir(parents=True,exist_ok=True)
    layout=db.Layout();layout.dbu=.001;layout.technology_name='TR-1um'
    bit=pc.bitcell(layout,family='six_single');array=pc.array(layout,bit,16,16,gap=22)
    columns=column_bank(layout,16,gap=22)
    top=layout.create_cell('sram512_bank_core');d=pc.Drawing(layout,top)
    top.insert(db.CellInstArray(array.cell_index(),db.Trans(0,round(AY*1000))))
    top.insert(db.CellInstArray(columns.cell_index(),db.Trans()))
    for col in range(16):
        for name,dx in [('BL',-.4),('BLB',18.4)]:
            x=col*22+dx;d.wire('M1',[(x,38),(x,AY+5.7)],1.8)
        d.label('M2',f'COL{col}',col*22+11,-11)
    for bx,side in [(0,-1),(352,1)]:
        for name,off,y0 in [('VDD',14.4,31.5),('VSS',19.8,-35)]:
            x=bx+side*off
            d.wire('M1',[(x,y0),(x,AY+464.9)],3.4)
    for row in range(16):
        y=AY+(row*29.6+2.7 if row%2==0 else (row+1)*29.6-2.7)
        gy=round(y/5.5)*5.5;direction=gy-y
        long_leg=(row%2==1 and direction>=0) or (row%2==0 and direction<0)
        reach=33 if long_leg else 27.5
        # Leave the dense array before jogging onto a metal routing track.
        # Both sides are exposed so the right half can be driven from right.
        for x0,x in [(-9.6,-reach),(361.6,352+reach)]:
            d.wire('M2',[(x0,y),(x,y),(x,gy)],3.4)
        d.label('M2',f'WL{row}',0,y)
    for name,y in [('Y',5.5),('YB',0),('PREB',11.5),('VDD',31.5)]:
        d.label('M2',name,366.4,y)
    d.label('M2','VSS',371.8,-35)
    pc.fill_metal_notches(layout,top)
    arr_ref=pc.reference(array.name,16,16);col_ref=reference(columns.name,16)
    defs=parse(arr_ref+'\n'+col_ref)
    ports=[f'WL{i}' for i in range(16)]+[f'COL{i}' for i in range(16)]+['Y','YB','PREB','VDD','VSS']
    text='* Physical 16-row half-array, without a column decoder\n.subckt '+top.name+' '+' '.join(ports)+'\n'
    text+='Xarray '+' '.join(defs[array.name.lower()]['pins'])+' '+array.name+'\n'
    text+='Xcolumns '+' '.join(defs[columns.name.lower()]['pins'])+' '+columns.name+'\n'
    text+='.ends '+top.name+'\n'+arr_ref+'\n'+col_ref
    gds=work/'bank.gds';ref=work/'reference.spice';top.write(str(gds));ref.write_text(text)
    result=verify_layout(gds,top.name,ref,work/'checks');result['bbox_um']=str(top.dbbox())
    write_json(REPORTS/'layout_bank_core16.json',result)
    print(result['drc'],result['lvs'],result['bbox_um'],flush=True)
    return all(result[k]['passed'] for k in ('drc','lvs'))

if __name__=='__main__':raise SystemExit(0 if main() else 1)
