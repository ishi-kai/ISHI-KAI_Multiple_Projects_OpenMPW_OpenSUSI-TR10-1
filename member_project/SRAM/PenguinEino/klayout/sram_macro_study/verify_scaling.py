#!/usr/bin/env python3
"""Check generated gate logic against RTL and sweep distributed WL load.

WL resistance/capacitance are sensitivity assumptions, NOT foundry PEX values.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib,json,re,sys
import numpy as np
from macro_model import Circuit,source_text
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path.insert(0,str(ROOT/'scripts'))
from verify_rtl import tool,LOCAL_ICARUS,run
PDK=Path('/home/ishi-kai/pdk/TR-1um')
WORK=ROOT/'build/sram_macro_study/scaling'


def logic_test(rb,cb):
    c=Circuit(source_text());meta=c.controller(rb,cb)
    c.decoder(rb,'RA','WL','WL_EN');c.decoder(cb,'CA','COL')
    n=meta['receive_bits'];k=meta['counter_bits']
    work=WORK/f'logic_{rb}_{cb}';work.mkdir(parents=True,exist_ok=True)
    lines=['`timescale 1ns/1ps','module test;',
           'reg CLK=0, RESET=0, SDI=0, WE=0, SOUT=0;']
    nets=set();regs=set()
    for p in c.parts:
        nets.update(p['nets'].values())
        if p['kind']=='DFFR':regs.add(p['nets']['Q'])
    nets-=regs|{'CLK','RESET','SDI','WE','SOUT','VDD','0'}
    lines+=['wire '+','.join(sorted(nets))+';','reg '+','.join(sorted(regs))+';']
    for p in c.parts:
        kind=p['kind'];m=p['nets']
        if kind=='DFFR':
            lines += [f"always @(posedge CLK or posedge RESET) if (RESET) {m['Q']}<=0; else {m['Q']}<={m['D']};",
                      f"assign {m['QB']}=~{m['Q']};"]
        elif kind=='MUX2':lines.append(f"assign {m['Y']}={m['S']} ? {m['B']} : {m['A']};")
        elif kind=='INV_X1':lines.append(f"assign {m['Y']}=~{m['A']};")
        else:
            op='^' if kind=='XOR2' else '&' if kind.startswith('AND') else '|'
            expr=op.join(m[a] for a in 'ABCD' if a in m)
            lines.append(f"assign {m['Y']}=({expr});")
    outputs=['DIN','PREB','WRITE_EN','WL_EN','SAE','SDO']
    lines += [f'wire [{rb-1}:0] ref_ra;',f'wire [{cb-1}:0] ref_ca;',
              'wire '+','.join('ref_'+n.lower() for n in outputs)+';']
    ports=['.CLK(CLK)','.RESET(RESET)','.SDI(SDI)','.WE(WE)','.SOUT(SOUT)',
           '.RA(ref_ra)','.CA(ref_ca)']+['.'+o+'(ref_'+o.lower()+')' for o in outputs]
    lines.append(f'sram_serial_controller #(.ROW_BITS({rb}),.COL_BITS({cb})) reference('+','.join(ports)+');')
    def vector(prefix,count):return '{'+','.join(f'{prefix}{i}' for i in reversed(range(count)))+'}'
    checks=[(vector('RA',rb),'ref_ra'),(vector('CA',cb),'ref_ca'),
            (vector('C',k),'reference.count'),
            ('{'+','.join(reversed(meta['shift_nets']))+'}','reference.shift_reg')]
    checks +=[(o,'ref_'+o.lower()) for o in outputs]+[('W','reference.W')]
    lines+=['integer cycle; integer seed=271828;', 'task check; begin']
    for lhs,rhs in checks:
        lines.append(f'if ({lhs} !== {rhs}) $fatal(1,"mismatch {lhs} cycle %0d",cycle);')
    for r in range(2**rb):lines.append(f'if (WL{r} !== (ref_wl_en && ref_ra=={rb}\'d{r})) $fatal(1,"row decode");')
    for col in range(2**cb):lines.append(f'if (COL{col} !== (ref_ca=={cb}\'d{col})) $fatal(1,"col decode");')
    lines+=['end endtask', 'initial begin #1; RESET=1; #1; check; #2; RESET=0;',
            'for (cycle=0;cycle<2048;cycle=cycle+1) begin',
            'SDI=$random(seed); WE=$random(seed); SOUT=$random(seed);',
            'if (cycle%137==71) begin RESET=1; #1; check; #1; RESET=0; end',
            '#5; CLK=1; #1; check; #4; CLK=0; end',
            '$display("PASS 2048 clock cycles and asynchronous resets"); $finish; end endmodule']
    (work/'test.sv').write_text('\n'.join(lines)+'\n')
    cc=[tool('iverilog')];vv=[tool('vvp')]
    if cc[0]==LOCAL_ICARUS/'bin/iverilog':
        ivl=next((LOCAL_ICARUS/'lib').glob('*/ivl'));cc+=['-B',ivl];vv+=['-M',ivl]
    run(cc+['-g2012','-s','test','-o','sim',ROOT/'sram512/rtl/sram_serial_controller.v','test.sv'],work,'compile.log')
    log=run(vv+['sim'],work,'simulation.log');assert 'PASS' in log
    print(f'Gate vs RTL {2**rb} x {2**cb}: PASS',flush=True)
    return dict(row_bits=rb,col_bits=cb,cycles=2048,pass_=True,
        controller_bom=dict(CircuitControllerBom(rb,cb)),
        netlist_sha256=hashlib.sha256(('\n'.join(c.lines)).encode()).hexdigest())


def CircuitControllerBom(rb,cb):
    c=Circuit(source_text());c.controller(rb,cb);return c.bom


def wl_case(args):
    interval,rs,cwire,temp=args
    work=WORK/f'wl_{interval}_{rs}_{cwire}_{temp}';work.mkdir(exist_ok=True)
    inv=Circuit(source_text()).defs['inv_x1'][2]
    lines=['Distributed WL sensitivity; 32 columns, actual MOS gate loads',
        f'.include {PDK}/libs.tech/spice/models/ip62_models',f'.temp {temp}',
        'VDD VDD 0 5','Vin IN 0 PULSE(5 0 10n 1n 1n 80n 1000n)',
        'Xdriver VDD IN DRIVE 0 INV_X1',inv]
    for bank in range(32//interval):
        lines.append(f'Rmetal{bank} DRIVE b{bank}_start 20')
        for col in range(interval):
            prev=f'b{bank}_{col-1}' if col else f'b{bank}_start';node=f'b{bank}_{col}'
            # 23.2 um long, 1 um wide GC segment; two access gate loads per bit.
            lines += [f'R{bank}_{col} {prev} {node} {23.2*rs}',
                      f'C{bank}_{col} {node} 0 {23.2*cwire}f',
                      f'XA{bank}_{col} VDD {node} 0 0 NMOS W=3.4u L=1u',
                      f'XB{bank}_{col} VDD {node} VDD 0 NMOS W=3.4u L=1u']
    far=f'b0_{interval-1}'
    lines += ['.control','tran 0.1n 400n',
              f'meas tran t90 TRIG v(IN) VAL=2.5 FALL=1 TARG v({far}) VAL=4.5 RISE=1',
              f'meas tran t10 TRIG v(IN) VAL=2.5 RISE=1 TARG v({far}) VAL=0.5 FALL=1',
              f'meas tran v35 FIND v({far}) AT=45.5n',
              'set wr_singlescale','set wr_vecnames',f'wrdata wl.txt v(IN) v(DRIVE) v({far})','quit','.endc','.end']
    deck='\n'.join(lines)+'\n';path=work/'test.spice';path.write_text(deck)
    log=run(['ngspice','-b','test.spice'],work,'simulation.log')
    assert not re.search(r'(?im)^error|failed|^warning',log),log[-2000:]
    values={m[1]:float(m[2]) for m in re.finditer(r'(?im)^(t90|t10|v35)\s*=\s*([-+\d.eE]+)',log)}
    assert len(values)==3
    return dict(interval=interval,rs_ohm_sq=rs,cwire_ff_um=cwire,temperature_c=temp,
                rise90_ns=values['t90']*1e9,fall10_ns=values['t10']*1e9,
                voltage_after_35ns=values['v35'],pass_35ns=values['v35']>=4.5,
                deck_sha256=hashlib.sha256(deck.encode()).hexdigest())


def main():
    WORK.mkdir(parents=True,exist_ok=True)
    logic=[logic_test(*s) for s in [(1,1),(3,5),(4,4),(4,5),(5,4),(4,6)]]
    cases=[(n,r,c,t) for n in (4,8,16) for r in (10,30,120,300) for c in (.1,.3) for t in (27,85)]
    with ThreadPoolExecutor(max_workers=2) as pool:wl=list(pool.map(wl_case,cases))
    report=dict(gate_logic_vs_rtl=logic,wl_sensitivity=wl,
        rtl_sha256=hashlib.sha256((ROOT/'sram512/rtl/sram_serial_controller.v').read_bytes()).hexdigest(),
        scope='Gate functional comparison uses zero delay. WL sweep uses PDK MOS, assumed GC sheet R and wire C, 20 ohm M2 branch R, 32 columns; not PEX or full-array read/write.',
        model_sha256=hashlib.sha256((PDK/'libs.tech/spice/models/models_IP62_mos_v2.lib').read_bytes()).hexdigest())
    (HERE/'scaling_results.json').write_text(json.dumps(report,indent=2)+'\n')
    for n in (4,8,16):
        subset=[x for x in wl if x['interval']==n]
        print(n,'max rise90 ns',max(x['rise90_ns'] for x in subset),'35ns passes',sum(x['pass_35ns'] for x in subset),'/',len(subset))


if __name__=='__main__':main()
