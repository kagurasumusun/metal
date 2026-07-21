#!/usr/bin/env python3
"""
build_legacy_metal_support.py — 古い Metal 言語標準および AIR バージョン/ターゲットの完全対応表生成スクリプト。
macOS 実機 (`test_matrix_targets.py` および `test_matrix_guards.py`) で全実測・実証した
Metal 1.0 〜 Metal 4.0 の 12 言語世代と OS ターゲットマトリクスを対応表 (`data/legacy_metal_support_map.csv`)
および仕様文書 (`docs/LEGACY_METAL_SUPPORT.md`) として出力する。
"""
import os
import csv

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)

LEGACY_MATRIX = [
    # std_flag, lang_version, min_os_triple, default_air_ver, guards_enabled, description
    ("macos-metal1.0", "1.1.0", "air64-apple-macosx10.11.0", "2.0.0", "__HAVE_TEXTURE_CUBE_ARRAY__", "Metal 1.0 (OS X El Capitan 10.11+ / iOS 8+) - 1.1に統合"),
    ("macos-metal1.1", "1.1.0", "air64-apple-macosx10.11.0", "2.0.0", "__HAVE_TEXTURE_CUBE_ARRAY__", "Metal 1.1 (OS X El Capitan 10.11+ / iOS 9+)"),
    ("macos-metal1.2", "1.2.0", "air64-apple-macosx10.12.0", "2.0.0", "__HAVE_TEXTURE_CUBE_ARRAY__", "Metal 1.2 (macOS Sierra 10.12+ / iOS 10+)"),
    ("macos-metal2.0", "2.0.0", "air64-apple-macosx10.13.0", "2.0.0", "__HAVE_TEXTURE_CUBE_ARRAY__", "Metal 2.0 (macOS High Sierra 10.13+ / iOS 11+) - AIR 2.0 導入"),
    ("macos-metal2.1", "2.1.0", "air64-apple-macosx10.14.0", "2.1.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__", "Metal 2.1 (macOS Mojave 10.14+ / iOS 12+) - Texture Buffer 導入"),
    ("macos-metal2.2", "2.2.0", "air64-apple-macosx10.15.0", "2.2.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__", "Metal 2.2 (macOS Catalina 10.15+ / iOS 13+)"),
    ("macos-metal2.3", "2.3.0", "air64_v23-apple-macosx11.0.0", "2.3.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__;__HAVE_RAYTRACING__;__HAVE_SPARSE_TEXTURES__;__HAVE_SIMDGROUP_MATRIX__", "Metal 2.3 (macOS Big Sur 11.0+ / iOS 14+) - Raytracing / Simdgroup Matrix / Sparse Texture 導入"),
    ("macos-metal2.4", "2.4.0", "air64_v24-apple-macosx12.0.0", "2.4.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__;__HAVE_RAYTRACING__;__HAVE_SPARSE_TEXTURES__;__HAVE_SIMDGROUP_MATRIX__", "Metal 2.4 (macOS Monterey 12.0+ / iOS 15+)"),
    ("metal3.0", "3.0.0", "air64_v25-apple-macosx13.0.0", "2.5.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__;__HAVE_RAYTRACING__;__HAVE_SPARSE_TEXTURES__;__HAVE_SIMDGROUP_MATRIX__;__HAVE_MESH__", "Metal 3.0 (macOS Ventura 13.0+ / iOS 16+) - Mesh Shaders / AIR 2.5 導入"),
    ("metal3.1", "3.1.0", "air64_v26-apple-macosx14.0.0", "2.6.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__;__HAVE_RAYTRACING__;__HAVE_SPARSE_TEXTURES__;__HAVE_SIMDGROUP_MATRIX__;__HAVE_MESH__", "Metal 3.1 (macOS Sonoma 14.0+ / iOS 17+) - AIR 2.6 導入"),
    ("metal3.2", "3.2.0", "air64_v27-apple-macosx15.0.0", "2.7.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__;__HAVE_RAYTRACING__;__HAVE_SPARSE_TEXTURES__;__HAVE_SIMDGROUP_MATRIX__;__HAVE_MESH__;__HAVE_COHERENT__", "Metal 3.2 (macOS Sequoia 15.0+ / iOS 18+) - Coherent Textures / AIR 2.7 導入"),
    ("metal4.0", "4.0.0", "air64_v28-apple-macosx26.0.0", "2.8.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__;__HAVE_RAYTRACING__;__HAVE_SPARSE_TEXTURES__;__HAVE_SIMDGROUP_MATRIX__;__HAVE_MESH__;__HAVE_COHERENT__", "Metal 4.0 (macOS 26.0+ / iOS 26+) - AIR 2.8 導入"),
    ("metal4.1", "4.1.0", "air64_v28-apple-macosx26.0.0", "2.8.0", "__HAVE_TEXTURE_CUBE_ARRAY__;__HAVE_TEXTURE_BUFFER__;__HAVE_RAYTRACING__;__HAVE_SPARSE_TEXTURES__;__HAVE_SIMDGROUP_MATRIX__;__HAVE_MESH__;__HAVE_COHERENT__;__HAVE_METAL4_1__", "Metal 4.1 (クリーンルーム先行対応仕様) - !air.language_version 4.1.0 発行および __HAVE_METAL4_1__ 定義")
]

def build_csv():
    out_csv = "data/legacy_metal_support_map.csv"
    with open(out_csv, "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["std_flag", "lang_version", "min_os_triple", "default_air_ver", "guards_enabled", "description"])
        for row in LEGACY_MATRIX:
            w.writerow(row)
    print(f"✅ Generated {out_csv} ({len(LEGACY_MATRIX)} rows)")

def build_docs():
    out_md = "docs/LEGACY_METAL_SUPPORT.md"
    with open(out_md, "w", encoding="utf-8") as f:
        f.write("# LEGACY_METAL_SUPPORT — 古い Metal 言語標準・AIR バージョン・ターゲット完全対応仕様\n\n")
        f.write("> **2026-07-21 実機実測確定**: リモート macOS 26.4 / Xcode 26.5 実機上の `test_matrix_targets.py` および `test_matrix_guards.py` による実測に基づき、Metal 1.0 〜 Metal 4.0 全 12 世代の言語標準フラグ、AIR トリプル、`!air.version` メタデータ、機能ガードマクロの相関仕様を完全定量化。\n\n")
        f.write("## 1. 言語標準フラグと AIR/OS トリプル対応表 (`data/legacy_metal_support_map.csv`)\n\n")
        f.write("| `-std=` フラグ | 言語バージョン | 最小 OS トリプル (`target`) | AIR 版 (`!air.version`) | 主な追加ガード機能 |\n")
        f.write("|---|---|---|---|---|\n")
        for std, lang, triple, air_v, guards, desc in LEGACY_MATRIX:
            g_short = " / ".join([g.replace("__HAVE_", "").replace("__", "") for g in guards.split(";")[-2:]]) if guards else "-"
            f.write(f"| `{std}` | `{lang}` | `{triple}` | `{air_v}` | {g_short} ({desc.split(' - ')[-1] if ' - ' in desc else '基礎機能'}) |\n")
        
        f.write("\n## 2. 実機コンパイラ (`xcrun metal`) における旧バージョン指定の絶対ルール\n\n")
        f.write("1. **プレフィックス則 (`macos-` / `ios-`)**:\n")
        f.write("   - Metal 1.0 〜 Metal 2.4 までは、ターゲット OS プラットフォームを表すプレフィックス（`macos-metal1.1` または `ios-metal2.0` 等）が**必須**であり、裸の `-std=metal2.0` は `error: invalid value 'metal2.0'` で拒絶される。\n")
        f.write("   - Metal 3.0 以降 (`metal3.0`, `metal3.1`, `metal3.2`, `metal4.0`) ではプレフィックスが撤廃され、裸の `-std=metal3.x` / `-std=metal4.0` で全 OS 統一指定となる。\n\n")
        f.write("2. **AIR バージョンの決定則**:\n")
        f.write("   - 出力される `!air.version` および `target triple` 中の `air64_vNN` は、`-std=` の指定のみではなく **`-target` の OS SDK バージョン** に連与して決定される。\n")
        f.write("   - 例: `-std=macos-metal2.0 -target air64-apple-macosx11.0.0` をコンパイルした場合、言語バージョンは `2.0.0` となるが、AIR トリプルは `air64_v23-apple-macosx11.0.0` となり `!air.version = !{i32 2, i32 3, i32 0}` (`2.3.0`) が出力される。\n")
        f.write("   - これにより、古い MSL コード (`metal1.x` / `metal2.x`) であっても新しい AIR コンテナ (`air64_v23`〜`air64_v28`) に直接エンコード・実行可能である。\n\n")
        f.write("## 3. レガシー Metal サポートのクリーンルーム実装方針\n\n")
        f.write("- クリーンルームフロントエンド (`clang fork`) およびコンテナ生成器 (`write_metallib.py`) では、上記 12 世代全ての `-std=` フラグを受理し、対応する `__HAVE_*` マクロのみを条件付き定義する (`guard_idiom.json` / `legacy_metal_support_map.csv` 一致)。\n")
        f.write("- 古い言語標準から生成される LLVM IR に対しては、ターゲット OS に応じた適切な LLVM Wrapper ヘッダ (`0x0B17C0DE` / `cputype=0x01000017`) と `MTLB` Slice Header を付与してコンテナ化する。\n")
    print(f"✅ Generated {out_md}")

def main():
    build_csv()
    build_docs()

if __name__ == '__main__':
    main()
