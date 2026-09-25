# 1-trit multiply-add slice

レビュー後の変更・電源範囲は [MAC_IMPROVEMENTS.md](MAC_IMPROVEMENTS.md) を参照。
±5 Vはユーザーが採用した定格外条件であり、動作解析は耐圧・寿命保証ではない。

`mac.sch` は組合せ回路 `X + A×B + Cin = Sum + 3×Cout`。
各tritの −1/0/+1 を −5/0/+5 V で表す。電源は VDD=+5 V、VSS=−5 V、VMID=0 V。
入力を電圧で式に入れる場合は `Vx + Va×Vb/5 + Vcin = Vsum + 3×Vcout`。
レジスタは含まないため、累積値の保存と桁シフトは外部で行う。

| 使用方法 | 固定する入力 | 演算 |
|---|---|---|
| ADD / FA | B=+5 V | X+A+Cin |
| SUB | B=−5 V | X−A+Cin |
| MUL | X=Cin=0 V | A×B（Cout=0） |
| NEG | X=Cin=0 V、B=−5 V | −A |

## ファイルと階層

- `mac.sch` / `mac.sym`：MUL×1、FA×1、AND用inverter×1、OR復元用inverter×2。
- `mac_tb.sch`：全81入力と初期状態への復帰。シーケンスと期待値は回路図内の表に記載。
- `mac.gds`：上記の階層を保持した算術コア全体。MUL→ゲート、FA→HA→primitiveを保持。
- `mac.extracted`：公式LVSデッキの抽出結果。
- `mul.gds` と `mul_nand.gds` / `mul_nor.gds` / `mul_inv.gds`：サイジング済みMULと専用primitive。
- `layout/mac.ports.json` / `layout/mul.ports.json`：端子座標、配置、配線、元ファイルのハッシュ。

MUL専用ゲートは回路図のサイジング結果をそのままレイアウトした。
全MOSのL=1 µm、抵抗のW=2.8 µm。

| セル | PMOS W (µm) | NMOS W (µm) | RR L (µm) |
|---|---:|---:|---:|
| mul_nand（2個使用） | 19 | 13 | 30 |
| mul_nor | 37 | 6.5 | 30 |
| mul_inv | 13.5 | 5 | 30 |

合計118 MOS＋46 RR。全RRはW=2.8 µm、L=30 µm。MOS寸法は変更していない。
TBのSum/Cout/AND/ORにはそれぞれ10 pF || 1 MΩを置く。指定の整定待ちは1 µs。
MULのt1=-min(A,B)を反転して `and_out=min(A,B)`、t3は2段INVで復元・分離して `or_out=max(A,B)` とする。
50 Ω終端は直接接続しない。容量は測定器・パッド・配線の合計で管理する。
端子順は `x a b cin sum cout VDD VSS VMID and_out or_out`。共通VSSを除く10本、VSSを含め11本を使用。
汎用NAND/NORは変更していない。INV/NANY/MULの抵抗長と階層内の電源配線を更新した。
手編集FAの変更前形状は`layout/full_adder_signal_template.json`に保存し、信号配線を再利用した。
広げた配線・抵抗と干渉するC1配線とCoutビアだけは再配線した。
元GDSを含む退避は`layout/backups/mac_improvements_FIzCF0/design_before.tgz`。

GDSはDBU=0.001 µm、製造・配置格子0.05 µm、全インスタンス倍率1。
MULの外形820×235.7 µm。MACの外接矩形は **1788.4×780.85 µm**。
全形状の範囲はx=3.3〜1791.7 µm、y=12.35〜793.2 µmで、指定の **1800×1000 µm** 領域内。
2026-09-25の整理で、MULの4ゲートとAND/OR用の3 INVを原点y=600 µmの一列に配置した。
上段・中段のVDD/VSS計4本をM1 44 µm幅に統一。上段中心はVDD=744.6、VSS=581.4 µm、
中段はVDD=358.2、VSS=418.2 µm。上段VSSはx=1480 µmで止め、上段VDDと中段VSSは右端x=1790 µmまで引き出した。
M2幹線14 µm・主接続24カットを維持し、FAのM1幹線も32→44 µmに拡幅した。
旧MUL＋FA共有VSS合流部40 µmは廃止。MUL・追加INV群とFAの帰路は別の水平レールから幹線へ接続する。
素子寸法・HA内部形状・118 MOS＋46 RRの回路構成は変更していない。

下段は親FAのM1で左右HA間のVSS/VDD/VSSをそれぞれ接続し、最下段VSSは右側のcarry合成・出力INVまで連続化した。
HA内部と既存の給電経路は維持。VSS橋は16 µm、VDD橋は12 µm幅。先のHA間接続では、追加した4矩形以外の図形が不変であることを照合した。
この橋渡し後にDrawing DRC/LVSと抽出回路の全端子・全パラメータ同等性を確認し、過渡結果は継承した（橋渡し後の過渡再実行は行っていない）。
証跡は `reports/mac_alignment/rail_stitch.json`。配線R/Cがない抽出なので、抵抗低減や電流分担の改善量は未評価。

さらに右HAのVDDからcarry合成NANYへ12 µm幅で橋渡しし、NANYから右端INVへ3.4 µm幅の段差配線で接続した。
C1はこの交差点でM2を通るため、不要になった旧ビア（FA座標1308.45,22.35 µm）を除去した。既存の個別給電は維持。
追加接続後もDrawing DRC/LVSと全9階層の抽出同等性に合格。過渡結果は継承し、配線RCによる改善量は未評価。
証跡は `reports/mac_alignment/rightmost_vdd.json`。


既存FAの配置を再利用したコアで、パッドフレームやESD保護は含まない。
GDS内に子セルの図形を収録しているので、外部BTライブラリを同梱しなくても図形は完結する。

## Xschemと通常シミュレーション

`mac_tb.sch` を開いて Netlist → Simulate。純正ngspiceの電圧plotを使用する。
1 µsごとに次の入力へ移り、入力エッジは1 ns。999 ns時点で期待値との差が±0.5 V以内か確認する。
X、A、B、Cinの順で −5/0/+5 V の全組合せを列挙する。最後に初期状態へ戻る。

```sh
python3 scripts/check_mac.py
```

通常TBに加え、81状態間の全6,480有向遷移と1入力だけが変わる全648有向遷移を確認する。
全て10 pF || 1 MΩ、1 µs保持、1 nsエッジ。通常TBは最大刻み10 ns、全遷移は20 ns。
出力の整定時間は、入力エッジ終了からSum/Cout/AND/ORのすべてが±0.5 V以内に入り、区間末まで留まる時間。
回路図版・抽出版とも、全遷移を一度ずつ通るEuler巡回を16分割し、4並列で実行する。
各分割の先頭に共通の初期入力と開始状態の保持区間を追加し、元の全6,480遷移の網羅性を照合する。
各遷移のたびに回路状態をリセットすることはない。

過渡中は論理経路の遅延が異なるためグリッチが出る。整定後にサンプリングすること。
この試験は27 ℃、理想電源・理想入力源の条件であり、PVTやチップ間配線の保証ではない。

## レイアウト検証と抽出

```sh
python3 scripts/verify_arithmetic_layout.py mul_nand mul_nor mul_inv mul mac
python3 scripts/check_mac_driver.py
python3 layout/audit_arithmetic.py
QT_QPA_PLATFORM=offscreen /home/ishi-kai/bin/klayout/klayout -z -t -r scripts/check_arithmetic_gui.py
python3 scripts/check_mac_extracted.py
```

使用するPDKは `/home/ishi-kai/pdk/TR-1um` のdev版。
Drawing DRC 0件、階層内全セルとトップ端子を含めたstrict LVS一致を確認する。
通常GUIメニュー用の参照SPICEは `simulation/mul.spice` と `simulation/mac.spice`。
再生成は最初のverifyコマンドで行える。比較の緑表示だけでなく、ポート不足等のエラーログも確認する。

単体MACのマスクDRCには外部入力の `WAR06: Floating SG Detected` が14件残る。
4入力をVDDへ実配線した別の診断用親セルではDrawing/LVS/マスクDRCとも合格、マーカー0件。
本来の回路への入力固定や、DRCの免除領域は追加していない。
パッドを接続した最終TOPでの再確認は別途必要。

抽出シミュレーションでは、抽出したsubcktの端子順と匿名内部ノードを接続構造から対応付ける。
初期動作点に一般的な推定値だけを使うと、PDKモデルが非物理的な解へ収束する場合がある。
そのため最新の回路図で初期入力のDC動作点を求め、対応する内部電圧を抽出側の `.nodeset` に使う。
これはNewton法の初期推定であり、電圧源での固定や `.ic` / `uic` による動作点の省略ではない。
抽出回路の動作点を解き直してから全シーケンスを実行する。

**この抽出は素子接続・MOS接合面積/周長とモデル内部容量を反映するが、配線寄生R/Cは含まない。**
抽出デッキとGDS、参照回路、PDKのハッシュを記録し、古いLVS結果での解析を拒否する。

抽出波形を純正plotで見る場合：

```sh
cd simulation/mac/alignment_extracted/tb_sequence
ngspice view.spice
```

全遷移データは `simulation/mac/{schematic,extracted}/all_6480_10000f/`、
その下の `chunk_0`〜`chunk_15` に分かれる。
1入力遷移は同じ階層の `single_input_648_10000f/`。
`tb.spice`、`run.log`、波形、遷移ごとの `results.json` を保存する。
要約は `reports/mac.json` / `reports/mac_extracted.json`。

<!-- verification-results -->
## 検証結果（2026-09-25）

| 回路 | 試験 | 負荷 | 最大出力誤差（4出力） | 最大整定時間 | 判定 |
|---|---|---:|---:|---:|---|
| 回路図 | 81入力＋復帰 | 10 pF | 61.307 mV | 415.47 ns | PASS |
| 回路図 | 全6,480遷移 | 10 pF | 64.297 mV | 504.31 ns | PASS |
| 回路図 | 1入力648遷移 | 10 pF | 64.107 mV | 499.41 ns | PASS |
| 抽出回路 | 81入力＋復帰 | 10 pF | 61.286 mV | 414.27 ns | PASS |
| 抽出回路 | 全6,480遷移 | 10 pF | 64.262 mV | 503.67 ns | PASS |
| 抽出回路 | 1入力648遷移 | 10 pF | 64.085 mV | 485.87 ns | PASS |

SUM/Coutの最大誤差は 64.297 mV、AND/ORの最大誤差は 60.530 mV。
内部の積Pも各状態で確認し、最大誤差は 100.9 mV。
表の整定時間は波形サンプルによる値であり、最大時間刻みより細かい精度を保証しない。
今回は単体算術コアの検証。5チップ直列接続の負荷・遅延は含まない。

全11端子を左右の境界付近へ引き出した後、Drawing DRC/LVSと抽出81入力を再実行して合格。全9電気回路が同等なため、全6,480/648遷移は前版の結果を引き継いだ。
証跡は `reports/mac_edge_ports.json` と `reports/mac_edge_access.json`。各端子から領域外への水平経路を確認した。