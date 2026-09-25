# MAC修正後の評価記録

主説明は [MAC_IMPROVEMENTS.md](../../MAC_IMPROVEMENTS.md)。10 V差の耐圧・寿命保証や製造投入の合格証ではありません。

- `logic.json` / `audit.json`：現行階層の理想論理、GDS内子セル・提出版の図形/ラベル同一性、格子・領域・PDK一致。
- `supply_T*_num0_power0_2.0_2.5_0.05.json`：未変更PDKでの低電圧DC再確認。`valid`と`logic_pass`と`accuracy_pass`を区別します。
- `supply_T*_num1_power0_0.5_7.0_0.05.json`：0/0だけを代数的に除去した等価RR式での詳細DC走査。低電圧の非物理的解は`valid=false`で除外します。
- `supply_T-40.0_fixed0_num0_power1_4.5_5.5_0.5.json`：階層電源のDC電流測定。
- `corners_supply.json` / `corners_integration.json` / `corners_boundary.json`：10 pF || 1 MΩ・1 µs、供給電圧/温度、起動3例、集中給電抵抗、0入力オフセット、低電圧境界。境界試験には意図的な不合格点も含みます。
- `corners_stress.json` / `corners_slew_stress.json` / `transient_stress_summary.json` / `slew_stress_summary.json`：電流・端子間電圧。MOSドレイン電流と全配線/ビア電流を同一視しません。
- `solver_comparison.json`：81入力列の収束設定による整定後電圧差。
- `worst_tight_*.json`：全遷移で見つかった最大誤差/遅延の遷移を、厳しい収束設定・2 ns刻みで再確認。
- `nany_regression.json`：RR30更新後NANYのDC近傍、全72遷移、入力スキュー回帰試験。
- `power_join.json`：MUL＋FAの共有VSS合流電流と40 µm M1形状。`vss_equivalence.json` / `vss_before*`は最終拡幅前後の回路同一性と波形再判定の証拠。
- `power_placement_equivalence.json`：上側VDD/VSSを左側MULの高さへ下げた変更。子セルと配置は不変、主接続24カットを維持し、抽出SPICEは全バイト一致。過渡解析の再実行ではなく、同一回路の既存合格結果を継承。
- `rr*.json`、`candidate*.json`、`hot*.json`、`finite_rr_hot.json`：実装前の電気的候補・収束診断の履歴。現在の物理レイアウト合格証としては使用しません。
- `supply_T-40.0_fixed0_num0_power0_1.9_2.5_0.05.json`は旧走査器の上り区間エラーを含む診断履歴。修正後の`2.0_2.5`報告を優先します。

全6,480遷移等の正式な公称結果は一つ上の `mac.json` / `mac_extracted.json` / `mac_summary.json`。
波形・試行ネットリスト・全状態の大量データはGit対象外の `simulation/mac_improvements/` と `simulation/mac/` に保存します。
