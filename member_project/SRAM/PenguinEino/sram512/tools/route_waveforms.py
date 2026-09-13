#!/usr/bin/env python3
"""Plot complete before/after physical simulations around the critical edges."""
import argparse
import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt
from common import *
from analog import load_raw


def traces(name):
    folder=WORK/'analog'/name
    result=json.loads((folder/'result.json').read_text())
    t,w=load_raw(folder/'sram512_tb.raw')
    case=json.loads((folder/'scenario.json').read_text())
    assert len(case['operations'])==1 and abs(t[-1]-case['stop_ns'])<1e-6
    mesh=json.loads((folder/'wire_rc.json').read_text())['signal_mesh']
    e=case['operations'][0]['e0']
    pc=(t>=e-20)&(t<=e+200)
    taps={m['node'] for n,net in mesh['nets'].items() if re.fullmatch(r'wl\d+',n)
          for m in net['terminals'] if m['pin']=='G'}
    wl=np.maximum.reduce([w['v('+n.lower()+')'][pc] for n in taps])
    edge=e+5*case['period_ns']
    counter=(t>=edge-20)&(t<=edge+150)
    records=json.loads((folder/'physical_devices.json').read_text())
    # The saved pre-RC device records describe identity and position. Read
    # the actual remapped terminal names from the simulated deck.
    lines={int(m[1]):m[2].split()[:4] for m in re.finditer(r'(?m)^XM(\d+) (.+)$',(folder/'test.spice').read_text())}
    maximum=np.zeros(int(counter.sum()))
    zero=np.zeros_like(maximum)
    voltage=lambda n: zero if n in ('vss','0') else w['v('+n.lower()+')'][counter]
    for i,record in enumerate(records):
        if record['model'] not in ('NMOS','PMOS'):continue
        d,g,s,b=lines[i]
        np.maximum(maximum,np.abs(voltage(g)-voltage(b)),out=maximum)
    return result,(t[pc]-e,wl),(t[counter]-edge,maximum)


def render(before,after,output):
    runs=[traces(n) for n in (before,after)]
    assert runs[1][0]['passed']
    fig,axes=plt.subplots(1,2,figsize=(12,4.8))
    for run,label,color in zip(runs,('Before routing change','After routing change'),('#b94d44','#24756b')):
        for ax,trace in zip(axes,run[1:]):ax.plot(*trace,label=label,color=color,lw=1.6)
    axes[0].axhline(.5,color='#555',ls='--',lw=1,label='LOW ceiling: 0.5 V')
    axes[1].axhline(5.75,color='#555',ls='--',lw=1,label='MOS limit: 5.75 V')
    axes[0].set(title='Largest voltage at any unselected WL gate',xlabel='Time after precharge starts [ns]',ylabel='Voltage [V]')
    axes[1].set(title='Largest |VGB| across all MOS devices',xlabel='Time after E5 clock edge [ns]',ylabel='Absolute voltage [V]')
    for ax in axes:ax.grid(alpha=.2);ax.legend(fontsize=8)
    fig.suptitle('Actual 16 x 32 SRAM: added WL end taps and C4B metal shunt',fontsize=13)
    fig.text(.04,.02,'5 V, 27 C, physical signal RC and supply mesh. Complete first-access tests; this plot is not the full release qualification.',fontsize=8)
    fig.tight_layout(rect=(0,.04,1,.95))
    output=Path(output);fig.savefig(output,dpi=160);plt.close(fig)
    write_json(output.with_suffix('.json'),dict(
        runs=[dict(name=n,source_gds_sha256=r[0]['physical_extraction']['gds_sha256'],passed=r[0]['passed'],
                   window_wl_peak_v=float(r[1][1].max()),window_max_vgb_v=float(r[2][1].max()))
              for n,r in zip((before,after),runs)],image_sha256=sha(output)))


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('before');p.add_argument('after');p.add_argument('output')
    a=p.parse_args();render(a.before,a.after,a.output)
