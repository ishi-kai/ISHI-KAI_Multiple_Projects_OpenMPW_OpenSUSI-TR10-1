# 3値評価ICの採用方針

2026-09-23の決定。目標は基本3値ゲートを外から評価でき、同じprimitiveを使うFAを内蔵し、5チップのCout→Cin接続で5-trit加算器を構成できるIC。
今回の作業範囲はNANYの回路基準確定とHAの階層回路図まで。レイアウト・DRC/LVS・FA/TOPの回路実装は次工程です。

## 電源と外部端子

VDD=+5 V、VMID=0 V、共通VSS=−5 Vの理想3レール。
全論理電圧はVMIDを基準に−5/0/+5 V。VMIDは独立した電源・基準端子です。
現段階でOPAMPによる中点生成は行いません。ピン数が厳しい場合のみ再検討します。

共通VSSを除く10本の第一案：

| Pin | 用途 |
|---|---|
| 1 | VDD |
| 2 | VMID |
| 3 | A |
| 4 | B |
| 5 | Cin |
| 6 | INV OUT |
| 7 | NAND OUT |
| 8 | NOR OUT |
| 9 | FA SUM |
| 10 | FA Cout |

INVの入力はA、NAND/NORの入力はA/Bを共有する想定でTOPを設計する。
NANYの単体出力ピンは設けない。PTI/NTIは実験セルとして残し、今回のTOPには含めない。
CinをVMIDに固定すればFAをHAとして評価できる。
5チップで各桁のA/Bを入力し、chip0のCinだけVMID、以降は前桁Cout→次桁Cin。3電源レールは全チップで共有する。
チップ間接続の容量・配線・パッドを含む速度と整定はTOP実装後に評価する。

## 階層

`primitive → HA → FA → TOP` を維持する。

- primitive：INV / NAND / NOR / NANYを個別にレイアウトし、DRC/LVSを通す。
- HA：NANY×5＋INV×2。SUMとCARRYを一つのマクロにし、TとCARRYを内部共有する。
- FA：HA1(A,B)→(S1,C1)、HA2(S1,Cin)→(SUM,C2)、Cout=INV(NANY(C1,C2))。
- TOP：基本ゲート3個とFAマクロを配置して配線する。

HAは44 MOS＋14抵抗。FAはNANY×11＋INV×5で98 MOS＋32抵抗。
上記FAの論理式について全27入力組で `A+B+Cin=SUM+3*Cout` を確認した。
これは論理式の検査であり、FAのトランジスタシミュレーションは未実施。
HAの実レイアウトで抵抗・well・コンタクト・配線を含む面積を確認し、FAへの展開を判断する。
必要な場合だけ最後に部分的にflattenする。

## 今回確定した回路基準

IC向けNANYの正本は `nany.sch`、インターフェースは `nany.sym`。
8MOS＋2RR（主回路4MOS＋2RR、VMIDへ接続する0 Vクランプ4MOS）。寸法は [NANY_CELL.md](NANY_CELL.md)。
`nsign.*` は過去のTB・CONS実験の再現用として保存している。IC向けHAは参照しない。
今後のNANYの変更は `nany.sch` に行い、回路基準と検証結果を更新する。

HAの正本は `half_adder.sch` / `half_adder.sym`。5つのNANYはすべて同じ `nany.sym` を参照し、2つのINVは `inverter.sym` を参照する。
HA端子はa/b、sum/carry、VDD/VSS/VMID。内部Tは外部端子にしない。
INVはprimitiveレイアウト工程で電源端子をVDD/VSSへ統一した。HAの既存接続は維持。NAND/NORの既存インターフェースの整理は各primitiveのレイアウト工程で行う。

セル内部に明示的な試験負荷は置かない。モデル寄生容量は残し、外部負荷はTBに置く。
今回追加したNANY/HAのTBはVMIDを独立した0 V電圧源で駆動する。

## 次工程

1. primitiveのレイアウト・個別DRC/LVS。
2. 現在のHA回路図に対応するレイアウト・DRC/LVSと面積確認。
3. FAの階層回路図・TB・レイアウト。
4. TOP・パッド・外部負荷・5チップ接続の統合検証。

現時点の「確定」はシミュレーションを通した回路基準を指す。レイアウト、DRC/LVS、製造ばらつき、実チップ動作の完了を意味しない。


## INVレイアウトの進捗

`inverter.gds`（top `inverter`）を作成。84×66 µm、VDD/VSSの上下レール、左入力・右出力。
Drawing DRC 0件、厳密端子モードLVS一致。12 µm間隔のR0/MY/MX/R180配置でDrawing DRC 0件。
単体の製造マスクチェックは寸法エラー0件、未接続vinのFloating SG警告1件。
2個のINVを実配線したdriver検証用レイアウトでは、Drawing DRC・LVS・全製造マスクDRCがPASS（警告も0）。
これはprimitive接続検証で、HA/FA/TOP全体の完成ではない。再利用条件は [layout/INVERTER_LAYOUT.md](layout/INVERTER_LAYOUT.md)。


## NANYレイアウトの進捗

`nany.gds`（top `nany`）を作成。132×115 µm、回路図の寸法と8 MOS＋2 RRを保持。
Drawing DRC 0件、strict LVS一致。標準GUIのDRC/LVSも確認済み。
12 µm間隔でR0/MY/MX/R180の配置を確認し、2段実配線fixtureはDrawing/maskとも0件、LVS一致。
単体maskの未接続入力警告6件は保持。抽出回路のDC・全72遷移・10/100 fF・±2 nsスキューもPASS。
HA/FAへの接続条件は [layout/NANY_LAYOUT.md](layout/NANY_LAYOUT.md)。


## 2026-09-24 dev版への適合

DBUを0.001 µmに統一し、INV/NANYのRR用GCコンタクトを認識領域の外へ移動。
回路図の素子寸法とセル外形を維持し、両方ともdev版Drawing DRC 0件・strict LVS一致を確認。
INVのPMOSもlive PCellへ復帰。単体maskの未接続入力警告は保持する。

補足：dev版の未配線4方向fixtureは親に入力端子がないため、DrawingにINV 4件・NANY 24件のGC.ANTが出る。寸法違反は0件。実配線driver fixtureはDrawing/maskとも全項目0件。
