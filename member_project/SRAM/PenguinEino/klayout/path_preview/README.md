# Path開始前の幅プレビュー

KLayoutの標準Pathツールで、最初のクリック前に縦横の長さが設定幅と同じ
水色の十字（＋）を表示するPythonマクロです。既存のLive DRCのMarkerと
autorunマクロの構成を参考にしています。KLayout本体の再ビルドは不要です。

```bash
./klayout/path_preview/install.sh
```

次回KLayout起動時から自動で有効になります。起動中のKLayoutでは
Macro Developmentで `pymacros/path_start_preview.lym` を開いて実行しても
読み込めます（再実行しても二重登録しません）。

- 標準Pathの幅設定とグリッド・図形スナップに追従します。
- 最初のクリックで十字を消し、以降は標準Pathのプレビューを使います。
- 確定・キャンセル後は再表示、他ツールや画面外では非表示になります。
- `Tools > Path start preview` で一時的に無効化できます。
- 表示用マーカーのみで、レイアウトやUndo履歴には追加しません。

十字は幅の目安です。向きやFlush/Round/Squareの端部形状は、配線開始後の
標準プレビューで確認してください。起動中にマクロを読み込む場合は、
作図途中のPathをいったん確定またはキャンセルしてから実行してください。

Pluginの `snap2` とEditorHooksを使います。対象はKLayout 0.30.4以降、
動作確認はこの環境の0.30.9です。50 msのタイマーは幅・ツール変更の追従用で、
マウス移動にはイベントで即座に追従します。

検証（保存せずに専用レイアウトを生成して、標準ツールへ入力イベントを送信）:

```bash
QT_QPA_PLATFORM=offscreen klayout -z -nc -rx -e \
  -r klayout/path_preview/tests/gui_smoke.py
```

API参考: [Plugin](https://klayout.de/doc/code/class_Plugin.html)、
[EditorHooks](https://klayout.de/doc/code/class_EditorHooks.html)。
