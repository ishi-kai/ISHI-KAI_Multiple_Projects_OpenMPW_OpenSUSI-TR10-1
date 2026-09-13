#!/usr/bin/env python3
"""Open the dedicated schematic with the same dev PDK as the verification."""
import argparse
from common import *

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--circuit',action='store_true',help='open physical circuit instead of testbench')
args=p.parse_args()
w=WORK/'gui';w.mkdir(parents=True,exist_ok=True)
paths=[SCHEMATICS,Path('/usr/local/share/xschem/xschem_library'),
       Path('/usr/local/share/xschem/xschem_library/devices'),LIB,LIB/'TR-1umLIB',LIB/'TR-1um_5_stdcell']
rc=w/'xschemrc'
rc.write_text('set XSCHEM_LIBRARY_PATH {'+':'.join(map(str,paths))+'}\n'
    +f'set LIB {{{PDK}/libs.tech/spice/models}}\n'
    +f'set netlist_dir {{{w}}}\nset lvs_netlist 0\nset spiceprefix 1\n'
    +f'set top_is_subckt {int(args.circuit)}\n')
os.chdir(ROOT)
os.execvpe('xschem',['xschem','--rcfile',str(rc),str(SCHEMATICS/('sram512.sch' if args.circuit else 'sram512_tb.sch'))],ENV)
