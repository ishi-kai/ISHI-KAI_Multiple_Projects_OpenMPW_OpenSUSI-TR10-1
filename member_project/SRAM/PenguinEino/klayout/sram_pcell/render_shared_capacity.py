#!/usr/bin/env python3
"""Draw reserved blocks in the shared-frame estimate; these are not GDS."""
from pathlib import Path
import json
import os
os.environ.setdefault('MPLCONFIGDIR','/tmp/sram-shared-capacity-matplotlib')
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, Patch

HERE=Path(__file__).resolve().parent
COLORS={'Array':'#86bfa9','Row decode':'#c4b1db','Column circuits':'#e7be7c',
        'Global logic':'#92b4d1','Common analog':'#df9a99'}


def boxes(case):
    p=case['floorplan'];aw=case['array_width_um'];ah=case['array_height_um']
    strip=case['column_strip_um'];band=137.6
    blocks=[('Array',band,0,aw,ah),('Row decode',0,0,band,ah),
            ('Column circuits',band,ah,aw,strip)]
    if p['array_rotation_deg']:
        blocks=[(n,ah+strip-y-h,x,h,w) for n,x,y,w,h in blocks]
    y=p['upper_height_um']+20
    blocks += [('Global logic',0,y,p['global_logic_width_um']+12.6,p['global_logic_height_um']),
               ('Common analog',0,y+p['global_logic_height_um'],120,60)]
    if p['frame_rotation_deg']:
        blocks=[(n,case['target_um'][0]-y-h,x,h,w) for n,x,y,w,h in blocks]
    return blocks


def main():
    report=json.loads((HERE/'shared_capacity.json').read_text());s=report['scenarios']
    examples=[s[1]['shared']['best_binary'],s[2]['shared']['best'],
              s[4]['shared']['best_binary'],s[5]['shared']['comparisons'][2]]
    fig,axes=plt.subplots(2,2,figsize=(12,10),layout='constrained')
    for ax,case in zip(axes.flat,examples):
        tw,th=case['target_um'];p=case['floorplan'];blocks=boxes(case)
        for name,x,y,w,h in blocks:
            ax.add_patch(Rectangle((x,y),w,h,facecolor=COLORS[name],edgecolor='white',lw=1))
            if name in ('Array','Global logic'):
                label=(f"{case['rows']} rows x {case['columns']} cols\n{case['bits']} bit"
                       if name=='Array' else f"Global logic\n{p['global_logic_rows']} rows")
                ax.text(x+w/2,y+h/2,label,ha='center',va='center',fontsize=9)
        ax.add_patch(Rectangle((0,0),tw,th,fill=False,edgecolor='#1c3040',lw=1.8))
        xmin=min(0,min(b[1] for b in blocks));xmax=max(tw,max(b[1]+b[3] for b in blocks))
        ymax=max(th,max(b[2]+b[4] for b in blocks))
        ax.set(xlim=(xmin-40,xmax+40),ylim=(ymax+40,-40),aspect='equal',xlabel='um',ylabel='um')
        status='FITS BUDGET' if p['fits'] else 'EXCEEDS BUDGET'
        ax.set_title(f"{tw} x {th} um | {case['bits']} bit | {status}\n"
                     f"Logic fill {case['utilization']:.0%}; column depth {case['column_strip_um']} um",
                     fontsize=10,color='#244f3e' if p['fits'] else '#9c3333')
        ax.spines[['top','right']].set_visible(False)
    fig.suptitle('TR-1um PCell SRAM after register sharing\nReserved blocks only: peripheral placement / routing not verified',fontsize=14)
    fig.legend([Patch(facecolor=c) for c in COLORS.values()],list(COLORS),
               loc='outside lower center',ncol=5,frameon=False)
    fig.savefig(HERE/'shared_capacity.png',dpi=160)


if __name__=='__main__':main()
