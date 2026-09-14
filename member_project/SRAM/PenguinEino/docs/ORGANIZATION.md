# 2026-09-13 フォルダ整理

整理前の全履歴を保持したまま移動しました。

| 以前の場所 | 現在の場所 |
|---|---|
| ルートの`sram512*.sch` / `.sym` | `sram512/schematics/` |
| `sense_amp_7t.*`、`write_control.*` | `sram512/schematics/`。学習用からも共用 |
| その他のルートの`.sch` / `.sym` | `learning/schematics/` |
| ルートの旧GDS、抽出ネットリスト | `learning/layout/` |
| 拡張子なしの`sram_dense_1x1` | `learning/schematics/sram_dense_1x1.sch` |
| `SEQUENCER_DESIGN.md`、`TESTBENCHES.md`、容量の教材 | `learning/docs/` |
| `simulation/` | `learning/simulation/` |
| `rtl/` | `sram512/rtl/`。可変サイズの仕様は学習TBとも共用 |
| `tb/tb_sram512.sv` | `sram512/tb/` |
| その他の`tb/` | `learning/tb/` |
| `sram512/`直下のPython/C++ | `sram512/tools/` |
| `xschem_customizations.md` | `xschem/README.md` |

全対応は[path-migrations.json](path-migrations.json)。元PCellの場所`klayout/sram_pcell/`、
PDK本体、保存GDS、過去の詳細RC波形の場所は維持しました。個別レポートも履歴として保持し、
現在有効な結果は`sram512/reports/validation_summary.json`が列挙します。

## 履歴を読む

整理前の未コミット状態は`c1598f6`へ保存しました。次のブランチもその状態を指します。

```sh
git log --follow -- sram512/schematics/sram512.sch
git show before-submission-organization-20260913:sram512.sch
git log --all --oneline
```

rebase、履歴圧縮、`.git`再作成、強制pushは行っていません。
元の回路図32依存ファイル・GDS・マスクGDSの同一性と、移動後の確認結果は
`reviews/repository_organization.json`に記録しています。

## 過去の結果に残るパス

旧レポートや波形内の絶対パスは、その解析時点の記録です。元の内容・ハッシュを保持するため、
一括置換していません。新しい配置との対応は上の移動表を参照してください。
新しく実行するツールと利用手順の参照先は更新しています。

提出用`submission/`は`.sch`・`.sym`・`.gds`・`.md`と、README掲載用の全体画像を直下に置く構成です。
Xschemの標準ライブラリとTR-1um dev PDKを導入した環境で開きます。
モデルのコピー・JSON・実行スクリプト・ログは提出フォルダへ入れず、作業領域に保持します。
提出ファイルのチェックサムは`reviews/submission_manifest.json`にあります。
提出版GDSは外側の座標・端子用階層を一段統合し、トップ名を回路図と同じ`sram512`にしています。
元の全層の図形・文字・端子座標との一致は同manifest、通常設定でのDRC/LVSは
`reviews/submission_lvs.json`に記録しました。開発側の元GDS・マスク・旧階層は保持しています。
GUI実行で生じる`submission/simulation/`と抽出結果は作業ファイルで、Git・提出ZIPには含めません。
