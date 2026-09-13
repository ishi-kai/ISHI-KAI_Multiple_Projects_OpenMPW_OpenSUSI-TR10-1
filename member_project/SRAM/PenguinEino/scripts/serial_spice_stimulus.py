"""External-pin stimulus shared by the schematic TB and RTL comparison.

Times are ns; analog edges take 1 ns. Changing this file requires intentional
regeneration with build_serial_schematics.py before running the comparison.
"""

def scenario():
    events = {0: dict(CLK=0, RESET=1, SDI=0, WE=0)}
    def put(t, **values):events.setdefault(t, {}).update(values)
    put(120, RESET=0)
    operations=[]
    edges=[]
    next_edge=250
    def pulse(bit, we):
        nonlocal next_edge
        t=next_edge
        put(t-40, SDI=bit, WE=we)
        put(t, CLK=1);put(t+50, CLK=0)
        edges.append(t);next_edge+=100
        return t
    def access(row,col,data,write):
        first=next_edge
        for i,bit in enumerate([row,col,data if write else 0]):pulse(bit,i%2)
        for e in range(8):pulse(e%2,write if e==0 else 1-write)
        operations.append(dict(first=first,e0=first+300,row=row,col=col,data=data,write=write))
    for invert in range(2):
        for row,col in [(0,0),(0,1),(1,0),(1,1)]:
            data=row^col^invert
            access(row,col,data,1)
            access(row,col,data,0)
    # Stop with two bits received and the previous read result HIGH. Reset
    # without a CLK; the next edge must receive RA, not continue the old frame.
    partial=next_edge
    pulse(1,0);pulse(1,0)
    reset_at=next_edge-20
    put(reset_at,RESET=1);put(reset_at+130,RESET=0)
    next_edge=reset_at+250
    access(1,1,1,0) # Read the bit written before reset: SRAM must retain it
    access(0,1,1,1)
    access(0,1,1,0)
    stop=next_edge+100
    state=dict(CLK=0,RESET=1,SDI=0,WE=0)
    timeline=[]
    for t,updates in sorted(events.items()):
        state.update(updates);timeline.append(dict(time=t,**state))
    timeline.append(dict(time=stop,**state))
    return dict(timeline=timeline, operations=operations, edges=edges,
                partial=partial, reset_at=reset_at, stop=stop)


def pwl(name, timeline):
    points=[(0,5*timeline[0][name])]
    value=points[0][1]
    for item in timeline[1:]:
        new=5*item[name]
        if new != value:
            points.extend([(item['time'],value),(item['time']+1,new)])
            value=new
    points.append((timeline[-1]['time'],value))
    return 'PWL('+' '.join(f'{t}n {v}' for t,v in points)+')'
