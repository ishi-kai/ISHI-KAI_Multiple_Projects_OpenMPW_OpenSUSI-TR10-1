# 平衡3値 Full Adder

2026-09-24のMAC改善で配下RRを30 µmへ変更し、電源配線も更新しました。以下の旧単体試験値・旧配置は当時の記録です。
現行の仕様・検証は [MAC_IMPROVEMENTS.md](MAC_IMPROVEMENTS.md)、端子座標は `layout/full_adder.ports.json` を参照してください。

`full_adder.sch` は既存の `half_adder.sch` を2個使う階層セル。
論理値 −1 / 0 / +1 を −5 / 0 / +5 V で表す。

```text
HA1(a, b)   -> s1, c1
HA2(s1, cin)-> sum, c2
nc   = NANY(c1, c2)
cout = INV(nc)

a + b + cin = sum + 3*cout
```

有効な入力では `c1` と `c2` が両方 +1、または両方 −1 になることはなく、
`ANY(c1,c2) = sat(c1+c2) = c1+c2` でcarryを合成できる。
合計 NANY×11 + INV×5（98 MOS + 32抵抗）。
内部に負荷容量・電源・解析指示は含めない。

`full_adder.sym` の端子順は `a b cin sum cout VDD VSS VMID`。
電源は VDD=+5 V、VSS=−5 V、VMID=0 V。

## Xschemから実行

1. `full_adder_tb.sch` を開く。
2. LVSを無効にして、SPICEモードで Netlist → Simulate。
3. ngspice純正のSUM/Cout波形と、コンソールの `PASS` / `FAIL` を確認する。

入力は全27組を辞書順で印加し、最後に `(−5,−5,−5)` に戻す。
各区間200 ns、エッジ1 ns、合計5.6 µs。区間と期待値の一覧はTB上に記載。
各区間の終了1 ns前にSUM、Cout、s1、c1、c2、ncを±0.5 Vで判定する。
出力容量はTB上の `Csum` / `Ccout`（各10 fF）。
モデルは現在のTR-1um PDKの `$::LIB/ip62_models` を読む。
`.nodeset` は初期入力 `(−5,−5,−5)` の動作点を解くための推定値。
DC連続掃引はこのTBでは行わない。

入力波形を変更する場合は `VA` / `VB` / `VCIN` を編集する。
シーケンス表と `SIMULATION` の期待値・測定時刻も合わせて更新する。
出力データはngspiceの実行ディレクトリの `full_adder_tran.txt`。

## 追加検証

```sh
python3 scripts/check_full_adder.py
```

実際のTBの解析指示を実行した後、27状態間の全702通りの有向遷移を
10 fF・100 fFの各出力負荷で確認する。
期待値はゲート接続の再実装ではなく、整数の平衡3進加算で計算する。
SUM/Coutが目標電圧±0.5 Vに入り、区間末まで留まる時間も測定する。
最大時間刻みは通常TBが0.5 ns、全遷移検証が2 ns（入力エッジ付近では自動細分化）。

要約は `reports/full_adder.json`、詳細波形・ログは
`simulation/full_adder_checks/` に保存する。
各 `transitions_*f/view.spice` はngspice純正plot用。
温度27 ℃、理想3レール、同時入力変化での回路図シミュレーションであり、
配線寄生・PVT・チップ間配線の負荷は今回の評価に含めない。

検証結果（2026-09-24）：

| 条件 | 入力・遷移 | 最大出力誤差 | 最大整定時間 | 判定 |
|---|---|---:|---:|---|
| 通常TB、10 fF | 全27入力＋初期入力へ戻る | 2.576 mV | 46.18 ns | PASS |
| 10 fF | 全702有向遷移 | 2.576 mV | 61.15 ns | PASS |
| 100 fF | 全702有向遷移 | 2.576 mV | 63.35 ns | PASS |

整定時間は入力の1 nsエッジが終わった時刻から計測。
全遷移検証の値は最大2 ns刻みの波形からの判定であり、桁数は精度保証を表さない。
