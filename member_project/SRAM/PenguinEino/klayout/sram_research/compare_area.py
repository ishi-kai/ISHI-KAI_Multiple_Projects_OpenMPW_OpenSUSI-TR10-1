#!/usr/bin/env python3
"""Enumerate rectangular arrays in both orientations, including generated edge overhead."""
from pathlib import Path
import json
import klayout.db as db
HERE=Path(__file__).resolve().parent
CONFIGS={
 'baseline':{'x':21.2,'y':34.0,'gap':26.2,'edge_x':26.2,'even_y':3.4,'odd_y':10.0,'file':'baseline_fit.gds','prefix':'sram_dense'},
 'baseline_shared':{'x':21.2,'y':34.0,'gap':14.4,'edge_x':26.2,'even_y':3.4,'odd_y':10.0,'file':'baseline_shared.gds','prefix':'baseline_shared'},
 'euler':{'x':23.2,'y':29.6,'gap':39.6,'edge_x':43.0,'even_y':0,'odd_y':12.2,'file':'euler.gds','prefix':'euler'},
 'euler_shared':{'x':23.2,'y':29.6,'gap':21.2,'edge_x':43.0,'even_y':0,'odd_y':12.2,'file':'euler_shared.gds','prefix':'euler_shared'}}


def dimensions(conf,r,c):
    return (round(c*conf['x']+((c-1)//16)*conf['gap']+conf['edge_x'],1),
            round(r*conf['y']+(conf['odd_y'] if r%2 else conf['even_y']),1))


def main():
    results={}
    for variant,conf in CONFIGS.items():
        l=db.Layout();l.read(str(HERE/conf['file']))
        for cell in l.each_cell():
            suffix=cell.name.removeprefix(conf['prefix']+'_')
            if 'x' not in suffix or not all(v.isdigit() for v in suffix.split('x')):continue
            r,c=map(int,suffix.split('x'));b=cell.dbbox()
            assert dimensions(conf,r,c)==(round(b.width(),1),round(b.height(),1)),cell.name
        orientations=[]
        for rotated,(max_x,max_y) in ((False,(600,1800)),(True,(1800,600))):
            feasible=[]
            for r in range(1,101):
                for c in range(1,101):
                    w,h=dimensions(conf,r,c)
                    if w<=max_x and h<=max_y:feasible.append({'rows':r,'cols':c,'bits':r*c,'width_um':w,'height_um':h,'rotated':rotated})
            orientations.append(max(feasible,key=lambda v:(v['bits'],-v['width_um']*v['height_um'])))
        best=max(orientations,key=lambda v:v['bits'])
        # Winning dimensions must correspond to an actual generated and verified GDS cell.
        cell=l.cell(f"{conf['prefix']}_{best['rows']}x{best['cols']}")
        assert cell is not None,best
        w,h=dimensions(conf,16,64)
        results[variant]={'pitch_um':[conf['x'],conf['y']],
                         'cell_area_um2':round(conf['x']*conf['y'],2),
                         'array_1024_um':[w,h],'array_1024_area_um2':round(w*h,2),
                         'best_by_orientation':orientations,'best':best}
    old=results['baseline'];new=results['euler_shared']
    report={'envelope_um':[600,1800],'scope':'One rectangular array, both orientations, rows and columns 1..100, 16-column tap period; includes GDS taps and power straps, excludes peripheral circuits/pads.',
            'designs':results,
            'improvement':{'cell_area_reduction_percent':100*(1-new['cell_area_um2']/old['cell_area_um2']),
                           'cell_density_increase_percent':100*(old['cell_area_um2']/new['cell_area_um2']-1),
                           'array_1024_area_reduction_percent':100*(1-new['array_1024_area_um2']/old['array_1024_area_um2']),
                           'capacity_increase_percent':100*(new['best']['bits']/old['best']['bits']-1)}}
    (HERE/'area_comparison.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report,indent=2))


if __name__=='__main__':main()
