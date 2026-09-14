#!/usr/bin/env python3
"""Open a learning schematic with shared cells and the pinned dev PDK."""
import argparse
import os
from pathlib import Path
import sys

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'scripts'))
from pdk_profiles import environment,pdk_path

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('schematic',nargs='?',default='sram_tb_serial.sch')
a=p.parse_args()
source=ROOT/'learning/schematics'/a.schematic
if not source.is_file():p.error(f'Not found: {source}')
lib=pdk_path('dev')/'libs.tech/xschem'
work=ROOT/'build/learning_gui';work.mkdir(parents=True,exist_ok=True)
paths=[source.parent,ROOT/'sram512/schematics',Path('/usr/local/share/xschem/xschem_library'),
       Path('/usr/share/xschem/xschem_library'),lib,lib/'TR-1umLIB',lib/'TR-1um_5_stdcell']
rc=work/'xschemrc'
rc.write_text('set XSCHEM_LIBRARY_PATH {'+':'.join(map(str,paths))+'}\n'
              +f'set LIB {{{pdk_path("dev")}/libs.tech/spice/models}}\n'
              +f'set netlist_dir {{{work}}}\nset lvs_netlist 0\nset spiceprefix 1\n')
os.chdir(work)
os.execvpe('xschem',['xschem','--rcfile',str(rc),str(source)],environment('dev'))
