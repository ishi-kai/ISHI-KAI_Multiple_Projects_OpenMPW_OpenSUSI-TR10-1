#!/usr/bin/env python3
"""Static scientific figures from the saved, verified GDS polygons."""
from pathlib import Path
import sys,json,os
os.environ.setdefault('MPLCONFIGDIR','/tmp/sram-t4-matplotlib')
import klayout.db as db
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Patch,Rectangle
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(HERE.parent/'dense_sram'))
from render import draw,STYLES


def read(path):
    l=db.Layout();l.read(str(path));return l


def main():
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10})
    e=read(HERE.parent/'sram_research/euler_shared.gds')
    d=read(HERE/'t4_dualwl.gds');s=read(HERE/'t4_singlewl.gds')
    fig,axs=plt.subplots(1,3,figsize=(16,5.8),layout='constrained')
    for ax,l,top,title,pitch in zip(axs,[e,d,s],['euler_shared_4x4','t4_dualwl_4x4','t4_singlewl_4x4'],
                                     ['Existing shared-source','T4: two WL rails','T4: one WL + shared vias'],[686.72,1115.12,857.38]):
        c=l.cell(top);b=c.dbbox();draw(ax,l,c,-b.left,-b.bottom)
        ax.add_patch(Rectangle((0,0),b.width(),b.height(),fill=False,ls='--',edgecolor='#283e4c',lw=1))
        ax.set_xlim(-4,225);ax.set_ylim(-5,125);ax.grid(alpha=.1);ax.set_axisbelow(True)
        ax.set_xlabel('x [µm]');ax.set_ylabel('y [µm]')
        ax.set_title(f'{title}\n{b.width():.1f} × {b.height():.1f} µm\n{b.area()/16:.2f} µm²/bit including ends',fontsize=11,loc='left')
        ax.text(.01,-.20,f'Periodic core: {pitch:.2f} µm²/bit',transform=ax.transAxes)
    fig.legend([Patch(facecolor=c,alpha=max(a,.4)) for _,_,c,a in STYLES],[n for _,n,_,_ in STYLES],
               loc='outside lower center',ncol=8,frameon=False)
    fig.suptitle('Actual 4 × 4 arrays at the same scale | M1/M2 only | all MOS W/L = 3.4/1 µm',fontsize=14)
    fig.savefig(HERE/'array_comparison.png',dpi=180);plt.close(fig)

    fig,ax=plt.subplots(figsize=(14,8),layout='constrained')
    c=s.cell('t4_singlewl_2x2');draw(ax,s,c)
    for x in (0,52.6):
        for label,xx,yy in [('PD-L',0,2.4),('AX-L',0,7.2),('PU-L',20.4,2.4),
                            ('PU-R',25.2,7.2),('AX-R',45.6,2.4),('PD-R',45.6,7.2)]:
            if x==0:ax.text(x+xx,yy,label,fontsize=7,ha='center',va='center',color='#172735',
                           bbox={'facecolor':'white','alpha':.8,'edgecolor':'none','pad':1})
    for label,xy,xytext in [
        ('WL0: horizontal M1',(70,-4),(112,-7)),
        ('WL1: horizontal M1',(70,25.4),(112,29)),
        ('Local M2 WL overpass',(11.2,2),(10,-12)),
        ('Shared BL / VSS / VDD sources\n+ one via per shared source',(25.2,10.7),(112,11)),
        ('VDD well contacts',(75.4,-15.4),(112,-18)),
        ('Substrate contacts to VSS',(98.2,-20.8),(112,-24)),
        ('Mirrored upper row',(73,17),(112,20)),
    ]:
        ax.annotate(label,xy,xytext=xytext,fontsize=9,arrowprops={'arrowstyle':'-','color':'#253c4a','lw':1},va='center')
    ax.set_xlim(-8,158);ax.set_ylim(-27,48);ax.set_xlabel('x [µm]');ax.set_ylabel('y [µm]');ax.grid(alpha=.1);ax.set_axisbelow(True)
    ax.set_title('T4 adapted to two metals: actual 2 × 2 GDS\nRow-pair pitch 32.6 µm; column pitch 52.6 µm; 857.38 µm²/bit core',loc='left',fontsize=15)
    fig.legend([Patch(facecolor=c,alpha=max(a,.4)) for _,_,c,a in STYLES],[n for _,n,_,_ in STYLES],
               loc='outside lower center',ncol=8,frameon=False)
    fig.savefig(HERE/'singlewl_detail.png',dpi=180);plt.close(fig)


if __name__=='__main__':main()
