# TR-1umのPCellを使った6T SRAMの密度探索

2026-09-12追記：受信・アクセス保持段の共用後の容量を[再算定した](SHARED_CAPACITY.md)。600×1800 µmでは512 bitの75%条件が593.6×1623.4 µmに縮小。端数を許す85%条件では16×41＝656 bit。1600×800 µmも別途比較した。以下の周辺容量表と`capacity.json`は二重保持時の記録。

2026-09-12。**TR-1umライブラリのMOS PCellを6個使い、22.0×29.6 µm＝651.20 µm²/bitの配置を実装・検証した。** 以前の手描き最小案と同じビット密度になった。今回の8候補の探索ではこれが最小。6T構成、全MOSのW/L＝3.4/1 µm、M1/M2のみという条件を維持した。

[採用GDS](/home/ishi-kai/sram/klayout/sram_pcell/pcell.gds)には単セルから20×76＝1,520 bitまでのアレーを収録した。全10トップでDRC違反0件・LVS一致。実2×2の抽出回路と既存シリアル周辺回路による3条件の動作試験も通った。

![保存GDSの比較。右がTR-1umのPCell版](/home/ishi-kai/sram/klayout/sram_pcell/cell_comparison.png)

## 使用したPCellと拡散共有

使用元はローカルに導入済みの[OpenSUSI/TR-1um](https://github.com/OpenSUSI/TR-1um)にあるPythonライブラリ`TR-1um`。ソースは`/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech/python/cells/`。このソースは今回変更していない。使用したファイルのハッシュを[pcell_audit.json](/home/ishi-kai/sram/klayout/sram_pcell/pcell_audit.json)に記録した。

| 用途 | PCell | 採用コア内の数・パラメータ |
|---|---|---|
| アクセス・プルダウンMOS | `fet_n` | 4個、`w=3.4, l=1, n=1, cont_between_gates=True, y0=c` |
| プルアップMOS | `fet_p` | 2個、同上 |
| ゲートへのコンタクト | `cont_g` | 2個、アレーのWL接続部にも使用 |
| M1–M2接続 | `via_1` | コア・アレーの接続に使用 |
| 基板・ウェルタップ | `cont_p`, `cont_n` | アレー端部と16列ごとの接続に使用 |

MOSの形状を手描きしてPCellで包んだものではなく、**提供ライブラリのPCellインスタンスそのもの**を配置している。元のPCell内の拡散・ゲート・コンタクト・M1は削除・編集せず、ウェルとGC/M1/M2配線を親セルへ追加した。

密度を上げるため、同じノードにつながる端部の拡散を、PCell同士の重ね合わせで共有した。Q/QB側ではコンタクトを同じ座標へ重ね、中央のVSS/VDD側ではコンタクト中心を2.0 µm離したまま、拡散だけを0.6 µm重ねる。後者には元のコンタクトが2個とも残る。行は交互に反転してウェルを共有する。

PCellがそれぞれ正しい形でも、重ね方によって短絡や間隔違反が起こる。このため、PCell単体の検査に加え、**共有後のアレー全体**を検証した。製造側がこの重ね合わせを受け入れることまで確認した結果ではない。

## これまでの資料・結果をどう反映したか

参照した[2016年論文](https://www.jestr.org/downloads/Volume9Issue5/fulltext23952016.pdf)のFig. 2・3・8と、[2015年の6方式比較](https://www.researchgate.net/publication/277075492_Design_and_evaluation_of_6T_SRAM_layout_designs_at_modern_nanoscale_CMOS_processes)のFig. 2・3では、素子配置と隣接セルの共有を含むアレー比較が重要になる。今回も単体の外接矩形ではなく、反転・共有して敷き詰めた配置周期と端部込み面積を評価した。

前段の[T4・M1/M2版](/home/ishi-kai/sram/klayout/sram_t4/README.md)は857.38 µm²/bit、[共有ソースの手描き最小案](/home/ishi-kai/sram/klayout/sram_compact/README.md)は651.20 µm²/bitだった。そのため今回は、後者の拡散列・中央共有・反転配置を出発点に、TR-1umのPCellが生成する固定のゲート／コンタクト間隔に合わせて配線し直した。論文の3層Metalや32 nmの寸法をそのまま使ったものではない。

## 実レイアウトによる比較

[scan.py](/home/ishi-kai/sram/klayout/sram_pcell/scan.py)で8種類の4×4アレーを生成し、同じPDKのDRC/LVSを実行した。[全結果](/home/ishi-kai/sram/klayout/sram_pcell/scan.json)。面積欄は配置周期の積で、不成立案を有効なビット密度には数えていない。

| 候補 | 配置周期 µm | 面積 µm²/bit | DRC | LVS |
|---|---:|---:|---|---|
| Nを2ゲートPCell×2、Pを1ゲートPCell×2 | 23.2×29.6 | 686.72 | 0件 | 一致 |
| 同上、列を詰める | 22.0×29.6 | 651.20 | 0件 | 一致 |
| **6個とも1ゲートPCell：採用** | **22.0×29.6** | **651.20** | **0件** | **一致** |
| 列ピッチ21.9 | 21.9×29.6 | 648.24 | 15件：N拡散・M1間隔 | 一致 |
| 行ピッチ29.5 | 22.0×29.5 | 649.00 | 16件：GC間隔 | 一致 |
| 中央コンタクト中心間隔1.9 | 21.9×29.6 | 648.24 | 64件：CO・M1・V1–GC間隔 | 一致 |
| 行ピッチ28.5 | 22.0×28.5 | 627.00 | 0件 | **不一致** |
| Nを4ゲート、Pを2ゲートの連続PCellへ置換 | 22.0×29.6 | 651.20 | 208件 | **不一致** |

採用案では、N拡散の左右端がX＝−1.3 / 19.3 µm。隣接列と1.4 µm離すには、列ピッチは22.0 µm以上必要になる。反転した隣接行のPゲート端は、行ピッチ29.6 µmでちょうど1.2 µm離れる。29.5 µmでは間隔違反、28.5 µmではゲート同士がつながり、DRCが0件でもLVSで不一致になる。

6個の1ゲートPCell案と、Nを2ゲートずつまとめた案は同じ密度で成立した。採用版は6個のMOSを個別に確認しやすい前者とした。最終行の連続PCell案は、既存の配線位置との相性を試した結果であり、**その方式の全配線を最適化して否定した結果ではない**。今回の最小値はこの探索範囲での値で、全トポロジー・全W/Lに対する最適性の証明ではない。

![8候補の実4×4 GDSを同じ縮尺で表示](/home/ishi-kai/sram/klayout/sram_pcell/scan_comparison.png)

## 保存したPCellと回路の確認

[audit.py](/home/ishi-kai/sram/klayout/sram_pcell/audit.py)は、まずライブラリ未登録の状態でGDSを読み、保存されているPCellの図形を取得する。その後にTR-1umを登録し、同じパラメータから新しく生成した図形とレイヤーごとに比較した。ライブラリ登録による自動再生成で、保存図形の変更が隠れない順序にしている。

- MOS・コンタクト・ビアの全6種類のPCellで、保存形状と再生成形状の差分面積は0。
- コア内には`fet_n`が4個、`fet_p`が2個。親セルに追加した拡散は0。
- 配線を加えた後のゲートと拡散の交差領域は、元の6個のMOSと一致。追加のゲート形成やW/L変更はない。
- TR-1umを登録してGDSを再読込すると、全PCellのライブラリ名・宣言名・パラメータが復元される。
- 1×1から抽出した回路も、W/L＝3.4/1 µmのNMOS 4個、PMOS 2個。

GDSの検証には、導入済みTR-1umの`tech/drc/run.drc`と`tech/lvs/run.lvs`を変更せず使用した。ルール除外やポート無視は追加していない。[verification.json](/home/ishi-kai/sram/klayout/sram_pcell/verification.json)には最終GDSのハッシュと全10トップの結果を、[verification_inputs.json](/home/ishi-kai/sram/klayout/sram_pcell/verification_inputs.json)にはPDKと参照回路のハッシュを保存した。

## 電気的な検証

`learning/schematics/sram_tb_serial.sch`を現在の回路図から再ネットリストし、4個のメモリセルを**実2×2アレー全体の抽出回路**へ置き換えた。周辺回路には既存のシリアル制御・行列選択・書き込み・読み出し回路を使い、ユーザーの回路図は変更していない。

| 電源・温度 | BL負荷 / 共通線負荷 | シリアル動作試験 |
|---|---|---|
| 5 V・27℃ | 10 fF / 100 fF | PASS |
| 5 V・85℃ | 10 fF / 100 fF | PASS |
| 5 V・27℃ | 1 pF / 1 pF | PASS |

各条件は100 nsクロック、19操作、3,408件のRTL比較と745件のアナログ区間判定。[serial_results.json](/home/ishi-kai/sram/klayout/sram_pcell/serial_results.json)。負荷容量は感度確認のために与えた値で、配線から抽出した値ではない。今回のPCell版について、512 bit以上の全マクロ動作試験や全アドレス・全パターンの試験は行っていない。

抽出1×1のDC伝達曲線から、前段と同じ[回転VTCによるSNMの手順](/home/ishi-kai/sram/klayout/sram_pcell/verify_dc.py)で保持・読出しの安定性を比較した。5 V・27℃で、保持SNM **1.5373 V**、読出しSNM **0.4421 V**。以前の手描き案とこの計算精度で同等だった。[snm.json](/home/ishi-kai/sram/klayout/sram_pcell/snm.json)。方法の参考は[TemanのSRAM講義資料](https://www.eng.biu.ac.il/temanad/files/2017/02/Lecture-7-SRAM.pdf)、pp.33–53。

抽出回路には共有後の接合面積・周囲長（AS/AD/PS/PD）を反映した。配線RCのPEX、製造ばらつき、プロセスコーナー、IR drop、タップ距離の製造条件は未評価。また、今回使用したのはTR-1umのDrawing Layer用PCell・検証フローであり、[MDPと製造側の最終確認](https://github.com/OpenSUSI/TR-1um/blob/main/Document/Drawing_vs_Mask.md)を通した製造保証ではない。

## 600×1800 µmへの収容数

タップ間隔16列、タップ列の幅21.2 µm、左右の端部合計43 µmという前段と同じ条件で比較した。保存GDSの外形は次のとおり。

| アレー | ビット数 | 端部・電源・タップ込み外形 µm |
|---|---:|---:|
| 1×1 | 1 | 65.0×41.8 |
| 2×2 | 4 | 87.0×59.2 |
| 4×4 | 16 | 131.0×118.4 |
| 4×17：タップ境界確認 | 68 | 438.2×118.4 |
| 8×8 | 64 | 219.0×236.8 |
| 16×16 | 256 | 395.0×473.6 |
| 16×32 | 512 | 768.2×473.6 |
| 16×64 | 1,024 | 1514.6×473.6 |
| **20×76** | **1,520** | **1799.8×592.0** |

単独1セルの65.0×41.8 µmはタップ・終端付きの外接寸法で、651.20 µm²/bitはアレー内の繰返し面積。両者は異なる。20×76を90度回転すると592.0×1799.8 µmで目標領域に収まる。この候補そのもののDRC/LVSも通った。

幅＝`22×列数＋21.2×floor((列数−1)/16)＋43`、高さ＝`29.6×行数＋奇数行なら12.2`の式を全9寸法のGDSと照合した。1〜100行・1〜100列を両方向で列挙すると、今回の矩形アレーでは1,520 bitが最大だった。[寸法](/home/ishi-kai/sram/klayout/sram_pcell/dimensions.json)、[容量計算](/home/ishi-kai/sram/klayout/sram_pcell/capacity.json)。

周辺回路込みは、以前と同じシリアル構成・標準セル・配線領域の予算で再計算した。PCell版も外形が同じなので、次の見積もりは変わらない。

| ロジック配置率 / 列周辺の奥行き | 入る最大の2べき乗容量 | マクロ外形の見積もり µm |
|---|---:|---:|
| 65% / 150 µm | 256 bit | 592.6×1561.2 |
| 75% / 120 µm | 512 bit | 593.6×1783.4 |
| 85% / 120 µm | 512 bit | 593.6×1733.4 |

これは**周辺回路を配置・配線していないブロック見積もり**で、パッド・ESDを除く。アレー単体の1,520 bitとは分けて扱う。行出力のINVなどはセルごとの単純な横並びにはせず、偶数／奇数行に分けた2レーンと端子位置を合わせる配線領域を合わせて137.6 µm予約する。WL端子のY座標は2.7、56.5、61.9、115.7…µmで、間隔は53.8 / 5.4 µmの交互。この問題と代替案は[周辺回路調査](/home/ishi-kai/sram/klayout/sram_macro_study/README.md)を引き継ぐ。

## 再生成と成果物

```bash
cd /home/ishi-kai/sram
python3 klayout/sram_pcell/scan.py
python3 klayout/sram_pcell/finalize.py
python3 klayout/sram_pcell/audit.py
python3 klayout/sram_pcell/verify_serial.py
python3 klayout/sram_pcell/verify_dc.py
python3 klayout/sram_pcell/compare_capacity.py
python3 klayout/sram_pcell/render_results.py
```

採用版の生成・全トップ検証は`finalize.py`で行う。`build.py`は寸法・PCellのまとめ方を変更する実験用入口。最終GDSのコア名は`pcell_core`、最大アレーは`pcell_20x76`、観測端子付き2×2は`pcell_probe_2x2`。KLayoutではTR-1umライブラリを登録し、TR-1umテクノロジーでGDSを開くとPCellとして編集できる。ライブラリ未登録の読み込みでも保存図形は表示できるが、その場合は通常のセルとして読まれる。

抽出回路・ログ・波形・探索用GDSは`build/sram_pcell/`に置き、再生成できる大きなデータはコミット対象外とした。元の回路図・GDS・既存調査ファイルは保持している。
