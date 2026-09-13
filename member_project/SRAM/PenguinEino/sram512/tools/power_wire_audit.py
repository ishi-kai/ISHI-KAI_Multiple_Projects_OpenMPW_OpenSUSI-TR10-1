#!/usr/bin/env python3
"""Reconstruct supply-wire currents without changing the simulated circuit.

The published wire limits are treated as steady-current limits. Mean absolute
and RMS density are screened; peak density is reported separately because the
public manual specifies an instantaneous limit for TC, but not for M1/M2.
This is a geometry-based current/heating screen, not foundry EM qualification.
"""
import argparse
from collections import defaultdict
import networkx as nx
import numpy as np
from scipy.sparse import coo_matrix
from scipy.sparse.linalg import splu
from common import *
from power_mesh import medial, connect
from power_grid import network
from analog import load_raw


def model(folder, info):
    cache=Path(folder)/'power_wire_transfer.json'
    definition=dict(version=1,source_gds_sha256=sha(Path(folder)/'sram512.gds'),
                    sheet_ohm=info['sheet_ohm'],grid_um=info['grid_um'],via_ohm=info['via_ohm'])
    if cache.exists():
        previous=json.loads(cache.read_text())
        if previous['definition']==definition:return previous
    _,nets=network(folder);result={}
    for name,supply in info['networks'].items():
        graph=nx.Graph();at={};metal=[]
        for k,parts in enumerate(nets[name]['regions']):
            for i,region in enumerate(parts):
                branch,points,widths=medial(region,info['grid_um'])
                for j in branch:
                    node=(k,i,j);graph.add_node(node)
                    key=(k+1,*(round(float(v)*1000) for v in points[j]))
                    assert key not in at
                    at[key]=node
                for a,b,data in branch.edges(data=True):
                    first,second=(k,i,a),(k,i,b)
                    resistance=info['sheet_ohm']*data['squares']
                    connect(graph,first,second,resistance)
                    metal.append(dict(a=first,b=second,r=resistance,layer=k+1,
                        width_um=float(min(widths[a],widths[b])),
                        position_um=((points[a]+points[b])*.5).tolist()))
        nodes={m['net']:at[(m['layer'],*(round(v*1000) for v in m['position_um']))]
               for m in supply['mesh_nodes']}
        labels={node:label for label,node in nodes.items()}
        assert len(labels)==len(nodes)
        for branch in supply['via_branches']:
            connect(graph,nodes[branch['a']],nodes[branch['b']],branch['resistance_ohm'],'via')
        assert nx.is_connected(graph)
        protected=set(nodes.values());todo=[n for n in graph if n not in protected and graph.degree(n)<=2]
        equations=[]
        while todo:
            n=todo.pop()
            if n not in graph or n in protected or graph.degree(n)>2:continue
            adjacent=list(graph[n]);assert adjacent
            if len(adjacent)==2:
                a,b=adjacent;ra,rb=graph[n][a]['r'],graph[n][b]['r']
                equations.append((n,[(a,rb/(ra+rb)),(b,ra/(ra+rb))]))
                connect(graph,a,b,ra+rb,'series')
            else:equations.append((n,[(adjacent[0],1.)]))
            graph.remove_node(n)
            todo.extend(a for a in adjacent if a not in protected and graph.degree(a)<=2)
        assert set(graph)==protected
        original={tuple(sorted((e['a'],e['b']))):e['resistance_ohm'] for e in supply['mesh_edges']}
        reduced={tuple(sorted((labels[a],labels[b]))):d['r'] for a,b,d in graph.edges(data=True)}
        assert set(original)==set(reduced)
        error=max(abs(reduced[n]-r)/r for n,r in original.items())
        assert error<1e-8,(name,error)
        order=list(nodes);indices={label:i for i,label in enumerate(order)}
        weights={n:{indices[label]:1.} for label,n in nodes.items()}
        for n,terms in reversed(equations):
            coefficients=defaultdict(float)
            for other,weight in terms:
                for endpoint,value in weights[other].items():coefficients[endpoint]+=weight*value
            assert abs(sum(coefficients.values())-1)<1e-9
            weights[n]=dict(coefficients)
        # Every series/parallel metal path depends on its two surviving
        # endpoint voltages. Keep the worst density on each such path, so
        # short narrowed sections cannot disappear with series reduction.
        groups={};zero_current=0;sum_error=0.
        for edge in metal:
            coefficients=defaultdict(float)
            for sign,key in ((1,'a'),(-1,'b')):
                for endpoint,value in weights[edge[key]].items():coefficients[endpoint]+=sign*value/edge['r']
            scale=max(map(abs,coefficients.values()))
            coefficients={n:v for n,v in coefficients.items() if abs(v)>max(1e-12,scale*1e-8)}
            if not coefficients:
                zero_current+=1;continue
            assert len(coefficients)==2,(name,edge,coefficients)
            a,b=sorted(coefficients)
            residual=abs(coefficients[a]+coefficients[b])/scale
            sum_error=max(sum_error,residual);assert residual<1e-6
            gain=max(abs(v) for v in coefficients.values())/edge['width_um']
            key=(a,b,edge['layer'])
            if key not in groups or gain>groups[key]['density_gain_a_per_v_um']:
                groups[key]=dict(a=order[a],b=order[b],layer=edge['layer'],
                    density_gain_a_per_v_um=gain,width_um=edge['width_um'],position_um=edge['position_um'])
        result[name]=dict(original_metal_edges=len(metal),zero_current_edges=zero_current,
            reduced_nodes=len(nodes),screened_paths=len(groups),groups=list(groups.values()),
            maximum_reduced_resistance_relative_error=error,maximum_transfer_row_sum_relative_error=sum_error)
        print(name,'wire audit',len(metal),'physical samples ->',len(groups),'current-density paths',flush=True)
    result=dict(definition=definition,networks=result,scope=__doc__)
    write_json(cache,result);return result


def verify(folder, case, name=None):
    case=Path(case).resolve();info=json.loads((case/'power_rc.json').read_text())
    assert info['source_gds_sha256']==sha(Path(folder)/'sram512.gds')
    transfer=model(folder,info)
    raw=case/'sram512_tb.raw'
    if not raw.exists():raw=case/'startup.raw'
    source_report=json.loads((case/'result.json').read_text())
    assert source_report['physical_extraction']['gds_sha256']==info['source_gds_sha256']
    assert source_report['deck_sha256']==sha(case/'test.spice')
    t,w=load_raw(raw);span=float(t[-1]-t[0]);assert span>0
    measurements=[]
    for supply,paths in transfer['networks'].items():
        physical=info['networks'][supply];labels=[n['net'] for n in physical['mesh_nodes']]
        external='vdd' if supply=='VDD' else '0';labels.append(external)
        ids={n:i for i,n in enumerate(labels)};row=[];col=[];values=[]
        edges=physical['mesh_edges']+[dict(a=physical['port_node'],b=external,
                                          resistance_ohm=max(.001,physical['port_lead_resistance_ohm']))]
        for edge in edges:
            a,b=ids[edge['a']],ids[edge['b']]
            # device_lines serializes resistor values with 12 significant
            # digits; use that same value when reconstructing hidden nodes.
            conductance=1/float(f"{edge['resistance_ohm']:.12g}")
            row +=[a,b,a,b];col +=[a,b,b,a];values +=[conductance,conductance,-conductance,-conductance]
        matrix=coo_matrix((values,(row,col)),shape=(len(labels),len(labels))).tocsc()
        known=np.array([i for i,n in enumerate(labels) if n=='0' or 'v('+n+')' in w],dtype=int)
        unknown=np.array(sorted(set(range(len(labels)))-set(known)),dtype=int)
        solve=splu(matrix[unknown,:][:,unknown]) if len(unknown) else None
        cross=matrix[unknown,:][:,known]
        groups=paths['groups'];a=np.array([ids[g['a']] for g in groups]);b=np.array([ids[g['b']] for g in groups])
        gain=np.array([g['density_gain_a_per_v_um'] for g in groups])
        peak=np.zeros(len(groups));square=np.zeros(len(groups));absolute=np.zeros(len(groups))
        previous=None;previous_t=None;kcl=0.
        for first in range(0,len(t),256):
            last=min(first+256,len(t));x=np.asarray(t[first:last]);voltage=np.empty((len(labels),len(x)))
            voltage[known,:]=np.vstack([np.zeros(len(x)) if labels[i]=='0' else w['v('+labels[i]+')'][first:last] for i in known])
            if len(unknown):
                rhs=-cross@voltage[known,:];voltage[unknown,:]=solve.solve(rhs)
                kcl=max(kcl,float(np.max(np.abs(matrix[unknown,:]@voltage))))
            current=np.abs(voltage[a,:]-voltage[b,:])*gain[:,None]
            peak=np.maximum(peak,current.max(axis=1))
            if previous is not None:
                current=np.column_stack((previous,current));x=np.r_[previous_t,x]
            dt=np.diff(x)
            square+=np.sum((current[:,1:]**2+current[:,:-1]**2)*.5*dt,axis=1)
            absolute+=np.sum((current[:,1:]+current[:,:-1])*.5*dt,axis=1)
            previous=current[:,-1];previous_t=float(x[-1])
        assert kcl<1e-7,(supply,kcl,'Reconstruction violates KCL at a node with no load')
        for i,g in enumerate(groups):
            # Conservatively apply the smaller M1 step limit to all M1.
            limit=.0005/2 if g['layer']==1 else .0037/3
            rms=float(np.sqrt(square[i]/span));mean=float(absolute[i]/span)
            measurements.append(dict(supply=supply,**g,peak_a_per_um=float(peak[i]),
                mean_absolute_a_per_um=mean,rms_a_per_um=rms,screen_limit_a_per_um=limit,
                rms_fraction_of_limit=rms/limit,passed=rms<=limit and mean<=limit))
        print(supply,'reconstructed',len(unknown),'unsaved nodes; KCL residual',kcl,'A',flush=True)
    failures=[r for r in measurements if not r['passed']]
    report=dict(passed=not failures,source_gds_sha256=info['source_gds_sha256'],
        checks=2*len(measurements),failure_count=len(failures),failures=failures[:30],
        waveform_sha256=sha(raw),power_model_sha256=sha(case/'power_rc.json'),
        transfer_model_sha256=sha(Path(folder)/'power_wire_transfer.json'),
        source_case_report_sha256=sha(case/'result.json'),
        source_case=case.name,interval_ns=[float(t[0]),float(t[-1])],
        worst_paths=sorted(measurements,key=lambda r:-r['rms_fraction_of_limit'])[:20],
        published_limits=dict(m1_field_a_per_2um=.0009,m1_step_a_per_2um=.0005,m2_field_a_per_3um=.0037),
        method='Exact resistive-node reconstruction and series/parallel current transfer on the existing supply model. Local sampled width is conservative; all M1 uses the smaller step-current rating.',
        reference='Unmodified OS00 reference manual rev1.1, tables I-3-1 and I-3-3.',scope=__doc__)
    output=REPORTS/((name or case.name+'_power_wires')+'.json');write_json(output,report)
    print(output.name,report['passed'],report['checks'],len(failures),flush=True)
    return report


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('folder',type=Path);p.add_argument('case',type=Path)
    p.add_argument('--name');a=p.parse_args();raise SystemExit(0 if verify(a.folder,a.case,a.name)['passed'] else 1)
