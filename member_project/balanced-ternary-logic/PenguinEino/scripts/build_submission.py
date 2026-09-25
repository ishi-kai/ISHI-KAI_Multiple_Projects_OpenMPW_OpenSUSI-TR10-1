"""Package the current MAC with local schematic dependencies and portable GDS."""
from pathlib import Path
import argparse,hashlib,json,re,shutil,subprocess,zipfile
import klayout.db as db
import check_mac as logic
ROOT=logic.ROOT;PDK=logic.PDK;OUT=ROOT/'submission';WORK=ROOT/'simulation/submission'
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def dependencies():
 pending=[ROOT/'mac.sch',ROOT/'mac.sym',ROOT/'mac_tb.sch'];found=set()
 while pending:
  p=pending.pop()
  if p in found:continue
  assert p.is_file(),p
  found.add(p)
  for ref in re.findall(r'^C \{([^}]+)\}',p.read_text(),re.M):
   if ref.startswith(('devices/','TR-1umLIB/')):continue
   q=Path(ref);q=q if q.is_absolute() else ROOT/q
   assert q.parent==ROOT,q
   pending.append(q)
   if q.with_suffix('.sch').exists():pending.append(q.with_suffix('.sch'))
 return sorted(found)
def geometry(layout,top):
 out={}
 for idx in layout.layer_indexes():
  info=layout.get_info(idx);texts=[];it=top.begin_shapes_rec(idx)
  while not it.at_end():
   if it.shape().is_text():texts.append(str(it.shape().text.transformed(it.trans())))
   it.next()
  out[(info.layer,info.datatype)]=(db.Region(top.begin_shapes_rec(idx)),sorted(texts))
 return out
def export_gds():
 src=ROOT/'mac.gds';ly=db.Layout();ly.read(str(src));top=ly.cell('mac');before=geometry(ly,top)
 options=db.SaveLayoutOptions();options.gds2_write_timestamps=False;options.write_context_info=False
 top.write(str(OUT/'mac.gds'),options)
 saved=db.Layout();saved.read(str(OUT/'mac.gds'));assert saved.dbu==.001
 assert [c.name for c in saved.top_cells()]==['mac']
 assert saved.top_cell().bbox()==top.bbox()
 after=geometry(saved,saved.top_cell());assert set(before)==set(after)
 for spec,(region,texts) in before.items():assert (region^after[spec][0]).is_empty() and texts==after[spec][1],spec
 assert not any(c.is_library_cell() or c.is_pcell_variant() for c in saved.each_cell())
 return dict(source_sha256=sha(src),submitted_sha256=sha(OUT/'mac.gds'),geometry_and_labels_identical=True,hierarchy_preserved=True,external_library_context_removed=True,dbu_um=.001)
def netlist(folder,stem,lvs=False):
 d=WORK/('portable_lvs' if lvs else 'portable_tb');d.mkdir(parents=True,exist_ok=True)
 rc=d/'xschemrc';rc.write_text(f'set XSCHEM_LIBRARY_PATH {{{folder}:/usr/local/share/xschem/xschem_library:{PDK}/libs.tech/xschem}}\nset LIB {{{PDK}/libs.tech/spice/models}}\nset lvs_netlist {int(lvs)}\nset top_is_subckt {int(lvs)}\nset spiceprefix 1\nset dark_colorscheme 0\n')
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(rc),'-s','--command','set r [xschem netlist]; puts [xschem get infowindow_text]; exit $r','-o',str(d),str(folder/f'{stem}.sch')],cwd=folder,capture_output=True,text=True)
 log=p.stdout+p.stderr;(d/'netlist.log').write_text(log)
 assert p.returncode==0 and not re.search(r'Error:|IS MISSING|SKIPPING',log),log[-2000:]
 s=(d/f'{stem}.spice').read_text()
 if lvs:s=re.sub(r'(?im)^X(\S+)(\s+\S+\s+\S+\s+\S+\s+\S+\s+(?:NMOS|PMOS)\b)',r'M\1\2',s)
 return s,rc

def electrical(s):return '\n'.join(l.strip() for l in re.sub(r'\n\+\s*',' ',s).splitlines() if l.strip() and not l.lstrip().startswith('*'))
def prepare():
 OUT.mkdir(exist_ok=True);WORK.mkdir(parents=True,exist_ok=True)
 files=dependencies()
 for p in files:
  text=p.read_text().replace(str(ROOT)+'/', '')
  assert str(ROOT) not in text
  (OUT/p.name).write_text(text)
 layout=export_gds()
 # Relocate the package and allow only its own directory, Xschem and the PDK.
 moved=WORK/'relocated';moved.mkdir(exist_ok=True)
 for p in files:shutil.copy2(OUT/p.name,moved/p.name)
 tb,rc=netlist(moved,'mac_tb')
 original=logic.netlist();assert electrical(tb)==electrical(original),'Relocated TB differs electrically'
 ref,_=netlist(moved,'mac',True)
 assert electrical(ref)==electrical((ROOT/'simulation/mac.spice').read_text())
 (OUT/'simulation').mkdir(exist_ok=True)
 # Make default KLayout LVS work from the submission directory as well.
 (OUT/'simulation/mac.spice').write_text('\n'.join(l for l in ref.splitlines() if not l.lstrip().startswith('*')).rstrip()+'\n')
 shutil.copy2(ROOT/'mac.extracted',OUT/'mac.extracted')
 svg=OUT/'mac_schematic.svg';cmd=f'xschem set text_svg 1; xschem print svg {{{svg}}} 2000 2000 -20 -190 1370 1200; exit'
 p=subprocess.run(['xschem','-r','-x','--rcfile',str(rc),'--command',cmd,str(moved/'mac.sch')],capture_output=True,text=True)
 assert p.returncode==0 and svg.exists() and svg.stat().st_size>1000
 # Increase only exported vector stroke width for readable white-background previews.
 svg.write_text(svg.read_text().replace('stroke-width: 0.24;', 'stroke-width: 1.1;'))
 report=dict(passed=True,layout=layout,local_schematic_dependencies=[p.name for p in files],portable_tb_electrically_identical=True,portable_lvs_reference_identical=True,external_dependency='TR-1um dev PDK and Xschem devices library',schematic_image_source_sha256=sha(OUT/'mac.sch'))
 (ROOT/'reports/submission_portability.json').write_text(json.dumps(report,indent=2)+'\n')
 return report

def docs(final=False):
 from spec_gate_figures import main as gate_figures
 gate_figures()
 summary=json.loads((ROOT/'reports/mac_summary.json').read_text()) if final else None
 if final:
  assert summary['passed'] and summary['gds_sha256']==sha(ROOT/'mac.gds')
  portability=json.loads((ROOT/'reports/submission_portability.json').read_text())
  physical=json.loads((ROOT/'reports/submission_layout.json').read_text())
  figures=json.loads((ROOT/'reports/submission_figures.json').read_text())
  assert portability['passed'] and physical['passed'] and figures['passed']
  assert portability['layout']['source_sha256']==summary['gds_sha256']
  assert portability['layout']['submitted_sha256']==physical['gds_sha256']==figures['gds_sha256']==sha(OUT/'mac.gds')
  assert physical['reference_sha256']==sha(OUT/'simulation/mac.spice')
  assert sha(OUT/'mac.extracted')==sha(ROOT/'mac.extracted')
  assert portability['schematic_image_source_sha256']==sha(OUT/'mac.sch')
  for name,digest in figures['images'].items():assert sha(OUT/name)==digest,name
  for p in dependencies():assert (OUT/p.name).read_text()==p.read_text().replace(str(ROOT)+'/', ''),p.name
 ports=json.loads((ROOT/'layout/mac.ports.json').read_text())['ports']
 functions={'VDD':('電源','+5 V'),'VMID':('電源','0 V基準'),'VSS':('電源','−5 V（共通VSS）'),'x':('入力','加算値・外部で保持する累積値'),'a':('入力','被乗数'),'b':('入力','乗数、ADD時+1、SUB時−1'),'cin':('入力','下位桁からのcarry'),'sum':('出力','演算結果の下位trit'),'cout':('出力','上位桁へのcarry'),'and_out':('出力','min(a,b)'),'or_out':('出力','max(a,b)')}
 rows=[]
 for name in ('VDD','VMID','x','a','b','cin','sum','cout','and_out','or_out','VSS'):
  p=ports[name];direction,desc=functions[name];layer='M1 (13/0)' if p['layer']==[13,0] else 'M2 (20/0)';x,y=p['position_um']
  rows.append(f'| `{name}` | {direction} | {desc} | {layer} | {x:g} | {y:g} |')
 table='\n'.join(rows)
 if final:
  results='\n'.join(f"| {r['scope']} | {r['mode']} | {r['load_fF']/1000:g} pF/出力 | {r['max_error_mV']:.3f} mV | {r['max_settle_ns']:.2f} ns | PASS |" for r in summary['cases'])
 else:results='| 検証更新中 | 全遷移の実行完了後に結果を反映 | — | — | — | 実行中 |'
 for name in ('README.md','SPEC.md'):
  s=(ROOT/'design/submission'/name).read_text().replace('{{PORTS}}',table).replace('{{RESULTS}}',results).replace('{{ERROR_DETAIL}}',f"SUM/Coutの最大誤差は {max(r['sum_cout_error_mV'] for r in summary['cases']):.3f} mV、AND/ORの最大誤差は {max(r['and_or_error_mV'] for r in summary['cases']):.3f} mV。" if final else '各出力群の誤差は全検証終了後に集計する。').replace('{{STATUS}}','検証完了。条件と未評価範囲は仕様書を参照。' if final else '全遷移検証を実行中。完了後に仕様書の検証結果を更新する。')
  (OUT/name).write_text(s)

def manifest():
 paths=sorted(p for p in OUT.rglob('*') if p.is_file())
 records={str(p.relative_to(OUT)):dict(bytes=p.stat().st_size,sha256=sha(p)) for p in paths}
 archive=WORK/f'mac_submission_{sha(OUT/"mac.gds")[:12]}.zip'
 with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED) as z:
  for p in paths:z.write(p,'submission/'+str(p.relative_to(OUT)))
 with zipfile.ZipFile(archive) as z:assert z.testzip() is None
 result=dict(source_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),source_worktree_dirty=bool(subprocess.check_output(['git','status','--porcelain'],cwd=ROOT,text=True).strip()),provenance_note='source_commit is the base revision; file hashes identify the exact packaged working-tree content.',source_gds_sha256=sha(ROOT/'mac.gds'),files=records,archive=str(archive.relative_to(ROOT)),archive_sha256=sha(archive))
 (ROOT/'reports/submission_manifest.json').write_text(json.dumps(result,indent=2)+'\n');return result
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--final',action='store_true');p.add_argument('--docs-only',action='store_true');a=p.parse_args()
 if not a.docs_only:prepare()
 docs(a.final);print(json.dumps(manifest(),indent=2))
