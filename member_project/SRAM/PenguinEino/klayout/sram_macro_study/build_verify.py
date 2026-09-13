#!/usr/bin/env python3
"""Saved-GDS verification of WL strap intervals and stdcell abutment coupons."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib, json, re, sys
import klayout.db as db
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path[:0]=[str(HERE.parent/'sram_research'),str(HERE.parent/'dense_sram')]
from build_candidates import euler,euler_array
from build import reference,Drawing
from verify import check,PDK
from macro_model import Circuit,source_text
OUT=ROOT/'build/sram_macro_study/layout'


def arrays():
    cases=[];l=db.Layout();l.dbu=.1;core=euler(l)
    for interval in (4,8,16):
        for r,c in ((4,17),(16,16),(16,32)):
            top=euler_array(l,core,r,c,interval=interval,gap=21.2,shared=True)
            top.name=f'wlstrap{interval}_{r}x{c}'
            cases.append((top.name,reference(top.name,r,c)))
    path=HERE/'wlstrap_arrays.gds';l.write(str(path))
    return [(path,top,ref) for top,ref in cases]


def stdcell_coupon():
    l=db.Layout();l.read(str(PDK/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds'))
    # SPICE canonicalizes pin names to uppercase. Keep strict named-port checks
    # enabled for the leaf cells too, including their supply pins.
    for cell in l.each_cell():
        for shape in cell.shapes(l.layer(48,0)).each():
            if shape.is_text():
                text=shape.text;text.string=text.string.upper();shape.text=text
    # OR3 has no VDD text in the installed library although its upper supply
    # rail is physically present. Supply a real on-metal label in this copy.
    Drawing(l,l.cell('OR3')).label('M1','VDD',0,55)
    # The source schematic and GDS order the commutative OR inputs differently.
    # Align labels to the actual transistor stack correspondence in the copy;
    # keep the independently netlisted schematic and strict port check intact.
    for kind,swap in [('OR3',{'B':'C','C':'B'}),('OR4',{'A':'B','B':'A'})]:
        for shape in l.cell(kind).shapes(l.layer(48,0)).each():
            if shape.is_text() and shape.text.string in swap:
                text=shape.text;text.string=swap[text.string];shape.text=text
    # The installed AND3_X1 GC contains two coordinates at 23.705 um, off the
    # 0.05-um mask grid. Repair this COPY only, keeping the PDK untouched.
    local=l.cell('AND3_X1');li=l.layer(8,1);fixed=db.Region()
    for shape in local.shapes(li).each():
        poly=shape.polygon
        if poly:
            grid=round(.05/l.dbu)
            points=[db.Point(round(p.x/grid)*grid,round(p.y/grid)*grid) for p in poly.each_point_hull()]
            fixed.insert(db.Polygon(points))
    local.shapes(li).clear();local.shapes(li).insert(fixed.merged())
    c=Circuit(source_text());top=l.create_cell('stdcell_abutment')
    types=['INV_X1','NAND2','AND2_X1','AND3_X1','AND4_X1','OR2','OR3','OR4','XOR2','MUX2','DFFR']
    lines=[];ports=['VDD','VSS'];instances=[]
    for r in range(2):
        x=0
        for col,kind in enumerate(types):
            cell=l.cell(kind);name=f'u{r}_{col}'
            trans=db.Trans(db.Trans.M0 if r else db.Trans.R0,round(x/l.dbu),round((110 if r else 0)/l.dbu))
            top.insert(db.CellInstArray(cell.cell_index(),trans))
            mapping={}
            for pin in c.defs[kind.lower()][1]:
                net={'GND':'VSS','VDD':'VDD'}.get(pin,(name+'_'+pin).upper())
                mapping[pin]=net
                if net not in ports:ports.append(net)
            for shape in cell.shapes(l.layer(48,0)).each():
                if not shape.is_text():continue
                pin=shape.text.string.upper()
                assert pin in mapping,(kind,pin)
                label=shape.text.transformed(trans);label.string=mapping[pin]
                top.shapes(l.layer(48,0)).insert(label)
            lines.append('X'+name+' '+' '.join(mapping[p] for p in c.defs[kind.lower()][1])+' '+kind)
            # Nominal stdcell width measured between end substrate/well contacts.
            pitch=round(cell.dbbox().width()-12.6,1)
            instances.append(dict(name=name,cell=kind,x_um=x,y_um=110 if r else 0,
                                  mirror=bool(r),pitch_width_um=pitch))
            x+=pitch
    d=Drawing(l,top)
    # Both mirrored rows have separate VSS rails; physically join them in M2.
    # Repeated text labels alone would not be an electrical connection.
    for y in (0,110):
        d.wire('M1',[(-4.8,y),(0,y)],2.6);d.via(-4.8,y)
    d.wire('M2',[(-4.8,0),(-4.8,110)],3.4)
    defs='\n'.join(c.defs[n.lower()][2] for n in types)
    # LVS reads four-terminal MOS, while simulation uses the PDK model wrapper.
    defs=re.sub(r'(?im)^X(M\S+)\s+',r'\1 ',defs)
    ref='* Independent schematic standard-cell instances\n.subckt '+top.name+' '+' '.join(ports)+'\n'
    ref+='\n'.join(lines)+'\n.ends '+top.name+'\n'+defs+'\n'
    path=HERE/'stdcell_abutment.gds';top.write(str(path))
    (HERE/'stdcell_abutment.json').write_text(json.dumps(dict(instances=instances,
        bbox_um=[top.dbbox().width(),top.dbbox().height()],row_pitch_um=55,
        local_copy_fixes=['AND3_X1 GC: 23.705 -> 23.700 um on two vertices',
                          'Uppercase supply labels; add missing OR3 VDD label',
                          'Align OR3 B/C and OR4 A/B labels with schematic stack order',
                          'Original PDK unchanged']),indent=2)+'\n')
    return [(path,top.name,ref)]


def main():
    OUT.mkdir(parents=True,exist_ok=True)
    cases=arrays()+stdcell_coupon()
    def one(case):
        path,top,ref=case;work=OUT/top;work.mkdir(exist_ok=True)
        reference_file=work/'reference.spice';reference_file.write_text(ref)
        key=hashlib.sha256(path.read_bytes()+ref.encode()).hexdigest()
        for kind in ('drc','lvs'):
            for p in sorted((PDK/'libs.tech/klayout/tech'/kind).glob('*')):
                if p.is_file():key=hashlib.sha256(key.encode()+p.read_bytes()).hexdigest()
        cache=work/'result.json'
        if cache.exists() and json.loads(cache.read_text()).get('input_sha256')==key:
            result=json.loads(cache.read_text())
        else:
            result={'top':top,'gds':str(path.relative_to(ROOT)),'input_sha256':key}
            for kind in ('drc','lvs'):
                ok,detail=check(path,top,kind,work,reference_file)
                result[kind]={'pass':ok,**detail}
            cache.write_text(json.dumps(result,indent=2)+'\n')
        print(top,result['drc']['pass'],result['lvs']['pass'],flush=True)
        return result
    with ThreadPoolExecutor(max_workers=2) as pool:results=list(pool.map(one,cases))
    (HERE/'layout_results.json').write_text(json.dumps(results,indent=2)+'\n')
    assert all(r[k]['pass'] for r in results for k in ('drc','lvs'))


if __name__=='__main__':main()
