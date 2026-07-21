# GPUCompiler.framework 静的情報 (macOS SDK 由来・Mac不要で取得)

> 出所: [alexey-lysiuk/macos-sdk](https://github.com/alexey-lysiuk/macos-sdk/tree/main/MacOSX26.5.sdk) (Xcode 26.5 SDK)。
> SDK の `.tbd` (text-based stub) に含まれる**公開シンボル一覧**を解析。バイナリ本体は SDK に含まれないが、シンボルだけでツールチェーン構造がかなり読み解ける。
> 取得物: `reference-external/gpucompiler-tbd/*.tbd` (実テキスト) / `data/gpucompiler_demangled.txt` (全 C++ シンボル demangle 一覧 22,110 件)。

## 1. レイヤ構成 (我々のパイプラインとの対応)

```
 clang fork (我々の実装範囲)         Apple JIT 側 (提供物として使う/参考にする)
 ┌─────────────────────┐      ┌───────────────────────────────────────────┐
 │ .metal→AIR bitcode   │ ──▶  │ libGPUCompilerUtils / libairutility        │ 入口補助 (Versions/32023)
 │ .metallib (MTLB)     │      │ libLLVM (Apple fork, 21.5k export)         │ AIRパスを内蔵
 └─────────────────────┘      │ libGPUCompiler → libGPUCompilerImpl        │ AIRNT C API 98個
                              │ libLLVMContainer                           │ (Versions/A=legacy系?)
                              │ libmetallinker / libsrc2module / libmetal_timestamp │ リンク/変換補助
                              └───────────────────────────────────────────┘
```

## 2. AIRNT C API (libGPUCompilerImpl.tbd: 98 symbols)

JIT バックエンドの**エントリ API**。動詞分類: Get×47, Supports×13, Emit×12, Add(pass)×6, Clone/Dispose/Init×各4, Parse×3, Set×2, Create/Initialize/Wrap×各1。

判明した構造要素:
- **出力イメージ種別**: `ExecutableImage`, `DylibImage`, `BuiltinExecutableImage`, `PipelineImages`, `Assembly`, `Object` → GPU側実行形式にも「実行/動的ライブラリ/組込実行/パイプライン一括」の概念 (_AIRNTEmit*Image_*)
- **FunctionId 種別**: `Compute / Vertex / Fragment / Mesh / Object / Tile / Builtin` → エントリステージの識別体系 (Tile = tile shading 系)
- **Target 選択**: `SupportsArch/Target/Threads`, `GetSupportedArchs/Impls/BitcodeVersion`, `GetPreferredAIRArch`, `GetDefaultArch`, `GetLLVMVersion`, `GetSupportedBitcodeVersion`, `GetLegalizationPasses`, `GetDeploymentTarget`, `GetVendorId/VendorName`
- **バリアント**: `_Opaque / _Wrapper / _Matching / _Legalizer` + `_Default` の組合せ = プラガブルなベンダーバックエンド構造 (GPU ベンダ実装が差し替わる設計)

## 3. LLVM 内部 (libLLVM.tbd + libGPUCompilerImpl.tbd: demangle 22,110 件中の要点)

### llvm::air 関連パス (AIR モジュール品質管理系) — **我々の .air が通過すべき関門**
| シンボル | 意味 |
|---|---|
| `llvm::air::AIRVerifierPass` | **AIR モジュールの検証器** — 受理条件の実体。生成 IR がこれを通過することが実質的な互換条件 |
| `llvm::air::AIRLegalizerPass` | AIR への legalization (非対応形の書換え/許容化) |
| `llvm::air::AIRUpgradePass` / `AIRDowngradePass` | **AIR バージョン間の自動変換** (v23↔v25↔v26 の互換機構の存在を示唆) |
| `llvm::air::AIRLateWorkItemPass` / `GlobalCtorOptPass` | ワークアイテム最適化 / グローバル ctor 最適化 |
| `llvm::airdevlower::DeviceLowering` + `air::DeviceLoweringConfig` | AIR→デバイス lowering パイプラインの構成体 (PipelinesData) |
| `callDefaultCtor<air::AIRDeviceLoweringConfigWrapperPass>` | pass 登録 |

### AGX デバイス側 (スコープ外だが構造理解に有用)
- `createAGXInstCombinePass` / `createAGXPreRAAnalysisPass` / `createAGXShaderCanonicalizerPass`
- `AGCStatusPrinter` (optimize/lowered フック)
- C API: `_LLVMAGXRuntimeMajorVersion` / `_LLVMAGXRuntimeMinorVersion`

### airnt 名前空間 (JIT 側実行基盤)
- `airnt::ScriptInfo`, `airnt::StagesAnalysis` (pass として登録)

## 4. この発見による方針更新

| 従来想定 | 更新 |
|---|---|
| 「Apple 側パイプラインは全くのブラックボックス」 | **AIRVerifier/AIRLegalizer/AIRUpgrade/Downgrade の存在が判明**。我々の clang が出す .air は `*=Opaque/Wrapper` 系 vendor backend の **Legalizer に受理される形**が品質基準になる |
| 「AIR バージョン互換の扱いが不明」 | Upgrade/Downgrade pass の存在 → **多少古い/新しい AIR でも JIT側で変換される**可能性が高い = 我々は特定 v に正確に出すことに集中してよい (例 v25/v26) |
| 「最適化パス列 (S3) は実測のみ」 | `GetLegalizationPasses` API + `DeviceLoweringConfig` の存在 → legalization パス列は **API 経由で列挙可能な設計**。実機があれば C API 呼出だけで一覧取得できる |

## 5. Macなしで「静的情報」を更に掘るための残オプション

| やりたいこと | 可否 (Macなし) | 方法 |
|---|---:|---|
| air.* intrinsic 名の全辞書 | ⚠️ 可能 | 実 Mach-O バイナリが必要 → **Xcode xip を Linux でダウンロード&展開** (要無料 Developer アカウント; `xar -xf` + `pbzx` で個別ファイル抽出可)。対象: GPUCompiler.framework の libLLVM.dylib 等 → `strings` で一括 |
| 実バイナリの逆アセンブル (LLVM fork の差分解析) | ⚠️ 同上 | 展開後 radare2/Ghidra 等で静的解析可能 (実行は不要) |
| **実行** (probe コンパイル) | ❌ | macOS バイナリを Linux で実行する実用的手段なし (Darling 非現実)。実機 or CI が必要 |
| Metal.framework ホスト API 全容 | ✅ 可能 | SDK の `Frameworks/Metal.framework/Versions/A/{Headers,Metal.tbd}` を同様に取得すればよい (tbd 53KB) |

## 6. 取得物の参照先

- tbd 原本: `reference-external/gpucompiler-tbd/` (9ファイル, 計 ~3.1MB)
- demangle 全一覧: `data/gpucompiler_demangled.txt`
- 解析スクリプト: 本 doc 記載の正規表/`c++filt` で再現可能
