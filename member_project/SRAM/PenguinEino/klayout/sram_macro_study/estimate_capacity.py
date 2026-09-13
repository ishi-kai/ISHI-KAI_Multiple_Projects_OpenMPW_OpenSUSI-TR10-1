#!/usr/bin/env python3
"""Area AND bounding-box estimates; peripheral routing is still unimplemented.

Native 55-um standard-cell rows are supported by a DRC/LVS abutment coupon.
Column-periphery depth and placement utilization remain explicit assumptions.
"""
from pathlib import Path
from collections import Counter
import hashlib,json,math,re
import klayout.db as db
from macro_model import digital,source_text,Circuit
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
import sys
sys.path.insert(0,str(ROOT/'scripts'))
from project_paths import schematic_path

PDK=Path('/home/ishi-kai/pdk/TR-1um')
LIB=db.Layout();LIB.read(str(PDK/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds'))


def dimension(name):
    c=LIB.cell(name);b=c.dbbox()
    return dict(width_um=round(b.width(),1),height_um=round(b.height(),1),
                bbox_area_um2=round(b.area(),2),
                abut_width_um=round(b.width()-12.6,1),abut_row_pitch_um=55)


def area(bom):return sum(dimension(n)['abut_width_um']*55*v for n,v in bom.items())


def schematic_bom(name):
    return Counter(re.findall(r'^C \{TR-1um_5_stdcell/([^/}]+)\.sym\}',schematic_path(name).read_text(),re.M))


def pack_rows(bom,utilization,width=580):
    # FFD packs real cell widths; the unused fraction is reserved for routing.
    cells=sorted([(dimension(n)['abut_width_um'],n) for n,count in bom.items()
                  for _ in range(count)],reverse=True)
    rows=[];used=[]
    for w,n in cells:
        for i,x in enumerate(used):
            if x+w <= width*utilization+1e-6:
                rows[i].append(dict(cell=n,x_um=round(x,1),width_um=w));used[i]+=w;break
        else:rows.append([dict(cell=n,x_um=0,width_um=w)]);used.append(w)
    # Alternating rows add 7.6 um (odd) / 2.6 um (even) beyond nominal height;
    # keep another 5 um for end treatment rather than using the exact bbox.
    fringe=12.6 if len(rows)%2 else 7.6
    return dict(rows=rows,height_um=55*len(rows)+fringe,width_um=width,
                occupancy=area(bom)/(width*55*len(rows)))


def estimate(r,c,u,strip,interval=16,separate=False):
    rb=(r-1).bit_length();cb=(c-1).bit_length()
    cir,meta,groups=digital(rb,cb,combined=not separate)
    # Prune unimplemented addresses only at final decode outputs. Predecode and
    # controller still support the full address width, leaving address holes.
    finalrow=('AND2_X1' if rb<=3 else 'AND3_X1')
    finalcol='AND2_X1' if cb>=4 else None
    if separate or finalcol is None or rb<2:return None
    row=Counter(groups['row_decoder']);col=Counter(groups['col_decoder'])
    row[finalrow]-=2**rb-r;col[finalcol]-=2**cb-c
    rowpre=row.copy();rowpre[finalrow]-=r
    colpre=col.copy();colpre[finalcol]-=c
    globalbom=Counter(groups['controller'])+rowpre+colpre
    globalbom+=schematic_bom('write_control.sch')
    # Budget, not sized/verified clock-tree synthesis: clock/reset/precharge and
    # control/output distribution get 12 BUF_X4 equivalents.
    globalbom['BUF_X4']+=12
    packed=pack_rows(globalbom,u)
    aw=c*23.2+((c-1)//interval)*21.2+43
    ah=r*29.6+(12.2 if r%2 else 0)
    rowband=137.6  # two 55-um rows + 2.6 bbox fringe + 5 end allowance + 20 routing
    common=60     # 120 x 60 um reserved for common 11-MOS analog circuitry
    # Either array orientation; local column/row regions follow its edges.
    alternatives=[]
    for rotation in (0,90):
        upperw,upperh=(aw+rowband,ah+strip) if rotation==0 else (ah+strip,aw+rowband)
        totalh=upperh+20+packed['height_um']+common+20
        totalw=max(upperw,592.6)  # native rows plus well end overhang
        alternatives.append(dict(rotation_deg=rotation,width_um=round(totalw,1),
            height_um=round(totalh,1),upper_width_um=round(upperw,1),upper_height_um=round(upperh,1),
            fits=totalw<=600+1e-6 and totalh<=1800+1e-6))
    chosen=min(alternatives,key=lambda a:(not a['fits'], max(a['width_um']/600,a['height_um']/1800)))
    digitalarea=area(globalbom)+r*dimension(finalrow)['abut_width_um']*55+c*dimension(finalcol)['abut_width_um']*55
    # Regions, rather than raw MOS area, determine fit. Do not double-count local
    # final gates in the bottom global-logic pool.
    return dict(rows=r,columns=c,bits=r*c,rb=rb,cb=cb,strap_interval=interval,
        array_width_um=round(aw,1),array_height_um=round(ah,1),array_area_um2=round(aw*ah,2),
        digital_abut_area_um2=round(digitalarea,2),per_column_mos=4,common_analog_mos=11,
        target_utilization=u,column_strip_um=strip,global_stdcell_bom=dict(globalbom),
        row_decoder_bom=dict(+row),column_decoder_bom=dict(+col),controller=meta,
        global_logic_rows=len(packed['rows']),global_logic_height_um=packed['height_um'],
        global_actual_occupancy=packed['occupancy'],local_row_region_um=rowband,
        common_analog_region_um=[120,60],floorplan=chosen,
        packed_rows=packed['rows'])


def main():
    original={n:dict(schematic_bom(n+'.sch')) for n in ['sram_serial_controller','row_decoder_1to2','col_decoder_1to2','write_control']}
    types=set(sum((list(b) for b in original.values()),[]))|{'BUF_X4'}
    inventory={n:dimension(n) for n in sorted(types)}
    exact={n:dict(cells=sum(b.values()),bom=b,abut_area_um2=area(b),
            isolated_bbox_sum_um2=sum(dimension(k)['bbox_area_um2']*v for k,v in b.items())) for n,b in original.items()}
    cases=[]
    for u,strip in ((.65,150),(.75,120),(.85,120)):
        for r in range(4,49):
            for c in range(16,65):
                cases.append(estimate(r,c,u,strip))
    def compact(x,placements=False):
        return {k:v for k,v in x.items() if placements or k!='packed_rows'} if x else None
    scenarios=[]
    for u,strip in ((.65,150),(.75,120),(.85,120)):
        subset=[x for x in cases if x and x['target_utilization']==u and x['column_strip_um']==strip]
        fits=[x for x in subset if x['floorplan']['fits']]
        binary=[x for x in fits if x['rows']&(x['rows']-1)==0 and x['columns']&(x['columns']-1)==0]
        best=max(fits,key=lambda x:(x['bits'],-x['floorplan']['height_um'])) if fits else None
        best_binary=max(binary,key=lambda x:(x['bits'],-x['floorplan']['height_um'])) if binary else None
        scenarios.append(dict(utilization=u,column_strip_um=strip,best=compact(best),best_binary=compact(best_binary,True)))
    # Useful comparisons at the same interface and different array shape.
    comparisons=[estimate(r,c,u,s) for u,s in ((.65,150),(.75,120),(.85,120))
                 for r,c in ((8,16),(8,32),(16,16),(16,32),(32,16),(8,64),(16,64))]
    strap_tradeoff=[estimate(r,c,u,s,interval=i) for i in (4,8,16)
                   for r,c,u,s in ((16,16,.65,150),(16,32,.85,120))]
    report=dict(scope='600 x 1800 um core including serial controller; no pads/ESD; block estimates, not routed peripheral GDS',
        sources_sha256={n:hashlib.sha256(schematic_path(n+'.sch').read_bytes()).hexdigest() for n in original},
        library_sha256=hashlib.sha256((PDK/'libs.tech/klayout/libraries/TR-1um_STDCELL.gds').read_bytes()).hexdigest(),
        library_dimensions=inventory,original_2x2=exact,scenarios=scenarios,comparisons=[compact(x) for x in comparisons],
        strap_tradeoff=[compact(x) for x in strap_tradeoff])
    (HERE/'capacity.json').write_text(json.dumps(report,indent=2)+'\n')
    with (HERE/'capacity_sweep.csv').open('w') as f:
        f.write('rows,columns,bits,utilization,column_strip_um,width_um,height_um,fits\n')
        for x in cases:
            if x:f.write(f"{x['rows']},{x['columns']},{x['bits']},{x['target_utilization']},{x['column_strip_um']},{x['floorplan']['width_um']},{x['floorplan']['height_um']},{x['floorplan']['fits']}\n")
    for s in scenarios:
        print(s['utilization'],s['column_strip_um'],[(kind,(s[kind]['bits'],s[kind]['rows'],s[kind]['columns'],s[kind]['floorplan']) if s[kind] else None) for kind in ('best','best_binary')])


if __name__=='__main__':main()
