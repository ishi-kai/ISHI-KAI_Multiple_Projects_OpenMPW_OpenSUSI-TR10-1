# PCell・セル配置の研究とKLayout補助

**完成した512 bitコアのGDSは [../sram512/layout/sram512.gds](../sram512/layout/sram512.gds) です。**
ここは主にセル・アレイの比較研究で、周辺回路込みの提出品とは区別します。

| フォルダ | 内容 |
|---|---|
| **[sram_pcell/](sram_pcell/README.md)** | 最終512 bitにも使用した元のPCell。生成元の場所を保持 |
| [dense_sram/](dense_sram/README.md) | 初期の高密度セル・配列、共通描画ヘルパー |
| [sram_research/](sram_research/README.md) | ソース共有など複数の配置案の比較 |
| [sram_compact/](sram_compact/README.md) | 拡散共有によるコンパクト化 |
| [sram_t4/](sram_t4/README.md) | 配線トポロジーの比較研究。4T SRAMを意味する名前ではない |
| [sram_macro_study/](sram_macro_study/README.md) | 容量・周辺面積・配線負荷の見積もり |
| [sram_area_options/](sram_area_options/README.md) | 面積と構成の選択肢 |
| [lvs/](lvs/README.md) | 初期セル・2×2のLVS補助。提出品の検証は公式devを使用 |
| [live_drc/](live_drc/README.md) | ライブDRC表示補助 |
| [path_preview/](path_preview/README.md) | 配線開始位置のプレビュー |

`place_sram_cont_n.py`と`place_sram_cont_p.py`は初期セルのコンタクト配置補助です。
比較研究は相互に生成コードを参照するため、ディレクトリ間の位置を保持しています。
