"""Export device-level schematic crops for the submission specification."""
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'submission';WORK=ROOT/'simulation/spec_figures'
CELLS={'inverter':(0,0,930,880),'mul_nand':(100,0,930,1040),'mul_nor':(100,0,930,1140),'nany':(-340,-520,980,640)}
def main():
 WORK.mkdir(parents=True,exist_ok=True)
 rc=WORK/'xschemrc'
 rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{ROOT}:/usr/local/share/xschem/xschem_library:/home/ishi-kai/pdk/TR-1um/libs.tech/xschem}}\nset dark_colorscheme 0\n')
 records={}
 for name,bounds in CELLS.items():
  svg=OUT/f'{name}_schematic.svg';x1,y1,x2,y2=bounds
  cmd=f'xschem set text_svg 1; xschem print svg {{{svg}}} {x2-x1} {y2-y1} {x1} {y1} {x2} {y2}; exit'
  p=subprocess.run(['xschem','-r','-x','--rcfile',str(rc),'--command',cmd,str(ROOT/f'{name}.sch')],capture_output=True,text=True)
  assert p.returncode==0 and svg.exists() and svg.stat().st_size>1000,p.stderr
  svg.write_text(svg.read_text().replace('stroke-width: 0.24;','stroke-width: 1.1;'))
  records[name]={'source_sha256':hashlib.sha256((ROOT/f'{name}.sch').read_bytes()).hexdigest(),'image_sha256':hashlib.sha256(svg.read_bytes()).hexdigest(),'crop':bounds}
 (ROOT/'reports/spec_gate_figures.json').write_text(json.dumps(records,indent=2)+'\n')
if __name__=='__main__':main()
