#!/usr/bin/env python3
"""Verify the 2x2 schematic against RTL and analog timing/retention checks.

  python3 scripts/verify_serial_spice.py
  python3 scripts/verify_serial_spice.py --reuse build/serial_spice

Default: netlist the existing .sch (never regenerate it), run ngspice, run RTL
with matching external-pin stimulus, compare logic, then check analog windows.
--reuse skips netlisting/SPICE and checks a previously completed simulation.
"""
from pathlib import Path
import argparse
import json
import os
import re
import subprocess
import sys
import numpy as np
from serial_spice_stimulus import scenario, pwl
from verify_rtl import tool, LOCAL_ICARUS
ROOT=Path(__file__).resolve().parents[1]


def run(cmd, directory, log):
    with (directory/log).open('w') as stream:
        result=subprocess.run(list(map(str,cmd)),cwd=directory,stdout=stream,stderr=subprocess.STDOUT)
    text=(directory/log).read_text()
    if result.returncode or re.search(r'Error:|FAIL:|Warning:|Symbol not found',text,re.I):
        raise RuntimeError(f'{log} failed; inspect {directory/log}\n'+text[-2500:])
    return text


def netlist_and_simulate(work,case):
    pdk=Path(os.environ.get('PDK_ROOT','/home/ishi-kai/pdk'))/os.environ.get('PDK','TR-1um')
    lib=pdk/'libs.tech/xschem'
    paths=[ROOT/'learning/schematics', ROOT/'sram512/schematics',Path('/usr/local/share/xschem/xschem_library'),Path('/usr/local/share/xschem/xschem_library/devices'),lib,lib/'TR-1umLIB',lib/'TR-1um_5_stdcell']
    rc=work/'xschemrc'
    rc.write_text('set XSCHEM_LIBRARY_PATH {'+':'.join(map(str,paths))+'}\n'+f'set LIB {{{pdk}/libs.tech/spice/models}}\nset lvs_netlist 0\nset top_is_subckt 0\nset spiceprefix 1\n')
    # ERC messages live in Xschem's info window, not stdout by default.
    # Print them and propagate the netlister status so run() checks both.
    command='set result [xschem netlist]; puts [xschem get infowindow_text]; exit $result'
    run(['xschem','-r','-x','--rcfile',rc,'-s','--command',command,'-o',work,ROOT/'learning/schematics/sram_tb_serial.sch'],work,'netlist.log')
    net=(work/'sram_tb_serial.spice').read_text()
    # Detect edits to the generator/stimulus without corresponding TB updates.
    flat=re.sub(r'\n\+\s*',' ',net)
    for name in ['CLK','RESET','SDI','WE']:
        m=re.search(r'^V'+name+r' \S+ \S+ (PWL\([^\n]+\))',flat,re.M)
        if not m or m[1].split()!=pwl(name,case['timeline']).split():
            raise RuntimeError(f'{name} PWL differs from serial_spice_stimulus.py; update stimulus and TB together')
    (work/'batch.spice').write_text('\n'.join(line for line in net.splitlines() if not line.startswith(('plot ','write '))))
    print(f'Running transistor simulation; progress log: {work/"simulation.log"}',flush=True)
    run(['ngspice','-b','batch.spice'],work,'simulation.log')


def rtl_reference(work,case):
    (work/'input_events.txt').write_text(''.join(' '.join(str(e[k]) for k in ['time','CLK','RESET','SDI','WE'])+'\n' for e in case['timeline']))
    cc=[tool('iverilog')];vv=[tool('vvp')]
    if cc[0]==LOCAL_ICARUS/'bin/iverilog':
        ivl=next((LOCAL_ICARUS/'lib').glob('*/ivl'))
        cc+=['-B',ivl];vv+=['-M',ivl]
    run(cc+['-g2012','-Wall','-s','tb_serial_spice_reference','-o','reference.vvp',ROOT/'sram512/rtl/sram_serial_controller.v',ROOT/'learning/tb/sram_functional_model.v',ROOT/'learning/tb/tb_serial_spice_reference.sv'],work,'rtl_compile.log')
    run(vv+['reference.vvp'],work,'rtl_simulation.log')


def verify(work,case):
    waveform=work/'serial_spice_waveforms.txt'
    with waveform.open() as f: names=f.readline().lower().split()
    data=np.loadtxt(waveform,skiprows=1)
    time=data[:,0]*1e9
    v={n:data[:,i] for i,n in enumerate(names)}
    checks=0;errors=[]
    def level(net,bit,a,b=None,rails=True,tag=''):
        nonlocal checks
        checks+=1
        if b is None:
            values=np.array([np.interp(a,time,v['v('+net.lower()+')'])])
        else:
            values=v['v('+net.lower()+')'][(time>=a)&(time<=b)]
        if not len(values):raise RuntimeError(f'empty window {a}..{b}')
        limit=(4.5 if bit else 0.5) if rails else 2.5
        if not np.isfinite(values).all() or (values.min()<limit if bit else values.max()>limit):
            errors.append(f'{tag} {net} expected {bit} at {a}..{b}: {values.min():.4f}..{values.max():.4f} V')
    # Direct comparison to RTL after each common input edge and async reset.
    ref=(work/'rtl_reference.tsv').read_text().splitlines()
    for line in ref[1:]:
        fields=line.split();t=float(fields[0]);count=int(fields[1]);shift=int(fields[2])
        for i in range(4):level(f'xctrl.C{i}',(count>>i)&1,t,tag='RTL counter')
        for i,n in enumerate(['DIN','CA','RA']):level(n,(shift>>i)&1,t,tag='RTL shared frame')
        for n,b in zip(['RA','CA','DIN','xctrl.W','PREB','WRITE_EN','WL_EN','SAE','SDO'],fields[3:]):
            if b not in ['0','1']:raise RuntimeError(f'unknown RTL expectation: {line}')
            level(n,int(b),t,tag='RTL')
    rtl_checks=checks
    reset_windows=case['reset_windows'] if 'reset_windows' in case else [(0,245),(case['reset_at'],case['reset_at']+245)]
    known={};last_read=0; previous_first=-1
    for i,op in enumerate(case['operations']):
        a=op['e0'];first=op['first'];row=op['row'];col=op['col'];wr=op['write'];bit=op['data'];tag=f'op{i}'
        if any(previous_first < start < first for start,_ in reset_windows):last_read=0
        if op.get('forget_memory_before'):known.clear()
        previous_first=first
        for n,b in [('RA',row),('CA',col),('DIN',bit if wr else 0)]:
            level(n,b,a-65,a+795,tag=tag+' frame hold after last RX')
        level('xctrl.W',wr,a+35,a+795,tag=tag+' mode hold')
        # Address and data now shift while the array is connected. Check all
        # known cells throughout RX, including the cell about to be rewritten.
        for n in ['WL0','WL1','PD_Y','PD_YB']:
            level(n,0,first-10,a-10,tag=tag+' RX disabled')
        level('SAE',1,first-10,a-10,tag=tag+' RX sense isolated')
        for (r,c),b in known.items():
            level(f'Q{r}{c}',b,first-10,a-10,rails=False,tag=tag+' RX retained cell')
            level(f'QB{r}{c}',1-b,first-10,a-10,rails=False,tag=tag+' RX retained cell')
        # Whole inactive windows include state changes and the CLK falling edge.
        for n in ['WL_EN',f'WL{row}']:
            level(n,0,first+35,a+299,tag=tag+' before WL')
            level(n,0,a+535,a+795,tag=tag+' after WL')
        level(f'WL{1-row}',0,first+35,a+795,tag=tag+' other row')
        level(f'WL{row}',1,a+335,a+495,tag=tag+' selected WL')
        for n in ['PD_Y','PD_YB']:
            target=wr and ((n=='PD_YB')==bool(bit))
            if target:
                level(n,0,first+35,a+199,tag=tag+' before PD')
                level(n,1,a+235,a+595,tag=tag+' active PD')
                level(n,0,a+635,a+795,tag=tag+' after PD')
            else:level(n,0,first+35,a+795,tag=tag+' inactive PD')
        for n,b in [('COL0',1-col),('COL1',col)]:level(n,b,a+35,a+795,tag=tag+' column')
        for n in ['BL0','BLB0','BL1','BLB1','Y','YB']:level(n,1,a+80,a+95,tag=tag+' precharge')
        if not wr:
            for n in ['SOUT','SOUTB']:level(n,1,a+80,a+95,tag=tag+' SA reset')
            level('SOUT',bit,a+450,a+695,tag=tag+' read sense')
            level('SOUTB',1-bit,a+450,a+695,tag=tag+' read sense')
        for (r,c),b in known.items():
            if wr and (r,c)==(row,col):continue
            level(f'Q{r}{c}',b,first+35,a+795,rails=False,tag=tag+' retained cell')
            level(f'QB{r}{c}',1-b,first+35,a+795,rails=False,tag=tag+' retained cell')
        if wr:known[row,col]=bit
        for (r,c),b in known.items():
            level(f'Q{r}{c}',b,a+750,a+790,tag=tag+' stored')
            level(f'QB{r}{c}',1-b,a+750,a+790,tag=tag+' stored')
        level('SDO',last_read,first+35,a+599 if not wr else a+795,tag=tag+' result hold')
        if not wr:
            last_read=bit;level('SDO',bit,a+635,a+795,tag=tag+' captured result')
    # Check settled outputs of each asynchronous RESET assertion. Retention
    # during access interruption is deliberately outside the memory contract.
    for assertion,end in reset_windows:
        start=assertion+35
        for n in ['RA','CA','DIN','xctrl.W','SDO','WL_EN','WRITE_EN','WL0','WL1','PD_Y','PD_YB']+[f'xctrl.C{i}' for i in range(4)]:level(n,0,start,end,tag='async RESET')
        for n in ['PREB','SAE']:level(n,1,start,end,tag='async RESET')
    if errors:
        (work/'failures.txt').write_text('\n'.join(errors)+'\n')
        raise RuntimeError(f'{len(errors)} / {checks} checks failed:\n'+'\n'.join(errors[:25])+f'\nFull report: {work/"failures.txt"}')
    report={'operations':len(case['operations']),'rtl_checks':rtl_checks,'analog_checks':checks-rtl_checks,'total_checks':checks,'stop_ns':case['stop']}
    (work/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
    print(f'PASS: {report["operations"]} serial operations, {rtl_checks} RTL comparisons, {checks-rtl_checks} analog interval checks',flush=True)
    return report


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--reuse',type=Path,help='directory containing completed SPICE waveforms')
    args=parser.parse_args()
    work=(args.reuse or ROOT/'build/serial_spice').resolve();work.mkdir(parents=True,exist_ok=True)
    case=scenario()
    if not args.reuse:netlist_and_simulate(work,case)
    rtl_reference(work,case)
    verify(work,case)

if __name__=='__main__':
    try:main()
    except (RuntimeError,OSError,ValueError,KeyError) as error:
        print(f'ERROR: {error}',file=sys.stderr);sys.exit(1)
