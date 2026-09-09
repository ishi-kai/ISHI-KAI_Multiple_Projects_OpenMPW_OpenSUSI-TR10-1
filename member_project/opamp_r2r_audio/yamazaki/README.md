# 2026-08-08_opamp-audio

- ISHI会「オーディオ用OPAMP半導体ハンズオン」(2026/08/08, WeWork日比谷) の成果物。
- プロセス: OpenSUSI-TR10 (TR-1um) / ツール: KLayout, xschem, ngspice
- https://ishikai.connpass.com/event/390873/

## 資料
- https://github.com/ishi-kai/openmpw-transistor-level-examples/tree/main/OpenSUSI-TR10/opamp_r2r_audio



## 成果物

- 差動増幅回路: `opamp_r2r_diff_yamazaki.sch` / `opamp_r2r_diff_yamazaki.gds`
- AB級出力段: `opamp_r2r_ABAMP_yamazaki.sch` / `opamp_r2r_ABAMP_yamazaki.gds`

両ブロックとも DRC 0件 / LVS "Netlists match" 確認済み。サイズ制限(差動300×500µm, AB級800×500µm)内であることも実測確認。前回に続きチップアート "T.Y" をM1に刻印。

## メモ・感想

- try_layout_01〜09までは自力で再現しました。PCell配置→M1/VIA/M2配線→ウェルタップ→ガードリングまで到達、DRC 0件でした
- 前回はsubckt名とセル名の不一致でLVSが失敗しましたが、今回は`cp`でファイル複製したため名前ズレなし。LVSが見るのはファイル名でなく中身のセル名、という切り分けができました
- スナップ設定0.005µmが原因でOFFGRID違反268件となりました。グリッド設定は作業前にします（リファレンス更新済み）
- 井戸をNWレイヤーで描いてしまいDRC大量発生→正しくはWN。プロセスのレイヤー名をしっかり確認します
- 自分でアレンジを加えるとすぐにDRC/LVSエラーになるのですが、サンプルの配置は、ある程度適当なのでなく、すべて意味があるものなのだと知りました
