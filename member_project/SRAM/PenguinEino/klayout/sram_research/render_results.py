#!/usr/bin/env python3
"""Render actual saved GDS and numerical comparison results as static figures."""
from pathlib import Path
import sys,json,os
import klayout.db as db
os.environ.setdefault('MPLCONFIGDIR','/tmp/sram-research-matplotlib')
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle,Patch
import numpy as np
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
from render import draw,STYLES


def layout(path):
    l=db.Layout();l.read(str(path));return l


def main():
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10})
    old=layout(ROOT/'learning/layout/sram.gds');base=layout(HERE/'baseline_fit.gds');new=layout(HERE/'euler_shared.gds')
    fig,axes=plt.subplots(1,3,figsize=(15,5.4),layout='constrained')
    entries=[(old,'sram',57.5,28,'Hand layout | 1,610 um²/bit'),
             (base,'sram_dense',21.2,34,'Previous dense | 720.8 um²/bit'),
             (new,'euler',23.2,29.6,'Shared-source 6T | 686.72 um²/bit')]
    for ax,(l,name,w,h,title) in zip(axes,entries):
        cell=l.cell(name);b=cell.dbbox()
        dx,dy=(-b.left,-b.bottom) if name=='sram' else (0,5.7 if name=='euler' else 0)
        draw(ax,l,cell,dx,dy)
        ax.add_patch(Rectangle((0,0),w,h,fill=False,ls='--',lw=1.5,edgecolor='#172e41'))
        ax.set_xlim(-5,61);ax.set_ylim(-3,44);ax.set_xlabel('x [µm]');ax.set_ylabel('y [µm]')
        ax.set_title(title+'\n'+f'{w:g} × {h:g} µm placement pitch',loc='left',fontsize=11)
        ax.grid(alpha=.15);ax.set_axisbelow(True)
    fig.legend([Patch(facecolor=c,alpha=max(a,.5)) for _,_,c,a in STYLES],[n for _,n,_,_ in STYLES],
               loc='outside lower center',ncol=8,frameon=False)
    fig.suptitle('Actual cell polygons at the same scale | all MOS W/L = 3.4/1 µm',fontsize=15)
    fig.savefig(HERE/'cell_comparison.png',dpi=170);plt.close(fig)

    report=json.loads((HERE/'area_comparison.json').read_text())
    fig,axes=plt.subplots(1,3,figsize=(12,7),layout='constrained',gridspec_kw={'width_ratios':[1,1,1.6]})
    for ax,key in zip(axes[:2],('baseline','euler_shared')):
        v=report['designs'][key];w,h=v['array_1024_um'][::-1]
        ax.add_patch(Rectangle((0,0),600,1800,facecolor='#f4f6f5',edgecolor='#35443e',lw=1.5))
        ax.add_patch(Rectangle((0,1800-h),w,h,facecolor='#9dbfaf' if key=='euler_shared' else '#b5c7d5',edgecolor='#365747'))
        ax.text(w/2,1800-h/2,f'1,024 bits\n\n{w:g} × {h:g} µm\n\nTaps + power\nstraps included',ha='center',va='center')
        ax.set_xlim(-30,630);ax.set_ylim(-30,1830);ax.set_aspect('equal');ax.set_xlabel('µm');ax.set_ylabel('µm')
        ax.set_title('Previous dense' if key=='baseline' else 'New cell + shared taps')
    keys=['baseline','baseline_shared','euler','euler_shared'];vals=[report['designs'][k]['best']['bits'] for k in keys]
    labels=['Previous dense','Previous + shared taps','New cell, paired taps','New cell + shared taps']
    bars=axes[2].barh(labels,vals,color=['#b5c7d5','#809cb6','#b2cabc','#598b73'])
    axes[2].bar_label(bars,padding=5);axes[2].set_xlim(0,1600);axes[2].invert_yaxis()
    axes[2].set_xlabel('Bits fitting inside 600 × 1800 µm');axes[2].set_title('Maximum for each tested rectangular tiling')
    axes[2].text(.02,-.12,'Final: 20 × 72 = 1,440 bits\n592.0 × 1798.2 µm, rotated\n\nNo peripheral circuits or pads in these footprints.',transform=axes[2].transAxes,fontsize=10,va='top')
    fig.suptitle('Compare the complete array footprint',fontsize=15)
    fig.savefig(HERE/'array_comparison.png',dpi=170);plt.close(fig)

    fig,(a,b)=plt.subplots(1,2,figsize=(12,7),layout='constrained')
    draw(a,new,new.cell('euler_shared_2x2'));bound=new.cell('euler_shared_2x2').dbbox()
    a.set_xlim(bound.left-2,bound.right+2);a.set_ylim(-3,63)
    for r in range(2):
        for c in range(2):a.add_patch(Rectangle((c*23.2,r*29.6),23.2,29.6,fill=False,ls='--',lw=1,color='#344f48'))
    a.set_title('2 × 2: physical body ties and mirrored rows')
    draw(b,new,new.cell('euler_shared_4x17'))
    b.set_xlim(353,421);b.set_ylim(-3,63)
    b.axvspan(371.2,392.4,alpha=.09,color='#233c33')
    b.axvline(371.2,ls='--',lw=.8,color='#344f48');b.axvline(392.4,ls='--',lw=.8,color='#344f48')
    b.set_title('Shared tap column between bits 15 and 16\n21.2 µm gap, one set of body ties')
    for ax in (a,b):ax.set_xlabel('x [µm]');ax.set_ylabel('y [µm]')
    fig.savefig(HERE/'array_detail.png',dpi=170);plt.close(fig)

    sim=json.loads((HERE/'spice_comparison.json').read_text())
    fig,axes=plt.subplots(1,2,figsize=(10,5),layout='constrained')
    for ax,mode in zip(axes,('hold','read')):
        for variant,color,style in [('baseline','#597c9c','--'),('euler_shared','#c1583c','-')]:
            a=np.loadtxt(ROOT/f'build/sram_research/spice/{variant}_{mode}_vtc.csv',delimiter=',',skiprows=1)
            for i in (0,2):ax.plot(a[:,i],a[:,i+1],style,color=color,lw=1.4,label=variant if i==0 else None)
        snm=[r for r in sim['static_noise_margin'] if r['variant']=='euler_shared' and r['mode']==mode][0]['snm_v']
        ax.set_title(f'{mode.capitalize()} SNM: {snm:.3f} V');ax.set_xlabel('Q [V]');ax.set_ylabel('QB [V]')
        ax.set_xlim(0,5);ax.set_ylim(0,5);ax.set_aspect('equal');ax.grid(alpha=.2);ax.legend(fontsize=8)
    fig.suptitle('Extracted MOS DC transfer curves | 5 V, 27 °C | wire RC excluded')
    fig.savefig(HERE/'stability.png',dpi=170);plt.close(fig)


if __name__=='__main__':main()
