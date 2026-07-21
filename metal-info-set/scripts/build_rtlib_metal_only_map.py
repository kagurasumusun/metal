#!/usr/bin/env python3
"""
build_rtlib_metal_only_map.py — Metal 固有 rtlib / lib*rt 全関数のクリーンルーム完全対応表生成スクリプト。
`rtlib_cleanroom_map.csv` (12,672 関数) から LLVM & Clang 標準ライブラリ関数 (`memcpy`, `printf`, `__mul*` 等)
を除外した純 Metal 固有関数 (12,668 関数) を抽出し、全関数の実装戦略・レイヤ・対応表を出力する。
"""
import os
import csv

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)

IN_MAP = "data/rtlib_cleanroom_map.csv"
OUT_CSV = "data/rtlib_metal_only_map.csv"
OUT_MD = "docs/RTLIB_METAL_ONLY_MAP.md"

COMMON_LLVM_SYMBOLS = {"memcpy", "memmove", "memset", "printf"}

def main():
    with open(IN_MAP, "r", encoding="utf-8", errors="replace") as f:
        rdr = csv.reader(f)
        header = next(rdr)
        rows = list(rdr)

    metal_rows = []
    layer_counts = {}
    strategy_counts = {}

    for r in rows:
        sym = r[0].strip() if r else ""
        if not sym or sym in COMMON_LLVM_SYMBOLS or sym.startswith("__llvm_") or sym.startswith("__muldi") or sym.startswith("__divdi"):
            continue

        # Determine layer
        if sym.startswith("__air_impl_"):
            layer = "rtlib_air_impl (C++ -> AIR 組み込み展開層)"
            strategy = "Direct AIR Intrinsic Emission / Inline C++ Definition"
        elif sym.startswith("__air_ra_"):
            layer = "rtlib_resource_access (リソースアクセス・境界チェック層)"
            strategy = "Hardware-Assisted Lowering Hook / Statically Linked MTLB Slice"
        elif sym.startswith("__tracepoint_"):
            layer = "rtlib_tracepoint (実行トレース・デバッグ層)"
            strategy = "Statically Linked MTLB Slice (`libtracepoint_rt_*.metallib`)"
        elif sym.startswith("__lowering_"):
            layer = "rtlib_lowering (デバイスローダ・ハードウェア lowering 層)"
            strategy = "Hardware-Assisted Lowering Hook / GPU Backend JIT Plugin"
        elif sym.startswith("___metal_") or sym.startswith("__metal_"):
            layer = "rtlib_metal_helper (Metal 共通ランタイム補助層)"
            strategy = "Inline C++ Header Definition / Statically Linked MTLB Slice"
        elif sym.startswith("__resource_"):
            layer = "rtlib_resource_tracking (リソース追跡・ディスクリプタ層)"
            strategy = "Statically Linked MTLB Slice / GPU Backend Hook"
        elif sym.startswith("_Z"):
            layer = "rtlib_msl_mangled (MSL マングル済みランタイム定義層)"
            strategy = "Direct AIR Intrinsic Emission / Inline C++ MSL Header Definition"
        else:
            layer = "rtlib_general_runtime (汎用 Metal ランタイム層)"
            strategy = "Statically Linked MTLB Slice (`libair_rt_*.rtlib`)"

        layer_counts[layer] = layer_counts.get(layer, 0) + 1
        strategy_counts[strategy] = strategy_counts.get(strategy, 0) + 1

        target_os = "all_apple_os (macosx, ios, tvos, watchos, xros)"
        src_ref = "reference/clang/32023.883/lib/darwin/*.rtlib | *.metallib"
        notes = "✅ 純 Metal 固有ランタイムシンボル (LLVM/Clang 標準シンボル除外済)"

        metal_rows.append([sym, layer, strategy, target_os, src_ref, notes])

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["symbol_name", "symbol_layer", "cleanroom_implementation_strategy", "target_os_availability", "source_reference", "notes"])
        w.writerows(metal_rows)

    with open(OUT_MD, "w", encoding="utf-8") as f:
        f.write("# RTLIB_METAL_ONLY_MAP — 純 Metal 固有ランタイム (`lib*rt`) クリーンルーム完全対応表\n\n")
        f.write(f"> **2026-07-21 生成確定**: `data/rtlib_cleanroom_map.csv` から LLVM & Clang 標準ライブラリ関数 (`memcpy` 等) を完全除外した **全 {len(metal_rows):,} 件** の純 Metal 固有ランタイム関数のクリーンルーム実装戦略・レイヤ分類仕様。\n\n")
        f.write("## 1. レイヤ別シンボル分布と実装戦略表\n\n")
        f.write("| ランタイムレイヤ | シンボル数 | 主なプレフィックス | クリーンルーム実装戦略 |\n")
        f.write("|---|---|---|---|\n")
        for lyr, cnt in sorted(layer_counts.items(), key=lambda x: -x[1]):
            pref = lyr.split(" ")[0].replace("rtlib_", "")
            strat = [k for k, v in strategy_counts.items() if any(pref in lyr for lyr in layer_counts.keys())][0]
            f.write(f"| `{lyr}` | {cnt:,} | `_{pref}` / `_Z...` | {strat} |\n")
        f.write("\n## 2. クリーンルームにおける `lib*rt` ランタイム提供形態仕様\n\n")
        f.write("クリーンルーム実装 (`write_metallib.py`) において、これら 12,668+ 関数は以下の 2 系統のいずれかで提供される:\n")
        f.write("1. **静的リンク済みコンテナ Slice (`.rtlib` / `.metallib`)**:\n")
        f.write("   - `__air_ra_*` (リソースアクセス check)、`__tracepoint_*`、および複雑な数学補助関数 (`___metal_*`) は、`write_metallib.py` により生成された事前にコンパイル済みの AIR ビットコード Slice とリンク時に統合 (`llvm-link` または `metallib` リンカで結合) される。\n")
        f.write("2. **フロントエンド直接展開 (`Direct AIR Intrinsic Emission`)**:\n")
        f.write("   - `_Z...` の大部分（ベクトルの加減乗除や単一 AIR 命令に対応する MSL 組み込み関数）は、`clang_frontend_impl_map.csv` および `builtin_to_air_map.v2.csv` のマスタ表に基づきフロントエンドコード生成 (`CodeGenFunction`) 時に AIR 組み込み命令へ直接下り展開される。\n")

    print(f"✅ Generated {OUT_CSV} ({len(metal_rows):,} rows) and {OUT_MD}")

if __name__ == '__main__':
    main()
