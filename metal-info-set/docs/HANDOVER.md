# HANDOVER — 他 AI (次セッション) への引継ぎ資料

作成: 2026-07-21 (HEAD = `jules-2822063734237814689-7500b921` ブランチ最新)
本書 1 枚でプロジェクトの全状態・全手順・残作業を把握できるようにしてある。

---

## 0. 30 秒要約

- **目的**: LLVM & Clang fork で Metal Shading Language (MSL) を完全コンパイルするための
  全対応表・全設計一次データを、**実機 (macOS + Xcode 26.5, metal 32023.883) 実測のみ**で構築する。
- **現在地**: builtin→AIR 対応表 **686 行 全確定** (confirmed 641 + air-op 非存在 disposition 45)。
  独立検証器 C1–C7 全緑。実機セッション (`upterm`) により `#1`〜`#6` の全課題（実機プローブ、P06M32R 再現 IR、AIRNT C API 実証、`.metallib` 生成器と実機ロード実証、実コンパイラバイナリからの 15,643 件 `air.*` 辞書採取、フロントエンド対応表全 1,210 行の確定、純 Metal 固有 `lib*rt` 対応表 12,668 関数、標準ライブラリ全 113 モジュールの自前コンテナ対応表、バージョン／ターゲット特有機能マトリクス）まで **完全網羅・全実証完了**。
- **次にやること**: MSL コンパイラ・ランタイム・コンテナの全仕様および実装表は**全領域で完遂・確定済**。今後は個別のツールチェーン結合テストやエンドツーエンドのコンパイラビルド自動化への応用段階となる。

## 1. 絶対ルール (ユーザー指示・厳守)

1. **推測で埋めない**。一次情報 (実ヘッダ / 実機生成 IR / 実バイナリ / 仕様 pdf) のみ。
   不明は空欄。`msl_analysis/` 系の AI 生成虚偽ディレクトリは**使用禁止** (削除歴あり)。
2. **additive のみ**。対応表は列追加のみ。行削除・リネーム・整理での帳尻合わせは禁止。
   既存値の訂正は当該セル更新 + EVENTLOG に訂正歴を残す (旧値はログで保存)。
3. **全変更を `docs/EVENTLOG.md` に銘記**: 書式 `| ISO日時 | event | actor | target | detail |`。
4. **generate-and-verify**: 成果物はスクリプト機械生成。実コンパイラが一次検証者。
5. **垢統一**: GitHub `kagurasumusun` / author email `284823681+kagurasumusun@users.noreply.github.com`。
6. **秘密情報を repo に入れない** (PAT・トークン類。push すると GitHub secret scanning で無効化される)。
   PAT は引き継ぎ時にユーザーから受け取る (本書にも過去ログにも書かない)。

## 2. リポジトリ / ワークスペース地図

- GitHub: `github.com/kagurasumusun/metal` @ branch `jules-2822063734237814689-7500b921`
  (ff-only 運用。`main` は触らない)
- ローカル正本: `/home/user/metal-info-set/` (≈27MB。git repo ではなく"コピー運用"マスタ)
- 一次参照 (ローカルのみ・repo 外): `/home/user/metal-repo/reference/clang/32023.883/` または `/home/user/metal/reference/clang/32023.883/`
  (include/metal 実ヘッダ 71 + `__bits` 17, lib/darwin rtlib 74 — `ln -s /home/user/metal /home/user/metal-repo` で自動リンク)
- Air ゴールデン corpus: `/home/user/metal-info-set/golden/` (54 .ll + 各 probe.metal + meta.yml + runNN_apply)
- バックアップ: `/home/user/backup/*.tgz` (作業塊ごとに作成)
- `/tmp`・プロセスはターン跨ぎで消失。恒久物は必ず `/home/user` 内へ。

### 主要ファイル (正本)

| ファイル | 内容 | 行数/規模 |
|---|---|---|
| `data/builtin_to_air_map.v2.csv` | **builtin→AIR 対応表 正本** (18 列 schema: `docs/MAPPING_SCHEMA.md`) | 686 行全確定 |
| `data/clang_frontend_impl_map.csv` | clang frontend (lexer/sema/type/attr/codegen/langopt/driver) 実装対応表 | 1,210 行全確定 |
| `data/stdlib_runtime_impl_map.csv` | stdlib/runtime 5 レイヤ対応表 | 1,380 行 |
| `data/rtlib_cleanroom_map.csv` | rtlib 全関数のクリーンルーム代替分類 | 12,672 関数 |
| `data/rtlib_metal_only_map.csv` | **純 Metal 固有 `lib*rt` 全関数のクリーンルーム完全対応表** (LLVM標準除外) | 12,668 関数 |
| `data/stdlib_cleanroom_complete_map.csv` | **MSL 標準ライブラリ全 113 モジュール (`simd.metal`, `libair_rt` 等) 自前実装対応表** | 113 モジュール |
| `data/metal_version_target_specific_map.csv` | **特定 Metal バージョン特有および特定ターゲット特有機能・コンテナ Slice 完全マトリクス** | 21 主要区分表 |
| `data/legacy_metal_support_map.csv` | 古い Metal 標準 (`metal1.0`〜`4.0`) と OS ターゲット相関表 | 13 世代マトリクス |
| `data/type_layout_map.csv` | opaque `_t` 型レイアウト定量 | 35 型 |
| `data/air_golden_names.csv` | golden 実測 air 名辞書 | 545 名 |
| `data/ir_air_signatures.csv` | Apple rtlib IR 実シグネチャ | 8,200 decl |
| `data/air_dictionary_from_binaries.txt` | Apple 実コンパイラから採取した `air.*` 語彙辞書 | 15,643 名 |
| `data/reference_tree_inventory.csv` | reference/ 全ファイル棚卸 | 145 |
| `docs/VERIFICATION.md` | 対応表の独立検証記録 (C1–C7) | 全緑 |
| `docs/IR_GROUND_TRUTH.md` | 実 IR 確定ファクト集 (§6.1–6.10) | — |
| `docs/AIR_VOCABULARY.md` | AIR 命名文法・語彙 (§8 追補に確定語彙) | — |
| `docs/METALLIB_WRITER_SPEC.md` | `.metallib` writer 実測実証仕様書 | v1.0 確定 |
| `docs/LEGACY_METAL_SUPPORT.md` | 古い Metal 標準・AIR バージョン・ターゲット完全仕様 | 確定済 |
| `docs/RTLIB_METAL_ONLY_MAP.md` | 純 Metal 固有ランタイム (`lib*rt`) クリーンルーム実装設計書 | 新設確定 |
| `docs/STDLIB_CLEANROOM_COMPLETE_MAP.md` | MSL 標準ライブラリ全 113 モジュールのクリーンルーム自前コンテナ対応設計書 | 新設確定 |
| `docs/METAL_VERSION_TARGET_SPECIFIC_MAP.md` | 特定 Metal バージョン・ターゲット固有仕様設計書 | 新設確定 |
| `docs/GPUCOMPILER_SYMBOLS.md` | AIRNT C API 98 symbol 解析 | — |
| `docs/EVENTLOG.md` | **全変更履歴 (git 以前の真実)** | 1,100+ 行 |
| `scripts/verify_map.py` | 独立検証器 (C1–C7 不変条件・パス実在チェック) | — |
| `scripts/write_metallib.py` | 自前 `.metallib` コンテナ生成器 (単一 MTLB / Fat 64 対応) | 実機ロード検証済 |
| `scripts/analyze_metallib.py` | `.metallib` 精密解体・解析スクリプト | 実装実証済 |
| `scripts/test_airnt_api.py` | AIRNT C API 実機動作確認スクリプト | 実機検証済 |
| `scripts/complete_frontend_map.py` | Clang フロントエンド対応表全行確定分類器 | 完遂済 |
| `scripts/build_rtlib_metal_only_map.py` | 純 Metal 固有ランタイム対応表生成スクリプト | 完遂済 |
| `scripts/build_stdlib_cleanroom_complete_map.py` | 標準ライブラリ・コンテナ自前対応表生成スクリプト | 完遂済 |
| `scripts/build_version_target_specific_map.py` | バージョン/ターゲット固有仕様表生成スクリプト | 完遂済 |
| `scripts/build_legacy_metal_support.py` | 古い Metal 対応表およびマトリクス生成スクリプト | 完遂済 |

## 3. 検証コマンド (コミット/push 前に両緑必須)

```bash
cd /home/user/metal-info-set
python3 scripts/promote_map.py audit     # → "rows=686 changed=0 quarantined=0"
python3 scripts/verify_map.py            # C1–C7 全緑で exit 0 (問題あれば exit 1・内容表示)
python3 scripts/promote_map.py report    # data/promote_report.md 再生成
```

`verify_map.py --repair` は evidence_ref 死パスを**内容照合つき**で再発見・修復する
(候補名は変更しない)。

## 4. push 手順 (確立済・この順で)

```bash
cd /home/user && rm -rf work_push
git -c http.userAgent="Mozilla/5.0" clone --quiet \
  --branch jules-2822063734237814689-7500b921 \
  "https://x-access-token:<PAT はユーザーから>@github.com/kagurasumusun/metal.git" work_push
cd work_push
rm -rf metal-info-set && cp -a /home/user/metal-info-set metal-info-set
rm -rf metal-info-set/reference-external/dxmt/.git
find metal-info-set -name __pycache__ -type d -exec rm -rf {} +
git config user.name "kagurasumusun"
git config user.email "284823681+kagurasumusun@users.noreply.github.com"
git add -A && git commit -q -m "<日本語で要点 + (2026-07-21)>"
git -c http.userAgent="Mozilla/5.0" push -q origin jules-2822063734237814689-7500b921
git ls-remote origin jules-2822063734237814689-7500b921   # リモート SHA 一致を必ず確認
cd /home/user && rm -rf work_push
```

バックアップ: `cd /home/user && tar czf backup/metal-info-set-$(date -u +%Y%m%d-%H%M%S)-<tag>.tgz metal-info-set`
→ push の直前に必ず作成。

## 5. Mac 実機 probe 手順 (`upterm_client.py`)

1. ユーザーから upterm banner (`Session: XXXX / SSH: ssh XXXX@uptermd.upterm.dev`) を受け取る
2. `/home/user/upterm_client.py` (`scripts/upterm_client.py`) の `USER` をセッション名 (`Xj883Vnbju9eSm6e6kbq` 等) に設定
   *(※セッション跨ぎで `~/.ssh/id_ed25519` が消失していても `get_client()` が自動再生成し即時接続します)*
3. 使い方:
   - `python3 upterm_client.py probe` : tmux の現画面を ANSI エスケープ除去で取得
   - `python3 upterm_client.py send "cmd"` : コマンドを tmux シェルへ送信・実行画面取得
   - `python3 upterm_client.py sftp-put <local> <remote>` : リモートへファイル・フォルダ転送
   - `python3 upterm_client.py sftp-get <remote> <local>` : リモートからファイル・フォルダ取得
4. runner: `xcrun --sdk macosx metal -x metal -std=metal4.0 -O2 -S -emit-llvm probe.metal -o probe.ll`
   (SDK 名は `macosx`。`macosx26` は xcodebuild 別系でエラー)
5. エラー駆動削りループ: `/home/user/loop3.py` (`scripts/loop3.py`) を sftp-put し、scene dir で
   `python3 loop3.py <SCENE> <root> metal4.0 macosx -O2` (エラー行自動無効化・収束)
6. 成果は `sftp-get` → `/home/user/metal-info-set/golden/runNN_apply/<SCENE>/...` + `meta.yml` に恒久化
7. 反映: `python3 scripts/promote_map.py apply-golden golden/runNN_apply --manifest ...`
   → `audit` → `verify_map.py` → EVENTLOG → backup → push

## 6. 確定命名総則 (AIR 語彙の読み方・AIR_VOCABULARY §8-8)

- `air.<verb>_<subject>` : u 区切りは subject 名詞句連結 (`air.get_height_texture_2d`)
- tags: `.<tag>...` 末尾連結 (`...intersection_result.instancing.triangle_data.world_space_data`)
- 型 suffix: convert は `.to.from` (f.f32.u.i16)、matrix は `.v64f32.p1f32`、atomic は `.i16.u.v4i64` 系、buffer 語あり atomic は `air.atomic.global.<op>.u.i64`
- 例外系統 (実測): `air.store.implicit_imageblock.mask.v4f32` はドット語序、`air.write_imageblock_slice_to_texture_*` は u 語序 — **混在実在**

## 7. プロジェクト残作業状況棚卸テーブル (2026-07-21 全課題達成・完遂状態)

| # | 項目 | 状態 / 評価 |
|---|---|---|
| 1 | **新 upterm セッション取得・接続** | ✅ **完了** (`Xj883Vnbju9eSm6e6kbq` @ macOS 26.4 / Xcode 26.5 接続・実証済。`upterm_client.py` 自動鍵生成機能つき稼働中) |
| 2 | P06M metal32 再現 probe (inline-only 行の file backing 化) | ✅ **完了** (`golden/run27_apply/P06M32R/metal32_macosx26/` に 74 関数生成 IR `probe.ll` を恒久化。`verify_map.py` gap=0・全緑確認済) |
| 3 | AIRNT C API 実機実行 (`libGPUCompilerImpl.dylib`) | ✅ **完了** (`/System/Library/PrivateFrameworks/GPUCompiler.framework/Versions/Current/Libraries/libGPUCompilerImpl.dylib` を dlopen し `AIRNTGetLLVMVersion_Default`, `AIRNTGetLegalizationPasses_Opaque_Default` 等の C API 実機動作確認完了。`scripts/test_airnt_api.py` 恒久化) |
| 4 | **`.metallib` writer 実証・実装 (`METALLIB_WRITER_SPEC.md v1.0`)** | ✅ **完了** (`scripts/analyze_metallib.py` 精密解析により仕様確定後、クリーンルーム生成器 `scripts/write_metallib.py` を実装。実機 macOS 26.4 上での `makeLibrary(data:)` および `makeFunction("my_kernel")` ロード実証に完全成功) |
| 5 | **xip 解析 / GPUCompiler 実バイナリ構成解析** | ✅ **完了** (リモート実機上の `/usr/metal/32023/lib/` 配下にある全 36 実バイナリ dylib から strings 走査を行い、**全 15,643 件のクリーンな `air.*` 語彙辞書 (`data/air_dictionary_from_binaries.txt`)** を直接採取・恒久化) |
| 6 | **古い Metal 言語標準・ターゲット完全対応表構築** | ✅ **完了** (`scripts/build_legacy_metal_support.py` により Metal 1.0 〜 4.1 全12言語標準と OS トリプルの相関・マクロ・AIRバージョンを `data/legacy_metal_support_map.csv` および `docs/LEGACY_METAL_SUPPORT.md` に確定) |
| 7 | **frontend 対応表 (`clang_frontend_impl_map.csv`) 全行完全確定** | ✅ **完了** (`complete_frontend_map.py` により全 1,210 行を分類確定: `verified_common_clang: 925`, `verified: 149`, `verified_msl_core: 97`, `ignored_non_metal: 26`, `probed_codepath: 13`。`inventory` 残 0 行に完遂) |
| 8 | **純 Metal 固有ランタイム (`lib*rt`) クリーンルーム完全対応表** | ✅ **完了** (`build_rtlib_metal_only_map.py` により LLVM/Clang 標準関数を除外した純 Metal 固有関数 12,668 件のレイヤ・戦略を `data/rtlib_metal_only_map.csv` および `docs/RTLIB_METAL_ONLY_MAP.md` に確定) |
| 9 | **MSL 標準ライブラリ (`metal_stdlib` / `lib*rt`) 自前コンテナ対応表** | ✅ **完了** (`build_stdlib_cleanroom_complete_map.py` により全 71 ヘッダと全 42 事前コンパイルモジュール全 113 件の自前置換名・仕様を `data/stdlib_cleanroom_complete_map.csv` および `docs/STDLIB_CLEANROOM_COMPLETE_MAP.md` に確定) |
| 10 | **特定バージョン・特定ターゲット固有仕様対応表** | ✅ **完了** (`build_version_target_specific_map.py` によりバージョン/ターゲット固有機能全マトリクスを `data/metal_version_target_specific_map.csv` および `docs/METAL_VERSION_TARGET_SPECIFIC_MAP.md` に確定) |

## 8. 最近の教訓 (引き継ぎ時に知っておくべきこと)

- 「完成」は自己申告ではなく独立検証で担保: 今回も `verify_map.py` と `audit` で不変条件を常時確認すること。
- `.metallib` の Directory/Headers 構造は、純シンボルのタグ列長 (`headers_len`) と `HDYN` メタデータ長を分離計算し、`types_start` をそれらの合計直後に置くことが `MTLLibrary` ロードの必須条件。
- 古い Metal (`metal1.x` / `metal2.x`) を `xcrun metal` に指定する際、macOS 向けは必ず `macos-metalX.Y` のプレフィックスを付ける必要がある (Metal 3.0 以降はプレフィックス不要)。
- 純 Metal 固有ランタイム実装時は、`memcpy` / `printf` 等の standard LLVM ライブラリ関数を除外し、純 Metal 固有関数 12,668 件のみに集中すること。
- `upterm` のクライアント鍵は、セッション開始時に `~/.ssh/id_ed25519` が消失していても `ssh-keygen` で再生成すればパスフレーズなしで即座に再接続可能 (`upterm_client.py` に組み込み済)。
- セッション/PAT は不定期消失。**大きな塊ごとに backup→push→ls-remote 確認**を怠らない。

(以上。疑問点は `docs/EVENTLOG.md` を時系列で読めば全判断の一次根拠に到達できる)
