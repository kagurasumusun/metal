# macOS probe 実測計画 (ローカル限界以降の確定手順)

> **🎉 2026-07-21 初回実施済**: macOS 26.4 実機 (upterm/paramiko 経由) で全 12 シーンをビルド成功、`golden/` に回収 (`golden/meta.yml` 付き)。**30 件を `probed_xcode_ll`=confirmed に昇格** (apply-golden 17 + corrections 13)。新トリプル `air64_v28-apple-macosx26.0.0` (AIR 2.8) 観測、エントリ metadata スキーマ実測確定 (`IR_GROUND_TRUTH.md` §6)。実施ログは `EVENTLOG.md`。
>
> 目的: `data/probe_cells.csv` (576 セル) を macOS+Xcode の実測で埋め、対応表 (`data/builtin_to_air_map.v2.csv` ★正本、スキーマは `MAPPING_SCHEMA.md`) の medium/high 行を confirmed にする。
> 原則: 命名文法は確立済のため、**ファミリー代表 probe → 文法確定 → 残りを機械展開検算** で最小実測数に抑える。
>
> **次回以降の実施手順**: ① `bench/upterm.env` に接続情報を保存 → ② `probe_scenes/` を SFTP upload → ③ `xcrun --sdk macosx metal -x metal -std=metal3.2 -O2 -S -emit-llvm` で全シーン → ④ golden tar 回収 → ⑤ `promote_map.py apply-golden golden --manifest probe_scenes/MANIFEST.csv` + `apply-golden-corrections golden --manifest probe_scenes/MANIFEST.csv` → ⑥ audit+report。

## 0. 環境セットアップ

**事前 (Mac不要・取得済)**: macOS SDK の `.tbd` 解析により JIT 側構造を把握済 (`GPUCOMPILER_SYMBOLS.md`):
- 我々の .air が通るべき関門 = `llvm::air::AIRVerifierPass` / `AIRLegalizerPass`、AIR 版間変換 = `AIRUpgradePass`/`AIRDowngradePass`
- Legalization パス列は `AIRNTGetLegalizationPasses` API で列挙可能 (実機実行時に要呼出)
- 残る実行系必須タスク: P1〜P13 の probe 生成のみ (静的語彙はほぼ揃った)

```bash
# ツール特定 (バージョン記録 → S0-2 対応表へ)
xcrun -f metal; xcrun --sdk macosx metal --version; xcrun --sdk macosx metal -v 2>&1
# AIRNT C API の直接列挙 (Legalization pass 一覧/AIR arch/BitcodeVersion を API で採取):
#  → libGPUCompilerImpl.dylib の _AIRNTGetLegalizationPasses_* 等を呼ぶ小さい C プログラム
# clang 実体と全オプション:
find /System/Library/PrivateFrameworks/GPUCompiler.framework -name "clang*" 2>/dev/null
METALFE=$(xcrun -f metal); "$METALFE" -help 2>&1 | tee metal_help.txt
```

**(語彙一括取得の本命は静的に変更)**: 実 dylib の strings は Mac不要で取れる可能性: Xcode xip を Linux で DL→`xar -xf`+`pbzx` で対象ファイルのみ抽出 → `strings`/`o `--‍```
strings … | grep -E '^air\.' | sort -u > air_dictionary.txt
```
(実機が取れたらこちらで二重取りして照合)

## 1. probe 共通コマンド形

```bash
# (A) LLVM IR テキストを直接出す (優先。失敗したらB)
xcrun -sdk macosx metal -x metal -std=metal3.2 -O2 -S -emit-llvm probe.metal -o probe.ll
# (B) bitcode 経由 (要 llvm-dis 互換確認: C-4)
xcrun -sdk macosx metal -x metal -std=metal3.2 -O2 -c probe.metal -o probe.air
llvm-dis probe.air -o probe.ll          # upstream llvm-tools で確認 (結果を C-4 に記録)
# (C) コンテナも併せて golden 化
xcrun -sdk macosx metallib probe.air -o probe.metallib
```

対象マトリクス: `-std=metal{2.4,3.0,3.2,4.0}` × `-target air64-apple-macosx{11,13,14}.0.0` を基本、iOS 系は `-sdk iphoneos`。

## 2. probe シーン優先順位 (各シーンが確定する表の範囲)

| # | シーン (probe.metal の内容) | 確定するセル | 波及 |
|---|---|---|---|
| P1 | 最小 kernel: `kernel void k(device float* b [[buffer(0)]], uint i [[thread_position_in_grid]], constant Params& p [[buffer(1)]], texture2d<float> t [[texture(0)]], sampler s [[sampler(0)]], threadgroup float* shm [[threadgroup(0)]])` | エントリ metadata 全構造 (air.kernel operand 列, air.arg_*, air.address_space), thread/device/constant/threadgroup addrspace, buffer/texture/sampler 属性エンコード, CC, datalayout | L表 / S表 / A-2 全確定。最大波及 |
| P2 | vertex/fragment 最小対 (stage_in, [[position]] 返却, raster order group, early_fragment_test) | air.vertex/air.fragment + vertex_input/output metadata | エントリ系の残 |
| P3 | 数学 builtin 代表 9: `sin, fma, fabs, floor, rsqrt, exp2, log2, pow, mix` (float/half/bfloat + fast/precise 両 namespace) | fast_math フラグの IR 表現, v 接尾辞規則, `__METAL_FAST_MATH__` 引数の解釈 | math 系 ~100 語彙を機械確定 |
| P4 | 整数代表 8: `abs,min,max,clz,popcount,hadd,add_sat,rotate` | .s/.u 規則, i 接尾辞 | int 系確定 |
| P5 | 変換: `as_type<T>`, `(T)` キャスト, saturate 変換各種 | air.convert 文法確定 (4631 バリアントの正当化) | convert 全展開検算 |
| P6 | texture 代表: `sample(bias/lod/grad/gather/gather_compare), read, write, get_width 等クエリ, fence` × texture2d<float> / depth2d<float> | texture 不透明 IR 型の実体, ch型接尾辞, cube/配列正規化規則 | texture 557 method の大半確定 |
| P7 | atomic 代表: `store/load/exchange/fetch_add/cmpxchg` × device+threadgroup × memory order | air.atomic.* 引数列, order/scope エンコード, addrspace 別変種 | atomic 完全確定 |
| P8 | 同期: `threadgroup_barrier(mem_flags), simdgroup_barrier/shuffle, quad_shuffle, async copy (MSL3)` | air.wg.simdgroup barrier 引数, mem_flags エンコード, p1/p3 copy | sync 系確定 |
| P9 | `[[function_constant(0)]] bool fc; if (fc) …` + パイプライン特殊化 | function constant の IR/metadata 実体 | A-6 確定 |
| P10 | visible function table + `[[visible]]` 関数 + intersection (raytracing min) | air.dyld_flat_table 構築, RT intrinsic 群実名 | A-7/A-9 確定 |
| P11 | mesh/object + metal_tensor/cooperative_tensor (MSL4) + simdgroup matrix | mesh metadata (air.mesh_*), tensor IR 表現 | MSL4 系確定 |
| P12 | `printf/assert/os_log` + shader logging | rtlib リンク trigger 規則, tracepoint への差込み形 | R-4 確定 |
| P13 | rtlib 使用関数: `nextafter, frexp, modf, bf16演算, f64変換` | `__air_impl_*` 呼出しの IR 形 (宣言参照か) | R-3 完全確定 |

## 3. 回収物の整理 (golden corpus 仕様: V-1)

```
golden/
  <SCENE>/{metal3.2_macosx14}/probe.{metal,ll(xcode),air,metallib}
  …
meta.yml  # date: YYYY-MM-DD (必須: observed_at に転記), Xcode 版 / clang -dumpversion / metal -v 出力
```

取得後の手順 (2026-07-21 確立のパイプライン):

```bash
# ① golden を対応表 v2 に昇格投入 (MANIFEST 突合・冪等・不一致は MISMATCH 記録で降格しない)
python3 scripts/promote_map.py apply-golden golden/ --manifest probe_scenes/MANIFEST.csv
# ② 一次辞書との再検算 (grammar/stem 辞書との整合を全行再採点)
python3 scripts/promote_map.py audit && python3 scripts/promote_map.py report
# ③ 全変更は docs/EVENTLOG.md を確認 (日時・主体・詳細が記録済)
```

※ `<SCENE>` 名は `probe_scenes/MANIFEST.csv` の scene (P01〜P13) に対応させること (apply-golden が scene 名で .ll を索引する)。

## 4. 所要見積

- probe ソース: 13 シーン × 平均 30 行 ≈ 400 行 (大半は `msl_stage1_*.csv` の signature から機械生成可能)
- 確定に要する実測: 約 40 probe (上表) で 686/686 の命名が検証可能と推定
