#!/usr/bin/env python3
"""Export readable, zoomable copies of the actual editable schematics."""
from common import *


def main():
    work=WORK/'schematic_previews';work.mkdir(parents=True,exist_ok=True)
    output=HERE/'diagrams';output.mkdir(exist_ok=True)
    paths=[SCHEMATICS,Path('/usr/local/share/xschem/xschem_library'),
           Path('/usr/local/share/xschem/xschem_library/devices'),LIB,
           LIB/'TR-1umLIB',LIB/'TR-1um_5_stdcell']
    rc=work/'xschemrc'
    rc.write_text('set XSCHEM_LIBRARY_PATH {'+':'.join(map(str,paths))+'}\n'
                  +f'set LIB {{{PDK}/libs.tech/spice/models}}\nset dark_colorscheme 0\n')
    # Explicit extents retain the free-standing explanatory text, which
    # Xschem's default export zoom can leave outside the viewport.
    views={
        'sram512':(-1400,-1200,7700,3600),
        'sram512_controller':(-1250,-950,1680,1650),
        'sram512_frame':(-750,-450,3800,1150),
        'sram512_phase':(-750,-550,3050,2480),
    }
    records=[]
    for name,bounds in views.items():
        source=SCHEMATICS/(name+'.sch');target=output/(name+'.svg')
        width=2400 if name in ('sram512','sram512_frame') else 1800
        height=round(width*(bounds[3]-bounds[1])/(bounds[2]-bounds[0]))
        command=f'xschem set text_svg 1; xschem print svg {{{target}}} {width} {height} '+ ' '.join(map(str,bounds))+'; exit'
        run(['xschem','-r','-x','--rcfile',rc,'--command',command,source],work,name+'.log')
        assert target.is_file() and target.stat().st_size>1000
        records.append(dict(schematic=source.name,schematic_sha256=sha(source),
                            image=str(target.relative_to(ROOT)),image_sha256=sha(target)))
    report=dict(passed=True,views=records,scope='Direct Xschem SVG exports; the .sch files remain authoritative and editable.')
    write_json(REPORTS/'schematic_previews.json',report)
    print('Exported',len(records),'schematic views',flush=True)
    return report


if __name__=='__main__':main()
