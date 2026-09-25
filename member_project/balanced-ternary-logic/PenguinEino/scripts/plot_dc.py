"""Render the ngspice DC sweep with voltage left and current right."""
from pathlib import Path
import argparse
import subprocess
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

parser=argparse.ArgumentParser()
parser.add_argument('data',type=Path)
parser.add_argument('--no-show',action='store_true')
args=parser.parse_args()
data=np.loadtxt(args.data)
vin,vout,current=data[:,0],data[:,1],data[:,3]*1e3
fig,voltage=plt.subplots(figsize=(10,6),layout='constrained')
amps=voltage.twinx()
a,=voltage.plot(vin,vout,color='#1565c0',lw=2,label='Vout')
b,=voltage.plot(vin,vin,color='#607d8b',lw=1.2,ls='--',label='Vin')
c,=amps.plot(vin,current,color='#e68a2e',alpha=.35,lw=2,label='Current V+ to V-')
voltage.set(xlabel='Input voltage (V)',ylabel='Voltage (V)',xlim=(vin.min(),vin.max()),ylim=(-5.5,5.5),title='DC transfer and current')
amps.set_ylabel('Current (mA)',color='#ad6722')
amps.tick_params(axis='y',colors='#ad6722')
amps.set_ylim(0,max(float(current.max())*1.15,.001))
voltage.grid(alpha=.2)
handles=[a,b,c]
if data.shape[1] >= 6:
    mid,=voltage.plot(vin,data[:,5],color='#7e57c2',lw=1.3,label='Stage 1')
    handles.insert(2,mid)
voltage.legend(handles=handles,loc='upper left')
out=args.data.with_suffix('.png').resolve()
fig.savefig(out,dpi=150)
plt.close(fig)
if not args.no_show:
    subprocess.Popen(['xdg-open',str(out)],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,start_new_session=True)
print(out)
