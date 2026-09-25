"""Audit one-microsecond sampling and plot the measured five-stage carry case."""
from pathlib import Path
import itertools,json,os
os.environ.setdefault('MPLCONFIGDIR','/tmp/mac-review-mpl')
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
ROOT=Path(__file__).resolve().parents[1];OUT=ROOT/'reports/final_review'
j=json.loads((OUT/'chain5.json').read_text());data=np.loadtxt(ROOT/'simulation/final_review/chain5/data.txt',skiprows=1);t=data[:,0]*1e9
rows=[]
for k,c in enumerate(j['cases']):
 carry=0;expect=[]
 for i in range(5):
  total=c['x'][i]+c['a'][i]*c['b']+carry
  s,carry=next((s,cy) for s,cy in itertools.product((-1,0,1),repeat=2) if s+3*cy==total)
  expect.extend([5*s,5*carry,5*min(c['a'][i],c['b']),5*max(c['a'][i],c['b'])])
 obs=np.array([np.interp(k*5000+1000,t,data[:,n]) for n in range(1,21)]);errors=abs(obs-expect)
 if max(errors)>.5:
  p=int(errors.argmax());rows.append(dict(index=k,name=c['name'],output=['sum','cout','and','or'][p%4],stage=p//4,max_error_V=float(errors[p]),actual_V=float(obs[p]),expected_V=float(expect[p])))
j['samples']=j.pop('states',j.get('samples'));j['transitions']=j['samples']-1;j['unique_inputs']=len({(tuple(r['x']),tuple(r['a']),r['b']) for r in j['cases']});j['one_us_sampling_failures']=rows
(OUT/'chain5.json').write_text(json.dumps(j,indent=2)+'\n')
k=max(range(len(j['cases'])),key=lambda i:j['cases'][i]['settle_ns']);cut=(t>=k*5000-100)&(t<=k*5000+1500);x=(t[cut]-k*5000)/1000
fig,axes=plt.subplots(2,1,figsize=(9,6),sharex=True,layout='constrained')
for i in range(5):
 axes[0].plot(x,data[cut,2+4*i],label=f'Cout {i}')
 axes[1].plot(x,data[cut,1+4*i],label=f'Sum {i}')
for ax in axes:
 ax.axvline(1,color='#555',ls='--',label='1 us sample');ax.set_ylabel('Voltage [V]');ax.set_yticks([-5,0,5]);ax.grid(alpha=.2);ax.legend(ncol=3,fontsize=8)
axes[1].set_xlabel('Time from input change [us]');fig.suptitle('Five extracted MAC slices: negative carry propagation\n10 pF || 1 Mohm per output + next Cin, ideal rails, no wire RC')
fig.savefig(OUT/'chain5_carry.png',dpi=150)
print('1 us failures:',rows)
