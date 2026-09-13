#!/usr/bin/env python3
"""Draw saved GDS polygons and measured/computed footprints."""
from pathlib import Path
import os,sys,json
os.environ.setdefault('MPLCONFIGDIR','/tmp/sram-compact-matplotlib')
import klayout.db as db
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle,Patch
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
from render import draw,STYLES


def read(path):
    l=db.Layout();l.read(str(path));return l


def legend(fig):
    fig.legend([Patch(facecolor=c,alpha=max(a,.4)) for _,_,c,a in STYLES],[n for _,n,_,_ in STYLES],
               loc='outside lower center',ncol=8,frameon=False)


def main():
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10})
    old=read(HERE.parent/'sram_research/euler_shared.gds');new=read(HERE/'compact.gds')
    fig,axes=plt.subplots(1,2,figsize=(11,8),layout='constrained')
    for ax,l,top,w,area,title in zip(axes,[old,new],['euler','compact_core'],[23.2,22],[686.72,651.2],
                                    ['Previous shared-source','Compact shared-source']):
        draw(ax,l,l.cell(top),dy=5.7)
        ax.add_patch(Rectangle((0,0),w,29.6,fill=False,ls='--',edgecolor='#203e4b',lw=1.5))
        ax.set_xlim(-4,27);ax.set_ylim(-1,36);ax.set_xlabel('x [µm]');ax.set_ylabel('y [µm]')
        ax.set_title(f'{title}\n{w:g} × 29.6 µm | {area:.2f} µm²/bit',loc='left',fontsize=13)
        ax.grid(alpha=.13);ax.set_axisbelow(True)
    for label,xy,txt in [('BL contact moved inward',(.6,5.7),(-2,2)),
                          ('Short GC jog',(6.6,16.5),(-2,19)),
                          ('Offset feedback vias',(9,13.6),(11,10))]:
        axes[1].annotate(label,xy,xytext=txt,fontsize=8,arrowprops={'arrowstyle':'-','color':'#243d47'},
                         bbox={'facecolor':'white','alpha':.9,'edgecolor':'none','pad':2})
    legend(fig);fig.suptitle('Actual cell polygons at the same scale | all MOS W/L = 3.4/1 µm\n5.17% smaller core, 5.45% higher bit density',fontsize=14)
    fig.savefig(HERE/'cell_comparison.png',dpi=180);plt.close(fig)

    scans=json.loads((HERE/'scan.json').read_text())
    fig,axes=plt.subplots(2,4,figsize=(16,10),layout='constrained')
    for ax,r in zip(axes.flat,scans):
        l=read(ROOT/r['gds']);c=l.cell('compact_4x4');b=c.dbbox();draw(ax,l,c,-b.left,-b.bottom)
        ax.set_xlim(-3,136);ax.set_ylim(-3,124);ax.set_xlabel('µm');ax.set_ylabel('µm')
        w,h=r['pitch_um'];ax.set_title(f'{w:g} × {h:g} = {r["core_um2"]:.2f} µm²/bit\nDRC {r["drc"]["items"]} | LVS {"PASS" if r["lvs"]["pass"] else "FAIL"}',
                                     fontsize=10,loc='left',color='#267046' if r['valid'] else '#b64036')
    axes.flat[-1].axis('off');axes.flat[-1].text(.02,.9,'Fixed-route sweep, actual 4 × 4 GDS\n\nGreen: valid candidate\nRed: rejected candidate\n\n0.05 µm database grid\nPDK rules and MOS sizes unchanged\n\nNot a global optimum proof',va='top',fontsize=11)
    legend(fig);fig.suptitle('Smaller drawn geometry is counted only after both DRC and LVS pass',fontsize=14)
    fig.savefig(HERE/'scan_comparison.png',dpi=160);plt.close(fig)

    report=json.loads((HERE/'capacity_comparison.json').read_text())
    fig,axes=plt.subplots(1,3,figsize=(13,8),layout='constrained')
    for ax,w,h,label,color in [(axes[0],592,1798.2,'Previous array only\n1,440 bits\n592.0 × 1798.2 µm','#bbcbd4'),
                              (axes[1],592,1799.8,'Compact array only\n1,520 bits\n592.0 × 1799.8 µm','#9ebfa9')]:
        ax.add_patch(Rectangle((0,0),600,1800,facecolor='#f1f4f2',edgecolor='#283e3c',lw=1.5))
        ax.add_patch(Rectangle((0,1800-h),w,h,facecolor=color,edgecolor='#456152'))
        ax.text(w/2,1800-h/2,label,ha='center',va='center')
    a=next(x for x in report['cases'] if x['variant']=='compact8' and x['utilization']==.85 and x['rows']==16 and x['columns']==32)
    ax=axes[2];ax.add_patch(Rectangle((0,0),600,1800,facecolor='#f1f4f2',edgecolor='#283e3c',lw=1.5))
    # Rotated memory and local regions, followed by packed common logic.
    top=1800;aw,ah=a['array_width_um'],a['array_height_um']
    ax.add_patch(Rectangle((0,top-aw),ah,aw,facecolor='#9ebfa9',edgecolor='#456152'))
    ax.add_patch(Rectangle((ah,top-aw),120,aw,facecolor='#d7c6a3',edgecolor='#8b7748'))
    ax.add_patch(Rectangle((0,top-aw-137.6),ah+120,137.6,facecolor='#afc5d8',edgecolor='#507691'))
    bottom=top-aw-137.6-20-a['global_logic_height_um']
    ax.add_patch(Rectangle((0,bottom),592.6,a['global_logic_height_um'],facecolor='#d9d0df',edgecolor='#796587'))
    ax.add_patch(Rectangle((0,bottom-60),120,60,facecolor='#d7c6a3',edgecolor='#8b7748'))
    ax.text(ah/2,top-aw/2,'512-bit memory\n16 × 32, rotated\nWL contacts every 8 columns',ha='center',va='center',fontsize=9)
    ax.text(290,bottom+a['global_logic_height_um']/2,'Serial control + predecode\n85% target logic utilization',ha='center',va='center',fontsize=9)
    ax.set_title('Peripheral block estimate\n593.6 × 1775.8 µm; routing unverified',fontsize=10)
    axes[0].set_title('Verified array footprint');axes[1].set_title('Verified array footprint')
    for ax in axes:
        ax.set_xlim(-15,615);ax.set_ylim(-15,1830);ax.set_aspect('equal');ax.set_xlabel('µm');ax.set_ylabel('µm')
    fig.suptitle('600 × 1800 µm | array-only capacity versus peripheral block budgeting\nNo pads or ESD in these estimates',fontsize=14)
    fig.savefig(HERE/'capacity.png',dpi=170);plt.close(fig)


if __name__=='__main__':main()
