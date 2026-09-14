# TR-1um SRAM

**提出物は [submission/](submission/README.md) にまとめています。**
16行×32列・512 bit、7端子のSRAMコアです。提出用READMEから回路図・TB・GDS・操作方法・アピールポイントへ辿れます。

| やりたいこと | 場所 |
|---|---|
| 提出物を見る／渡す | **[submission/](submission/README.md)** |
| 512 bit完成版を編集する | [sram512/schematics/](sram512/schematics/README.md) |
| 提出版GDSを開く | [submission/sram512.gds](submission/sram512.gds)（top: `sram512`） |
| 検証元のGDS・配置記録を見る | [sram512/layout/](sram512/layout/)（元のtop: `sram512_macro`） |
| 完成版の設計・検証手順を読む | [sram512/README.md](sram512/README.md) |
| 単セル・2×2から学習を追う | [learning/](learning/README.md) |
| 元のPCellとセル配置比較を見る | [klayout/](klayout/README.md)、元PCellは [klayout/sram_pcell/](klayout/sram_pcell/README.md) |
| 共通ツールを探す | [scripts/](scripts/README.md) |
| PDKの固定バージョン・設定を見る | [pdk/](pdk/README.md) |
| Xschemの表示補助を見る | [xschem/](xschem/README.md) |
| レビュー記録を読む | [reviews/](reviews/README.md) |
| 計算途中のデータ・大きな波形を探す | [build/](build/README.md)（Git・提出物には含めない） |

## よく使うコマンド

リポジトリのルートから実行します。

```sh
python3 sram512/run.py circuit       # 完成版の全体回路図
python3 sram512/run.py tb            # 完成版のMOSテストベンチ
python3 sram512/run.py digital       # 回路図の論理とVerilog仕様の照合
python3 sram512/run.py layout-check  # 保存GDSの公式DRC/LVS・マスク検証
python3 learning/open.py            # 以前の2×2シリアルTB
python3 sram512/tools/submission_runner.py simulate  # 提出用TBで16操作を試す
python3 sram512/run.py submission-lvs  # 提出版を通常のGUI設定でLVS・DRC確認
```

`submission/`には必要な`.sch`・`.sym`・`.gds`・`.md`と、README掲載用の全体画像を直下に置いています。
TR-1um PDKはインストール済みのdev版を参照します。編集は`sram512/schematics/`で行い、必要な再検証後に
`python3 sram512/run.py submission`で提出物を更新します。提出用コピーを直接編集した場合、
更新ツールはその変更を検出して停止します。
提出版は外側の座標用階層を一段統合し、`sram512.sch`とGDSトップ名を揃えています。
元の全図形・端子座標は保持しています。

提出版のLVSは、Xschemで`submission/sram512.sch`を開き、Simulation → LVS →
「LVS netlist + Top level is a .subckt」をON、Flat netlistをOFFにします。
出力先を「Use 'simulation' dir in schematic dir」にしてNetlistを実行し、
KLayoutで`submission/sram512.gds`のトップ`sram512`にLVS(Drawing)を実行します。
dev版での起動は`./scripts/pdk --profile dev exec -- xschem submission/sram512.sch`と
`./scripts/pdk --profile dev klayout submission/sram512.gds`です。

## 整理とGit履歴

整理前の未コミット変更も`c1598f6`に保存し、`before-submission-organization-20260913`
ブランチを残しています。移動先と履歴の辿り方は[整理の記録](docs/ORGANIZATION.md)を参照してください。
過去の不合格レポートや大きな波形も作業領域に残しています。

## 検証範囲

保存GDSは横1776.7×縦600.0 µm。Drawing DRC・製造マスクDRCは0件。
厳密LVSは元の階層で全14回路一致、提出版の階層統合後は全13回路一致です。
読み書きの条件は[仕様書](submission/SPEC.md)、詳細な検証記録は[検証説明](sram512/VERIFICATION.md)に記載しています。
寄生RCは仮定した係数による簡易モデルです。最大端子間電圧の5.75 V基準までの余裕は
約2.5 mVで、製造ばらつきや電源範囲の保証にはしていません。
