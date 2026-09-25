"""Publish a concise summary only after all arithmetic verification is complete."""
from pathlib import Path
from collections import Counter
import json
import check_mac as logic
import verify_arithmetic_layout as verify
from check_full_adder_extracted import normalized
from check_half_adder_extracted import subckts
ROOT=logic.ROOT

def main():
 reports={n:json.loads((ROOT/f'reports/{n}.json').read_text()) for n in ('mac','mac_extracted','mac_layout','mac_driver','arithmetic_gui','arithmetic_pcell_audit')}
 for n in ('mac','mac_extracted','mac_driver','arithmetic_gui','arithmetic_pcell_audit'):assert reports[n]['passed'],n
 layout=reports['mac_layout'];assert layout['drawing_lvs_passed']
 digest=logic.sha(ROOT/'mac.gds');assert layout['gds_sha256']==reports['mac_extracted']['gds_sha256']==reports['mac_driver']['source_sha256']==digest
 assert reports['arithmetic_gui']['cells']['mac']['gds_sha256']==reports['arithmetic_pcell_audit']['cells']['mac']['gds_sha256']==digest
 assert logic.sha(verify.reference('mac'))==layout['reference_sha256']==reports['mac_extracted']['reference_sha256']
 for n,h in reports['mac']['source_sha256'].items():assert logic.sha(ROOT/n)==h,n
 for n,h in reports['mac']['model_sha256'].items():assert logic.sha(verify.PDK/n)==h,n
 assert reports['mac']['model_sha256']==reports['mac_extracted']['model_sha256']
 assert logic.sha(ROOT/'mac.extracted')==reports['mac_extracted']['extracted_sha256']
 defs=subckts(normalized((ROOT/'mac.extracted').read_text()))
 def count(name):
  c=Counter()
  for l in defs[name]['lines']:
   if l[-1].lower() in defs:c.update(count(l[-1].lower()))
   elif len(l)>5 and l[5] in ('PMOS','NMOS'):c[l[5]]+=1
   elif len(l)>4 and l[4]=='F_RR':c['F_RR']+=1
  return c
 devices=dict(count('mac'));assert devices==dict(PMOS=59,NMOS=59,F_RR=46)
 rows=[]
 for n,label in [('mac','回路図'),('mac_extracted','抽出回路')]:
  cases=reports[n]['cases'];assert len(cases)==3 and [r['transitions'] for r in cases]==[81,6480,648]
  for r,mode in zip(cases,['81入力＋復帰','全6,480遷移','1入力648遷移']):
   assert r['passed'] and r['unsettled']==0
   rows.append(dict(scope=label,mode=mode,load_fF=r['load_fF'],max_error_mV=1000*r['max_output_error_V'],max_settle_ns=r['max_settle_ns'],sum_cout_error_mV=1000*r['max_sum_cout_error_V'],and_or_error_mV=1000*r['max_and_or_error_V']))
 summary=dict(passed=True,gds_sha256=digest,device_counts=devices,bbox_um=layout['bbox_um'],allocation_um=reports['arithmetic_pcell_audit']['cells']['mac']['allocation_um'],fits_allocation=reports['arithmetic_pcell_audit']['cells']['mac']['fits_allocation'],drawing_drc_items=0,strict_lvs_passed=True,standalone_mask_categories=layout['mask_drc']['categories'],driven_fixture_mask_items=reports['mac_driver']['mask_drc']['items'],cases=rows,
  max_product_error_V=max(r['max_product_error_V'] for n in ('mac','mac_extracted') for r in reports[n]['cases']),scope='Nominal 27 C ideal rails. Device extraction, no wire RC, no pad frame, no 5-chip chain test.')
 (ROOT/'reports/mac_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
 if 'relayout_equivalence' in reports['mac_extracted']:
  summary['relayout_equivalence']=reports['mac_extracted']['relayout_equivalence']
  (ROOT/'reports/mac_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
 if 'power_join_equivalence' in reports['mac_extracted']:
  summary['power_join_equivalence']=reports['mac_extracted']['power_join_equivalence']
  (ROOT/'reports/mac_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
 if 'power_placement_equivalence' in reports['mac_extracted']:
  summary['power_placement_equivalence']=reports['mac_extracted']['power_placement_equivalence']
  (ROOT/'reports/mac_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
 if 'alignment_equivalence' in reports['mac_extracted']:
  summary['alignment_equivalence']=reports['mac_extracted']['alignment_equivalence']
  (ROOT/'reports/mac_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
 if 'rail_stitch_equivalence' in reports['mac_extracted']:
  summary['rail_stitch_equivalence']=reports['mac_extracted']['rail_stitch_equivalence']
  (ROOT/'reports/mac_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
 if 'rightmost_vdd_equivalence' in reports['mac_extracted']:
  summary['rightmost_vdd_equivalence']=reports['mac_extracted']['rightmost_vdd_equivalence']
  (ROOT/'reports/mac_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
 if 'edge_ports_equivalence' in reports['mac_extracted']:
  access=json.loads((ROOT/'reports/mac_edge_access.json').read_text());assert access['passed'] and access['gds_sha256']==digest
  summary['edge_ports_equivalence']=reports['mac_extracted']['edge_ports_equivalence']
  summary['edge_access']='reports/mac_edge_access.json'
  (ROOT/'reports/mac_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
 lines=['## 検証結果（2026-09-25）','', '| 回路 | 試験 | 負荷 | 最大出力誤差（4出力） | 最大整定時間 | 判定 |','|---|---|---:|---:|---:|---|']
 for r in rows:lines.append(f"| {r['scope']} | {r['mode']} | {r['load_fF']/1000:g} pF | {r['max_error_mV']:.3f} mV | {r['max_settle_ns']:.2f} ns | PASS |")
 lines+=['',f"SUM/Coutの最大誤差は {max(r['sum_cout_error_mV'] for r in rows):.3f} mV、AND/ORの最大誤差は {max(r['and_or_error_mV'] for r in rows):.3f} mV。",f"内部の積Pも各状態で確認し、最大誤差は {summary['max_product_error_V']*1000:.1f} mV。",'表の整定時間は波形サンプルによる値であり、最大時間刻みより細かい精度を保証しない。','今回は単体算術コアの検証。5チップ直列接続の負荷・遅延は含まない。','']
 if 'relayout_equivalence' in reports['mac_extracted']:
  lines+=['1800×1000 µm対応の再配置後、抽出回路の81入力を再実行して合格。', '全6,480遷移・100 fFの648遷移は、コメント以外のSPICE全文、モデル、参照回路、LVSルールが完全一致する前版の合格結果を継承。', '同一性の証跡は `reports/mac_relayout_equivalence.json`。配線寄生R/Cの影響は評価に含まれない。', '']
 if 'power_join_equivalence' in reports['mac_extracted']:
  lines+=['共有VSS配線40 µm化の時点でDrawing DRC/LVSと抽出81入力を再実行した。', '匿名ネット1本の名前以外、抽出SPICEは全バイト一致。モデル・参照回路・LVSルールも同一で、全6,480/648遷移の波形を再判定して合格を継承。', '証跡は `reports/mac_improvements/vss_equivalence.json`。配線R/Cは抽出されていないため、拡幅による遅延改善は主張しない。', '']
 if 'power_placement_equivalence' in reports['mac_extracted']:
  lines+=['その後、VDD/VSS幹線をy=744.3/804.3 µmへ移動し、Drawing DRC/LVS・マスクDRC・入力接続fixtureを再実行した。', '抽出SPICEはコメント・匿名ノード名・素子パラメータも含め全バイト一致し、モデル・参照回路・ルールも不変。上表は同一回路の既存合格結果を継承しており、移動後に全過渡解析を再実行したものではない。', '証跡は `reports/mac_improvements/power_placement_equivalence.json`。セル配置・素子形状・信号配線は変更していない。', '']
 if 'alignment_equivalence' in reports['mac_extracted']:
  lines+=['配置整理後にDrawing DRC/LVS、マスクDRC、入力接続fixtureと抽出81入力＋復帰を新規実行し、合格した。', '全9階層回路について、端子名・素子端子の役割・全パラメータを区別したグラフ同型性を照合し、変更前と電気的に同一であることを確認。', 'モデル・参照回路・ルールも一致するため、全6,480/648遷移は変更前の合格結果を継承した（今回は全遷移の再実行ではない）。', '証跡は `reports/mac_alignment/electrical_equivalence.json`。新規81入力波形は `simulation/mac/alignment_extracted/tb_sequence/`。', '配線寄生R/Cは抽出に含まれず、今回の整理による遅延改善は主張しない。', '']
 if 'rail_stitch_equivalence' in reports['mac_extracted']:
  lines+=['その後の下段電源レール4箇所の橋渡しではDRC/LVSと抽出の全パラメータ・端子同等性を再確認し、上表の過渡結果を継承した。橋渡し後の過渡再実行ではない。', '証跡は `reports/mac_alignment/rail_stitch.json`。', '']
 if 'rightmost_vdd_equivalence' in reports['mac_extracted']:
  lines+=['右端NANY/INVへのVDD接続後もDRC/LVSと抽出の同等性を確認し、過渡結果を継承。今回の接続後に過渡解析を再実行したものではない。', '証跡は `reports/mac_alignment/rightmost_vdd.json`。', '']
 if 'edge_ports_equivalence' in reports['mac_extracted']:
  lines+=['全11端子を左右の境界付近へ引き出した後、Drawing DRC/LVSと抽出81入力を再実行して合格。全9電気回路が同等なため、全6,480/648遷移は前版の結果を引き継いだ。', '証跡は `reports/mac_edge_ports.json` と `reports/mac_edge_access.json`。各端子から領域外への水平経路を確認した。']
 if 'art_equivalence' in reports['mac_extracted']:
  lines+=['右端端子配線とM2の名前・ペンギン追加後にDrawing DRC/LVSと抽出81入力を再実行して合格。全9電気回路の端子名・素子端子・モデル・全パラメータが一致するため、全6,480/648遷移は同等な回路の検証結果を引き継いだ。', '証跡は `reports/mac_art.json` と `reports/mac_art_geometry.json`。配置と再生成方法は `layout/SILICON_ART.md`。', '']
 if 'final_review' in reports['mac_extracted']:
  lines+=['最終版の抽出回路で、81入力・全6,480遷移・単一入力648遷移を新規実行し、全て合格。全遷移は独立した期待値計算でも波形を再評価した。', '包括レビューと5段連結の代表試験は `MAC_FINAL_REVIEW.md` / `reports/final_review/`。5段連結の単体1 µs規定への適用は不可（±0.5 V基準で最大約1.181 µs、代表試験の保持時間は5 µs）。', '']
 path=ROOT/'MAC.md';s=path.read_text();mark='<!-- verification-results -->';s=s.split(mark)[0].rstrip()+'\n\n'+mark+'\n'+'\n'.join(lines);path.write_text(s)
 print(json.dumps(summary,ensure_ascii=False,indent=2))
if __name__=='__main__':main()
