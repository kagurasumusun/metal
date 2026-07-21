#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_rtlib_layer.py — callgraph 一次情報から __metal_* → rtlib (L4) 層辞書を作る器。

背景 (2026-07-21 実証): builtin の中には AIR intrinsic に lowering されず、
GPUCompiler の device lowering がリンクするランタイム実装 `__air_impl_<base>_type`
の呼出になる層 (L4) がある (例: __metal_nextafter* 24 個, __metal_os_log)。
v1 対応表はこれらに `air.nextafter*` のような**偽の intrinsic 候補**を付けていた;

本器は callgraph_edges.csv から `__air_impl_*` 実装関数を列挙し、
公開 API 語彙 (msl_stage1_api_to_builtin.csv) 経由で __metal_* に逆引きして
その事実関係のみを辞書化する (推測で接続しない: base 名一致のみ)。

出力: data/rtlib_layer_map.csv
  air_impl_symbol, impl_base, metal_builtin, msl_api_example,
  impl_calls_air_direct, impl_calls_air_2hop
"""
import csv
import os
import re
import sys
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

# AIR 型 suffix の剥がし方: _f32, _v2f16, _v16bf16, _i32, _bf16 ... の繰返し
_RE_TYSUF = re.compile(r"(_(v\d+)?(bf|f|i|u|h)\d+)+$")


def impl_base(name: str) -> str:
    return _RE_TYSUF.sub("", name[len("__air_impl_"):])


def main():
    edges = list(csv.DictReader(open(os.path.join(S.DATA, "callgraph_edges.csv"))))
    by_caller = defaultdict(set)
    for e in edges:
        by_caller[e["caller"]].add(e["callee"])

    impls = sorted(c for c in by_caller if c.startswith("__air_impl_"))
    # __metal 逆引き: 公開 API 語彙経由 + ベース名直接
    msl_api = {}
    p = os.path.join(S.DATA, "msl_stage1_api_to_builtin.csv")
    api_example = defaultdict(list)
    with open(p, newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            b = r["metal_builtins"].strip()
            if b:
                api_example[b].append(r["msl_api_signature"].strip())

    builtins = {r["__metal_builtin"] for r in
                csv.DictReader(open(S.MAP_V2, newline="", encoding="utf-8"))}

    rows = []
    unmatched = []
    for impl in impls:
        base = impl_base(impl)
        builtin = "__metal_" + base
        direct = sorted(c for c in by_caller[impl] if c.startswith("air."))
        twohop = set()
        for mid in by_caller[impl]:
            if not mid.startswith("air."):
                for leaf in by_caller.get(mid, ()):  # 2-hop
                    if leaf.startswith("air."):
                        twohop.add(leaf)
        if builtin not in builtins:
            unmatched.append((impl, builtin))
            continue
        rows.append({
            "air_impl_symbol": impl,
            "impl_base": base,
            "metal_builtin": builtin,
            "msl_api_example": " | ".join(api_example.get(builtin, [])[:3]),
            "impl_calls_air_direct": ";".join(direct),
            "impl_calls_air_2hop": ";".join(sorted(twohop)),
        })

    out = os.path.join(S.DATA, "rtlib_layer_map.csv")
    with open(out, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()) if rows else
                           ["air_impl_symbol", "impl_base", "metal_builtin",
                            "msl_api_example", "impl_calls_air_direct",
                            "impl_calls_air_2hop"])
        w.writeheader()
        w.writerows(rows)

    S.log_event("RTLIB_LAYER", f"build_rtlib_layer.py@{S.SCRIPT_VERSION}", out,
                f"__air_impl_* {len(impls)} 関数 → __metal 逆引き {len(rows)} 件"
                f" (base 一致のみ)。未接続 {len(unmatched)} 件: "
                f"{[u[1] for u in unmatched][:6]}…")
    print(f"wrote {out}: rows={len(rows)} unmatched={len(unmatched)}")
    for u in unmatched:
        print("  unmatched:", u)


if __name__ == "__main__":
    main()
