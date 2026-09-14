#!/usr/bin/env python3
"""Scientific static figures; peripheral rectangles are explicitly estimates."""
from pathlib import Path
import json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
import klayout.db as db
HERE=Path(__file__).resolve().parent
plt.rcParams.update({'font.size':10,'axes.spines.top':False,'axes.spines.right':False})


def floorplans(cap):
    fig,axs=plt.subplots(1,2,figsize=(10,12),layout='constrained')
    selected=[cap['scenarios'][0]['best_binary'],cap['scenarios'][2]['best_binary']]
    colors={'array':'#99cab5','local':'#f2d397','global':'#dae6ee','ff':'#42687c','logic':'#87a7b8','analog':'#d8b5c3'}
    for ax,x in zip(axs,selected):
        ax.add_patch(Rectangle((0,0),600,1800,fill=False,edgecolor='#202d3d',lw=1.5))
        rot=x['floorplan']['rotation_deg'];aw=x['array_width_um'];ah=x['array_height_um']
        s=x['column_strip_um'];d=x['local_row_region_um']
        ar=(d,0,aw,ah) if rot==0 else (s,0,ah,aw)
        col=(d,ah,aw,s) if rot==0 else (0,0,s,aw)
        row=(0,0,d,ah) if rot==0 else (s,aw,ah,d)
        for box,label in ((col,'Column circuits\n(reserved)'),(row,'WL decode\n2 lanes')):
            xx,yy,w,h=box;ax.add_patch(Rectangle((xx,yy),w,h,facecolor=colors['local'],edgecolor='white',hatch='..',lw=1))
            ax.text(xx+w/2,yy+h/2,label,ha='center',va='center',rotation=90 if h>2*w else 0,fontsize=9)
        xx,yy,w,h=ar;ax.add_patch(Rectangle((xx,yy),w,h,facecolor=colors['array'],edgecolor='white',lw=1))
        ax.text(xx+w/2,yy+h/2,f"{x['rows']} x {x['columns']}\n{x['bits']} bit\nverified array GDS\n{w:.1f} x {h:.1f} um",ha='center',va='center',fontsize=12)
        gy=x['floorplan']['upper_height_um']+20;gh=x['global_logic_height_um']
        ax.add_patch(Rectangle((0,gy),592.6,gh,facecolor=colors['global'],edgecolor='white',lw=1))
        for r,cells in enumerate(x['packed_rows']):
            for cell in cells:
                color=colors['ff'] if cell['cell']=='DFFR' else colors['logic']
                ax.add_patch(Rectangle((6.3+cell['x_um'],gy+r*55+2),cell['width_um']-.5,51,facecolor=color,edgecolor='white',lw=.2))
        ax.text(300,gy+gh/2,f"Serial controller + predecode\n{x['controller']['flipflops']} DFFR / {len(x['packed_rows'])} rows\ntarget utilization {x['target_utilization']:.0%}",ha='center',va='center',fontsize=11,
                bbox=dict(facecolor='white',alpha=.9,edgecolor='none',pad=6))
        ax.add_patch(Rectangle((0,gy+gh),120,60,facecolor=colors['analog'],edgecolor='white'))
        ax.text(130,gy+gh+30,'Shared write / sense: 11 MOS reserve',va='center',fontsize=8)
        ax.set(xlim=(-15,615),ylim=(1820,-45),aspect='equal',xlabel='um',ylabel='um')
        ax.set_title(f"{x['bits']} bit: {'roomier budget' if x['bits']==256 else 'aggressive budget'}\n{x['floorplan']['width_um']:.1f} x {x['floorplan']['height_um']:.1f} um",fontsize=12)
    fig.suptitle('600 x 1800 um core: peripheral block estimates, not routed layouts\nPads / ESD excluded; buffer budget included',fontsize=14)
    fig.savefig(HERE/'floorplans.png',dpi=160);plt.close(fig)


def pitch():
    fig,axs=plt.subplots(1,2,figsize=(11,4.8),layout='constrained')
    ax=axs[0]
    ax.add_patch(Rectangle((0,0),130,118.4,facecolor='#d9ece4',edgecolor='none'))
    ys=[2.7,56.5,61.9,115.7]
    for r,y in enumerate(ys):
        dx=-160 if r%2==0 else -88
        ax.add_patch(Rectangle((dx,y-14.55),62.6,29.1,facecolor='#8aaabb',edgecolor='white'))
        ax.text(dx+31.3,y,f'INV {r}',ha='center',va='center')
        ax.plot([dx+62.6,0],[y,y],ls='--',color='#4c5c70')
        ax.plot([0,130],[y,y],color='#2d795e')
        texty=y+(-6 if r==1 else 6 if r==2 else 0)
        ax.annotate(f'WL{r}  {y:.1f}',xy=(130,y),xytext=(140,texty),va='center',fontsize=9,
                    arrowprops=dict(arrowstyle='-',color='#888',lw=.7))
    ax.annotate('5.4 um',xy=(100,59.2),xytext=(100,84),ha='center',arrowprops=dict(arrowstyle='->'))
    ax.set(xlim=(-170,210),ylim=(140,-23),aspect='equal',xlabel='um',ylabel='um')
    ax.set_title('Actual WL pins; alternating drivers\nDashed lines are connection concepts')
    ax=axs[1];names=['INV_X1','NAND2','AND2_X1','DFFR'];full=[29.1,29.1,34.6,100.6];native=[16.5,16.5,22,88]
    q=np.arange(4);ax.barh(q-.18,full,.34,label='Standalone GDS bbox');ax.barh(q+.18,native,.34,label='Native abut width')
    ax.set_yticks(q,names);ax.invert_yaxis();ax.axvline(23.2,color='#3c8063',ls='--',label='SRAM column pitch')
    ax.set_xlabel('um');ax.set_title('Shared well / rail ends change the pitch');ax.legend(loc='lower right',fontsize=8)
    fig.savefig(HERE/'pitch.png',dpi=160);plt.close(fig)


def straps(scaling):
    l=db.Layout();l.read(str(HERE/'wlstrap_arrays.gds'))
    fig,axs=plt.subplots(1,2,figsize=(10,4.6),layout='constrained')
    order=[16,8,4];areas=[l.cell(f'wlstrap{i}_16x32').dbbox().area() for i in order]
    axs[0].bar([str(i) for i in order],np.array(areas)/1000,color=['#458775','#73a795','#b7ce8e'])
    for j,(i,a) in enumerate(zip(order,areas)):
        axs[0].text(j,a/1000+3,f'{a/1000:.1f}\n+{(a/areas[0]-1)*100:.2f}%',ha='center',fontsize=10)
    axs[0].set(ylim=(0,500),xlabel='Columns per GC-M2 connection',ylabel='512-bit array area (1000 um²)',title='Actual saved GDS: DRC / LVS pass')
    for rs,style in [(30,'-'),(120,'-'),(300,'--')]:
        values=[next(x['rise90_ns'] for x in scaling['wl_sensitivity'] if x['interval']==i and x['rs_ohm_sq']==rs and x['cwire_ff_um']==.3 and x['temperature_c']==85) for i in [4,8,16]]
        axs[1].plot([4,8,16],values,style,marker='o',label=f'Assumed Rs = {rs} ohm/sq')
    axs[1].axhline(35,color='#bf6964',ls=':',label='35 ns observation window')
    axs[1].set(xticks=[4,8,16],xlabel='Columns per GC-M2 connection',ylabel='WL rise to 4.5 V (ns)',title='Sensitivity only: 85 C, 0.3 fF/um\n32 columns driven by INV_X1; no foundry wire PEX')
    axs[1].legend(fontsize=8)
    fig.savefig(HERE/'strap_tradeoff.png',dpi=160);plt.close(fig)


def main():
    floorplans(json.loads((HERE/'capacity.json').read_text()));pitch()
    straps(json.loads((HERE/'scaling_results.json').read_text()))


if __name__=='__main__':main()
