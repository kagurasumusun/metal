# AIR IR グランドトゥルース (実ランタイム bitcode 全文逆アセンブル解析)

> 達成: **Apple 純正 AIR bitcode を upstream LLVM (llvmlite / LLVM 20) で全文パース可能であることを実証 (C-4 完了: 701/701 モジュール、エラー 0)**。これにより「文字列推測」ではなく **実 IR からの一次情報** で AIR 契約の大部分を確定した。
> 再現: `scripts/dump_ir_ground_truth.py` → `data/ir_*.csv`, `docs/samples/*.ll`
>
> **2026-07-21 追記**: macOS 実機 (upterm 経由) での golden corpus 取得により §6 を追加。ツールチェーンは参照ランタイムと同一世代 (metalfe-32023.883)。

## 6. 実機 golden による確定 (2026-07-21, `golden/`)

### 6.1 観測環境 (`golden/meta.yml`, `golden/env.txt`)

| 項目 | 値 |
|---|---|
| macOS | 26.4 (build 25E246), Darwin 25.4.0, arm64 (RELEASE_ARM64_VMAPPLE = Apple Silicon VM) |
| Xcode | 26.5 (Build 17F42) |
| metal | **Apple metal version 32023.883 (metalfe-32023.883)** — 参照ランタイムと同一世代 |
| clang | Apple clang 21.0.0 (clang-2100.1.1.101) |
| metallib | AIR-LLD 32023.883 (metalfe-32023.883) |
| **新トリプル** | **`air64_v28-apple-macosx26.0.0`** (metal3.2 デフォルト出力)。`!air.version = {2, 8, 0}` ↔ AIR 2.8 ↔ v28。v23〜v27 系譜に続く最新観測 |

### 6.2 エントリ metadata スキーマ (A-2/A-5 確定, golden/P01,P02 の probe.ll から)

**kernel**: `!air.kernel = !{!fn_node}`、`!fn_node = !{ptr @f, !{}, !args_node}` (2nd operand は空 metadata、3rd が引数配列)。

各引数 operand の構造 (P01 実測):

```
!{i32 <index>, !"air.buffer", !"air.location_index", i32 <n>, i32 1, !"air.read"|"air.read_write",
  (!"air.address_space", i32 <as>,)? (!"air.buffer_size", i32 <bytes>,)?
  (!"air.struct_type_info", !fields,)? 
  !"air.arg_type_size", i32 <size>, !"air.arg_type_align_size", i32 <align>,
  !"air.arg_type_name", !"<MSL型名>", !"air.arg_name", !"<引数名>"}
```

- `air.struct_type_info` の fields 形式 (例 Params): `!{i32 0, i32 16, i32 0, !"float4", !"scale", i32 16, i32 4, i32 0, !"uint", !"mode"}` = (index, offset, ?, type_name, field_name) の 5 要素反復
- **texture**: `!{i32 2, !"air.texture", !"air.location_index", i32 0, i32 1, !"air.sample", !"air.arg_type_name", !"texture2d<float, sample>", !"air.arg_name", !"t"}` — address_space 表記なし、access は `air.sample`
- **sampler**: `!{i32 3, !"air.sampler", !"air.location_index", i32 0, i32 1, ...}`
- **builtin**: `!{i32 5, !"air.thread_position_in_grid", !"air.arg_type_name", !"uint", ...}` — location_index なし

**vertex** (P02 実測): `!air.vertex = !{!{ptr @f, !outputs, !inputs}}` — 2nd operand が**出力配列**、3rd が入力配列:
- 出力: `!{!"air.position", !"air.arg_type_name", !"float4", !"air.arg_name", !"pos"}` / `!{!"air.vertex_output", !"generated(2uvDv2_f)", ...}` — **user output には `generated(<name><mangle>)` という一意IDが付く**
- 入力: `!{i32 0, !"air.vertex_input", !"air.location_index", i32 0, i32 1, ...}` (= `[[attribute(n)]]`)、builtin `air.vertex_id`/`air.instance_id` は index 付きだが location なし

**fragment** (P02 実測): `!air.fragment = !{!frag1, !frag2, ...}`:
- 各要素: `!{ptr @f, !outputs, !inputs (, !"early_fragment_tests")?}` — attribute は文字列 operand として末尾に
- 出力: `!{!"air.render_target", i32 0, i32 0, !"air.arg_type_name", !"float4"}`
- 入力: `!{i32 0, !"air.position", !"air.center", !"air.no_perspective", ...}` — **補間修飾は `air.center` + `air.perspective|no_perspective` の文字列組**。`generated(...)` ID は vertex 側と一致 (接続鍵)
- **`air.arg_unused`**: IR 経由で使われない引数に付与 (P02 で実測)

### 6.3 型表現の確定 (A-5 type_map の probe 保留分を解消)

- **texture opaque 型**: `%struct._texture_2d_t = type opaque`、**addrspace(1) (device)** を引数で使用
- **sampler opaque 型**: `%struct._sampler_t = type opaque`、**addrspace(2) (constant)**
- 引数 IR 属性: `"air-buffer-no-alias"` 文字列属性が buffer 引数に付与 (noalias ヒント)
- `air.sample_texture_2d.v4f32` 実シグネチャ: `{ <4 x float>, i8 } (texture*, sampler*, <2 x float> coord, i1, <2 x i32> offset, i1, float lod/bias, float, i32 options)` — **戻り値は構造体 {色, i8}** (residency/status 想定)

### 6.4 fast-math と命名 (probe P03/P04 実測)

- **fast-math 有効 (デフォルト -O2) では FP 系 intrinsic が `air.fast_*` 接頭になる**: `air.fast_fmax3.f32`, `air.fast_saturate.f32` 等実測 (対応表の命名訂正 13 件に反映)
- 関数属性: `"approx-func-fp-math"="true"`, `"unsafe-fp-math"="true"`, `"no-builtins"` 等がエントリに付与、fmul/fadd に `fast` フラグ
- module flag に **`SDK Version [26, 5]`** が追加 (新版の特徴)
- `air.max_read_write_textures = 8` が実測 (これまでの「threadgroup_imageblock=8」疑惑を解消: 8 は read_write textures の上限)

### 6.5 builtin→AIR 対応表への反映 (2026-07-21)

`promote_map.py apply-golden` + `apply-golden-corrections` を `golden/` に適用:

- **17 件 stem 照合昇格 + 13 件実名訂正昇格 = 30 件が `probed_xcode_ll` / confirmed** (observed_at=2026-07-21)
- 対応表総計: **confirmed 129 / high 68 / medium 489** (詳細は `data/promote_report.md`)
- 命名訂正の系統: ドット区切り推測 → 実際はアンダースコア連結 (`air.abs_diff`/`air.add_sat`/`air.extract_bits`/`air.mad_hi`)、整数系は `.s/.u` 付き、`fast_` 接頭 (FP 系) — 詳細は EVENTLOG XC_CORRECT

---

## 1. C-4 結論: upstream LLVM 互換

| 判定項目 | 結果 |
|---|---|
| bitcode 読込 (llvmlite/LLVM 20) | ✅ 701 モジュール全成功 (libair_rt/libmetal_rt/MTL*Runtime/libtracepoint metallib slices 含む) |
| 独自レコード/enum 衝突 | 現時点で観測なし (opaque pointer + bfloat + addrspace も標準通り) |
| **意味** | **clang fork の出力を upstream LLVM ツールで検証可能**。ゴールデン比較の技術基盤が確立 |

## 2. 確定した基盤データ

### 2.1 ターゲットトリプル系譜 (701 モジュール実測)

| triple | 件数 | 意味 |
|---|---:|---|
| `air64_v26-apple-macosx14.0.0` | 594 | 現行 main |
| `air64_v27-apple-macosx15.0.0` | 7 | **v27 の実在を初確認 (macOS 15 系)** |
| `air64_v25-apple-macosx13.0.0` | 63 | — |
| `air64_v23-apple-macosx11.0.0` | 31 | — |
| `air64-apple-macosx10.11.0` / `10.14.0` | 6 | **レガシー形式 (AIR バージョン表記なし期)** |

### 2.2 AIR バージョン ↔ triple ↔ MSL 対応 (メタデータ実測で確定)

実モジュールの `!air.version = !{!{i32 2, i32 3, i32 0}}` / `!air.language_version = !{!"Metal", i32 2, i32 3, i32 0}` から:

| `air64_vNN` | air.version | language (MSL) | 実測根拠 |
|---|---|---|---|
| v23 | **2.3.0** | Metal 2.3 | tracepoint slice0 |
| v25 | 2.5.0 | Metal 2.5? (slice1の確認) | 同上 slice1 |
| v26/v27 | 2.6.0 / 2.7.0 | (要対象確認) | — |

### 2.3 datalayout (全701モジュールで一意)

```
e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-n8:16:32
```
要点: 全アドレス空間共通の 64bit 平坦ポインタ / `v24=32bit`・3要素ベクトルの align 情報 (v48:64 等、3要素系が packed 配置であることの datalayout 上の裏付け) / `n8:16:32` ネイティブ整数幅 / **msl_analysis の捏造 datalayout (`n32:64-S128` 等) は実測と不一致 → 廃棄が確定**。

### 2.4 アドレス空間 (実 IR 使用状況で完全確定)

| addrspace | 意味 | 実測箇所 |
|---|---|---|
| 0 (無印 `ptr`) | `thread` | `__tracepoint_variable.p0i8` 系の引数 |
| **1** | `device` | `@air.atomic.global.add.u.i32(ptr addrspace(1)…)`, `air.async_wg_copy.p1*`, tracepoint `.p1i8` |
| **2** | `constant` | entry 引数 `PU11MTLconstantKjj…` → `ptr addrspace(2) nocapture readonly` |
| **3** | `threadgroup` | `air.async_wg_copy.p3*` (local 側), tracepoint `.p3i8` |

→ **A-4 完了**。texture/threadgroup_imageblock (8) はランタイム IR に現れず probe 継続。

### 2.5 呼出規約 (A-3 完了)

701 モジュール (エントリ kernel 関数含む) 全関数が **デフォルト C calling convention**。`spir_kernel` 等の特殊 CC は**一切存在しない** (msl_analysis の主張は全面否定確定)。エントリ判別は CC ではなく **後述 metadata/命名** による。

### 2.6 モジュール flags / metadata (A-2 モジュール面完了)

実測 (tracepoint モジュール):
```
!llvm.module.flags = !{!0..!7}     !0 = !{i32 7, !"air.max_device_buffers", i32 31} 他  (リソース上限 31 系)
!air.version            = !{!{i32 2, i32 3, i32 0}}
!air.compile_options    = !{!{!"air.compile.denorms_disable"}, !{!"air.compile.fast_math_enable"}, !{!"air.compile.framebuffer_fetch_enable"}}
!air.language_version   = !{!{"Metal", i32 2, i32 3, i32 0}}
!air.source_file_name   = !{!"…/clang/runtime/compiler-rt-extra/lib/tracepoint-rt/tracepoint.metal"}
```
残 (probe 継続): エントリ引数スキーマ (`air.arg_*`), `air.kernel` 等エントリ識別 — ユーザーシェーダ由来のモジュールが必要。

### 2.7 AIR intrinsic 実シグネチャ集 (A-1 ほぼ完了)

- **8,194 declare 全文** → `data/ir_air_signatures.csv`
- **375 確定 op stem** → `data/air_ops_definitive.csv`
- 引数構造の判例: `air.atomic.global.add.u.i32(ptr addrspace(1) nocapture, i32, i32, i32, i1)` / `air.async_wg_copy.p1v16f16.p3v16f16(ptr a1, ptr a3, i64, ptr a3) -> ptr a3`
- `builtin_to_air_map.csv`: **98 行が `observed_ir` (実シグネチャ確認) に昇格**, 19 airconv, 残 569 inferred (エントリ語彙/テクスチャ/新機能系でランタイムに現れないもの)

## 3. 残る probe 項目 (縮小後の最終リスト)

| 領域 | 残課題 | 理由 |
|---|---|---|
| エントリ metadata スキーマ | `air.kernel` 系・`air.arg_*` の operand 構造 | 「ユーザーシェーダのモジュール」がランタイムライブラリ群に存在しない → probe P1/P2 が必須 |
| texture/sampler opaque 型の IR 表現 | 実 ptr/target-extension 形 | 同上 |
| inferred 569 builtin の型規則最終確認 | 代表 probe 群 | sig の実測が欲しい (辞書取得でも代替可) |
| function_constant / visible table / RT 系 | IR 表現 | Runtime IR (MTLRaytracingRuntime 547 モジュール) に走査ヒントあり → 深掘りは別途 |

## 4. アーティファクト索引

| ファイル | 内容 |
|---|---|
| `data/ir_module_index.csv` | 701 モジュール索引 |
| `data/ir_air_signatures.csv` | 8,194 air declare 全文 |
| `data/air_ops_definitive.csv` | 375 確定 op stem |
| `data/ir_runtime_functions.csv` | 定義関数シグネチャ |
| `data/ir_named_metadata.csv` | metadata キー実測 |
| `docs/samples/*.ll` | 実 IR サンプル (tracepoint kernel エントリ 96KB 含む) |
| `data/builtin_to_air_map.csv` | 686 builtin マスタ (observed_ir 昇格済) |

---

## 5. 追記: 全 Apple OS 展開 (スコープ確定版)

- **全 10 ターゲット** (ios/iosmac/iossim/osx/tvos/tvossim/watchos/watchossim/xros/xrossim) の全ランタイム + 全 metallib/fat コンテナを逆アセンブル: **1,778 units 中 1,764 unique modules、パースエラー 0** → upstream LLVM 互換は全 OS で確立
- **OS↔triple 全対応を確定** (`data/os_triple_map.csv`): `-macabi` / `-simulator` サフィックス、watchos3.0.0 期のレガシー、`xros1.0.0` は v26 のみ など
- コンテナ補遺: `libtracepoint_rt_static_*.a` は ar ではなく **fat コンテナ (magic `cb fe ba be`, subtype=5)**。裸 `MTLB` 形式も存在
- MTLRaytracingRuntime/MTLShaderLoggingRuntime は OS 非依存 (triple に v26/v27)
