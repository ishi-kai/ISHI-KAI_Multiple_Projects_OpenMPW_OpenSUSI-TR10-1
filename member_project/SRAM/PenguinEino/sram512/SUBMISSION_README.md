# 512 bit Serial SRAM — OpenSUSI TR-1um

16行×32列・7端子。周辺回路込みで横1776.7×縦600.0 µm。

[@PenguinEino](https://github.com/PenguinEino)が仕様の決定、初期SRAMセル・2×2配列の回路図／手描きレイアウト、周辺回路の設計を担当し、GPT-6-Astraがセル配置の最適化、周辺回路の配置配線、512 bitへの統合、シミュレーション・DRC/LVS検証を担当しました。

## 提出物

| 項目 | ファイル |
|---|---|
| 回路図 | [sram512.sch](sram512.sch) |
| シミュレーション用回路図 | [sram512_tb.sch](sram512_tb.sch) |
| レイアウト | [sram512.gds](sram512.gds) — top: `sram512` |
| 仕様書・説明書 | [SPEC.md](SPEC.md) |

## アピールポイント

- **SRAM 1セル面積**：22×29.6 µm、651.2 µm²/bit。SRAMセル単体で約1,536 bit/mm²。
- **提出枠の使用率98.7%**：周辺回路込み1.0660 mm²を横1800×縦600 µm（1.0800 mm²）の枠に収容。
- **書込み回路とセンスアンプを32列で共有**：列選択回路で接続先を切り替え、共通の書込み回路と7Tセンスアンプで1 bitずつ読み書き。
- **シリアル方式で端子数を削減**：アドレスを順番に入力し、電源込み7端子で全512セルにアクセス可能。
- **セル配置を7通り比較**：最初の手描きから、拡散・配線・ビアの共有方法を比較。専用に描いたセルとPDK提供のMOS部品で組んだセルの両方で、同じ1,536 bit/mm²に到達。

Drawing DRC 0・LVS一致・製造マスクDRC 0。

### セルレイアウトの比較

すべて6T、全MOSのW/L=3.4/1 µm。密度はセルの配置ピッチから計算。外周配線・追加タップ列・周辺回路を除く。
画像は共有境界も見える2×2配列を同じ縮尺で表示。

| 配置案 | 保存GDSの画像 | 密度（bit/mm²） | 特徴 |
|---|---|---:|---|
| 初期手描き | [<img src="cell_hand.png" width="180" alt="最初に手描きしたSRAMの2×2配列">](cell_hand.png) | 621 | PMOSを中央、NMOSを左右に置いた最初の手配置。配置ピッチ57.5×28 µm |
| NMOSを2組に分けた配置 | [<img src="cell_branches.png" width="180" alt="NMOSを2組に分けた2×2配列">](cell_branches.png) | 1,387 | アクセスMOSと保持用MOSで拡散を共有。縦配線をM2へ集める |
| 中央電源の拡散を共有 | [<img src="cell_shared.png" width="180" alt="中央電源の拡散を共有した2×2配列">](cell_shared.png) | 1,456 | NMOS列の中央VSS、PMOS列の中央VDDを共有して高さを縮小 |
| 中央PMOS配置・初案 | [<img src="cell_two_wl.png" width="180" alt="中央PMOS・ワード線2本の2×2配列">](cell_two_wl.png) | 897 | PMOSを中央、NMOSを左右に置き、ワード線を2本に分ける |
| 中央PMOS配置・共有改善 | [<img src="cell_one_wl.png" width="180" alt="中央PMOS・ワード線1本の2×2配列">](cell_one_wl.png) | 1,166 | ワード線を1本にまとめ、反転した2行でビアを共有 |
| 拡散共有・寸法最適化 | [<img src="cell_compact.png" width="180" alt="寸法を詰めた拡散共有型2×2配列">](cell_compact.png) | 1,536 | 端のコンタクトと内部配線を詰め、22×29.6 µm/bitに縮小 |
| **PDKのMOS部品を使用（採用）** | [<img src="cell_pcell.png" width="180" alt="採用したPDKのMOS部品による2×2配列">](cell_pcell.png) | **1,536** | PDK提供のMOS部品6個を配置し、同じノードの拡散を重ねて共有。専用描画と同じ密度 |

## レイアウト全体

[![レイアウト全体：横1776.7×縦600.0 µm](sram512_layout.png)](sram512_layout.png)

## 回路図全体

[![SRAM512の全体回路図](sram512_schematic.svg)](sram512_schematic.svg)
