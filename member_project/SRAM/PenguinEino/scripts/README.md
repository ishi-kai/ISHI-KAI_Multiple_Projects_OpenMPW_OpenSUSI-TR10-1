# 共通スクリプト

512 bit専用の入口は`python3 sram512/run.py --help`、実体は`../sram512/tools/`です。
ここは完成版・学習用・レイアウト比較で共用するスクリプトを置きます。

| ファイル | 用途 |
|---|---|
| `pdk`、`pdk_profiles.py` | PDKの固定バージョンとGUI・検証環境 |
| `project_paths.py` | 完成版と学習用回路の場所 |
| `verify_rtl.py` | 可変サイズのシリアル仕様の論理検証 |
| `verify_serial_spice.py`、`serial_spice_stimulus.py` | 2×2のMOS試験 |
| `verify_shared_frame.py`、`diagnose_shared_frame_load.py` | 受信・アクセスFF共用の回帰確認 |
| `review_sram.py` | 以前の2×2のレビュー |
| `build_serial_schematics.py` | 2×2回路図生成と、完成版から使う描画部品 |
| `compare_pdk_drc.py`、`tests/` | PDK環境の比較・確認 |

生成スクリプトは、意図して回路図を再生成するときに使ってください。
回路図を読む・検証する操作は、手編集を上書きせず実行できます。
