"""Small deterministic cell-placement annealer; no electrical changes."""
import math, random
from collections import defaultdict
from common import *

def pack_from_seed(parts,width,capacity,source,min_x=None):
    """Fit added cells while preserving the verified placement's row grouping."""
    import numpy as np
    from scipy.optimize import milp,LinearConstraint,Bounds
    seed=json.loads(Path(source).read_text());wanted={p['name'] for p in parts}
    known={p['instance']:p for p in seed if p['instance'] in wanted and (min_x is None or p['x']>=min_x)}
    ys=sorted({p['y'] for p in known.values()});assert len(ys)==len(capacity)
    oldrow={n:ys.index(p['y']) for n,p in known.items()};nr=len(capacity);np_=len(parts)
    costs=np.zeros((np_,nr));matrix=np.zeros((np_+nr,np_*nr));upper=np.ones(np_+nr);lower=upper.copy()
    for i,p in enumerate(parts):
        for j in range(nr):
            matrix[i,i*nr+j]=1;matrix[np_+j,i*nr+j]=round(width(p)/5.5)
            if p['name'] in oldrow:
                costs[i,j]=0 if oldrow[p['name']]==j else 100+abs(oldrow[p['name']]-j)
            else:
                neighbors=[oldrow[q['name']] for q in parts if q['name'] in oldrow and
                           (set(q['nets'].values())&set(p['nets'].values()))-{'vdd','vss'}]
                costs[i,j]=sum(abs(j-k) for k in neighbors)/max(1,len(neighbors))
    lower[np_:]=0;upper[np_:]=[math.floor(c/5.5+1e-8) for c in capacity]
    result=milp(costs.ravel(),integrality=np.ones(np_*nr),bounds=Bounds(0,1),
                constraints=LinearConstraint(matrix,lower,upper),options={'time_limit':30})
    assert result.success,result.message
    selected=result.x.reshape(np_,nr).argmax(axis=1);rows=[[] for _ in capacity]
    for p,j in zip(parts,selected):rows[j].append(p)
    for row in rows:row.sort(key=lambda p:known.get(p['name'],{}).get('x',1800))
    assert all(sum(width(p) for p in row)<=cap+1e-6 for row,cap in zip(rows,capacity))
    print('seed row moves',sum(selected[i]!=oldrow[p['name']] for i,p in enumerate(parts) if p['name'] in oldrow),flush=True)
    return rows

def improve(rows,parts,width,anchors,x0=1419,y0=11,dy=71.5,capacity=429,allowed_rows=None):
    rng=random.Random(512);rows=[list(row) for row in rows]
    byname={p['name']:p for p in parts};inc=defaultdict(set)
    pos={}
    def rowpos(j):
        x=x0[j] if isinstance(x0,list) else x0
        y=y0[j] if isinstance(y0,list) else y0+dy*j
        for p in rows[j]:pos[p['name']]=(x+width(p)/2,y+27.5);x+=width(p)
    for j in range(len(rows)):rowpos(j)
    nets=defaultdict(list)
    for p in parts:
        for n in set(p['nets'].values()):
            if n in ('vdd','vss'):continue
            nets[n].append(p['name']);inc[p['name']].add(n)
    def cost(n):
        points=[pos[k] for k in nets[n]]+anchors.get(n,[])
        if len(points)<2:return 0
        xs,ys=zip(*points);w=.25 if n.endswith(('cki','rsti')) else 1
        return w*((max(xs)-min(xs))+1.4*(max(ys)-min(ys)))
    scores={n:cost(n) for n in nets};total=sum(scores.values());initial=total
    capacity=capacity if isinstance(capacity,list) else [capacity]*len(rows)
    used=[sum(width(p) for p in row) for row in rows]
    best=total;bestrows=[list(r) for r in rows];steps=360000
    for step in range(steps):
        j,k=rng.randrange(len(rows)),rng.randrange(len(rows))
        if not rows[j] or not rows[k]:continue
        i,q=rng.randrange(len(rows[j])),rng.randrange(len(rows[k]))
        moving=(j!=k and rng.random()<.25)
        if allowed_rows:
            if k not in allowed_rows[rows[j][i]['name']]:continue
            if not moving and j not in allowed_rows[rows[k][q]['name']]:continue
        if moving:
            if len(rows[j])<2 or used[k]+width(rows[j][i])>capacity[k]:continue
        elif j!=k:
            delta_width=width(rows[k][q])-width(rows[j][i])
            if used[j]+delta_width>capacity[j] or used[k]-delta_width>capacity[k]:continue
        else:
            if len(rows[j])<2:continue
            i=rng.randrange(len(rows[j])-1);q=i+1
        before={idx:list(rows[idx]) for idx in (j,k)}
        affected=set().union(*(inc[p['name']] for p in rows[j]+rows[k]))
        old=sum(scores[n] for n in affected)
        if moving:rows[k].insert(q,rows[j].pop(i))
        else:rows[j][i],rows[k][q]=rows[k][q],rows[j][i]
        rowpos(j)
        if k!=j:rowpos(k)
        newscore={n:cost(n) for n in affected};delta=sum(newscore.values())-old
        temp=150*(.001**(step/steps))
        if delta<=0 or rng.random()<math.exp(-delta/temp):
            total+=delta;scores.update(newscore)
            if total<best:best=total;bestrows=[list(r) for r in rows]
            for idx in before:used[idx]=sum(width(p) for p in rows[idx])
        else:
            for idx,row in before.items():rows[idx]=row;rowpos(idx)
    print('placement wire estimate',round(initial), '->',round(best),flush=True)
    return bestrows
