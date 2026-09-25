# Full Adderのレイアウト検証・抽出シミュレーション

対象：ユーザー配線の `full_adder.gds`。DBU 0.001 µm。
構成はHA×2、carry合成用NANY×1＋INV×1。合計98 MOS＋32抵抗。

## レビューと修正

最初の抽出ではFA/HA/NANY/INVの回路接続はすべて一致したが、
トップ端子の不足でstrict LVSが不合格になった。

| 端子 | 元の状態 | 修正 |
|---|---|---|
| a | M1配線上にTXM2（49/0）の文字 | TXM1（48/0）へ移動 |
| sum / cout | M1（13/0）そのものに文字を配置 | TXM1（48/0）へ移動 |
| cin | トップ階層にラベルなし | HA2のb端子上にTXM1を追加 |

全セル・全レイヤーの図形をXOR比較し、文字以外は変更していないことを確認。
元のレイアウトはGitコミット `95bf683` と
`layout/backups/full_adder_review/full_adder_before_terminal_labels.gds` に保存。
変更の詳細は `reports/full_adder_terminal_fix.json`。
修正版GDSのSHA256は
`1bf31dfe2323cff80d45e4f4686e0a4f59642abb613944dfadea76e01ba6ef81`。

使用中のKLayoutでは、保存済みファイルの変更を再読み込みして表示を更新する。
以前の内容を開いたまま上書き保存すると、ラベル修正が戻るので注意。

## 物理検証

- dev PDKのDrawing DRC：0件。
- strict LVS：FA/HA/NANY/INVの全4回路が一致。トップ端子の省略なし。
- 別プロセスで、通常GUIのDRC/LVSメニュー用マクロでも同じ結果を確認。
- マスク変換後のDRC：`WAR06: Floating SG Detected` が16件。
  外部入力a/b/cinをVDDへ実配線した別の確認用親セルでは、
  Drawing DRC 0件、strict LVS一致、マスクDRC 0件。
  この確認用接続を本来のFAに追加したり、ルールを免除したりはしていない。

単体セルのマスク警告は未駆動の外部入力に起因する。パッドや駆動回路を含めた
最終TOPのDRCを代替する検証ではない。

```sh
python3 scripts/verify_full_adder_layout.py
python3 scripts/check_full_adder_driver.py
QT_QPA_PLATFORM=offscreen /home/ishi-kai/bin/klayout/klayout -z -t -r scripts/check_full_adder_gui.py
```

最初のコマンドは、警告を含む全マーカーを数えるため単体マスクDRCの16件で
終了コード1になる。Drawing DRC / LVSの判定はレポート内で別に記録している。
参照回路は最新の回路図から `simulation/full_adder.spice` に生成する。

## 抽出回路のシミュレーション

```sh
python3 scripts/check_full_adder_extracted.py
```

最新GDS・回路図・PDKルールに対応したstrict LVS結果を確認してから実行する。
`full_adder.extracted` の端子順は
`VDD VMID VSS a b cin cout sum`。
回路図側の `a b cin sum cout VDD VSS VMID` とは異なるため、TBのDUT接続を合わせる。
匿名ノード名をngspiceで扱いやすい名前へ変換し、各`.subckt`の端子と接続から
内部ノードを対応付けて、`.nodeset`と波形の参照先も更新する。
素子パラメータや電気的な接続は変更しない。

試験条件は27 ℃、理想±5 V/0 V電源、1 ns入力エッジ、200 ns保持、許容誤差±0.5 V。
通常TBの全27入力＋初期状態への復帰と、全702通りの有向遷移を確認する。
全遷移は出力負荷10 fF・100 fFで実行する。
通常TBの最大刻み0.5 ns、全遷移は2 ns（必要に応じて自動細分化）。
整定時間は入力エッジ終了後、SUM/Coutが許容範囲に入り区間末まで留まる時間。

波形をngspice純正plotで開く場合：

```sh
cd simulation/full_adder_layout/extracted_sim/tb_sequence
ngspice view.spice
```

全遷移の波形は同じ `extracted_sim` 配下の
`transitions_10f/view.spice`、`transitions_100f/view.spice`。
各フォルダには `tb.spice`、波形データ、`run.log`、遷移ごとの `results.json` も保存する。
全体の要約は `reports/full_adder_extracted.json`。
通常の `full_adder_tb.sch` のSimulateは引き続き回路図版の解析。

検証結果（2026-09-24）：

| 条件 | 入力・遷移 | 最大出力誤差 | 最大整定時間 | 判定 |
|---|---|---:|---:|---|
| 抽出回路、10 fF | 全27入力＋初期状態へ戻る | 2.576 mV | 46.02 ns | PASS |
| 抽出回路、10 fF | 全702有向遷移 | 2.576 mV | 61.57 ns | PASS |
| 抽出回路、100 fF | 全702有向遷移 | 2.576 mV | 63.05 ns | PASS |

同じ回路図・PDKモデルのハッシュが一致する既存の回路図版検証と比較した。
回路図版の全遷移の最大整定時間は61.15 ns / 63.35 nsで、抽出後もほぼ同等。
上記時間の小数桁は波形から得た値であり、最大時間刻みを超える精度の保証ではない。

抽出結果にはMOSの接合面積・周長とPDKモデルの内部容量が反映される。
このLVSデッキでは**配線寄生R/Cは抽出していない**。
PVT、入力スキュー、実チップ間の配線負荷も今回の評価には含めない。
