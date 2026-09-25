# 平衡3値 Multiply-Add / AND / OR

**X + A×B + Cin = Sum + 3×Cout**

1 tritの乗算加算回路。ADD・SUB・MUL・NEGに対応し、AND・OR出力を備えます。

| 項目 | 仕様 |
|---|---|
| 電源 | VDD=+5 V、VMID=0 V、VSS=−5 V |
| 論理値 | −1 / 0 / +1 ⇔ −5 / 0 / +5 V |
| 端子数 | 11（共通VSSを除くと10） |
| 割当領域 | 1800 × 1000 µm |
| PDK | TR-1um dev / `9ef2ac3` |

## ファイル

| 内容 | ファイル |
|---|---|
| 仕様・端子・真理値表 | [SPEC.md](SPEC.md) |
| レイアウト | [mac.gds](mac.gds)（top: mac） |
| 回路図・シンボル | [mac.sch](mac.sch) / [mac.sym](mac.sym) |
| テストベンチ | [mac_tb.sch](mac_tb.sch) |
| LVS参照 | [simulation/mac.spice](simulation/mac.spice) |
| 素子抽出回路 | [mac.extracted](mac.extracted) |

![レイアウト](mac_layout.png)

![回路図](mac_schematic.svg)
