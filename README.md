# metal — MSL 一次情報 + LLVM/Clang Metal 対応の解析成果

> macOS/iOS 系 Silicon 向け Metal Shading Language (MSL) を自前 LLVM/Clang fork でコンパイル可能にするための一次情報と解析成果を収める。
> 最終スコープ: `.metal → clang(frontend) → LLVM IR (AIR) → AIR bitcode → .metallib` (Apple 全 OS: macOS/iOS/macabi/tvOS/watchOS/visionOS + 各 simulator)。最終 JIT は Apple GPUCompiler.framework に委譲。

## 構成 (2026-07-21 整理)

| パス | 内容 | 性質 |
|---|---|---|
| `Metal-Shading-Language-Specification/` | Apple 公式 MSL 仕様書 PDF **全 11 版** (1.2〜4.1) | 一次情報 (Apple) |
| `reference/clang/32023.883/include/metal/` | 実ツールチェーン (Xcode 26 系, `metalfe-32023.883`) の metal_stdlib ヘッダ ~130 ファイル | 一次情報 (Apple) |
| `reference/clang/32023.883/lib/darwin/` | GPU ランタイム実バイナリ (`.rtlib`/`.a` = 標準 LLVM bitcode、実 `.metallib` ほか) | 一次情報 (Apple) |
| **`metal-info-set/`** | **解析成果 (本プロジェクトの本体)**: 対応表・器・probe 計画 | 自作成果 |

### metal-info-set の中身

- `docs/` — **MSL_TO_IR_MAPPING.md (対応表ハブ)**, MAPPING_SCHEMA.md, EVENTLOG.md (全変更の日時記録), IR_GROUND_TRUTH.md, AIR_VOCABULARY.md, GPUCOMPILER_SYMBOLS.md, PROBING_PLAN.md, SPEC_VERSION_TIMELINE.md, INITIAL_GAP_ANALYSIS.md, 実 IR サンプル
- `data/` — **builtin_to_air_map.v2.csv ★正本** (686 builtin × AIR、18 列 provenance; confirmed 99 / high 68 / medium 519), callgraph_edges.csv (全ランタイム 31,134 エッジ), AIR 語彙/シグネチャ集、能力マクロ行列、spec 採掘 CSV ほか
- `scripts/` — 対応表 v2 体系の器 (promote_map.py / build_callgraph.py / build_probe_scenes.py / build_rtlib_layer.py / migrate_map_v2.py / lib_mapschema.py) + 採掘スクリプト群 (全成果はスクリプトから再生成可能)
- `probe_scenes/` — probe シーン集 (機械生成、576 セル被覆、MANIFEST 付き)
- `reference-external/` — 参照実装・SDK 資料: dxmt/airconv (3Shain/dxmt, AIR 参照実装), gpucompiler-tbd (AIRNT C API シンボル), macos-sdk-metal-headers

### 削除済 (記録は metal-info-set/docs/EVENTLOG.md)

- `msl_analysis/` (2026-07-21 削除): AI 生成の二次解析文書で、実証済の誤りが多い (例: `spir_kernel` 呼出規約の主張→全 701 モジュールがデフォルト C CC で否定、架空の GPU 向け ARM64 CPU asm 実装例 等)。**根拠として一切使用しない**。削除の経緯と誤り一覧は INITIAL_GAP_ANALYSIS.md §1 参照
- `metal-info-set/work/` (同): 再生成可能な中間展開物

## ライセンス/権利

- `Metal-Shading-Language-Specification/`, `reference/clang/` は Apple Inc. の著作物です (入手経路は公開配布物)。利用は調査・互換性目的の範囲で
- `metal-info-set/` 配下の成果は本プロジェクトの調査成果です
- `metal-info-set/reference-external/dxmt/` は dxmt プロジェクトのコードを含みます (COPYING.LIB 参照: `https://github.com/3Shain/dxmt`)

## 再現/再取得

- 全 CSV・対応表・probe シーンは `metal-info-set/scripts/` を再実行すれば `reference/` 一次情報から再生成可能 (実行環境: Python 3.13 + llvmlite 0.46)
- 次の一手: macOS 実機で `probe_scenes/` をコンパイルし golden を回収 → `promote_map.py apply-golden` で対応表昇格 (手順 `metal-info-set/docs/PROBING_PLAN.md`)
