#!/usr/bin/env python3
"""Render actual saved NANY GDS geometry without regenerating its PCells."""
import argparse
import json
from pathlib import Path
import klayout.db as db
from render_inverter import SPECS, plt, PlotPath, PathPatch, Patch

ROOT=Path(__file__).resolve().parents[1]


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--gds',type=Path,default=ROOT/'nany.gds')
    p.add_argument('--metadata',type=Path,default=ROOT/'layout/nany.ports.json')
    a=p.parse_args()
    meta=json.loads(a.metadata.read_text())
    layout=db.Layout();layout.read(str(a.gds));cell=layout.cell('nany')
    fig,ax=plt.subplots(figsize=(12,10));fig.patch.set_facecolor('#fafbfc');ax.set_facecolor('#fafbfc')
    for spec,label,color,alpha in SPECS:
        region=db.Region(cell.begin_shapes_rec(layout.layer(*spec))).merged()
        for poly in region.each():
            vertices,codes=[],[]
            for loop in [list(poly.each_point_hull())]+[list(poly.each_point_hole(h)) for h in range(poly.holes())]:
                points=[(p.x*layout.dbu,p.y*layout.dbu) for p in loop]
                vertices.extend(points+[points[0]])
                codes.extend([PlotPath.MOVETO]+[PlotPath.LINETO]*(len(points)-1)+[PlotPath.CLOSEPOLY])
            ax.add_patch(PathPatch(PlotPath(vertices,codes),facecolor=color,edgecolor=color,linewidth=.3,alpha=alpha))
    for inst in meta['instances']:
        if inst['role'].startswith('XM') or inst['role'] in ('R1','R2'):
            x,y=inst['origin_um'];pa=inst['parameters']
            ax.text(x,y,f"{inst['role']}\n{pa['w']:g}/{pa['l']:g}",ha='center',va='center',fontsize=8,
                    bbox=dict(facecolor='white',alpha=.88,edgecolor='none',pad=1))
    for name,port in meta['ports'].items():
        x,y=port['position_um'];ha='left' if port['edge']=='left' else 'right' if port['edge']=='right' else 'center'
        ax.text(x,y,name,ha=ha,va='center',fontsize=10,fontweight='bold',bbox=dict(facecolor='white',alpha=.88,edgecolor='none',pad=1))
    ax.set(xlim=(-3,meta['width_um']+3),ylim=(-3,meta['height_um']+3),xlabel='x [um]',ylabel='y [um]')
    ax.set_aspect('equal')
    ax.set_title(f"Balanced ternary NANY | {meta['width_um']:g} x {meta['height_um']:g} um\n8 MOS + 2 RR | a, b, vout, VDD, VSS, VMID",loc='left',pad=20)
    ax.legend(handles=[Patch(facecolor=c,label=l,alpha=al) for _,l,c,al in SPECS],loc='upper left',bbox_to_anchor=(1.01,1))
    fig.tight_layout();fig.savefig(ROOT/'layout/nany.png',dpi=170);plt.close(fig)


if __name__=='__main__':main()
