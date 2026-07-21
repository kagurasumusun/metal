# RTLIB_CLEANROOM_MAP — rtlib 全公開関数のクリーンルーム代替対応表

生成: scripts/build_rtlib_cleanroom_map.py (機械生成)

- 関数総数: **12672** (全 archive 横断でシンボル一意化)
- 分類分布: {'air-direct': 10278, 'leaf': 2068, 'llvm-or-module-only': 87, 'impl-chain-noair': 121, 'impl-chain-air@1hop': 106, 'impl-chain-air@2hop': 12}
- archive 度数分布: {1: 891, 2: 11775, 3: 3, 4: 2, 5: 1}

## 分類規則 (callee 集合から機械決定、内部シンボルは推移閉包で air 到達を判定)

| class | 意味 | 代替戦略 |
|---|---|---|
| air-direct | air.* 直呼び | 同等 AIR 呼出を emit する wrapper で代替 (語彙は builtin 対応表と同一正本) |
| impl-chain-air@Nhop | 内部連鎖の先 N hop で air.* に到達 | air_vocab_closure 列の語彙で wrapper 化 |
| impl-chain-noair | 内部連鎖のみ (air 非到達) | 連鎖先の leaf 実装ごと再実装 |
| llvm-or-module-only | llvm.*/module-object/data のみ | ポータブル IR または定数データで代替 |
| leaf | 呼出なし自己完結 | ヘッダ / 仕様 pdf の記述から MSL/C++ 等価実装 |

正本 CSV: `data/rtlib_cleanroom_map.csv`。**air-direct かつ builtin 連結済みの層が最先着の代替対象**。
