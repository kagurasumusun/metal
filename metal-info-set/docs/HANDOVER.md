# HANDOVER — 他 AI (次セッション) への引継ぎ資料

作成: 2026-07-21 (HEAD = commit `6cd38ee` @ branch `jules-2822063734237814689-7500b921`)
本書 1 枚でプロジェクトの全状態・全手順・残作業を把握できるようにしてある。

---

## 0. 30 秒要約

- **目的**: LLVM & Clang fork で Metal Shading Language (MSL) を完全コンパイルするための
  全対応表・全設計一次データを、**実機 (macOS + Xcode 26.5, metal 32023.883) 実測のみ**で構築する。
- **現在地**: builtin→AIR 対応表 **686 行 全確定** (confirmed 641 + air-op 非存在 disposition 45)。
  独立検証器 C1–C7 全緑。candidate 名の変更を伴わない証拠参照修復 155 件まで済。
- **次にやること**: §7 の残リスト順。最優先は **新 upterm セッションをユーザーから受け取ること**
  (旧セッション `zajg8DIlJdQ6m9nTdwPr` は消失確認済・paramiko EOFError)。

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
- 一次参照 (ローカルのみ・repo 外): `/home/user/metal-repo/reference/clang/32023.883/`
  (include/metal 実ヘッダ 71 + `__bits` 17, lib/darwin rtlib 74)
- Air ゴールデン corpus: `/home/user/metal-info-set/golden/` (54 .ll + 各 probe.metal + meta.yml)
- バックアップ: `/home/user/backup/*.tgz` (作業塊ごとに作成)
- `/tmp`・プロセスはターン跨ぎで消失。恒久物は必ず `/home/user` 内へ。

### 主要ファイル (正本)

| ファイル | 内容 | 行数/規模 |
|---|---|---|
| `data/builtin_to_air_map.v2.csv` | **builtin→AIR 対応表 正本** (18 列 schema: `docs/MAPPING_SCHEMA.md`) | 686 行全確定 |
| `data/clang_frontend_impl_map.csv` | clang frontend (lexer/sema/type/attr/codegen/driver) 実装対応表 | 1,210 行 |
| `data/stdlib_runtime_impl_map.csv` | stdlib/runtime 5 レイヤ対応表 | 1,380 行 |
| `data/rtlib_cleanroom_map.csv` | rtlib 全関数のクリーンルーム代替分類 | 12,672 関数 |
| `data/type_layout_map.csv` | opaque `_t` 型レイアウト定量 | 35 型 |
| `data/air_golden_names.csv` | golden 実測 air 名辞書 | 545 名 |
| `data/ir_air_signatures.csv` | Apple rtlib IR 実シグネチャ | 8,200 decl |
| `data/reference_tree_inventory.csv` | reference/ 全ファイル棚卸 | 145 |
| `docs/VERIFICATION.md` | 対応表の独立検証記録 (C1–C7) | 全緑 |
| `docs/IR_GROUND_TRUTH.md` | 実 IR 確定ファクト集 (§6.1–6.10) | — |
| `docs/AIR_VOCABULARY.md` | AIR 命名文法・語彙 (§8 追補に確定語彙) | — |
| `docs/METALLIB_WRITER_SPEC.md` | .metallib writer 仕様 draft | v0.1 |
| `docs/GPUCOMPILER_SYMBOLS.md` | AIRNT C API 98 symbol 解析 | — |
| `docs/EVENTLOG.md` | **全変更履歴 (git 以前の真実)** | 1,100+ 行 |

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

## 5. Mac 実機 probe 手順 (新セッション到着時)

1. ユーザーから upterm banner (`Session: XXXX / SSH: ssh XXXX@uptermd.upterm.dev`) を受け取る
2. `/home/user/upterm_client.py` の USER を新セッション名に書き換え
3. 使い方: `python3 upterm_client.py probe` (画面取得) / `send "cmd"` /
   `sftp-put <local> <remote>` / `sftp-get <remote> <local>`
   - 画面混濁時は `send 'clear; echo MARKER'` 後に probe
   - **罠**: 引数なし `grep -c PATTERN` は stdin 待ちでブロック → Ctrl-C (`\x03`) で復旧
4. runner: `xcrun --sdk macosx metal -x metal -std=metal4.0 -O2 -S -emit-llvm probe.metal -o probe.ll`
   (SDK 名は `macosx`。`macosx26` は xcodebuild 別系でエラー)
5. エラー駆動削りループ: `/home/user/upterm/loop3.py` を sftp-put し、scene dir で
   `python3 loop3.py <SCENE> <root> metal4.0 macosx -O2` (45 iter で #error 行を削り収束)
   - Background 化: `(python3 loop3.py ... > X.out.log 2>&1; echo DONE > probe_done.txt) & echo STARTED`
6. 成果は `sftp-get` → `/home/user/golden_dl_runNN/` → corpus `metal-info-set/golden/runNN_apply/<SCENE>/{metal40_macosx26/probe.ll, probe.metal, result json}` + `meta.yml` に恒久化
7. 反映: `python3 scripts/promote_map.py apply-golden golden/runNN_apply --manifest probe_scenes_methods/MANIFEST_*.csv`
   → `audit` → `verify_map.py` → EVENTLOG → backup → push

## 6. 確定命名総則 (AIR 語彙の読み方・AIR_VOCABULARY §8-8)

- `air.<verb>_<subject>` : u 区切りは subject 名詞句連結 (`air.get_height_texture_2d`)
- tags: `.<tag>...` 末尾連結 (`...intersection_result.instancing.triangle_data.world_space_data`)
- 型 suffix: convert は `.to.from` (f.f32.u.i16)、matrix は `.v64f32.p1f32`、atomic は `.i16.u.v4i64` 系、buffer 語あり atomic は `air.atomic.global.<op>.u.i64`
- 例外系統 (実測): `air.store.implicit_imageblock.mask.v4f32` はドット語序、`air.write_imageblock_slice_to_texture_*` は u 語序 — **混在実在**

## 7. 残作業 (優先順・2026-07-21 確定)

| # | 項目 | 状態 / 次の手 |
|---|---|---|
| 1 | **新 upterm セッション取得** | ユーザー待ち (旧消失)。取得後 §5 で接続確認 |
| 2 | P06M metal32 再現 probe (inline-only 73 行を file backing 化) | 原本 `golden/P06M/metal32_macosx26/probe.metal` (777 行・収束済) を sftp-put → `-std=metal3.2 -O2 -S -emit-llvm` → `golden/run27_apply/P06M32R/metal32_macosx26/` に恒久化 → 73 行の evidence_ref を内容照合つき再指向 (verify_map --repair 拡張 or 手動 XC) |
| 3 | AIRNT C API 実機実行 | dlopen(`GPUCompiler.framework/Versions/Current/Libraries/libGPUCompilerImpl.dylib`) + `_AIRNTGetLegalizationPasses_*` 系を dladdr/呼出する C/Swift 1 ファイル (シンボル表: `docs/GPUCOMPILER_SYMBOLS.md` §2、実験計画: `docs/PROBING_PLAN.md`)。AIR→metallib/GPU binary 経路の実証 |
| 4 | .metallib writer 実装 | `docs/METALLIB_WRITER_SPEC.md` v0.1 から。未確定 4 項目 (unknown4/HASH 入力/VERS/types-empties 則) を Apple 出力差分観測で埋め、byte-ident 検証 + MTLLibrary load 検証 |
| 5 | xip 解析 | GPUCompiler 配布 xip は暗号化で展開不能。strings 辞書は未着手 (優先度低: 対応表は全確定済) |
| 6 | frontend 対応表 langopt 964 行の個別 codepath 実証 | inventory 級からの深化 (低優先) |

完了済 (再作業不要): builtin→AIR 686 全確定 / frontend 対応表 1,210 / stdlib+runtime 対応表
1,380 / rtlib クリーンルーム分類 12,672 / reference/ 145 棚卸 / 型レイアウト 35 /
独立検証器 standing (verify_map.py)。

## 8. 最近の教訓 (引き継ぎ時に知っておくべきこと)

- 「完成」は自己申告ではなく独立検証で担保: 今回も evidence_ref 死パス 155 件が
  潜んでいた。**変更後は必ず verify_map.py 全緑を確認**。
- `apply-golden` 系は stem 一致で自動昇格する。manifest 書式:
  `scene,file,symbol,builtin,stage1_source` (同 symbol に複数 builtin 行可)。
- 訂正 (XC_CORRECT) は悪いことではない。一次実測で上書きし、旧値は EVENTLOG に残す。
- セッション/PAT は不定期消失。**大きな塊ごとに backup→push→ls-remote 確認**を怠らない。

(以上。疑問点は `docs/EVENTLOG.md` を時系列で読めば全判断の一次根拠に到達できる)
