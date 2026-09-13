#!/usr/bin/env python3
"""Explicit scalable version of the existing serial SRAM circuit.

Standard-cell pin order and transistor definitions come from a fresh Xschem
netlist, not a guessed logical pin order. No changes to user schematics.
"""
from collections import Counter
from pathlib import Path
import math, re
ROOT = Path(__file__).resolve().parents[2]


class Circuit:
    def __init__(self, source):
        self.defs = {m[1].lower(): (m[1],m[2].split(),m[0]) for m in re.finditer(
            r'(?ims)^\.subckt\s+(\S+)[ \t]+([^\n]+)\n.*?^\.ends[^\n]*', source)}
        self.lines = [];self.bom = Counter();self.parts = [];self.number = 0

    def gate(self, kind, name=None, **nets):
        self.number += 1
        name = name or f'g{self.number}'
        real,pins,_ = self.defs[kind.lower()]
        mapping = {'VDD':'VDD','GND':'0',**nets}
        assert set(pins) <= mapping.keys(), (kind,pins,mapping)
        self.lines.append('X'+name+' '+' '.join(mapping[p] for p in pins)+' '+real)
        self.bom[real] += 1
        self.parts.append(dict(name=name,kind=real,nets=mapping))
        return nets.get('Y',nets.get('Q'))

    def logic(self, op, inputs, out=None):
        assert inputs
        if len(inputs) == 1:
            assert out is None or out == inputs[0]
            return inputs[0]
        while len(inputs) > 4:
            inputs = [self.logic(op,inputs[:4])] + inputs[4:]
        kind = f'AND{len(inputs)}_X1' if op == 'AND' else f'OR{len(inputs)}'
        out = out or f'logic{self.number+1}'
        return self.gate(kind,Y=out,**dict(zip('ABCD',inputs)))

    def inverse(self, inp, out):return self.gate('INV_X1',A=inp,Y=out)

    def dff(self, d, q, qb=None):
        self.gate('DFFR',name='ff_'+q,D=d,Q=q,QB=qb or q+'B',CK='CLK',RST='RESET')

    def hold(self, d, q, enable):
        mx=self.gate('MUX2',A=q,B=d,S=enable,Y=q+'_next');self.dff(mx,q)

    def equals(self, width, value):
        return self.logic('AND',[f'C{i}'+('' if value>>i&1 else 'B') for i in range(width)])

    def less(self, width, value):
        terms=[]
        for i in range(width):
            if value>>i&1:
                inputs=[f'C{i}B']+[f'C{j}'+('' if value>>j&1 else 'B') for j in range(i+1,width)]
                terms.append(self.logic('AND',inputs))
        return self.logic('OR',terms)

    def controller(self, rb, cb, share_frame=True):
        n=rb+cb+1;k=(n+7).bit_length()
        run=self.less(k,n+7)
        for i in range(k):
            if i==0:toggle='C0B'
            else:
                carry=self.logic('AND',[f'C{j}' for j in range(i)])
                toggle=self.gate('XOR2',A=f'C{i}',B=carry,Y=f'toggle{i}')
            d=self.logic('AND',[toggle,run]);self.dff(d,f'C{i}')
        rx=self.less(k,n);e=[self.equals(k,n+i) for i in range(8)]
        self.dff(e[0],'PC_ON','PREB')
        self.dff(self.logic('OR',[e[3],e[4]]),'WL_EN')
        window=self.logic('OR',e[2:6])
        self.dff(self.logic('AND',[window,'W']),'WRITE_EN')
        web=self.inverse('WE','WE_B')
        track0=self.logic('AND',[web,e[0]])
        tracklater=self.logic('AND',[self.logic('OR',e[1:4]),'WB'])
        self.dff(self.logic('OR',[track0,tracklater]),'TRACK','SAE')
        # The receive FFs also hold the active frame. Their Q/QB directly feed
        # the data path and address predecoders; no extra transfer at E0.
        frame=['DIN']+[f'CA{i}' for i in range(cb)]+[f'RA{i}' for i in range(rb)]
        shift=frame if share_frame else [f'SR{i}' for i in range(n)]
        for i,q in enumerate(shift):self.hold('SDI' if i==0 else shift[i-1],q,rx)
        if not share_frame:
            # Explicit historical mode for reproducing the earlier area audit.
            for source,q in zip(shift,frame):self.hold(source,q,e[0])
        self.hold('WE','W',e[0])
        self.hold('SOUT','SDO',self.logic('AND',[e[6],'WB']))
        return dict(row_bits=rb,col_bits=cb,receive_bits=n,counter_bits=k,
                    flipflops=k+n+6+(0 if share_frame else n),clocks_per_operation=n+8,
                    shared_frame=share_frame,shift_nets=shift)

    def decoder(self, bits, prefix, output, enable=None, combined=True):
        # Reuse QB from address FFs. Two/three-bit predecode limits fan-in.
        if bits<=3:
            groups=[list(range(bits))]
        elif bits<=5:groups=[list(range(2)),list(range(2,bits))]
        elif bits==6:groups=[list(range(3)),list(range(3,6))]
        else:raise ValueError('Decoder study supports up to six address bits')
        assert all(len(g)<=3 for g in groups)
        terms=[]
        for group in groups:
            terms.append([self.logic('AND',[f'{prefix}{i}'+('' if v>>j&1 else 'B')
                          for j,i in enumerate(group)]) for v in range(2**len(group))])
        for value in range(2**bits):
            inputs=[]
            for group,groupterms in zip(groups,terms):
                sub=sum(((value>>i)&1)<<j for j,i in enumerate(group))
                inputs.append(groupterms[sub])
            if enable:inputs.append(enable)
            if len(inputs)==1:
                # A local non-inverting driver is needed even after predecode.
                t=self.inverse(inputs[0],f'{output}{value}B')
                self.inverse(t,f'{output}{value}')
            elif combined:self.logic('AND',inputs,out=f'{output}{value}')
            else:
                t=self.gate(f'NAND{len(inputs)}',Y=f'{output}{value}B',**dict(zip('ABCD',inputs)))
                self.inverse(t,f'{output}{value}')

    def write_control(self):
        self.gate('write_control',DIN='DIN',WRITE_EN='WRITE_EN',PD_Y='PD_Y',
                  PD_YB='PD_YB',VSS='0')

    def definitions(self):
        # Include all source subcircuits except the original top-level blocks.
        excluded={'sram','row_decoder_1to2','col_decoder_1to2','sram_serial_controller'}
        return '\n'.join(v[2] for k,v in self.defs.items() if k not in excluded)


def source_text():
    return (ROOT/'build/sram_macro_study/serial/sram_tb_serial.spice').read_text()


def digital(rb,cb,combined=True,share_frame=True):
    c=Circuit(source_text());meta=c.controller(rb,cb,share_frame=share_frame);ctrl=c.bom.copy()
    c.decoder(rb,'RA','WL','WL_EN',combined);row=c.bom-ctrl
    before=c.bom.copy();c.decoder(cb,'CA','COL',combined=combined);col=c.bom-before
    c.write_control()
    return c,meta,dict(controller=dict(ctrl),row_decoder=dict(row),col_decoder=dict(col))
