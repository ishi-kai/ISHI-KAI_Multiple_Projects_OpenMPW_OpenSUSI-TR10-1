# SRAM LVS

```sh
python3 klayout/lvs/run.py
python3 -m unittest discover -s klayout/lvs/tests -v
```

`klayout` と Python の `klayout.db` が必要です。現在のPDK参照先は
`/home/ishi-kai/pdk/TR-1um` です。結果は `build/lvs/` に出力します。
実行スクリプトは、PDKが不一致でも終了コード0を返す場合を考慮し、
比較結果とLVSデータベースを確認して失敗時に終了コード1を返します。

## 最小限の補正

`sram.lvs` はインストール済みTR-1umの抽出・比較ルールをそのままincludeします。
デバイス寸法の許容差や標準の厳密ポート比較は変更していません。
追加する接続規則は次の1つだけです。

```ruby
connect_explicit("sram", ["VSS", "Vss"])
```

単体内で分かれている左右のVssレールと、PDKがVSSと呼ぶNMOS基板を、
上位arrayで接続するmust-connectとして宣言します。
結合後の複合ネット名だけを回路図の `Vss` に戻しています。
上位階層の実配線の検証を保つためdeepモードを使用します。

現在のGDSではWL両端は下辺のM1とcont_gで実接続されています。
Nウェルもcont_n経由でVddに実接続されています。
従来のWL/Vdd implicit接続、GCへのWLラベル転写、ウェルへのVddラベル転写は削除しました。

単体は6 MOS・7ポートの比較が一致しますが、VSS/Vssを上位で接続する必要があるという
`must-connect` 警告が1件残ります。実行スクリプトは単体のこの特定の警告だけを許容します。
単体をチップとして接続完了とみなすものではありません。
arrayでは同じ補正の接続義務が実配線で解決され、警告・エラーはありません。

## arrayの検証

標準メニュー **TR-1um LVS(Drawing)** では、`learning/layout/sram.gds` 内の `sram_array` を
`learning/simulation/sram_array.spice` と比較します。フォルダ整理後は参照回路のパスを指定してください。
このファイルはXschemが回路図から直接生成した24 MOSのFlatネットリストです。
ユーザー設定のFlat変換差し替えで、最上位の`.SUBCKT`宣言を保持します。

1. Xschemで `learning/schematics/sram_array.sch` を開く。
2. Options → Netlist format / Symbol mode → **Flat netlist** を有効にする。
3. Simulation → LVS → **LVS netlist + Top level is a .subckt** を有効にする。
4. 出力先をこのプロジェクトの `learning/simulation/` にして **Netlist** を押す。
5. KLayoutで `sram_array` を表示して **TR-1um LVS(Drawing)** を実行する。

生成後の手加工や別の展開コマンドは不要です。
差し替えの実装・導入・解除方法は [Xschemの設定](../../xschem/flat_top/README.md) を参照してください。

今回の実配線修正は、基板タップ用viaを `(30.0, -220.0)` から
Vssの上辺レール上 `(30.0, -208.8)` µm に移し、そのM1を延長する変更です。
元のviaはVssのM2から離れて浮いていました。
単体の形状・回路図・トランジスタ寸法は変更していません。

3つの結果を保存します。

| 結果 | 検証内容 |
| --- | --- |
| `sram.lvsdb` | 単体6 MOS・7ポート、上記must-connect前提で一致 |
| `sram_array.lvsdb` | 専用デッキでも同じ生成SPICEと一致、接続エラーなし |
| `sram_array_official.lvsdb` | 補正なしのPDK `run.lvs`、24 MOS・全8ポートが一致 |

標準チェックでは、通常の参照ファイルに用意した階層展開済みの同値回路を読み、
標準PDKの `align` でレイアウト側の階層を合わせます。
接続・デバイス・ネット名は維持し、比較規則は追加しません。
階層を残した標準デッキだけでは、単体内の分割Vssを回路図の単一Vssと比較するため不一致になります。
この独立チェックではarray全体の実接続を検証できます。

テストではGDSの一時コピーに故障を入れ、WL切断・ウェルタップ削除・
array基板タップ切断を検出することを確認します。
今回の結果はLVSの検証であり、全DRCの合格を示すものではありません。

GUIでは、arrayを表示して **TR-1um LVS(Drawing)** を実行してください。
単体には `sram_lvs.lylvs` の **SRAM / array LVS (Vss must-connect)** を使用します。
デフォルトの参照回路はPDKと同じ `simulation/<cell名>.spice` です。
`run.py` のarrayチェックはどちらも同じXschem生成ファイルを使用します。

GUIと同じ表示セル・デフォルト参照ファイルでの実行確認:

```sh
QT_QPA_PLATFORM=offscreen klayout -r klayout/lvs/tests/gui_default.py
```
