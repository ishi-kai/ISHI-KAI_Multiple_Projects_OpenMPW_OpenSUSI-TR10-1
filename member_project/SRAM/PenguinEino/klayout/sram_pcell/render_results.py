#!/usr/bin/env python3
"""Draw actual saved polygons and PCell instance boundaries; no schematic art."""
from pathlib import Path
import importlib.util,json,os
os.environ.setdefault('MPLCONFIGDIR','/tmp/sram-pcell-matplotlib')
import klayout.db as db
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle,Patch
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
spec=importlib.util.spec_from_file_location('dense_render',HERE.parent/'dense_sram/render.py')
renderer=importlib.util.module_from_spec(spec);spec.loader.exec_module(renderer)

def load(path):
    l=db.Layout();l.read(str(path));return l

def main():
    old=load(HERE.parent/'sram_compact/compact.gds');new=load(HERE/'pcell.gds')
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10})
    fig,axes=plt.subplots(1,2,figsize=(11,7.2),facecolor='#fafbf9')
    fig.subplots_adjust(left=.07,right=.98,bottom=.11,top=.85,wspace=.18)
    for ax,l,name,title in zip(axes,(old,new),('compact_core','pcell_core'),
                              ('Previous custom layout','Six original TR-1um MOS PCells')):
        renderer.draw(ax,l,l.cell(name),dy=5.7)
        ax.add_patch(Rectangle((0,0),22,29.6,fill=False,edgecolor='#142e3e',ls='--',lw=1.5))
        ax.set(xlim=(-4,29),ylim=(-1,39),xlabel='um',ylabel='um')
        ax.set_title(title+'\n22.0 x 29.6 um pitch | 651.20 um²/bit',loc='left',fontweight='bold',fontsize=10)
        ax.spines[['top','right']].set_visible(False)
        ax.set_facecolor('#fafbf9')
        ax.text(11,36.2,'N-well extends across\nthe mirrored-row boundary',ha='center',fontsize=8)
    for inst in new.cell('pcell_core').each_inst():
        if inst.cell.name not in ('fet_n','fet_p'):continue
        b=inst.dbbox()
        axes[1].add_patch(Rectangle((b.left,b.bottom+5.7),b.width(),b.height(),fill=False,
                                   edgecolor='#152b3a',lw=.9,ls=':'))
    axes[1].annotate('Both original contacts retained\nShared VSS diffusion',xy=(9,5.7),xytext=(12,14.5),
                     ha='center',fontsize=8,bbox=dict(facecolor='white',alpha=.8,edgecolor='none'),
                     arrowprops=dict(arrowstyle='-',color='#243a43'))
    axes[1].text(11,31.8,'Dotted boxes: MOS PCell instances',ha='center',fontsize=8)
    fig.legend([Patch(facecolor=c,alpha=max(a,.4)) for _,_,c,a in renderer.STYLES],
               [n for _,n,_,_ in renderer.STYLES],loc='lower center',ncol=8,frameon=False,fontsize=9)
    fig.suptitle('TR-1um SRAM | actual saved GDS geometry',fontsize=14,fontweight='bold',y=.98)
    fig.savefig(HERE/'cell_comparison.png',dpi=180);plt.close(fig)

    results=json.loads((HERE/'scan.json').read_text())
    fig,axes=plt.subplots(2,4,figsize=(15,8),layout='constrained',facecolor='#fafbf9')
    for ax,r in zip(axes.flat,results):
        l=load(ROOT/'build/sram_pcell/scan'/r['name']/'pcell.gds')
        renderer.draw(ax,l,l.cell('pcell_4x4'))
        valid=r['drc']['passed'] and r['lvs']['passed']
        text=f"{r['name']} | {r['area_per_bit_um2']:.2f} um²/bit\nDRC {r['drc']['items']} | LVS {'match' if r['lvs']['passed'] else 'FAIL'}"
        ax.set_title(text,loc='left',fontsize=10,color='#246648' if valid else '#a33531',fontweight='bold')
        ax.set(xlim=(-25,120),ylim=(-3,128),xlabel='um',ylabel='um')
        ax.spines[['top','right']].set_visible(False)
    fig.suptitle('Eight real 4 x 4 candidates, all at the same scale',fontweight='bold')
    fig.savefig(HERE/'scan_comparison.png',dpi=150);plt.close(fig)

if __name__=='__main__':main()
