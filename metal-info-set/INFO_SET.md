# LLVM/Clang Metal 対応 — 必要情報セット (INFO SET) マスター

> 目的: `.metal → clang(frontend) → LLVM IR → AIR bitcode → .metallib` を自前の LLVM/Clang fork で完結させるために必要な情報を **完全セット** として定義・収集・検証する。
> **スコープ (確定)**:
> - ゴールは **Apple プラットフォームで動作する .metallib の生成まで**。Linux 上での metallib 実行・AGX 機械語の独自 JIT 実行は対象外 (最終 JIT は Apple GPUCompiler.framework / Metal.framework に委譲)。
> - **対象 OS は Apple 全系**: macOS, iOS/iPadOS, Mac Catalyst (macabi), tvOS, watchOS, visionOS (xros) および各 simulator。OS 別トリプル対応は `data/os_triple_map.csv` で確定済。

収集ルール:
- 全項目に ID を振り、**出所 (一次情報/実測/外部)・状態・格納場所** を管理する。
- **推測で埋めない**。未検証は必ず `OPEN`。`kagurasumusun/metal` の `msl_analysis/` は参考メモ扱い (実測との突合なしには利用しない)。
- 状態: ✅=取得済/🔶=部分取得(統合・検証待ち)/🧪=macOS実測が必要/🌐=外部資料の取得が必要/❌=未着手

---

## 1. 全体構成と進捗サマリ

| セクション | 内容 | 進捗 |
|---|---|---|
| **S0** | バージョン/ターゲット基盤 (トリプル・対応表) | 🔶 リポジトリ内実測は完了。新旧バージョン系は実測タスク |
| **S1** | フロントエンド言語定義 (字句/属性/型/マクロ/ビルトイン) | 🔶 機械抽出の土台完成 (686 builtin / 216 能力マクロ) |
| **S2** | **AIR 契約 (intrinsic / metadata / ABI)** ← 本案件の核心・最大ギャップ | 🔶 3ソース (rtlib実測・airconv・naga) 確保。統合仕様化はこれから |
| **S3** | clang IR → AIR の最適化パイプライン実態 | ❌ macOS 実測必須 |
| **S4** | GPU ランタイムリンク (rtlib のリンク規則・RT ABI) | 🔶 目録完成。リンク規則の意味論は OPEN |
| **S5** | .metallib / fat コンテナ出力仕様 | 🔶 実サンプルのタグ実測済。writer 実装には外部仕様の統合が必要 |
| **S6** | 検証資産 (ゴールデン出力・テストスイート) | 🔶 器完成 (probe_scenes 機械生成器 + apply-golden パイプライン)。golden 実体は macOS 実測待ち |
| **S7** | 外部参照実装・法務 | 🔶 airconv 取得済。RFC PoC 等の精読はこれから |

---

## 2. S0 ― バージョン/ターゲット基盤

| ID | 項目 | 状態 | 内容/格納先 |
|---|---|---|---|
| S0-1 | AIR ターゲットトリプルの実在系 (Apple 全 OS) | ✅ | `data/os_triple_map.csv` (全ランタイム 1,764 モジュール逆アセンブルで確定): v23/v25/**v26/v27** + レガシー無版形式。サフィックス `-macabi` (Catalyst), `-simulator`, watchos3〜, xros1〜 を全網羅。`!air.version` ↔ `air64_vNN` ↔ MSL 版の写像も確定。**2026-07-21 実機 golden で最新 `air64_v28-apple-macosx26.0.0` (AIR 2.8.0) を追加観測** (`IR_GROUND_TRUTH.md` §6.1 — os_triple_map.csv はランタイム実測一次データとして維持) |
| S0-2 | Xcode 版 ↔ clang build ↔ metalfe ↔ MSL ↔ AIR v ↔ OS の総対応表 | ✅(現行世代) | **現行世代は実機で特定完了** (2026-07-21, `golden/env.txt`): Xcode 26.5 (17F42) / macOS 26.4 (25E246) / Apple clang 21.0.0 (clang-2100.1.1.101) / **metal 32023.883 (metalfe-32023.883) — 参照ランタイムと同一世代** / metal3.2 → `air64_v28-apple-macosx26.0.0` (AIR 2.8) / SDK Version module flag [26,5]。過去世代 (v23〜v27 ↔ 各 Xcode) の表は 🔶: 複数 Xcode で `-v`/producer を採取 |
| S0-3 | fat スライス cpu subtype ↔ GPU ファミリの対応 | 🔶 | 実測: cputype=`0x01000017` 固定、subtype=`0x07/0x09` (osx, watch=?) が slice0/1 に対応 → AIR v の古い/新しいに連動すると推測されるが要検証 (upstream LLVM MachO の GPU 系定義とも照合) |

---

## 3. S1 ― フロントエンド言語定義 (Clang FE が実装すべき言語)

| ID | 項目 | 状態 | 内容/格納先 |
|---|---|---|---|
| F-1 | MSL 言語仕様 (正式) | ✅ | リポジトリの公式 PDF **全11版 (1.2〜4.1) をテキスト化・横断採掘済**: `data/spec_attrs_matrix.csv` (属性×版 行列, 新出属性の導入版特定), `data/spec_chapters_matrix.csv` (章構成変遷), `docs/SPEC_VERSION_TIMELINE.md` (各版新機能本文), `data/spec_attributes.csv` 等 |
| F-2 | キーワード実装方式 | ✅ | `device` `constant` `threadgroup` `thread` 等はヘッダに `#define` 無し → **コンパイラ組み込みキーワード/修飾子** (Parser/LangOpts 拡張必須) という確定事実 |
| F-3 | 属性スペリング全量 | ✅(網羅) / 🔶(意味) | `data/header_attributes.csv` (ヘッダ実測 GNU属性 25 種) + **`data/spec_attributes.csv` (MSL spec 4.1 PDF から `[[…]]` 属性 88 種を機械抽出・引数例/頁付き)** + `data/spec_table_index.csv` (Table 5.2〜5.13 の属性表索引)。`__packed_vector_type__` は Apple 独自で FE 拡張必須。個別 semantics → Attr.td 設計落とし込みは残 |
| F-4 | `__metal_*` ビルトイン・カタログ | ✅(語彙) / 🧪(意味) | `data/metal_builtins.csv` — **686 個** (基底 492 / texture派生 224)。stdlib は全 API をこの層経由で呼ぶため、これが **clang 追加分の完全な語彙表**。宣言はコンパイラ内蔵 (Builtins.def 相当) で、ヘッダからは「呼出しパターン」しか取れない → 各 builtin の正確な型付け・`__METAL_FAST_MATH__` 等暗黙引数の扱いは Xcode で生成IR実測して裏取る (S3-2 と連動) |
| F-5 | 能力マクロ `__HAVE_*` 行列 | ✅ | `data/have_matrix.csv`: **216 マクロ × (iOS/macOS) × MSL 1.0〜4.0** 全展開 + `data/have_matrix_summary.md` にバージョン毎の初出機能一覧。clang のプリプロセッサ実装とターゲット機能管理 (`TargetInfo`) の直接の設計入力 |
| F-6 | 通常 `__builtin_*` 依存 | ✅ | `__builtin_astype` (OpenCL 系, upstream 有) が 120 箇所で使用等の実測済 (§冒頭で抽出・要表追加) |
| F-7 | 禁止/診断仕様 (例外, RTTI, ポインタ制約, アドレス空間キャスト規則…) | 🔶 | `data/spec_key_sections.md` に MSL 4.1 §1.5.4 (C++17 制約一覧) §1.6 (コンパイラオプション: math intrinsics/最適化制御) §4 (アドレス空間) の本文抜粋を確保。Sema テスト一覧への落とし込みが残 |
| F-8 | stdlib 構造索引 | 🔶 | `reference/…/include/metal/` 全 ~130 ヘッダ + module.modulemap。依存グラフ索引 (`metal_stdlib` → 各ヘッダ) は未生成 (スクリプト化すれば自動生成可能) |

---

## 4. S2 ― AIR 契約 (CodeGen〜出力 IR が従うべき仕様) ★最重要

| ID | 項目 | 状態 | 内容/格納先 |
|---|---|---|---|
| A-1 | MSL→IR 対応表 (stage1: API→builtin) | ✅ | `data/msl_stage1_api_to_builtin.csv` (3,810 API) + `data/msl_stage1_methods.csv` (7,058 メソッド行 / 178 クラス)。650/686 builtin の使用経路を完全解明 |
| A-1b | builtin→AIR 正規マスタ表 | ✅実機昇格開始 | **`data/builtin_to_air_map.v2.csv` が正本** (18 列 provenance スキーマ `docs/MAPPING_SCHEMA.md`): **confirmed 425 / high 45 / medium 216** (`data/promote_report.md`)。**2026-07-21 macOS 実機 (upterm) で golden 12/12 ビルド成功・30 件を `probed_xcode_ll`=confirmed 昇格、**2026-07-21 後半の金属4.0/cosntruct波で 326 行が probed_xcode_ll** (P06M40/P07F40/P08M40 golden: アンダースコア命名・intersection_query allocate/abort/deallocate・ICB コマンド・interpolate 等 286 語彙昇格)。昇格パイプライン稼働中 (`scripts/promote_map.py`: audit 冪等 / apply-golden / apply-golden-corrections / apply-rtlib-layer / ingest-callgraph)。残は manual_needed シーンの wrapper 補完 (P06 texture 系 293 件ほか) で拡大可能。全変更は `docs/EVENTLOG.md` 記録 |
| A-1c | `air.*` intrinsic 語彙 | 🔶 | バイナリ実測 8,132 トークン / 2,530 ステム (`data/air_stems_binaries.txt`) + airconv 121 literal + 命名則 30 件 (`data/airconv_air_ops.csv`)。フル網羅は GPUCompiler strings + probe (🧪) |
| A-2 | 名前付きメタデータ スキーマ | ✅ (kernel/vertex/fragment) | **モジュール面 + エントリ引数面とも実測確定** (2026-07-21 golden P01/P02): kernel/vertex/fragment の metadata 構造、buffer (air.buffer) / texture / sampler / builtin 各 operand 列、air.struct_type_info、vertex `generated(...)` 接続 ID、fragment 補間修飾、air.arg_unused、early_fragment_tests、module flag に SDK Version [26,5] 追加。全詳細は `IR_GROUND_TRUTH.md` §6.2。残: mesh/object/tile (MSL3.0+) のエントリ metadata (P11 は stub のため未取得) |
| A-3 | 呼出規約 | ✅ | **全 701 モジュール (エントリ含む) がデフォルト C CC。特殊 CC は存在しない** (spir_kernel 説の完全否定確定) |
| A-4 | アドレス空間番号 | ✅ | **実 IR で確定**: thread=0 / device=1 / constant=2 / threadgroup=3 (atomics, async copy, entry args で使用実績)。texture/threadgroup_imageblock(8) は probe 継続。datalayout も一意確定 (`IR_GROUND_TRUTH.md` §2.3) |
| A-5 | エントリポイント ABI | ✅ (kernel/vertex/fragment 実測) | **2026-07-21 golden (P01/P02) で metadata スキーマ実測確定** (`IR_GROUND_TRUTH.md` §6.2): kernel/vertex/fragment の 3 関数形、buffer/texture/sampler/builtin 各 operand 列、`air.struct_type_info` の 5 要素反復、vertex `generated(...)` 接続 ID、fragment 補間修飾 (`air.center`+`air.perspective`)、`air.arg_unused`、`early_fragment_tests` の文字列 operand。opaque 型: texture=addrspace(1) device / sampler=addrspace(2) constant。残: threadgroup メモリ量の確定方式 (P01 の `air.buffer` threadgroup 形は取得済) |
| A-6 | function constants / 特殊化 | ❌ | `[[function_constant(i)]]` の IR 表現と MTLFunctionConstantValues との接続規約。msl_analysis 言及ゼロ・未調査領域 |
| A-7 | visible function tables / 間接呼出 | 🔶 | 実 intrinsic `air.dyld_flat_table` を rtlib で確認。テーブル構築 ABI・リンク条件を MTLVisibleFunctionTable 実機観察と併せて定義 🧪 |
| A-8 | atomics / fence / barrier の IR マッピング | 🔶 | `air.atomic.*`, `air.fence_*`, `air.atomic.fence` 実在確認。order/scope パラメータのエンコード規則を実測で採取 🧪 |
| A-9 | 拡張機能別 lowering: レイトレーシング / mesh / tensor (MSL4) / simdgroup / bfloat 等 | 🔶 | ヘッダ提供の builtin 直接使用が多いが、専用 intrinsic の有無・RTランタイム呼出し規約は要実測 🧪 |
| A-10 | コンパイルオプションの IR 表現 | 🔶 | `air.compile.fast_math_enable` / `air.compile.denorms_disable` / `air.compile.framebuffer_fetch_enable` を実メタデータとして確認済 (metallib strings)。意味と JIT 側解釈は仕様書精度表と合わせて整理 |

---

## 5. S3 ― clang IR → AIR 最適化パイプライン

| ID | 項目 | 状態 | 内容 |
|---|---|---|---|
| P-1 | 実際のパス列 (AIR 正規化・`air.*` 化・fast-math 反映の段階) | ❌🧪 | 要 macOS: 純正 clang の `-mllvm -print-*`/`-emit-llvm` 各段階ダンプ比較。当面は「upstream -O2 相当 + A-1 への lowering pass」で近似する設計方針 |
| P-2 | fast-math/denorm フラグと数値要件 (ULP) | 🔶 | 仕様書の誤差表あり。フラグ → metadata (A-10) への反映規則、および fast/strict での builtin 選択規則 (`__METAL_FAST_MATH__` 分岐) の中間表現を整理 |

---

## 6. S4 ― ランタイムリンク (rtlib 実装の供給方式)

| ID | 項目 | 状態 | 内容/格納先 |
|---|---|---|---|
| R-1 | アーカイブ目録 | ✅ | `data/rtlib_members.csv` (+summary): **64 アーカイブ** (`libair_rt_*` `libmetal_rt_*` `MTL*Runtime.rtlib` `libtracepoint_rt_*` `libopencl_rt_osx.a`) の全メンバ・サイズ |
| R-2 | bitcode 形式の同定 | ✅ | 全 .rtlib/.a メンバは **標準 LLVM bitcodeラッパ** (`de c0 17 0b` + `BC c0 de`) を確認 → 上流 LLVM で読める見通し (S5-5 で要実証) |
| R-3 | リンク規則の意味論 | 🔶→✅(構造) | **callgraph 全抽出で実装構造を確定** (2026-07-21): `__air_impl_*` 26 実装関数・呼出エッジ 31,134 件 (`data/callgraph_edges.csv`)。`__loweringlib.internal.N` は**関数名** (ar メンバー名ではない — 判例訂正済)。`__air_impl_nextafter_*` 24 variant と os_log の呼出構造を完全把握。builtin 側の帰属は `data/rtlib_layer_map.csv` + 対応表 v2 の `rtlib_layer_backing` 行で確定。呼出形 (宣言参照か実リンクの trigger 規則) は P13 probe 🧪 |
| R-4 | デバッグ/ロギング実行時 ABI (printf/assert/os_log/tracepoint) | 🔶 | `libtracepoint_rt_*.metallib` の関数群 (`_Z24kernel_thread_tracepoint…`) 確認済。バッファ形式・ホスト側契约は Metal.framework 観察が必要 🧪 |
| R-5 | MTLRaytracingRuntime / MTLShaderLoggingRuntime の役割 | 🔶 | 同左 |
| R-6 | 方針判断: rtlib をそのまま使うか自前再実装か | ❌ | ライセンス上、再頒布は不可の可能性大 (S7-3)。**リンク契約の仕様書** (R-3表+各実装の意味) があれば clean-room 代替可能 |

---

## 7. S5 ― .metallib / fat コンテナ出力

| ID | 項目 | 状態 | 内容/格納先 |
|---|---|---|---|
| C-1 | MTLB コンテナ実測構造 | ✅ | `data/metallib_structure.csv` / summary: 実サンプル 10 本からタグ **`NAME` `TYPE` `HASH` `VERS` `MDSZ` `ENDT` `UUID`**, ヘッダ u64 フィールド (version/file_size/各オフセット), slice↔triple 対応を抽出 |
| C-2 | MTLB writer 仕様 (全タグ・v2/v3差・一般シェーダの TYPE/PAYLOAD 系) | 🌐🔶 | 統合元: [naga wiki](https://github.com/gfx-rs/naga/wiki/Metallib-file-format), RFC PoC の [MetallibFormat.rst を含む LLVM Metal/AIR backend PoC](https://discourse.llvm.org/t/rfc-add-an-apple-metal-air-backend-target/90936), [metallib bitcode 抽出の実践記録](https://worthdoingbadly.com/metalbitcode/)。**注意**: 現サンプルは tracepoint ライブラリのみ — 通常シェーダ (kernel/vertex/fragment) のエントリ系タグは macOS で採取して補完 🧪 |
| C-3 | fat ラッパ仕様 | ✅(実測) / 🔶(subtype 表) | magic `cb fe ba be`, 20バイト slice エントリ (cputype `0x01000017` 固定を実測)。S0-3 の subtype ↔ (AIR v / GPU family) 対応の確定が残 |
| C-4 | `.air` / bitcode ラッパ詳細・upstream 互換 | ✅ | **upstream LLVM (llvmlite/LLVM 20) で 701/701 モジュールをエラー0で全文パース成功** (`docs/IR_GROUND_TRUTH.md` §1)。bitcode ラッパ 20B ヘッダ構造確定。独自レコード衝突は現時点で観測なし → upstream ツールで検証可能な技術基盤が確立 |
| C-5 | `.metallibsym` (デバッグシンボル) | ❌ | 未入手。Xcode で生成採取 🧪 |

---

## 8. S6 ― 検証資産 (品質の要)

| ID | 項目 | 状態 | 内容 |
|---|---|---|---|
| V-1 | ゴールデン出力コーパス | ✅ 初回回収済 | **2026-07-21 macOS 実機 (upterm/paramiko) で 12/12 シーンビルド成功、golden/ に回収**: 各シーン `metal32_macosx26/probe.{metal,ll}` (+P01/P02 は probe.air/probe.metallib 完全形) + `golden/meta.yml` (date・ツールチェーン版) + `golden/env.txt` (ツールチェーン版詳細)。apply-golden / apply-golden-corrections で 30 件昇格済。ビルドログは runner 側一時物のため未保持 (再現手順は probe_build2.sh 系)。次回収穫: manual_needed シーン (P06〜P11 の wrapper 補完) で規模拡大、および -std/-target マトリクス化 |
| V-2 | 差分比較ツール | 🔶 | `promote_map.py` の .ll 抽出器 (symbol → air.* 呼出) が差分比較の核として稼働中 (apply-golden/selftest で実証)。bitcode 構造比較・メタデータ比較器・metallib タグ比較器は未実装 (C-1 パーサ流用可) |
| V-3 | 実行検証スイート | ❌ | 公開 CTS は存在しない → ULP 精度・アトミクス・テクスチャ・同期・拡張機能の実機テスト (MTLCompute 経由) を自作。対象デバイス (apple 各 family) の確保計画も必要 |
| V-4 | 非回帰 CI | ❌ | macOS runner + Xcode 版マトリクス |

---

## 9. S7 ― 外部参照実装・法務

| ID | 項目 | 状態 | 内容 |
|---|---|---|---|
| X-1 | AIR 解釈の参照実装 **airconv** (dxmt) | ✅ | `reference-external/dxmt/src/airconv` (sparse clone 済 1.4MB)。`air_operations.*` (intrinsic語彙), `air_signature.*` (引数/属性シグネチャ) が最有力の公開一次資料 |
| X-2 | LLVM Metal/AIR backend RFC PoC | 🌐 | [RFC (2026-05)](https://discourse.llvm.org/t/rfc-add-an-apple-metal-air-backend-target/90936) + [imperatormk/llvm-project metal-target-poc](https://github.com/imperatormk/llvm-project/tree/metal-target-poc) (MC 層 metallib writer 含む)。diff 精読タスク |
| X-6 | GPUCompiler.framework 静的情報 | ✅ | macOS SDK (alexey-lysiuk) の `.tbd` 公開シンボル解析完了 → `docs/GPUCOMPILER_SYMBOLS.md`, `data/gpucompiler_demangled.txt` (22,110 symbol)。**AIRVerifier/AIRLegalizer/AIRUpgrade/AIRDowngrade pass と AIRNT C API 98 個、AGX バックエンド構造を解明**。実 dylib の strings (air.* 全辞書) は Xcode xip を Linux で DL/展開すれば Mac不要で可能 |
| X-3 | ライセンス / 再頒布性 | ❌ | Xcode 同梱ヘッダ・rtlib は Apple プロプライエタリ → **upstream/公開 fork への同梱不可が基本線**。stdlib ヘッダの clean-room 再実装要否と手順 (仕様書ベース) の法的判断が必要 |
| X-4 | 上流化戦略 | ❌ | upstream RFC 追従 or 独立 fork 運営の方針決定 |
| X-5 | (参考) AGX 機械語・ドライバ ABI | ✅(ポインタのみ) | スコープ外だがデバッグ用途に [Asahi docs](https://asahilinux.org/docs/hw/soc/agx/), Mesa AGX コンパイラ |

---

## 10. 直近の作業タスク (優先順)

**この環境で即実行可能 (macOS 不要)**
1. ✅ ~~A-1/A-2 統合表~~ → **完了** (`builtin_to_air_map.csv` + `air_stems_binaries.txt` + `airconv_air_ops.csv`)
2. ✅ ~~R-3 リンク対応表~~ → **構造規則まで完了** (`rtlib_pairing.csv`)
3. **F-3/F-7 属性・診断の仕様書紐付け表** (Attr.td/Sema 設計入力)
4. **C-2 writer 仕様ドラフト**: C-1 実測 + naga wiki + RFC PoC の統合版金属フォーマット仕様書
5. **F-8 stdlib 依存索引** 生成 (module map 化)

**macOS + Xcode が必要 (収集チェックリスト)** → 詳細は `docs/PROBING_PLAN.md` (probe 589 セルを 13 シーンに編成済)
6. ツール情報採取 + **GPUCompiler.framework strings による air.* 辞書一括取得**
7. probe コンパイル (P1〜P13) → `.ll` golden 収集: builtin_to_air_map の全行を `observed_xcode_ll` に昇格
8. bitcode 互換試験: 採取 `.air` を upstream llvm-dis で読めるか
9. `.metallibsym` / 通常シェーダ metallib タグ採取 (C-2 補完)

---

## 11. ディレクトリ構成 (整理後 — 一次データとドキュメントのみ保持)

```
metal-repo/                      対象リポジトリ (PDF・ヘッダ・ランタイム実物。`.git` は削除済: GitHub 側を正とする)
metal-info-set/
├── INFO_SET.md                  本書 (マスター管理)
├── docs/
│   ├── MSL_TO_IR_MAPPING.md     対応表マスター
│   ├── IR_GROUND_TRUTH.md       実 IR 逆アセンブル解析 (確定ファクト集)
│   ├── AIR_VOCABULARY.md        AIR 命名文法・語彙分析
│   ├── GPUCOMPILER_SYMBOLS.md   JIT 側構造シンボル解析
│   ├── PROBING_PLAN.md          Apple 実機 実測計画 P1〜P13
│   └── samples/*.ll             実 AIR IR ゴールデンサンプル
├── data/
│   ├── builtin_to_air_map.csv   ★本体 (686 builtin → AIR ・証拠等級)
│   ├── ir_air_signatures.csv    8,199 air declare 全文 (全 OS 集約)
│   ├── air_ops_definitive.csv   確定 op stem 表
│   ├── ir_all_os_unique.csv     全 OS 1,764 モジュール索引
│   ├── os_triple_map.csv        OS↔triple 全対応 (Apple 全 OS)
│   ├── msl_stage1_api_to_builtin.csv / msl_stage1_methods.csv
│   ├── metal_builtins.csv / metal_builtins_summary.md
│   ├── have_matrix.csv / have_matrix_summary.md
│   ├── header_attributes.csv / spec_attributes.csv / spec_table_index.csv
│   ├── spec_key_sections.md / spec_os_availability_forms.csv
│   ├── rtlib_members.csv / rtlib_pairing.csv
│   ├── metallib_structure.csv / metallib_summary.md
│   ├── type_map.csv / probe_cells.csv
│   ├── gpucompiler_demangled.txt
│   └── air_stems_binaries.txt / air_strings_binaries.csv / airconv_air_ops.csv
│       msl_stage1_summary.md / msl_stage1_methods_summary.md
├── scripts/                     全抽出スクリプト (再現可能)
└── reference-external/
    ├── dxmt/src/airconv         AIR 参照実装 (sparse clone)
    ├── gpucompiler-tbd/         GPUCompiler .tbd シンボル
    └── macos-sdk-metal-headers/ Metal.framework ヘッダ 97 + Metal.tbd
```
