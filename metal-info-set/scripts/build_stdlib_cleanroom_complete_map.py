#!/usr/bin/env python3
"""
build_stdlib_cleanroom_complete_map.py — MSL 標準ライブラリ (`metal_stdlib` および `lib*rt`) 全 113 モジュールの
クリーンルーム完全自前実装対応表生成スクリプト。
Apple 公式ツリー (`reference/clang/32023.883/`) 内の全 71 ヘッダモジュール (`.metal` / `.h`) および
全 42 事前コンパイルライブラリモジュール (`.metallib` / `.rtlib`) のクリーンルーム置換形態、
機能ガード、および収録シンボル・組み込み関数を定量マッピングする。
"""
import os
import csv

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)

IN_INV = "data/reference_tree_inventory.csv"
OUT_CSV = "data/stdlib_cleanroom_complete_map.csv"
OUT_MD = "docs/STDLIB_CLEANROOM_COMPLETE_MAP.md"

def main():
    with open(IN_INV, "r", encoding="utf-8", errors="replace") as f:
        rdr = csv.reader(f)
        header = next(rdr)
        rows = list(rdr)

    out_rows = []
    header_cnt = 0
    lib_cnt = 0

    for r in rows:
        path = r[0].strip() if r else ""
        kind = r[1].strip() if len(r) > 1 else ""
        guards = r[10].strip() if len(r) > 10 else ""
        builtins = r[11].strip() if len(r) > 11 else ""

        if kind == "header" or "include/metal/" in path:
            header_cnt += 1
            entity_type = "header_module (.metal / .h)"
            fname = os.path.basename(path)
            if fname.endswith(".h"):
                clean_name = fname.replace(".h", ".metal")
            else:
                clean_name = f"{fname}.metal"
            
            # Implementation strategy
            if "simd" in fname:
                spec = "Inline MSL Header (`simd.metal`) — SIMD/ベクトル/行列演算 C++ インライン展開ラッパー"
            elif "raytracing" in fname or "intersection" in fname:
                spec = "Inline MSL Header (`metal_raytracing.metal`) — intersector/query/result 組み込み関数ラッパー"
            elif "tensor" in fname:
                spec = "Inline MSL Header (`metal_tensor.metal`) — テンソル演算・不透明構造体定義ラッパー"
            elif "__bits/" in path:
                spec = f"Internal Header Submodule (`{clean_name}`) — stdlib 内部実装詳細・型定義"
            else:
                spec = f"Standard MSL Header (`{clean_name}`) — `builtin_to_air_map.v2.csv` 直結組み込みラッパー"
                
            out_rows.append([path, entity_type, clean_name, builtins if builtins else "MSL Type/Trait Definitions", guards if guards else "None (Unconditional)", spec])
            
        elif kind in ("library", "binary") or any(ext in path for ext in (".metallib", ".rtlib", ".bundle")):
            lib_cnt += 1
            entity_type = "precompiled_container (.metallib / .rtlib)"
            fname = os.path.basename(path)
            clean_name = fname.replace(".rtlib", ".metallib") if fname.endswith(".rtlib") else fname
            
            if "air_rt_" in fname:
                spec = "Precompiled AIR Runtime Slice (`libair_rt.metallib`) — 汎用ランタイム補助関数の AIR コンテナ"
            elif "tracepoint_rt_" in fname:
                spec = "Precompiled Tracepoint Runtime (`libtracepoint_rt.metallib`) — デバッグ・トレース用 AIR Slice"
            elif "post_mesh_dump_" in fname:
                spec = "Precompiled Mesh Dump Hook (`libpost_mesh_dump_rt.metallib`) — メッシュシェーダ出力ダンプ用 Slice"
            elif "RaytracingRuntime" in fname:
                spec = "Precompiled Raytracing Runtime (`MTLRaytracingRuntime.metallib`) — レイ解析ハードウェア補助 Slice"
            elif "ShaderLoggingRuntime" in fname:
                spec = "Precompiled Logging Runtime (`MTLShaderLoggingRuntime.metallib`) — `os_log` 処理 AIR Slice"
            else:
                spec = f"Precompiled Runtime Plugin (`{clean_name}`) — GPU ベンダ別またはコンパイラ補助コンテナ"
                
            out_rows.append([path, entity_type, clean_name, "Precompiled Runtime Symbols / AIR Hooks", guards if guards else "Target OS / Arch Specific", spec])

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["entity_path", "entity_type", "cleanroom_target_name", "primary_builtins_or_symbols", "feature_guards", "cleanroom_implementation_spec"])
        w.writerows(out_rows)

    with open(OUT_MD, "w", encoding="utf-8") as f:
        f.write("# STDLIB_CLEANROOM_COMPLETE_MAP — MSL 標準ライブラリ (`metal_stdlib` / `lib*rt`) クリーンルーム完全対応仕様\n\n")
        f.write(f"> **2026-07-21 生成確定**: Apple 公式参照ツリー (`reference/clang/32023.883/`) に収録される **全 {header_cnt} ヘッダモジュール** および **全 {lib_cnt} 事前コンパイルライブラリモジュール** (計 {len(out_rows)} エントリ) のクリーンルーム自前実装・コンテナ化完全対応表。\n\n")
        f.write("## 1. モジュール種別内訳と実装戦略サマリー\n\n")
        f.write(f"- **ヘッダモジュール (`.metal` / `.h`) — 全 {header_cnt} 件**:\n")
        f.write("  `simd/simd.h` -> `simd.metal`、`metal_stdlib`、`metal_graphics`、`metal_raytracing`、`metal_tensor` 等。全てクリーンルーム実装においてはインライン C++/MSL ヘッダとして実装され、`builtin_to_air_map.v2.csv` の `__metal_*` 関数を直接 wrap する。\n")
        f.write(f"- **事前コンパイルライブラリ (`.metallib` / `.rtlib`) — 全 {lib_cnt} 件**:\n")
        f.write("  `libair_rt_*.rtlib` -> `libair_rt.metallib`、`libtracepoint_rt_*.metallib` -> `libtracepoint_rt.metallib`、`MTLRaytracingRuntime.rtlib` -> `MTLRaytracingRuntime.metallib` 等。これらは自前コンテナ生成器 (`write_metallib.py`) により各ターゲット OS プラットフォーム向けの Slice としてコンパイルされ提供される。\n\n")
        f.write("## 2. 主要モジュール別クリーンルーム対応表 (`data/stdlib_cleanroom_complete_map.csv`)\n\n")
        f.write("| 原本パス (`entity_path`) | 種別 | クリーンルーム置換名 | 主な機能ガード | クリーンルーム実装仕様 |\n")
        f.write("|---|---|---|---|---|\n")
        for row in out_rows[:35]:
            p = row[0].replace("reference/clang/32023.883/", "")
            g = row[4].split(";")[:2]
            g_str = " / ".join([x.replace("__HAVE_", "").replace("__", "") for x in g]) if g != ["None (Unconditional)"] else "-"
            f.write(f"| `{p}` | `{row[1].split(' ')[0]}` | `{row[2]}` | `{g_str}` | {row[5]} |\n")
        f.write(f"\n*(全 {len(out_rows)} 件の完全一覧は `data/stdlib_cleanroom_complete_map.csv` を参照)*\n")

    print(f"✅ Generated {OUT_CSV} ({len(out_rows)} rows: {header_cnt} headers, {lib_cnt} libs) and {OUT_MD}")

if __name__ == '__main__':
    main()
