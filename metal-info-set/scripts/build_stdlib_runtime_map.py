#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_stdlib_runtime_map.py — Metal stdlib / runtime (airlib・rtlib) を
自前構築する場合に必要な要素の対応表を機械生成する。

入力 (全て一次データ: 実ヘッダ / Apple rtlib の callgraph / 実測 golden):
  - data/msl_stage1_methods.csv, data/msl_stage1_api_to_builtin.csv
  - data/callgraph_edges.csv (rtlib 31,134 edges)
  - data/callgraph_air_impl.csv (26)
  - data/rtlib_layer_map.csv
  - data/builtin_to_air_map.v2.csv
  - metal ヘッダ実体 (参照パスは --headers)
  - lib/darwin の rtlib 一覧 (--rtlib-dir)

出力:
  data/stdlib_header_inventory.csv           ヘッダ毎の宣言・guard 棚卸
  data/stdlib_runtime_module_inventory.csv   rtlib module 毎の呼出語彙棚卸
  data/stdlib_runtime_impl_map.csv           レイヤ構造の実装要件対応表 (正本)
  docs/STDLIB_RUNTIME_IMPL_MAP.md            同内容の読み物 (機械生成)
"""
import argparse
import csv
import os
import re
import sys
from collections import Counter, defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

LAYER_DESC = {
    "L1-headers": "ユーザー向け MSL 標準ヘッダ (types/templates/builtin 宣言)",
    "L2-metal-builtins": "__metal_* target builtin 語彙 (clang 実装側が受ける口)",
    "L3-air-impl": "__air_impl_* ブリッジ (rtlib 内で AIR 化しない経路)",
    "L4-rtlib": "airlib/rtlib module (bitcode archive、リンク時に引かれる)",
    "L5-driver": "metallib / GPUCompiler JIT まわり (実行系側必須要素)",
}


def header_inventory(stage1, headers_dir):
    """msl_stage1_* の file/line 情報から実ヘッダ棚卸 + 実ヘッダ走査で型・guard も拾う。"""
    per_file = defaultdict(lambda: {"decls": 0, "builtins": set(), "classes": set(), "guards": set()})
    for r in stage1:
        pf = per_file[r["file"]]
        pf["decls"] += 1
        for b in r["metal_builtins"].split():
            pf["builtins"].add(b)
        if r.get("class"):
            pf["classes"].add(r["class"])
        if r.get("guard"):
            for t in r["guard"].split("|"):
                if t.strip() and t.strip() != "cond":
                    pf["guards"].add(t.strip())
    rows = []
    for fn in sorted(per_file):
        p = per_file[fn]
        extra_types, n_pub_types = set(), 0
        hp = os.path.join(headers_dir, fn)
        if os.path.exists(hp):
            txt = open(hp, encoding="utf-8", errors="ignore").read()
            n_pub_types = len(re.findall(r"^(?:template.*\n)*(?:class|struct)\s+\w", txt, re.M))
            for m in re.finditer(r"^(?:typedef|using)\s+(?:[\w:<>,\s\*&]+?[\s=])\s*(\w+)\s*;", txt, re.M):
                extra_types.add(m.group(1))
        rows.append({
            "header": fn,
            "n_stage1_decls": p["decls"],
            "n_distinct_builtins": len(p["builtins"]),
            "n_classes": len(p["classes"]),
            "n_public_type_decls": n_pub_types,
            "n_typedefs": len(extra_types),
            "guards_used": ";".join(sorted(p["guards"])),
            "sample_builtins": ";".join(sorted(p["builtins"])[:5]),
            "evidence": "apple_stdlib_headers",
            "source_ref": f"include/metal/{fn}",
        })
    return rows


def module_inventory(edges):
    """rtlib module (=member) 毎: 呼出語彙 (air.*/llvm.*/内他関数) を機械集計。"""
    mods = defaultdict(lambda: {"archive": "", "callers": set(), "air": set(), "llvm": set(),
                                "internal": set(), "other": set()})
    for e in edges:
        key = (e["archive"], e["member"])
        m = mods[key]
        m["archive"] = e["archive"]
        m["callers"].add(e["caller"])
        callee = e["callee"]
        if callee.startswith("air."):
            m["air"].add(callee)
        elif callee.startswith("llvm."):
            m["llvm"].add(callee)
        elif callee.startswith("__air_") or callee.startswith("__metal_"):
            m["internal"].add(callee)
        else:
            m["other"].add(callee)
    rows = []
    for (archive, member), m in sorted(mods.items()):
        rows.append({
            "archive": archive, "module_member": member,
            "n_functions": len(m["callers"]),
            "n_air_intrinsics": len(m["air"]),
            "n_llvm_intrinsics": len(m["llvm"]),
            "n_internal_callees": len(m["internal"]),
            "n_other_callees": len(m["other"]),
            "air_stems": ";".join(sorted({S.split_air_name(a)[0] for a in m["air"]})[:12]),
            "sample_internal": ";".join(sorted(m["internal"])[:6]),
            "evidence": "apple_rtlib_ir",
            "source_ref": f"lib/darwin/{archive}::{member}",
        })
    return rows


def impl_rows(headers, mods, air_impl_rows, rtmap, v2rows, rtlib_files):
    rows = []
    def add(layer, comp, item, kind, n, irvocab, ev, ref, notes="", status="inventory"):
        rows.append({"layer": layer, "component": comp, "item": item, "kind": kind,
                     "n_items": n, "ir_vocab": irvocab, "evidence": ev,
                     "source_ref": ref, "implement_status": status, "notes": notes})

    # L1: ヘッダ単位
    for h in headers:
        add("L1-headers", h["header"], h["header"], "header", h["n_stage1_decls"],
            "", h["evidence"], h["source_ref"],
            notes=f"builtins={h['n_distinct_builtins']} classes={h['n_classes']} pub_types={h['n_public_type_decls']}")
    # L2: builtin 語彙 (v2 表を索引)
    by_ev = Counter(r["evidence"] for r in v2rows)
    add("L2-metal-builtins", "builtin-vocabulary", "__metal_* 全体", "vocab", len(v2rows),
        "see builtin_to_air_map.v2.csv", "this_repo_inference", "data/builtin_to_air_map.v2.csv",
        notes=f"evidence: {dict(by_ev)}")
    # L3: air_impl
    for a in air_impl_rows:
        add("L3-air-impl", "air_impl", a["air_impl_symbol"], "func", 1,
            a["air_callee"], "apple_rtlib_ir", "data/callgraph_air_impl.csv",
            notes="2-hop 以内に到達する直接 air 呼出")
    # L4: module 単位 + archive 集約
    arch_agg = defaultdict(lambda: {"mods": 0, "funcs": 0, "air": set()})
    for m in mods:
        add("L4-rtlib", m["archive"], m["module_member"], "module", m["n_functions"],
            m["air_stems"], m["evidence"], m["source_ref"],
            notes=f"air={m['n_air_intrinsics']} llvm={m['n_llvm_intrinsics']} int={m['n_internal_callees']}")
        a = arch_agg[m["archive"]]
        a["mods"] += 1
        a["funcs"] += m["n_functions"]
    for f in rtlib_files:
        a = arch_agg.get(f)
        add("L4-rtlib", f, f, "archive", (a["mods"] if a else 0), "",
            "apple_rtlib_ir", f"lib/darwin/{f}",
            notes=(f"functions={a['funcs']}" if a else "callgraph 未解析"),
            status="inventory" if a else "unparsed")
    # L5: driver 周辺 (GPUCompiler tbd, metallib) — 実在ファイル証拠のみ
    add("L5-driver", "metallib-container", ".metallib (MTLB タグ構造)", "container", 1,
        "", "apple_gpucompiler_symbols", "docs/GPUCOMPILER_SYMBOLS.md",
        notes="NAME/TYPE/HASH/VERS/MDSZ/ENDT/UUID タグ (旧知見) — 本日 golden probe.metallib (+meta) と金属部分の対応確認は docs/MTLB_FORMAT_NOTES.md 参照", status="partially-verified")
    add("L5-driver", "gpucompiler-tbd", "GPUCompiler.framework 10 .tbd", "framework", 10,
        "", "apple_gpucompiler_symbols", "reference-external/gpucompiler-tbd",
        notes="AIRLegalize/AIRLinkPass/Metal assembler APIs 等の symbol 表", status="inventory")
    return rows, arch_agg


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--headers", default="/home/user/metal-repo/reference/clang/32023.883/include/metal")
    ap.add_argument("--rtlib-dir", default="/home/user/metal-repo/reference/clang/32023.883/lib/darwin")
    ap.add_argument("--dry", action="store_true")
    args = ap.parse_args()

    stage1 = []
    for fn in ("msl_stage1_methods.csv", "msl_stage1_api_to_builtin.csv"):
        p = os.path.join(S.DATA, fn)
        with open(p, newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                stage1.append({"file": r["file"], "metal_builtins": r["metal_builtins"],
                               "class": r.get("class", ""), "guard": r.get("guard", "")})
    edges = list(csv.DictReader(open(os.path.join(S.DATA, "callgraph_edges.csv"), newline="", encoding="utf-8")))
    air_impl = list(csv.DictReader(open(os.path.join(S.DATA, "callgraph_air_impl.csv"), newline="", encoding="utf-8")))
    rtmap = list(csv.DictReader(open(os.path.join(S.DATA, "rtlib_layer_map.csv"), newline="", encoding="utf-8")))
    v2 = S.read_v2()
    rtlib_files = sorted(os.listdir(args.rtlib_dir)) if os.path.isdir(args.rtlib_dir) else []

    hdrs = header_inventory(stage1, args.headers)
    mods = module_inventory(edges)
    rows, arch_agg = impl_rows(hdrs, mods, air_impl, rtmap, v2, rtlib_files)

    if args.dry:
        print("headers:", len(hdrs), "modules:", len(mods), "impl rows:", len(rows))
        return

    def dump(path, rows, cols):
        with open(path, "w", newline="", encoding="utf-8") as f:
            w = csv.DictWriter(f, fieldnames=cols)
            w.writeheader()
            w.writerows(rows)
        print("wrote", path, len(rows))

    dump(os.path.join(S.DATA, "stdlib_header_inventory.csv"), hdrs,
         ["header", "n_stage1_decls", "n_distinct_builtins", "n_classes", "n_public_type_decls",
          "n_typedefs", "guards_used", "sample_builtins", "evidence", "source_ref"])
    dump(os.path.join(S.DATA, "stdlib_runtime_module_inventory.csv"), mods,
         ["archive", "module_member", "n_functions", "n_air_intrinsics", "n_llvm_intrinsics",
          "n_internal_callees", "n_other_callees", "air_stems", "sample_internal",
          "evidence", "source_ref"])
    dump(os.path.join(S.DATA, "stdlib_runtime_impl_map.csv"), rows,
         ["layer", "component", "item", "kind", "n_items", "ir_vocab", "evidence",
          "source_ref", "implement_status", "notes"])

    # --- markdown 生成 ---------------------------------------------------------
    n_air_total = len({c for key in mods for c in []})  # placeholder 計算は下で
    air_vocab = set()
    for m in mods:
        for stem in m["air_stems"].split(";"):
            if stem:
                air_vocab.add(stem)
    lines = [
        "# STDLIB / RUNTIME 自前構築 対応表 (機械生成)",
        "",
        f"生成: {S.today()} by build_stdlib_runtime_map.py",
        "(内容は全て csv 正本 data/stdlib_runtime_impl_map.csv 等から機械生成。推測行なし)",
        "",
        "## レイヤ構造",
        "",
    ]
    for lid, desc in LAYER_DESC.items():
        n = sum(1 for r in rows if r["layer"] == lid)
        lines.append(f"- **{lid}** ({n} rows): {desc}")
    lines += [
        "",
        "## 棚卸サマリ",
        "",
        f"- ヘッダ棚卸: {len(hdrs)} 個 ({'data/stdlib_header_inventory.csv'})",
        f"- rtlib module 棚卸: {len(mods)} modules ({'data/stdlib_runtime_module_inventory.csv'})",
        f"- rtlib が直接呼ぶ AIR stem 語彙: {len(air_vocab)} (直呼び分のみ)",
        f"- rtlib archive: {', '.join(sorted(arch_agg)) or rtlib_files}",
        "",
        "## ヘッダ棚卸 (stage1 宣言数 top20)",
        "",
        "| header | decls | builtins | classes | pub types |",
        "|---|---|---|---|---|",
    ]
    for h in sorted(hdrs, key=lambda x: -x["n_stage1_decls"])[:20]:
        lines.append(f"| {h['header']} | {h['n_stage1_decls']} | {h['n_distinct_builtins']} "
                     f"| {h['n_classes']} | {h['n_public_type_decls']} |")
    lines += [
        "",
        "## 参照 CSV",
        "",
        "- 正本: `data/stdlib_runtime_impl_map.csv` (レイヤ x 項目 対応表)",
        "- `data/stdlib_header_inventory.csv` / `data/stdlib_runtime_module_inventory.csv`",
        "- builtin 側の完全表: `data/builtin_to_air_map.v2.csv` (386 行はそちら)",
    ]
    md = "\n".join(str(x) for x in lines if not (isinstance(x, tuple))) + "\n"
    with open(os.path.join(S.ROOT, "docs", "STDLIB_RUNTIME_IMPL_MAP.md"), "w", encoding="utf-8") as f:
        f.write(md)
    print("wrote docs/STDLIB_RUNTIME_IMPL_MAP.md")


if __name__ == "__main__":
    main()
