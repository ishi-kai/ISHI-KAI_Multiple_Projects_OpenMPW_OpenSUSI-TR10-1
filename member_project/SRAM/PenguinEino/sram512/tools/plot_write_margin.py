#!/usr/bin/env python3
"""Show the failed/successful extracted-array write with identical RC stress."""
import numpy as np
from common import *
from analog import load_raw
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


def main():
    cases=[('mux51_rc3_low_hot_5us',795000,'PD W=3.4 um: failed','#c9463d','--'),
           ('pd102_rc3_addr0_5us_fine',255000,'PD W=10.2 um: passed','#2065ab','-')]
    fig,axes=plt.subplots(3,1,figsize=(10,8),sharex=True)
    sources=[]
    for name,origin,label,color,style in cases:
        folder=WORK/'analog'/name;result=json.loads((folder/'result.json').read_text())
        t,w=load_raw(folder/'sram512_tb.raw');mask=(t>=origin-300)&(t<=origin+3500)
        x=(t[mask]-origin)/1000
        for ax,n in zip(axes,('xarray.xr0c0.q','rc_yb_4','rc_wl0_4')):
            ax.plot(x,w[f'v({n})'][mask],style,color=color,lw=1.5,label=label)
        sources.append(dict(case=name,gds_sha256=result['physical_extraction']['gds_sha256'],
                            deck_sha256=result['deck_sha256'],origin_ns=origin))
    for ax,title in zip(axes,('Stored Q: requested value is 1','Common YB at the array end','WL at the far end of row 0')):
        ax.set_ylabel('Voltage [V]');ax.set_ylim(-.2,4.9);ax.grid(alpha=.22)
        ax.set_title(title,loc='left',fontsize=11)
    axes[0].legend(loc='lower right');axes[-1].set_xlabel('Time after E3 command [us]')
    fig.suptitle('Full 512-bit circuit: write strength under slow WL rise',fontsize=15)
    fig.text(.10,.015,'4.5 V / 85 C; RC x3 sensitivity; column MUX W=5.1 um; bitcells unchanged (W=3.4/L=1 um).',fontsize=9)
    fig.tight_layout(rect=(0,.04,1,.96));path=REPORTS/'write_driver_comparison.png';fig.savefig(path,dpi=150);plt.close(fig)
    write_json(REPORTS/'write_driver_comparison.json',dict(sources=sources,plot=str(path),
        scope='Both traces are full-array extracted simulations. Sequences differ before the compared write; Q starts at 0 and BL/BLB are precharged in both. RC assumptions are uncalibrated.'))
    print(path)


if __name__=='__main__':main()
