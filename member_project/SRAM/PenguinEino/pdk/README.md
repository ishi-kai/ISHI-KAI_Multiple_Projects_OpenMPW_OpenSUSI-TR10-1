# SRAMプロジェクト用TR-1um PDKの切り替え

2026-09-12。運営からのdevブランチ使用の案内に合わせ、**このプロジェクトのDRC/LVSはdev版を選択した状態**にした。KLayoutはプロジェクト専用の起動コマンドを使う。旧版PDKと既存のユーザー設定を保存し、旧版へ戻せる。

添付のセットアップ例には`~/pdk`や`~/src/TR-1um`を削除する処理があるため、そのまま実行せず、別ディレクトリへ導入した。使用中のKLayout 0.30.9で確認した。

## 起動・切り替え

以下は`/home/ishi-kai/sram`で実行する。

```bash
# 現在の選択と、実際に使うPDKの場所を表示
./scripts/pdk status

# 選択中のPDKでKLayoutを開く（現在はdev）
./scripts/pdk klayout sram_dense.gds

# 保存GDSをdevのDRCで検査
./scripts/pdk drc klayout/sram_pcell/pcell.gds --top pcell_20x76

# 旧版へ戻す
./scripts/pdk use original
./scripts/pdk klayout sram_dense.gds

# devへ再び切り替える
./scripts/pdk use dev
```

`use`はプロジェクト内の選択ファイルを書き換える。**すでに開いているKLayoutのPDKは切り替わらない**ので、新しいプロファイルで別のKLayoutを起動する。通常のアプリメニューから開いたKLayoutは従来の環境を使う。このプロジェクトのdev環境を使う場合は上の起動コマンドを使う。

選択を変更せず、一回だけ旧版を使うこともできる。

```bash
./scripts/pdk --profile original drc klayout/sram_compact/compact.gds --top compact_4x4
./scripts/pdk --profile original klayout sram_dense.gds

# コマンドを選択したPDKの環境変数で実行する
./scripts/pdk --profile dev exec -- python3 some_script.py

# KLayoutのオプションを渡す場合は -- の後に置く
./scripts/pdk klayout -- -ne klayout/sram_pcell/pcell.gds
```

DRCに違反があれば終了コード1、0件なら0を返す。PDKの実行失敗も成功扱いしない。マーカーDB・ログ・PDKとGDSのハッシュは`build/pdk_checks/<profile>/`に分けて保存する。GDSは再生成せず、指定した保存ファイルを検査する。

## 保存場所とバージョン

| プロファイル | PDK | KLayout設定 |
|---|---|---|
| dev | `.pdk/dev/TR-1um` | `.pdk/klayout/dev` |
| original | `.pdk/original/TR-1um` | `.pdk/klayout/original` |

devは[OpenSUSI/TR-1umのdevブランチ](https://github.com/OpenSUSI/TR-1um/tree/dev)から取得し、**`6afbd918951f2ea0dcd11c5a46986b4c20f9e6f9`**（2026-09-10の更新）を[profiles.lock.json](/home/ishi-kai/sram/pdk/profiles.lock.json)へ固定した。自動的な`git pull`は行わない。今回の検査結果はこのバージョンに対するもの。

originalは、以前使っていた`/home/ishi-kai/pdk/TR-1um`の実ファイルをコピーしたもの。元のソースチェックアウトは`v1.2609.0`、`c5bcc378c1c3d041fef6cc15e70d173bb80dcedb`だった。コピー前後でファイル内容の集合のハッシュを照合し、元の実環境を基準とした。Git管理情報とPythonキャッシュはこの比較から除く。

元の`~/pdk/TR-1um`、`~/src/TR-1um`、`~/.klayout/klayoutrc`、`~/.xschem/xschemrc`、`~/current_pdk`、`~/.bashrc`は今回の導入で書き換えていない。KLayoutの設定はコピー側だけでTR-1umの参照先を変更した。プロジェクトのライブDRC・配線プレビュー用マクロも専用環境に登録した。

`KLAYOUT_HOME`とテクノロジーの参照先をプロファイルごとに分離し、旧版とdevの同名PCellが同じKLayoutプロセスへ混ざることを避けた。旧来の`KLAYOUT_PATH`も専用起動時には継承しない。

## 既存スクリプトへの接続

[pdk_profiles.py](/home/ishi-kai/sram/scripts/pdk_profiles.py)が共通の参照先を解決する。優先順位は明示指定、`SRAM_PDK_PROFILE`、`.pdk/active`、ロックファイルの既定値（dev）。ログインシェルに旧版の`PDK_ROOT`が残っていても、このプロジェクトの検査は選択したプロファイルを使う。

次の検証入口を共通設定へ接続した。

- `klayout/dense_sram/verify.py`。これを使うresearch・compact・T4の検証も切り替わる。
- `klayout/sram_pcell/verify.py`。PCell生成用ソースと検証用PDKを区別してハッシュを記録するよう、`finalize.py`も調整した。
- `klayout/lvs/run.py`の独立した公式PDKチェック。元のセル境界専用`klayout/lvs/sram.lvs`は従来の別チェックとして残る。

過去のGDS・結果JSONは当時のPDKによる記録として残している。新しい比較は下記へ保存した。特に今回のDRC比較は、元のGDSをPCell再生成や形状修正で変えずに実施した。

## 同じGDSを検査した結果

[drc_comparison.json](/home/ishi-kai/sram/pdk/drc_comparison.json)に、6構成×2プロファイルの結果を保存した。

| GDSのトップセル | 旧版 | dev |
|---|---:|---:|
| 元の手配置 `sram_array` | 0件 | 0件 |
| 旧ルートの手配置GDS内 `sram_dense_1x1`（現在は`learning/layout/`） | 0件 | **12件** |
| 手描き最小案 `compact_4x4` | 0件 | **160件** |
| PCell版 `pcell_4x4` | 0件 | **0件** |
| 手描き最小案 `compact_20x76`、1,520 bit | 0件 | **15,200件** |
| PCell版 `pcell_20x76`、1,520 bit | 0件 | **0件** |

新しく検出されたカテゴリはすべて`CO.GG:CO(M)-GC Sfix != 1.0 or off-center/missing CO(M)`。MOSのコンタクトとゲートの間隔・位置を調べる検査で、[devのrun.drcの167〜168行](https://github.com/OpenSUSI/TR-1um/blob/6afbd918951f2ea0dcd11c5a46986b4c20f9e6f9/libs.tech/klayout/tech/drc/run.drc#L167)に対応する。最小間隔だけでなく、固定間隔やコンタクト位置を調べる処理が入っている。

したがって、以前の手描き最小案は**現時点のdevのDRCでは未合格**。今回の作業では切り替え後の差分を確認し、違反をマーカーとして保存した。レイアウト修正やルール緩和は行っていない。PCell版のDRC 0件も製造側の最終チェッカー通過を意味するものではない。

GUIの通常DRC／ライブDRC経由でも`compact_4x4`の160件を再現した。devのPCell・ルールファイル・DRC実行ファイルの実パスを確認している。旧版の専用GUIも起動・DRC実行でき、devの1×1 PCell版LVSも一致した。[GUI検査記録](/home/ishi-kai/sram/pdk/gui_validation.json)、[切り替え検証](/home/ishi-kai/sram/pdk/setup_validation.json)。

## 再構築と確認

```bash
# ロックしたPDKを準備。既存データの削除・上書き更新はしない
./scripts/pdk setup

# 実際の旧版/dev切り替え・既存検証スクリプト・元環境の保存を検証
python3 scripts/tests/verify_pdk_setup.py

# 同じ保存GDSのDRC比較
python3 scripts/compare_pdk_drc.py

# GUIも、画面を表示せず実アプリで検証
QT_QPA_PLATFORM=offscreen ./scripts/pdk --profile dev klayout -- \
  -z -t -ne klayout/sram_compact/compact.gds \
  -rd test_top=compact_4x4 -rd expect_co_gg=1 -r scripts/tests/pdk_gui_smoke.py
```

`setup`は既存のインストールを確認し、内容がロックした版と異なる場合には停止してファイルを残す。初回取得にはGitHubへの接続が必要。originalの初回コピーには元の`~/pdk/TR-1um`が必要になる。新しいdevへ更新するときは、現在の検査結果を残したうえで別のバージョンとして導入・比較する。

PDK本体、KLayoutの個人設定、再生成できるDRCマーカーとログは`.gitignore`で除外した。Gitには切り替え・再構築コード、固定バージョン、検証結果と手順を保存する。
