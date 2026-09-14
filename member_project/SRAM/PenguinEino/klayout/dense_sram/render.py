#!/usr/bin/env python3
"""Render the actual saved polygons, with placement pitch and size comparison."""
from pathlib import Path
import json
import os

import klayout.db as db
os.environ.setdefault('MPLCONFIGDIR','/tmp/sram-dense-matplotlib')
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import PatchCollection
from matplotlib.patches import Polygon, Rectangle, Patch

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
STYLES=[((140,0),'N-well','#afc58d',.25),((3,2),'N active','#41a866',.65),
        ((3,1),'P active','#d5a23a',.65),((8,1),'Poly','#c45042',.7),
        ((13,0),'Metal 1','#2781b4',.3),((20,0),'Metal 2','#7e70b5',.18),
        ((11,0),'Contact','#232c3a',.9),((19,0),'Via 1','#674693',.8)]


def draw(ax,layout,cell,dx=0,dy=0):
    for layer,name,color,alpha in STYLES:
        li=layout.find_layer(*layer)
        if li is None:
            continue
        patches=[]
        for poly in db.Region(cell.begin_shapes_rec(li)).merged().each():
            # Resolve holes by decomposing before plotting; use exact GDS polygons.
            for part in poly.decompose_trapezoids():
                points=[(p.x*layout.dbu+dx,p.y*layout.dbu+dy) for p in part.each_point()]
                patches.append(Polygon(points,closed=True))
        ax.add_collection(PatchCollection(patches,facecolor=color,edgecolor=color,
                                           alpha=alpha,linewidth=.45))
    ax.set_aspect('equal')


def main():
    old=db.Layout();old.read(str(ROOT/'learning/layout/sram.gds'))
    new=db.Layout();new.read(str(HERE/'sram_dense.gds'))
    dims=json.loads((HERE/'dimensions.json').read_text())
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10})
    fig,axes=plt.subplots(1,2,figsize=(13,5.7),layout='constrained',facecolor='#fafbf9')
    for ax in axes:
        ax.set_facecolor('#fafbf9');ax.set_xlim(-5,61);ax.set_ylim(-4,46)
        ax.set_xlabel('um');ax.set_ylabel('um')
        ax.spines[['top','right']].set_visible(False)
        ax.grid(alpha=.12);ax.set_axisbelow(True)
    box=old.cell('sram').dbbox()
    draw(axes[0],old,old.cell('sram'),-box.left,-box.bottom)
    axes[0].add_patch(Rectangle((0,0),57.5,28,fill=False,color='#182d40',lw=1.5,ls='--'))
    axes[0].set_title('Existing cell\n57.5 x 28 um pitch | 1,610 um2/bit',loc='left',fontweight='bold')
    draw(axes[1],new,new.cell('sram_dense'))
    axes[1].add_patch(Rectangle((0,0),21.2,34,fill=False,color='#182d40',lw=1.5,ls='--'))
    axes[1].set_title('Dense cell: 55.2% less area per bit\n21.2 x 34 um pitch | 720.8 um2/bit',loc='left',fontweight='bold')
    for label,xy,xytext in [('BL',(2.9,0),(0,-3)),('BLB',(18.7,0),(18,-3)),
                           ('WL',(10.8,16.6),(34,17)),('VDD / well tap',(10.8,34),(34,35)),
                           ('VSS row rail',(10.8,9.6),(34,10)),
                           ('Shared well',(23,40),(34,41))]:
        axes[1].annotate(label,xy,xytext=xytext,fontsize=9,
                         arrowprops={'arrowstyle':'-','color':'#34424a','lw':.8})
    fig.legend([Patch(facecolor=c,alpha=max(a,.4)) for _,_,c,a in STYLES],
               [n for _,n,_,_ in STYLES],loc='outside lower center',ncol=8,frameon=False)
    fig.suptitle('Actual GDS geometry at the same scale',fontsize=15,fontweight='bold')
    fig.savefig(HERE/'comparison.png',dpi=180)
    fig.savefig(HERE/'comparison.svg')
    svg=HERE/'comparison.svg'
    svg.write_text('\n'.join(line.rstrip() for line in svg.read_text().splitlines())+'\n')
    plt.close(fig)

    fig,(a,b)=plt.subplots(1,2,figsize=(12,7.8),layout='constrained',facecolor='#fafbf9')
    draw(a,new,new.cell('sram_dense_2x2'))
    box=new.cell('sram_dense_2x2').dbbox()
    a.set_xlim(box.left-3,box.right+3);a.set_ylim(box.bottom-3,box.top+3)
    a.set_title('2 x 2: real connections and mirrored rows',loc='left',fontweight='bold')
    a.set_xlabel('um');a.set_ylabel('um')
    for row in range(2):
        for col in range(2):
            a.add_patch(Rectangle((col*21.2,row*34),21.2,34,fill=False,
                                  edgecolor='#172a3a',lw=1,ls='--'))
    a.text(21.2,34,'Shared VDD diffusion',ha='center',va='center',fontsize=9,
           bbox={'facecolor':'white','alpha':.8,'edgecolor':'none'})
    b.set_aspect('equal');b.set_xlim(-30,640);b.set_ylim(-35,1840)
    b.add_patch(Rectangle((0,0),600,1800,facecolor='#f1f4ee',edgecolor='#233d39',lw=2))
    bound=dims['footprints']['sram_dense_16x64']
    w,h=bound['height_um'],bound['width_um']
    b.add_patch(Rectangle((0,1800-h),w,h,facecolor='#bad2c1',edgecolor='#327052'))
    b.text(w/2,1800-h/2,'1,024 bits\n16 x 64, rotated\n\n547.4 x 1461.6 um\n\nIncludes well/substrate taps\nand array power straps',
           ha='center',va='center',fontsize=10)
    b.text(300,(1800-h)/2,'Remaining space\n(peripherals and pads not placed)',ha='center',va='center',fontsize=9)
    b.set_title('Array-only fit in 600 x 1800 um',loc='left',fontweight='bold')
    b.set_xlabel('um');b.set_ylabel('um')
    fig.savefig(HERE/'array_and_fit.png',dpi=180)
    plt.close(fig)


if __name__=='__main__':
    main()
