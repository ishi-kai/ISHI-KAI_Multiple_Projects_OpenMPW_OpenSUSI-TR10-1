#!/usr/bin/env python3
"""Render the actual submitted geometry, with an annotated block overview."""
import argparse
from common import *
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import PolyCollection
from matplotlib.patches import Rectangle


def render(folder,output):
    folder=Path(folder);l=db.Layout();l.read(str(folder/'sram512.gds'))
    top=l.cell('sram512_macro');box=top.dbbox()
    fig,ax=plt.subplots(figsize=(18,7.4))
    for spec,color,alpha in [((140,0),'#e3d9b7',.75),((3,1),'#af4b32',.7),
                            ((3,2),'#8d679c',.7),((8,1),'#d96054',.8),
                            ((13,0),'#337fbe',.7),((20,0),'#32a893',.75)]:
        region=db.Region(top.begin_shapes_rec(l.layer(*spec)))
        polygons=[[(p.x/1000,p.y/1000) for p in shape.each_point_hull()] for shape in region.each()]
        ax.add_collection(PolyCollection(polygons,facecolors=color,edgecolors='none',alpha=alpha))
    ax.add_patch(Rectangle((0,0),1800,600,fill=False,color='#151e2d',lw=1.2))
    ax.text(450,615,'512 SRAM cells: 16 horizontal rows, 32 columns',ha='center',fontsize=13)
    ax.text(1380,615,'Serial control and predecoders',ha='center',fontsize=13)
    ax.text(430,35,'Column selection / precharge / nMOS MUX',ha='center',fontsize=11,
            bbox=dict(facecolor='white',alpha=.9,edgecolor='none'))
    ax.text(1030,40,'Shared write / SA',ha='center',fontsize=9,rotation=90,
            bbox=dict(facecolor='white',alpha=.85,edgecolor='none'))
    pins=json.loads((folder/'ports.json').read_text())
    for name,entry in pins.items():
        x,y=entry['position_um']
        if name in ('VDD','VSS'):
            ax.annotate(name,xy=(x,y),xytext=(x-10,640 if name=='VDD' else 665),
                        fontsize=10,ha='center',arrowprops=dict(arrowstyle='-',lw=.8))
        else:ax.annotate(name,xy=(x,y),xytext=(x,-38),fontsize=11,ha='center',arrowprops=dict(arrowstyle='-',lw=.8))
    ax.set_xlim(-20,1820);ax.set_ylim(-60,680);ax.set_aspect('equal')
    ax.set_xlabel('x [µm]');ax.set_ylabel('y [µm]');ax.set_yticks([0,100,200,300,400,500,600])
    ax.set_title(f'SRAM512 · actual GDS · {box.width():.1f} × {box.height():.1f} µm',loc='left',fontsize=17,pad=16)
    fig.text(.07,.02,'M1 blue · M2 green · gate red · well beige | '+sha(folder/'sram512.gds')[:16],fontsize=10)
    fig.tight_layout(rect=(0,.04,1,1));output=Path(output);output.parent.mkdir(parents=True,exist_ok=True)
    fig.savefig(output,dpi=150);plt.close(fig)
    return output


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('output',type=Path);a=p.parse_args()
    print(render(a.folder,a.output))
