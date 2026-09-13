#!/usr/bin/env python3
"""Check actual Xschem connectivity, then exercise that gate network against RTL."""
from collections import defaultdict,Counter
from common import *
from design import blocks
from verify_rtl import tool,LOCAL_ICARUS

def parse(source):
    source=re.sub(r'\n\+\s*',' ',source)
    result={}
    for m in re.finditer(r'(?ims)^\.subckt\s+(\S+)[ \t]+([^\n]+)\n(.*?)^\.ends[^\n]*',source):
        result[m[1].lower()]={'pins':m[2].lower().split(),'lines':[line.lower().split() for line in m[3].splitlines() if line.lower().startswith('x')]}
    return result

def connectivity(defs):
    results=[]
    for b in blocks():
        actual=defs[b.name];instances={line[0][1:]:line for line in actual['lines']}
        assert set(instances)=={p['name'].lower() for p in b.parts},b.name
        aliases={n.lower():n.lower() for n in b.ports}
        pairs=[]
        for p in b.parts:
            line=instances[p['name'].lower()]
            assert line[-1]==p['kind'].lower(),p
            expect={n.lower():v.lower() for n,v in p['nets'].items()}
            for pin,net in zip(defs[line[-1]]['pins'],line[1:-1]):pairs.append((expect[pin],net))
        for ideal,actual in pairs:
            if ideal in aliases:assert aliases[ideal]==actual,(b.name,ideal,aliases[ideal],actual)
            else:aliases[ideal]=actual
        assert len(set(aliases.values()))==len(aliases),(b.name,'shorted intended nets')
        results.append({'block':b.name,'parts':len(instances),'checked_pin_connections':len(pairs),'passed':True})
    arr=defs['sram512_array'];actual={line[0][1:]:dict(zip(defs[line[-1]]['pins'],line[1:-1])) for line in arr['lines']}
    assert len(actual)==512
    for r in range(16):
        for c in range(32):
            assert actual[f'r{r}c{c}']==dict(wl=f'wl{r}',bl=f'bl{c}',blb=f'blb{c}',vdd='vdd',vss='vss'),(r,c)
    results.append({'block':'sram512_array','cells':512,'checked_pin_connections':2560,'passed':True})
    return results

def identifier(name):return 'n_'+re.sub(r'[^a-zA-Z0-9_]','_',name)

def digital_parts(defs):
    parts=[]
    omitted={'sram512_array','sram512_column','sense_amp_7t'}
    def descend(kind,path,mapping):
        for line in defs[kind]['lines']:
            sub=line[-1]
            if sub not in defs:
                assert line[5] in ('nmos','pmos'),line
                continue
            nets={pin:mapping.get(net,path+net) for pin,net in zip(defs[sub]['pins'],line[1:-1])}
            name=path+line[0]
            if sub in omitted:continue
            if sub.startswith('sram512_'):descend(sub,name+'__',nets)
            else:parts.append({'name':name,'kind':sub,'nets':nets})
    descend('sram512','',{p:p for p in defs['sram512']['pins']})
    return parts

def verilog(defs):
    parts=digital_parts(defs)
    regnets={p['nets']['q'] for p in parts if p['kind']=='dffr'}
    nets={n for p in parts for n in p['nets'].values()}
    assert len({identifier(n) for n in nets})==len(nets)
    lines=['// Generated from actual sram512.sch Xschem netlist; functional verification only.',
        '`timescale 1ns/1ps','`default_nettype none',
        'module sram512_digital_gates(input wire CLK, RESET, SDI, WE, SOUT,',
        'output wire SDO, PREB, SAE, WL_EN, WRITE_EN, DIN, PD_Y, PD_YB,',
        'output wire [3:0] RA, output wire [4:0] CA, COUNT,',
        'output wire [15:0] WL, output wire [31:0] COL);']
    lines += ['reg '+','.join(identifier(n) for n in sorted(regnets))+';',
              'wire '+','.join(identifier(n) for n in sorted(nets-regnets))+';']
    for n in ('CLK','RESET','SDI','WE','SOUT'):lines.append(f'assign {identifier(n.lower())}={n};')
    lines += ["assign n_vdd=1'b1;", "assign n_vss=1'b0;"]
    for p in parts:
        k=p['kind'];m={pin:identifier(n) for pin,n in p['nets'].items()}
        if k=='dffr':
            lines += [f'always @(posedge {m["ck"]} or posedge {m["rst"]}) if ({m["rst"]}) {m["q"]}<=0; else {m["q"]}<={m["d"]};',
                      f'assign {m["qb"]}=~{m["q"]};']
        else:
            if k=='mux2':expr=f'{m["s"]}?{m["b"]}:{m["a"]}'
            elif k.startswith('inv'):expr='~'+m['a']
            elif k.startswith('buf'):expr=m['a']
            else:
                op='^' if k=='xor2' else '&' if k.startswith(('and','nand')) else '|' if k.startswith(('or','nor')) else None
                assert op,k
                expr='('+op.join(m[a] for a in 'abcd' if a in m)+')'
                if k.startswith(('nand','nor')):expr='~'+expr
            lines.append(f'assign {m["y"]}={expr};')
    for n in ('SDO','PREB','SAE','WL_EN','WRITE_EN','DIN','PD_Y','PD_YB'):
        assert n.lower() in nets,n
        lines.append(f'assign {n}={identifier(n.lower())};')
    for port,prefix,n in [('RA','ra',4),('CA','ca',5),('WL','wl',16),('COL','col',32),('COUNT','xctrl__xphase__c',5)]:
        lines.append(f'assign {port}='+'{'+','.join(identifier(prefix+str(i)) for i in reversed(range(n)))+'};')
    lines+=['endmodule','`default_nettype wire']
    path=ROOT/'sram512/rtl/sram512_digital_gates.v';path.write_text('\n'.join(lines)+'\n')
    assert len(regnets)==21,len(regnets)
    return {'flipflops':len(regnets),'standard_cells':len(parts),'gate_bom':dict(Counter(p['kind'] for p in parts)),'verilog_sha256':sha(path)}

def main():
    source=netlist(ROOT/'sram512/schematics/sram512.sch',WORK/'schematic')
    defs=parse(source.read_text());result={'connectivity':connectivity(defs),'gate_network':verilog(defs),
        'schematic_netlist_sha256':sha(source),'rtl_sha256':sha(ROOT/'sram512/rtl/sram_serial_controller.v')}
    cc=[tool('iverilog')];vv=[tool('vvp')]
    if cc[0]==LOCAL_ICARUS/'bin/iverilog':
        ivl=next((LOCAL_ICARUS/'lib').glob('*/ivl'));cc+=['-B',ivl];vv+=['-M',ivl]
    work=WORK/'digital'
    run(cc+['-g2012','-Wall','-s','tb_sram512','-o','sim',ROOT/'sram512/rtl/sram_serial_controller.v',
         ROOT/'sram512/rtl/sram512_digital_gates.v',ROOT/'sram512/tb/tb_sram512.sv'],work,'compile.log')
    _,log=run(vv+['sim'],work,'simulation.log')
    assert 'PASS' in log and 'FAIL' not in log,log
    result.update(passed=True,simulation=log.strip());write_json(REPORTS/'digital.json',result);print(log)

if __name__=='__main__':main()
