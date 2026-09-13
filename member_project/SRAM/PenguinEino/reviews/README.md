# レビューと保存確認

現在の提出物は[../submission/](../submission/README.md)です。ここはレビュー時点の記録です。

| ファイル | 内容 |
|---|---|
| [`sram512_review_response_2026-09-13.md`](sram512_review_response_2026-09-13.md) | 古いPASSの流用、波形不足、SDO誤変化の見逃しに対する修正と確認 |
| [`sram512_circuit_review_2026-09-13.md`](sram512_circuit_review_2026-09-13.md) | 回路構成・電流経路の追加レビュー。6Tセルの静的余裕、列MUX越しの書込み、7Tセンス、RESETの競合と内部ゲート電圧 |
| [`sram512_circuit_review_2026-09-13_results.json`](sram512_circuit_review_2026-09-13_results.json)、[`sram512_circuit_review.py`](sram512_circuit_review.py) | 現GDSの実寸法を使った24条件の小回路DC解析と、詳細RC波形の該当窓の再現 |
| [`sram512_review_2026-09-13.md`](sram512_review_2026-09-13.md) | SRAM512の設計・回路図・GDS・製造適合・テスト監査。新規検証、保存波形の再集計、検証ツールの欠陥と製造判断の未解決事項 |
| [`sram512_review_2026-09-13_results.json`](sram512_review_2026-09-13_results.json)、[`sram512_review_checks.py`](sram512_review_checks.py) | 上記レビューの入力ハッシュ・確認結果・負例の再現コード |
| `repository_organization.json` | 移動後の回路・レイアウト同一性、参照先の確認 |
| `submission_portability.json` | 直下配置の提出回路図を別の場所へコピーし、dev PDKで確認した結果 |
| `submission_manifest.json` | 提出ファイル一覧・元の場所・チェックサム・ZIPの確認 |
| `submission_lvs.json` | `sram512.sch`から通常設定で生成し、公式GUIの自動参照でLVS一致・DRC 0 |
| `sram512_release_archive.json` | 整理前の詳細版提出ZIPの検証記録 |
| `pre_organization_validation_summary.json` | 整理前の32依存ファイルと26群の検証一覧 |
| `sram_review_2026-09-11*` | 以前の2×2のレビュー |
| `sram_shared_frame_retest_2026-09-12.png`、`fixtures/` | FF共用方式の比較資料 |

旧パスと現在の場所の対応は[移動表](../docs/path-migrations.json)で確認できます。
