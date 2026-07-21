# MSL → LLVM IR (AIR) 対応表 — マスター (ハブ: v2 体系)

> 目的: `.metal → clang → LLVM IR → AIR bitcode → .metallib` を自前 LLVM/Clang で実現するための **MSL↔LLVM IR 対応表**。
> **2026-07-21 改訂**: 対応表は `data/builtin_to_air_map.v2.csv` が正本 (確度・出所・日時・検証手順つき 18 列スキーマ: `MAPPING_SCHEMA.md`)。全変更は `EVENTLOG.md` に記録され、昇格/検証は `scripts/promote_map.py` が担う (詳細 §3/§8)。
> 残る不確定セルは `data/probe_cells.csv` (576 セル) に集約 = macOS 実測タスク。probe シーンは `scripts/build_probe_scenes.py` により `probe_scenes/` へ機械生成される (生成器が信頼の起点)。

## 1. 変換アーキテクチャ (4段) と各段の完成度

```
[L0] MSLソース            kernel void f(device float* b [[buffer(0)]], ...) { y = sin(x); }
      │  ① Sema/attr    ② stdlib 展開
[L1] stdlib 表現          metal::sin(float)→ __metal_sin(x, __METAL_FAST_MATH__)
      │  ③ clang 内蔵 builtin (686語彙)
[L2] __metal_* builtin    __metal_sin(float, int) ── CGBuiltin.cpp が受理
      │  ④ CodeGen lowering  ★対応表の核心
[L3] AIR intrinsic/IR     call float @air.sin.f32(...)  (+ metadata, addrspace, CC)
      │  ⑤ JIT側リンク
[L4] rtlib 実体           __air_impl_nextafter_* ← __loweringlib.internal.N で供給
```

| 段 | 写像 | ローカル到達度 |
|---|---|---|
| ①② L0→L1→L2 | **✅ 完了**: API→builtin 全経路を機械分類 (free 3,810 + クラスメソッド 7,058 行) | `msl_stage1_api_to_builtin.csv`, `msl_stage1_methods.csv` |
| ③ builtin 語彙 | **✅ 完了**: 686 語彙 + 呼出サイト + availability ガード | `metal_builtins.csv`, `have_matrix.csv` |
| ④ L2→L3 | **✅ 全確定 (run26 反映、2026-07-21)**: v2 正本 686行。confirmed **641** (golden 実測名) / low **45** (air op 非存在を実測確定: frontend-consteval/native lowering/型) / medium, high **0**。証拠は全行 `evidence_ref` に golden 相対パス付き | `builtin_to_air_map.v2.csv` ★正本 |
| ⑤ L4 | **✅ 層判定完了**: callgraph 全抽出 (1,764 unique モジュール・エッジ 31,134・parse エラー 0)。`__air_impl_*` 26 実装関数を特定し builtin 2 件 (nextafter/os_log) の rtlib 帰属を確定 | `callgraph_edges.csv`, `rtlib_layer_map.csv`, `rtlib_pairing.csv` |

---

## 2. 表 F: MSL API → builtin (Layer0→2) ✅完了

**分類集計** (スクリプト `build_mapping.py` + `build_final_tables.py`):

| 分類 | 件数 | clang 作業 |
|---|---:|---|
| free function `builtin_direct` | 2,915 | CodeGen lowering 必須 |
| free function `builtin_composed` | 30 | 合成 lowering |
| free function header 内完結 | 865 | **変更不要** |
| クラスメソッド (texture/atomic/RT/mesh…178 クラス) | 7,058 行 → builtin **650** 語彙 | 同上 |

- builtin 使用率: 650/686。残り 36 語彙は呼出サイト無し (コンパイラ内部使用候補) → `no_callsite` として標識済
- 全行に `__HAVE_*` ガード列あり → `have_matrix.csv` と join で availability 完全一致可能

## 3. 表 D: builtin → AIR (Layer2→3) — `data/builtin_to_air_map.v2.csv` ★正本

**v2 体系 (2026-07-21 制定)**: 確度・出所・日時・検証手順を銘々する 18 列スキーマ (`MAPPING_SCHEMA.md`)。v1 (`builtin_to_air_map.csv`) は凍結保持。運用ルール:

- **additive のみ** (列追加のみ・削除/リネームなし)、推測で値 (特に日付) を埋めない
- 全変更を `docs/EVENTLOG.md` に日時記録、`scripts/promote_map.py` が audit/report/昇格を担う
- 昇格パス: ① `apply-golden` (実機 golden .ll + `probe_scenes/MANIFEST.csv` 突合 → confirmed) ② `apply-rtlib-layer` (callgraph で L4 帰属確定) ③ `ingest-callgraph` (直接 air 参照の補助証拠)

証拠等級の現況 (audit 冪等・`data/promote_report.md` が最新スナップショット):

| evidence | 件数 | confidence | 意味 |
|---|---:|---|---|
| `probed_xcode_ll` | 540 | confirmed | **実機 Xcode 26.5 (metal 32023.883) 生成 IR (golden corpus) で実名確定** — 正本の主柱 |
| `observed_ir` | 97 | confirmed | **実 IR から AIR シグネチャ全文を確認済 (P-IR1 再検算で全行検証成功)** |
| `rtlib_layer_backing` | 2 | confirmed | **AIR intrinsic に写像せず `__air_impl_*` 呼出に lowering (callgraph 実証: nextafter, os_log)** |
| `observed_airconv` | 19 | high | airconv が生成/解釈する名として確認 |
| `inferred` | **0** | — | **全行解消済** (run10–26 golden 訂正で全て probed_xcode_ll へ昇格 or 低確度 disposition へ) |
| `disposition (air op 非存在)` | 45 | low | **実測で専用 air op 非存在を確定**: frontend-consteval (get_sampler/struct_has_render_target/get_control_point/const 系), native LLVM 降下 (divide/select), 純粋型 `_t` 36, tensor fold 3 (各 evidence_ref に実測注記) |

補強: `data/air_ops_definitive.csv` (375 確定 op stem) / `data/ir_air_signatures.csv` (8,194 declare 全文) / `data/callgraph_edges.csv` (全ランタイム call グラフ 31,134 エッジ) / upstream LLVM での bitcode 読込 1,764/1,764 成功 (C-4 完了)。詳細は `IR_GROUND_TRUTH.md`。

**callgraph 由来の訂正**: v1 で `__metal_nextafter` に付けた `air.nextafter.*` 系候補は**偽**だった (当該 builtin は rtlib 層: 24 variant の `__air_impl_nextafter_*` 実装が callgraph で実在確認)。v1 マッパーの grammar 照合は文法的に正当な偽候補を通してしまう → observe でない inferred は「実測まで未確定」という運用の重要性を実証した事例として EVENTLOG に記録。

**命名文法は確立済** (`docs/AIR_VOCABULARY.md`):
`air.<op>[.s|.u][.rt{z,p,n,e}][.<[vN]type|pAS type>...]` — これにより inferred 569件も「文法適用+代表probeで一括確定」できる見通し。

実測の信頼性の高位ファクト:
- アドレス空間: `air.async_wg_copy.p1*.p3*` の p1↔p3 (device=1/threadgroup=3) を実測
- バリア: `air.wg.barrier`, `air.simdgroup.barrier`; atomic 全系 (`air.atomic.global.{add,and,max,or,sub,xor,xchg}.{s,u}.i32`, `cmpxchg.weak`), `air.atomic.fence`
- texture: read/write/sample/gather/fence + クエリ群 (`air.get_width_texture_2d` …)
- 数学: pi系 (`acospi/atanpi/tanpi`), sincos, mad24, abs_diff, add_sat, rsqrt 等

## 4. 表 L: 言語要素 (属性/組込変数/キーワード) — 既知確定分

| MSL | AIR表現 | 状態 |
|---|---|---|
| `[[thread_position_in_grid]]` 等 16種の組込変数 | `air.thread_position_in_grid` 等 (実名一覧は `data/airconv_air_ops.csv`) | ✅実名確定 |
| 補間 `[[center_perspective]]` 系 | `air.interpolate_{sample,center,centroid}_{perspective,no_perspective}.v4f32` | ✅ |
| `discard_fragment()` | `air.discard_fragment` | ✅ |
| `[[kernel]]/[[vertex]]/[[fragment]]` | 名前付き metadata `air.kernel`/`air.vertex`/`air.fragment` + エントリ md | ✅キー実測 / 🧪オペランド列 |
| 引数属性 `[[buffer(n)]]` 等 | metadata `air.arg_name` `air.arg_type_name` `air.arg_type_size(_align_size)` `air.address_space` … | 🧪スキーマprobe |
| `thread/device/constant/threadgroup` 修飾子 | `ptr addrspace(0/1/2/3)` — **実 IR で完全確定** (`IR_GROUND_TRUTH.md` §2.4) | ✅ |
| `#pragma METAL fp math_mode(safe)` | 専用 pragma → fastmath 制御 (FE実装必須) | ✅存在確認 |
| `#pragma METAL internals : enable` | 内部宣言 pragma (FE実装必須) | ✅存在確認 |

## 5. 表 T: 型 — `data/type_map.csv` (19行)

確定: `matrix<T,C,R> = { vec<T,R> columns[C] }` 列優先 (ヘッダ実測)、vector=`__ext_vector_type__`、**`packed_vector_type` は upstream clang に無い可能性大 (FE拡張必須)**。texture/sampler の opaque IR 表現は probe 最重要級で残置。

## 6. 表 R: rtlib リンク — `data/rtlib_pairing.csv` + `data/callgraph_edges.csv` + `data/rtlib_layer_map.csv`

実測規則: 各アーカイブ内 **`__air_impl_<API>…` (公開シンボル) → `__loweringlib.internal.N` (内部実装**関数**) を呼ぶ**構造。
**2026-07-21 訂正**: `__loweringlib.internal.N` は ar メンバー名でなく**関数名** (callgraph エッジとして実測: 直接エッジ 20/24 件確認。未検出 4 件は公開シンボル無しの特殊 rtlib)。

- `callgraph_edges.csv`: 全 1,764 unique モジュールの call エッジ 31,134 件 (caller/callee/member/archive)。`__air_impl_*` 実装関数 26 個の呼出構造を完全抽出 (os_log → `air.atomic.fence`/`air.get_private_data` 直接 + internal 経由 125 2-hop パス等)
- `rtlib_layer_map.csv`: `__air_impl_*` → `__metal_*` 逆引き辞書 (nextafter 24 variant, os_log)。**builtin → AIR 表に「rtlib 層」判定を導入した根拠データ**
- リンク単位=API機能単位。どの MSL API が rtlib リンクを引くかは `builtin_to_air_map.v2.csv` (rtlib_layer_backing 行) + 本表の join で参照可能

## 7. AIR コンテナ側 (付帯)

`.metallib` 構造は `data/metallib_structure.csv` で実測済 (MTLB tag NAME/TYPE/HASH/VERS/MDSZ/ENDT/UUID、fat slice↔triple air64_v23/v25/v26、writer は naga wiki/RFC PoC と統合して実装)。

---

## 8. probe フェーズ完了記録 (2026-07-21)

run10–run26 のエラー駆動ループ (upterm → macOS runner Xcode 26.5 / metal 32023.883) で **正本 686 行が全確定**。
- golden corpus: `golden/run1x_apply` … `golden/run26_apply` (各 scene .metal + .ll + meta.yml 入り, eventlog PROBE_GOLDEN 群を参照)
- 一次訂正の要点は `AIR_VOCABULARY.md` §6–§8 に集約済み (命名則, fold 則, stage 依存則, frontend-consteval family, cap 訂正)
- 以後の真の残作業 = §AIRNT C API 実機実行 / .metallib writer / xip (長期項目、§10 参照)

### 8.1 (旧文) macOS probe 計画 — 全件完了

`data/probe_cells.csv` (576 セル) に全不確定セルを集約。手順と最小 probe 群は `docs/PROBING_PLAN.md`。
**probe シーンは `scripts/build_probe_scenes.py` により `probe_scenes/` に機械生成済 (2026-07-21)**: 13+1 シーン、セル被覆 576/576 (auto_wrapper 35 / manual_needed 541)。実機で .ll を回収後:

```
python3 scripts/promote_map.py apply-golden golden/ --manifest probe_scenes/MANIFEST.csv
```

で対応表 v2 が `probed_xcode_ll` / confirmed へ昇格する (不一致行は降格せず MISMATCH 記録)。

probe で確定させる残項目:
1. エントリ metadata スキーマ確定 (kernel/vertex/fragment の3件で多数が連鎖確定)
2. inferred medium 519 builtin はファミリー代表 ~40 probe の golden と命名則で機械展開
3. opaque 型 (texture/sampler/RT) の IR 表現
4. function_constant / visible table 構築 ABI
5. rtlib 層関数の呼出形確定 (P13: `__air_impl_*` が宣言参照か実リンクか)

**裏ワザ (網羅の近道)**: `/System/Library/PrivateFrameworks/GPUCompiler.framework` バイナリの strings 抽出で clang 内蔵の全 AIR 名辞書が一括取得できる可能性 (xip 不可のため未実施。strings 取得なら medium 群を一括昇格可能)。

---

## 付録: ファイル索引

| ファイル | 内容 |
|---|---|
| `../data/builtin_to_air_map.v2.csv` | **本表の本体 (686 builtin × AIR、18 列 provenance 付き正本)** |
| `../data/builtin_to_air_map.csv` | v1 凍結版 (再現用・改変禁止) |
| `MAPPING_SCHEMA.md` | v2 スキーマ定義 (列・evidence・protocol・confidence ルール) |
| `EVENTLOG.md` | 全変更イベントの日時ログ |
| `../data/promote_report.md` | 確度集計の最新スナップショット |
| `REFERENCE_TREE_INVENTORY.md` + `../data/reference_tree_inventory.csv` | reference/clang/32023.883 全 145 ファイル棚卸 (header 71・rtlib 32・.a 32・metallib 10; ar member 計1,792) |
| `../golden/` | golden corpus (run1x–run26_apply: 実機 Xcode .ll + scene .metal + meta.yml)。証拠 JSON/一次エラー付き |
| `../data/promote_report.md` | 最新状態: confirmed 641 / low 45 / 残不確定 0 |
| `../data/callgraph_edges.csv` / `callgraph_air_impl.csv` / `callgraph_summary.md` | 全ランタイム call グラフ (31,134 エッジ、parse エラー 0) |
| `../data/rtlib_layer_map.csv` | `__air_impl_*` → `__metal_*` 逆引き (rtlib 層判定の根拠) |
| `../probe_scenes/` | probe シーン集 (機械生成・MANIFEST 付き) |
| `../data/scene_cell_coverage.csv` | セル → シーン割当 (人間検証用) |
| `../data/msl_stage1_api_to_builtin.csv` / `msl_stage1_methods.csv` | L0→L2 全経路 |
| `../data/air_stems_binaries.txt` / `air_strings_binaries.csv` | AIR 語彙実測 |
| `../data/airconv_air_ops.csv` | airconv の AIR 生成規則 (30 命名則含む) |
| `../data/type_map.csv` | 型対応 |
| `../data/rtlib_pairing.csv` | rtlib リンク構造 (ペア規則は §6 訂正参照) |
| `../data/probe_cells.csv` | macOS probe 対象全セル (576) |
| `AIR_VOCABULARY.md` | 命名文法・語彙分析 (§6 run10 tensor/quad/simd/rrm/fold 則 追補済) |
| `PROBING_PLAN.md` | macOS 実測計画 |
| `PIXEL_FORMAT_MAP.md` | 16 pixel format 完全対応表 (alias/tag/storage/許容 T/pack・unpack builtin) |
| `CLANG_FRONTEND_IMPL_MAP.md` + `../data/clang_frontend_impl_map.csv` | clang が .metal→LLVM IR に要する実装対応表 (lexer/parser/sema/型/CodeGen、1,210 行) |
| `STDLIB_RUNTIME_IMPL_MAP.md` + `../data/stdlib_runtime_impl_map.csv` | stdlib/runtime/rtlib クリーンルーム完全代替対応表 (1,380 行・ヘッダ在庫 43・module 在庫 1,257) |
| `../data/air_golden_names.csv` | golden 全 .ll からの機械抽出 AIR 語彙 (379 unique) |
| `../probe_scenes_methods/` | メソッド/Free/構築/pack/tensor/misc 深掘り probe シーン群 (MANIFEST_{methods,free,construct,pack,tensor,misc}.csv) |
| `../golden/*run10` | run10 実機成果 (std=metal4.0 -O2、tensor 13/13 compiled 等) |
| `../scripts/lib_mapschema.py` / `migrate_map_v2.py` / `promote_map.py` / `build_probe_scenes.py` / `build_callgraph.py` / `build_rtlib_layer.py` | v2 体系の器群 |
