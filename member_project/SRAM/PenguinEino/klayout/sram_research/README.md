# TR-1um SRAM：文献調査とレイアウト比較

2026-09-11。今回の候補では、**ソースを共有する6Tセルと、16列ごとに共有するタップ列の組合せ**が最も高密度だった。セルの配置ピッチは23.2×29.6 µm、686.72 µm²/bit。前回の21.2×34 µmセルに対してセル面積は4.73%減、セル密度は4.96%増となった。
23.2×29.6 µm
600×1800 µmには、タップ・電源配線を含む20×72＝1,440 bitを配置できた。寸法は90度回転後592.0×1798.2 µm。**周辺回路・パッドを含まないアレイの容量**であり、1,440 bitの完成SRAMマクロを意味しない。

![実GDSの単セル比較](/home/ishi-kai/sram/klayout/sram_research/cell_comparison.png)

## 調べた資料と、採用した考え方

- Balobas / Konofaos, *Design and evaluation of 6T SRAM layout designs at modern nanoscale CMOS processes*, MOCAST 2015：6種類の配置を同じルール・寸法条件で比較している。アレイでの反転、拡散層・コンタクト・タップの共有を評価する方針を採用した。この論文の比較は3層メタルで、thin/ultra-thinの元の構成にはlocal interconnectもあるため、その面積順位や縮小率をTR-1umへ直接適用していない。[著者公開全文](https://www.researchgate.net/publication/277075492_Design_and_evaluation_of_6T_SRAM_layout_designs_at_modern_nanoscale_CMOS_processes)、[学会の掲載一覧](https://www.mocast.eu/index.php/proceedings)
- Adam Teman, *Digital VLSI Design — SRAM*, pp.17–18, 33–53：従来セルとthin cellの配置、同じ向きに揃えたトランジスタ、SNMの測定方法を参照した。新配置では全MOSのゲート方向を揃え、DC伝達曲線から保持・読出しSNMも比較した。[大学公開講義資料](https://www.eng.biu.ac.il/temanad/files/2017/02/Lecture-7-SRAM.pdf)
- Wang / Lien / Terrill, *Local interconnect structure and process for six-transistor SRAM cell*, US5831899A：局所配線と拡散領域の相対配置による面積削減を検討する材料にした。記載の自己整合コンタクト、strapping viaなどはTR-1umの通常CO/V1では使えないため採用していない。[原資料](https://patents.google.com/patent/US5831899A/en)

今回のGDSは、これらの考え方を使ってTR-1um用に設計した独自の配置であり、論文中の特定セルの複製ではない。局所配線層、3層目のメタル、埋込みコンタクト、特殊SRAMルールは追加していない。

## 比較の条件と結果

全案で6T、全MOSのW/L＝3.4/1 µmを維持した。タップ間隔は16列。面積は配置ピッチと、実際に生成したGDSの外接矩形の両方で比較した。

| 配置 | セル面積 µm²/bit | 1,024 bitの実寸 µm、回転後 | 1,024 bitの面積 µm² | 600×1800内の最大配置 |
|---|---:|---:|---:|---:|
| 前回セル・前回タップ配置 | 720.80 | 547.4×1461.6 | 800,079.84 | 17×78＝1,326 bit |
| 前回セル・共有タップ列 | 720.80 | 547.4×1426.2 | 780,701.88 | 17×80＝1,360 bit |
| 新セル・両側タップ列 | 686.72 | 473.6×1646.6 | 779,829.76 | 20×68＝1,360 bit |
| **新セル・共有タップ列** | **686.72** | **473.6×1591.4** | **753,687.04** | **20×72＝1,440 bit** |

前回構成との比較では、1,024 bitのアレイ面積が5.80%減、最大配置容量が8.60%増。タップ列の共有を前回セルにも適用した対照案と比べても、アレイ面積は3.46%減、容量は1,360→1,440 bitとなった。したがって、タップ整理だけの効果とセル変更の効果を分けて確認できる。

最初の手描きセルの配置ピッチは57.5×28 µm＝1,610 µm²/bitで、図の参考比較に含めた。今回、この手描きセルから大容量アレイを作り直す検証はしていない。

「最大配置」は、各生成方式について1～100行・1～100列の単一矩形アレイを両方向で列挙した結果。ウェルの張り出し、奇数行の終端、共有タップ列、電源配線の外形を含む式を、保存GDSの実寸と照合した。任意形状・任意タップ間隔・全トポロジーに対する大域最適の証明ではない。

![アレイ外形と容量の比較](/home/ishi-kai/sram/klayout/sram_research/array_comparison.png)

## 新セルの配置を決めた理由

NMOSを1本の横方向拡散層に並べ、中央のVSSを2個のプルダウンで共有した。PMOSも1本の横方向拡散層とし、中央のVDDを共有する。以下の角括弧はゲート信号を表す。

```text
NMOS: BL —[WL]— Q —[QB]— VSS —[Q]— QB —[WL]— BLB
PMOS:            Q —[QB]— VDD —[Q]— QB
```

Q/QBの上下のドレイン接続とBL/BLBはM1に配置し、交差結合には短いM2配線を使った。前回セルの4本の縦M2トラックを前提とする構成から変えたことで、高さを34.0→29.6 µmへ減らせた。幅は21.2→23.2 µmへ増えるが、積としての面積は小さくなる。

寸法は、インストール済みPDKの通常ルールから決めている。

| 主な制約 | 今回の配置への影響 |
|---|---|
| MOS最小W＝3.4、最小L＝1.0 µm | 素子を小さくする余地は残さず、配置・共有を比較 |
| N拡散–Nウェル距離10、P拡散のウェル囲み7 µm | N/P拡散の中心間隔は20.4 µm |
| V1＝1.4、V1–GC距離1.2 µm | 連続するインバータゲート間にビアを収めるため4.8 µmのピッチ |
| M1幅1.8／間隔1.4、M2幅3.0／間隔2.0 µm | コンタクト周辺の曲がり、交差結合、隣接列の配線を制約 |
| CO/V1の重なり禁止、GC/V1の距離制約 | ゲートコンタクトとビアをずらして配置 |

行は上下反転で配置する。PMOSのVDD拡散はセル内で共有し、隣接行ではVDDのM2配線・ビアとウェルを共有する。ワード線はM2で配り、16列ごとの端部でポリシリコンへ接続する。タップ列には実際のウェル・基板コンタクトと電源ストラップを配置している。

前回セルのタップだけを共有した対照案では、ウェル上端の張り出しを列間でも埋める必要があった。単純に列間を縮めるだけではWN間隔違反になり、その修正後のGDSを比較している。

![2×2と共有タップ列の実GDS](/home/ishi-kai/sram/klayout/sram_research/array_detail.png)

## 不採用にした案

`offset_via.gds`は、前回構成の拡散コンタクト間隔を4.8→4.0 µmに詰め、ビアを横へ逃がす試作。名目のピッチは21.2×31.6 µm＝669.92 µm²/bitだが、2×2でDRC違反44件となった。LVSは一致するものの、V1–GC、M2間隔、隣接列のGC間隔、M1の切欠き、端部タップの拡散間隔が成立しない。この面積値を有効な密度改善には数えていない。GDSと生成スクリプトは不採用の比較資料として残した。

## 検証内容と適用範囲

通常候補と対照案の23個のトップセルは、インストール済みTR-1umの変更していないDRC/LVSデッキで全てDRC 0件・LVS一致となった。単セル、2×2、4×4、8×8、タップ境界を跨ぐ4×17、1,024 bit、各方式の最大配置、および動作観測用の2×2を対象としている。構成ごとの実行一覧、DRC件数、LVS一致状態、GDS・デッキのハッシュは[verification.json](/home/ishi-kai/sram/klayout/sram_research/verification.json)に保存する。規則除外、ラベルだけによる信号接続、ピン無視、W/L許容差の追加は行っていない。

さらに、帰還ゲートの切断、ビット線短絡、ワード線短絡を意図的に入れ、LVSが拒否することを確認した。検証失敗の試作も正常候補と混在させず記録する。

動作比較は、各案の**実際の2×2配置から抽出した24個のMOS**を既存の読み書き・選択・センス・保持テストベンチへ接続した。観測用GDSは元の配線形状を変更せず、Q/QBのラベルだけを追加して別途LVSを通している。接合のAS/AD/PS/PDを含めて使用した。

- VDD＝5 V、温度−40／27／85 ℃、外付けCBL＝10 fF／100 fF／1 pF、CY＝100 fF。
- 前回セルと新セルの各9条件、計18条件で読み書き試験PASS。
- 5 V・27 ℃の保持SNMは両案とも約1.537 V、読出しSNMは約0.442 V。DC刻み2.5 mVの伝達曲線を45度変換して算出。
- 遅い条件の例である85 ℃・CBL＝1 pFでも、センス開始前の最小絶対差動電圧は前回2.719 V、新配置2.717 V。この試験条件で速度改善を示す差ではない。

![保持と読出しの伝達曲線](/home/ishi-kai/sram/klayout/sram_research/stability.png)

**配線抵抗・配線容量のPEX、製造ばらつき・プロセスコーナー、ラッチアップ距離の製造上の適否、アレイ全体の電源降下は未検証。** 特に新配置はBLがM1で、WLのポリシリコン接続が16列ごとなので、配線RCを含む遅延は別途評価が必要。温度と外付け容量を振った試験を、これらの代わりにはしていない。1,440 bit全体のアナログ動作や周辺回路込みの収容確認も今回の結果には含まれない。

## ファイルと再現方法

採用候補は[euler_shared.gds](/home/ishi-kai/sram/klayout/sram_research/euler_shared.gds)。主なセル名は次のとおり。

| セル名 | 用途 |
|---|---|
| `euler` | 配置ピッチ23.2×29.6 µmの繰返し用コア。単独の外接矩形や端部付き単セルとは異なる |
| `euler_shared_1x1` | タップ・電源・WL接続・7端子ラベル付きの単セル検証用。外形66.2×41.8 µm |
| `euler_shared_16x64` | 1,024 bitアレイ |
| `euler_shared_20x72` | 600×1800 µm内に入る1,440 bitアレイ。90度回転して配置 |
| `euler_shared_probe_2x2` | 各ビットのQ/QB観測端子を持つ抽出シミュレーション用 |

単セル検証用の端部付きラッパーを全ビットに並べると、上記の密度にはならない。アレイ生成器はコアを反転配置し、タップ列と配線を共有している。

```bash
cd /home/ishi-kai/sram
python3 klayout/sram_research/build_candidates.py
python3 klayout/sram_research/build_baseline_shared.py
python3 klayout/sram_research/rejected_offset.py
python3 klayout/sram_research/verify_layouts.py
python3 klayout/sram_research/compare_area.py
python3 klayout/sram_research/compare_spice.py
python3 klayout/sram_research/render_results.py
```

検証をすべて再実行する場合は`verify_layouts.py --fresh`。通常実行では、入力より新しい保存済みレポートを読み直して再利用し、中断後は残りから進む。未完了のレポートは再実行する。詳細なDRC/LVSデータベース、抽出回路、SPICE入力・ログ・DC曲線は`build/sram_research/`に保存し、Gitの対象外とした。

[面積・容量の数値](/home/ishi-kai/sram/klayout/sram_research/area_comparison.json)、[動作比較の数値](/home/ishi-kai/sram/klayout/sram_research/spice_comparison.json)、[PDKのDRC実装](/home/ishi-kai/pdk/TR-1um/libs.tech/klayout/tech/drc/run.drc)。元の手描きGDSと前回の`klayout/dense_sram`は保持している。
