# NANY primitive v1

この文書と `design/nany_v1.json` は旧v1の記録です。2026-09-24のMAC改善でRR長を30 µmへ変更しました。
現行版の寸法・検証は [MAC_IMPROVEMENTS.md](MAC_IMPROVEMENTS.md) と `nany.sch`、`layout/nany.ports.json` を参照してください。
現行の照合基準は `design/nany_mac_rr30.json`。`scripts/check_nany.py` もこの基準で再検証しています。

IC向け正本：`nany.sch` / `nany.sym`。試験：`nany_tb.sch`。
回路基準の素子接続・寸法・ネットリストdigestは `design/nany_v1.json` に記録。

論理tritについて `Y = −sat(A+B)`。入力−1/0/+1を−5/0/+5 Vへ対応させる。

| A \ B | −1 | 0 | +1 |
|---|---:|---:|---:|
| −1 | +1 | +1 | 0 |
| 0 | +1 | 0 | −1 |
| +1 | 0 | −1 | −1 |

SPICE端子順は `a b vout VDD VSS VMID`。
a/b=in、vout=out、VDD/VSS/VMID=inout。VDD=+5 V、VSS=−5 V、VMID=0 V。
PMOS bulkとRR SUBはVDD、NMOS bulkはVSS。逆符号時のクランプ先はVMID。
明示的な負荷容量をセル内に持たない。セル内に電源・試験刺激・モデルinclude・解析コードは置かない。

| 素子 | 個数 | W / L〔µm〕 |
|---|---:|---:|
| 主回路PMOS XM3/XM5 | 2 | 34 / 1 |
| 主回路NMOS XM1/XM2 | 2 | 11 / 1 |
| クランプPMOS XM6/XM8 | 2 | 14 / 1 |
| クランプNMOS XM7/XM9 | 2 | 8 / 1 |
| RR R1/R2 | 2 | 2.8 / 16 |

RRは各約4.13 kΩが目安。抵抗モデルには電圧・温度依存性がある。
ネットリストで旧NSIGNと、電源端子名の変更を除く全素子・接続・寸法の一致を確認した。
旧`nsign.*`は過去の実験用に保存し、今後のIC設計は`nany.*`を使う。

## 検証

Xschemで `nany_tb.sch` を開き、LVSをOFFにしてNetlist→Simulate。
TB側Cload=10 fF。ngspice純正の電圧plotで3本のDC掃引と過渡を表示する。
TBには全9入力組と、正負両側から逆符号入力へ変える履歴試験を記載してある。
VMIDはTBの独立した理想0 V源。通常TBの全17過渡測定点で誤差判定0件。

追加検証は `python3 scripts/check_nany.py`。
実際のシンボル経由でネットリスト化し、v1基準との接続・寸法の一致、2次元DC、全72有向遷移を確認する。
基準と不一致になったときは停止するので、意図した変更はレビュー後に基準も更新する。

27℃・±5 V・公称モデルで、DCの9論理点の最大誤差2.486 mV。
各論理点のA/B両方を±0.5 Vずらした領域（電源内）で最大誤差0.1354 V。
過渡の入力エッジは1 ns、保持100 ns、判定は理想値±0.5 V。整定時間は最後の入力変化完了から測る。

| 条件 | 遷移数 | 最長整定時間 | 区間末尾の最大誤差 |
|---|---:|---:|---:|
| 10 fF | 72 | 7.58 ns | 2.485 mV |
| 100 fF | 72 | 8.52 ns | 2.485 mV |
| 10 fF・Aが2 ns遅延 | 72 | 7.58 ns | 2.485 mV |
| 10 fF・Bが2 ns遅延 | 72 | 6.74 ns | 2.485 mV |

全条件PASS。結果は `simulation/nany_checks/results.json`。通常TBログは `simulation/nany_freeze/nany_tb/`。
回路v1としての基準確定であり、レイアウト・DRC/LVS・製造ばらつき評価は次工程。
温度/電源条件の過去の評価は [NSIGN_TUNING.md](NSIGN_TUNING.md) を参照（今回の27℃・±5 V再検証とは区別する）。
