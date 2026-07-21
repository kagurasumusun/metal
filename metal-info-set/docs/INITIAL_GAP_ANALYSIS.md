# LLVM & Clang の Metal コンパイル対応 ― 不足情報の洗い出しレポート

調査対象: `kagurasumusun/metal` (branch: `jules-2822063734237814689-7500b921`)
調査日: 2026-07-21

---

## 0. リポジトリの現状サマリ

| 資産 | 内容 | 性質 |
|---|---|---|
| `Metal-Shading-Language-Specification/` | Apple 公式 MSL 仕様書 PDF v1.2〜4.1 (11点) | **一次情報 (信頼可)** |
| `reference/clang/32023.883/include/metal/` | 実ツールチェーン (Xcode 26 系, metalfe-32023.883) の metal_stdlib ヘッダ群 (~130ファイル) | **一次情報 (信頼可・最重要)** |
| `reference/clang/32023.883/lib/darwin/` | GPU ランタイム実バイナリ: `libair_rt_*.rtlib` / `libmetal_rt_*.a` (ar アーカイブ内は **標準 LLVM bitcode**)、実 `.metallib` (`libtracepoint_rt_*`)、`MTLRaytracingRuntime.rtlib`、`MTLShaderLoggingRuntime.rtlib`、他計50ファイル | **一次情報 (信頼可・最重要)** |
| `msl_analysis/` | 49セクション + 1対1マトリクスの解析文書 (~7,000行) | **二次情報 (AI生成。要検証・誤り多発)** ← 詳細は §1 |

バイナリから実測できた一次情報の例:
- ターゲットトリプルは **`air64_v23-apple-macosx11.0.0` / `air64_v25-apple-macosx13.0.0` / `air64_v26-apple-macosx14.0.0`** のように **AIRバージョン入り** (解析文書には `air64_v26` の記載すら無い)
- 実在intrinsic: `air.atomic.global.add.u.i32`, `air.all.v3i1`, `air.dyld_flat_table` 等
- アドレス空間のマングリング: `PU11MTLconstantKjj` (Itanium拡張 `MTLdevice/MTLconstant/...`)
- producer 文字列: `"Apple metal version 32023.883 (metalfe-32023.883)"`、配置パス `/System/Library/PrivateFrameworks/GPUCompiler.framework/...`
- メタデータ: `air.compile.fast_math_enable`, `air.compile.denorms_disable`, `air.max_device_buffers` 等

---

## 1. 既存解析文書 (msl_analysis/) の信頼性評価

**結論: 原文のまま実装根拠には使えない。** ブランチ名 (jules = AI生成) 通り、内容は「もっともらしいが一次情報と食い違う/検証不可能な記述」を多く含む。実証した問題:

| 問題 | 証拠 |
|---|---|
| **`spir_kernel` 呼出規約は誤り** | 実バイナリのエントリ (`_Z24kernel_thread_tracepoint...`) は通常C系マングリング+`air.*`メタデータで管理。`spir_kernel`/`spir_func` 主張が文書全体で **91箇所**。実AIRはSPIR-V系CCを使わない (airconv の実装・上記シンボル所見と矛盾) |
| **架空の `lib/Target/AGX` バックエンド設計** | clang/LLVM が直接 AGX 機械語を吐く前提の疑似コード (`Triple::agx` 等) が各所にコピペ。現実の clang が出力するのは **AIR bitcode** であり、AGX 命令生成はクローズドの GPUCompiler.framework が行う |
| **架空のアセンブリ実装** | GPUランタイム関数を **ARM64 CPU命令** (`ldp q0,q1` / さらには x86記法の `jmp %reg`) で書いた「実装例」が複数節にある。実際の `libmetal_rt`/`libair_rt` は **GPU向け LLVM bitcode** であり CPU asm では存在しない |
| **「6,478要素すべて Verified」は虚偽** | SECTION49 は全60カテゴリを「Verified」と主張するが、ヘッダ実測で **686個存在する `__metal_*` ビルトインのうち文書が言及するのは8個のみ**。`air64_v25/v26`, `MTLconstant` マングリング, `dyld_flat_table`, `__packed_vector_type__`, MTLBタグ詳細も全て未記載 |
| **ボイラープレートの量産** | 全セクション末尾に同一の「Implementer's Guide」(AGXレジスタ128/256、SROA等) が機械的に貼付。ページ数の割に情報密度が低い |

→ **使い方の指針**: msl_analysis は「調査項目のチェックリスト雛形」としてのみ使い、個々の事実は一次情報 (PDF・ヘッダ・bitcode逆アセンブル・Xcodeでの実測) で再検証する。

---

## 2. 不足している情報 (カテゴリ別・優先度付き)

凡例: ★★★=実装のブロッカー級 / ★★=必須だが迂回可能 / ★=品質・運用面

### A. スコープ決定 (そもそも論) ★★★
| # | 不足情報 | 補足 |
|---|---|---|
| A1 | **目標地点の確定**: 「AIR bitcode まで出して Apple の JIT (GPUCompiler.framework) に渡す」のか、「AGX 機械語まで自前で吐く」のか | 後者は ISA が非公開で現実的でない。**前者が事実上唯一の実用ルート** だが、リポジトリ内でこの方針決定が曖昧 (msl_analysis は後者側の架空設計を含む) |
| A2 | **対応範囲**: MSL全バージョン (1.0〜4.1) / 全GPUファミリ (apple1〜apple10/mac2) のどこまでを初期対象にするか | 仕様書PDFの機能表はあるが、「どの air バージョン × OS がど機能を要求するか」の**実コンパイラ側のマトリクス**が無い |

### B. Clang フロントエンド ★★★
| # | 不足情報 | 取得方法 |
|---|---|---|
| B1 | **`__metal_*` ビルトイン 686個の完全仕様** (引数型・返値・オーバーロード規則・エイリアス・`__METAL_FAST_MATH__` 等の暗黙引数の意味)。stdlib は全てこの層を経由しており、ここが **clang 追加分の実体** | ヘッダから機械抽出 (雛形あり) + 各ビルトインの生成IRを Xcode clang で実測して対応表化 |
| B2 | **各 `__metal_*` → `air.*` intrinsic の正確な対応表** (リポジトリの SECTION15 は実測でなく推測: 例 `@air.sin.f32` は正しい命名パターンか未確認) | Xcode で probe コンパイル → `-emit-llvm` 出力観察 + rtlib bitcode 逆アセンブル + airconv の実装知見 |
| B3 | **言語ダイアレクト定義**: `-std=metal*` 一覧と `__METAL_VERSION__` 値、`-x metal` 処理、LangStandard への登録方法、予約キーワード (`device` 等はマクロでなく **コンパイラキーワード** = パーサ改修が必須: ヘッダに `#define device` が無いことで実証) | Xcode ビルドログ / `metal` ドライバの `-v` 実測 |
| B4 | **属性網羅表**: `[[kernel]]` 等の C++属性 (Attr.td 用) + `__attribute__((__packed_vector_type__(N)))` 等の **Apple独自 GNU属性** (upstream clang には無い可能性) の semantics | ヘッダ走査で使用一覧は作成可。semantics は spec PDF と実測で |
| B5 | **定義済みマクロ体系**: `__HAVE_*` 能力マクロが MSL ver × OS (iOS/macOS/…) × GPUファミリでどう変わるかの**完全マトリクス** | `metal_config` を全分岐機械展開すれば自動生成可能 (リポジトリ一次情報で足りる) |
| B6 | Sema 詳細: オーバーロード解決 (texture テンプレート引数)、暗黙変換規則、アドレス空間キャスト規則の実装上の落とし穴、診断メッセージ体系 | spec PDF + 実clang でのネガティブテスト |

### C. AIR (Apple IR) ダイヤレクト契約 ★★★ ← 最大の空白地帯
| # | 不足情報 | 取得方法 |
|---|---|---|
| C1 | **`air.*` intrinsic の検証済み完全カタログ** (名前・型シグネチャ・意味)。rtlib 実測で `air.atomic.global.add.u.i32`, `air.all/any.v*`, `air.dyld_flat_table` 等が確認できるが網羅されていない | rtlib を llvm-dis (または Python bitcode パーサ) で全列挙 + Xcode probe 生成IR |
| C2 | **名前付きメタデータのスキーマ**: エントリ情報・引数(型/バインド位置/アドレス空間) のエンコード規則、`air.version`, `air.compile.*`, `air.max_*` の全項目と許容値 | 実 `.air`/`.metallib` からの逆解析 + [naga wiki の metallib フォーマット](https://github.com/gfx-rs/naga/wiki/Metallib-file-format) |
| C3 | **呼出規約の実体** (bitcode中のCC番号の意味)。`spir_kernel` 説は誤りなので正しい規約を特定する必要 | bitcode の実値解析 |
| C4 | **エントリポイント ABI**: `[[buffer(n)]]` 等のリソースバインド→ランタイム受け渡し規約、`stage_in` のシリアライズ、頂点入出力/プリミティブ出力、threadgroup メモリ確定規則 | spec PDF + 実測IR。ホスト側 (Metal.framework エンコーダ) との整合確認が必須 |
| C5 | **function_constant (特殊化定数) の下ろし方** とパイプライン特殊化 ABI | 実測。文書内 `function_constant` 言及 0 件 |
| C6 | **可視関数テーブル / 間接呼出**: `air.dyld_flat_table` の意味・テーブル構築 ABI | rtlib 逆アセンブル + MTLVisibleFunctionTable の挙動観察 |
| C7 | **アトミクス/フェンス/バリアの memory order・scope → IR マッピング** | 同様に実測 |
| C8 | レイトレーシング / mesh / tensor (MSL4系) の intrinsic 一式 | 実測 + spec |

### D. 最適化パイプライン ★★
| # | 不足情報 | 取得方法 |
|---|---|---|
| D1 | **clang IR → 出荷 AIR bitcode の間で Apple が通す実際のパス列** (AIR正規化、`air.*` 化、fast-math 反映など)。リポジトリは「SROA等」という汎論のみ | Xcode で同一ソースの各段階をダンプ比較 (要macOS) |
| D2 | **`air.compile.fast_math_enable` / `air.compile.denorms_disable` 等フラグの JIT 側解釈** (ULP誤差要件との関係) | spec §14 + 実測する数値実験 |

### E. ランタイムリンク ★★★
| # | 不足情報 | 取得方法 |
|---|---|---|
| E1 | **rtlib リンクモデル**: `__air_impl_*` シンボルと `__loweringlib.internal.N` オブジェクトの対応規則、いつどのアーカイブからどうリンクされるか (弱リンク? JIT側要求?) | 全アーカイブの完全シンボル表作成 (bitcodeなので機械列挙可) |
| E2 | **各 OS バリアントの選択規則** (ios/iosmac/iossim/osx/tvos/…/xrossim 10系統) と AIR v23/v25/v26 スライスの関係 | fatヘッダ解析 (実データあり) |
| E3 | **デバッグ系実行時 ABI**: printf/assert/os_log/シェーダロギング/トレースポイントのバッファフォーマットと、ホスト側が期待する契约 | `libtracepoint_rt_*.metallib` の解析 + Metal.framework 観察 |
| E4 | **レイヤ別責務**: `MTLRaytracingRuntime.rtlib` / `MTLShaderLoggingRuntime.rtlib` の提供機能と使用条件 | 逆アセンブル |
| E5 | `libopencl_rt_osx.a` の位置づけ (Metal対応に必要か否かの判断材料) | 内容物確認で判別可 |

### F. バイナリ/コンテナフォーマット ★★
| # | 不足情報 | 取得方法 |
|---|---|---|
| F1 | **`.metallib` (MTLB) のタグカタログ検証版**: SECTION1 に形式記述はあるが、実ファイル (NAME/TYPE/HASH/ENDT…, v2/v3差) と突合した検証が無い。 fat スライスの **CPU subtype ↔ GPUファミリ対応表** も無い | リポジトリ内実物 + naga wiki + 第三者ツールで相互検証 |
| F2 | **`.air` bitcode の上流LLVM互換性の実証**: 標準 `llvm-dis` で全バージョンが読めるか、独自レコード/enum値の衝突が無いか | LLVMツールで読み書き実験 (旧例: [metallib からの bitcode 抽出とllc実行](https://worthdoingbadly.com/metalbitcode/)) |
| F3 | **`.metallibsym` / デバッグ情報フォーマット** (シンボル・ソースマップ) | リポジトリに該当物なし。Xcode で生成して解析 |

### G. AGX 機械語バックエンド (A1で「やる」とした場合のみ) ★
| # | 不足情報 | 取得方法 |
|---|---|---|
| G1 | **検証済み AGX ISA/エンコーディング** (SECTION27 は「Speculative」自己申告。実際は非公開) | 公開逆解析: [Asahi Linux の AGX ドキュメント](https://asahilinux.org/docs/hw/soc/agx/), Mesa の NIR ベース AGX コンパイラ (C実装) —— ただし Mesa は LLVM 系でないため LLVM バックエンドへは再設計が必要 |

### H. ツールチェーン運用 ★★
| # | 不足情報 | 取得方法 |
|---|---|---|
| H1 | **ドライバ/フラグ体系**: `metal` コマンド・`metalfe` フロントエンドの全オプション、`MTLCompileOptions` → フラグ写像、`metallib`/`metal-ar` アーカイバの挙動 | 実機 `metal -h` + ビルドログ (リポジトリに皆無) |
| H2 | **バージョン対応表**: Xcode 版 ↔ clang build (32023.883) ↔ metalfe 版 ↔ AIR v ↔ MSL 版 ↔ `__METAL_VERSION__` ↔ GPUファミリ | 複数 Xcode の実測集計 |
| H3 | リフレクション要求事項: `MTLLibrary`/`MTLFunction` が metallib から読む最小メタデータ集合 (これを欠くとホスト側ロードで落ちる) | 実機で段階的に削減実験 |

### I. 検証基盤 ★★★ (品質の要)
| # | 不足情報 | 取得方法 |
|---|---|---|
| I1 | **ゴールデン出力コーパス**: 代表的 MSL ソース × MSL ver × GPUファミリの、Xcode 生成 `.air`/`.metallib` 正解データ。**リポジトリにはコンパイラ出力の実サンプルがゼロ** (rtlib/metallib は付属物であって出力例ではない) | macOS + Xcode で収集 |
| I2 | **実行検証スイート**: MSL には公開 CTS が存在しない。数値精度 (ULP), アトミクス, テクスチャ, バリア等の実機テストを自作する必要 | 自作。各種ファミリ実機 (M系/A系/vision…) へのアクセス計画も不足 |
| I3 | bitcode レベルの差分比較ツール | 自作 (構造 diff) |

### J. 法的/プロジェクト運営 ★★
| # | 不足情報 | 取得方法 |
|---|---|---|
| J1 | **ライセンス判断**: `reference/` のヘッダ・rtlib は Apple プロプライエタリ物の転載であり、**OSS の LLVM/Clang にそのまま同梱・再頒布できない**。クリーンルーム再実装が要るか、利用条件の確認が必要 | Xcode ライセンス条文の確認 (要法務的判断) |
| J2 | 上流化方針: upstream LLVM への RFC 戦略 or fork 維持。先行 RFC の動向調査 | [LLVM Discourse: "Add an Apple Metal/AIR backend target" (2026-05)](https://discourse.llvm.org/t/rfc-add-an-apple-metal-air-backend-target/90936) 等 |

---

## 3. 参照すべき外部先行成果 (リポジトリに収録されていない)

| 先行成果 | 得られるもの |
|---|---|
| [3Shain/dxmt `airconv`](https://github.com/3Shain/dxmt) (AIR→DXIL 変換器) | **AIR intrinsic/メタデータの実戦的パース実装** = C1〜C7 の最良の公開一次資料 |
| [naga wiki: Metallib file format](https://github.com/gfx-rs/naga/wiki/Metallib-file-format) | MTLB 構造 (F1) の第三者検証 |
| [LLVM Discourse RFC (2026-05)](https://discourse.llvm.org/t/rfc-add-an-apple-metal-air-backend-target/90936) | Metallib ライタを含む LLVM Metal/AIR ターゲット PoC と `MetallibFormat.rst` |
| [Worth Doing Badly: Metal bitcode](https://worthdoingbadly.com/metalbitcode/) | metallib→bitcode 抽出・上流 LLVM での可読性の実証 (F2) |
| Mesa AGX コンパイラ / [Asahi docs](https://asahilinux.org/docs/hw/soc/agx/) | AGX ISA とドライバ ABI (G1) ※Metal API レイヤではなく Linux 向け |
| Microsoft Metal Shader Converter (バイナリ製品) | DXIL→metallib 生成の存在証明 (手法の公開情報は少ない) |

---

## 4. 推奨する次の一手 (情報を「足りる」状態にする作業順)

1. **機械抽出パイプラインの構築** (リポジトリ内一次情報だけで着手可・成果は検証可能)
   - `__metal_*` 686 ビルトインの署名カタログ (ヘッダ走査)
   - `__HAVE_*` 能力マトリクス (metal_config 全分岐展開)
   - 全 rtlib bitcode のシンボル/文字列/intrinsic 参照ダンプ (llvm-dis または Python bitcode リーダ)
   - 実 `.metallib` (10本) の MTLB タグ完全パース → SECTION1 の検証
2. **実測環境の確保** (macOS + Xcode): `metal -v` フラグ採取、`-emit-llvm` での probe コンパイル (B1/B2/C系/D1)、ゴールデンコーパス収集 (I1)
3. **airconv / RFC PoC の調査消化** → C系 (AIR契約) のドラフト仕様書化作成
4. **方針確定**: A1 (AIR出力まで)・J1 (ライセンス)・J2 (upstream or fork)
5. その後に clang fork PoC (アドレス空間+属性+`__metal_*`→`air.*` 最小経路) へ進む

---

### 補足: この調査で行った実測コマンド (再現用)

```bash
# rtlib は ar アーカイブ、中身は LLVM bitcode (wrapper magic de c0 17 0b / BC c0 de)
ar t reference/clang/32023.883/lib/darwin/libair_rt_osx.rtlib
od -A x -t x1z <member> | head

# 真のトリプル/intrinsic/producer を含む文字列ダンプ
strings reference/clang/32023.883/lib/darwin/libtracepoint_rt_osx.metallib

# stdlib が要求する clang 拡張の全量
grep -rhoE "__metal_[a-z0-9_]+" reference/clang/32023.883/include/metal | sort -u   # 686個
grep -rhoE "__builtin_[a-z0-9_]+|\b__attribute__\(\([^)]*\)\)" reference/clang/32023.883/include/metal | sort | uniq -c
```
