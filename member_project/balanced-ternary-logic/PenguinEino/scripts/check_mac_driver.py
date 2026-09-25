"""Separate physically driven fixture: distinguish floating input warnings from core faults."""
from concurrent.futures import ThreadPoolExecutor
import json,sys
import klayout.db as db
import verify_arithmetic_layout as verify
sys.path.insert(0,str(verify.ROOT/'layout'))
from arithmetic_helpers import Route,port

def main():
 root=verify.ROOT;ly=db.Layout();ly.read(str(root/'mac.gds'));mac=ly.cell('mac')
 meta=json.loads((root/'layout/mac.ports.json').read_text())
 vdd_y=meta['ports']['VDD']['position_um'][1]
 top=ly.create_cell('mac_driver_check');top.insert(db.CellInstArray(mac.cell_index(),db.Trans()));d=Route(ly,top)
 # All external input routes land on a separate VDD test spine at x=0.
 for net in ('a','b','x','cin'):
  p=meta['ports'][net];px,py=p['position_um']
  d.route('VDD','M1',[(0,py),(px,py)]);d.via('VDD',0,py)
  if p['layer']==[20,0]:d.via('VDD',px,py)
 ymin=min(meta['ports'][n]['position_um'][1] for n in ('a','b','x','cin'))
 d.route('VDD','M2',[(0,ymin),(0,vdd_y)]);d.via('VDD',0,vdd_y)
 d.route('VDD','M1',[(0,vdd_y),(20,vdd_y)])
 for n in ('sum','cout','and_out','or_out','VDD','VSS','VMID'):
  p=meta['ports'][n];port(d,n,'M1' if p['layer']==[13,0] else 'M2',*p['position_um'])
 folder=verify.WORK/'mac_driver';folder.mkdir(parents=True,exist_ok=True);gds=folder/'driver.gds';ly.write(str(gds))
 ref=folder/'reference.spice';ref.write_text(verify.reference('mac').read_text()+'\n.subckt mac_driver_check sum cout and_out or_out VDD VSS VMID\nXdut VDD VDD VDD VDD sum cout VDD VSS VMID and_out or_out mac\n.ends\n')
 with ThreadPoolExecutor(max_workers=3) as pool:
  fs=[pool.submit(verify.drc,gds,top.name,folder/'drawing'),pool.submit(verify.lvs,top.name,gds,ref,folder/'lvs'),pool.submit(verify.mask,gds,top.name,folder/'manufacturing')]
  r=dict(source_sha256=verify.sha(root/'mac.gds'),scope='Separate fixture tying the four external inputs to VDD. Functional MAC unchanged. No waivers.',**dict(zip(('drawing_drc','lvs','mask_drc'),[f.result() for f in fs])))
 r['passed']=all(r[k]['passed'] for k in ('drawing_drc','lvs','mask_drc'));(root/'reports/mac_driver.json').write_text(json.dumps(r,indent=2)+'\n');print(json.dumps(r,indent=2))
 if not r['passed']:raise RuntimeError('Driver fixture failed')
if __name__=='__main__':main()
