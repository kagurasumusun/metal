#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_callgraph.py — airlib (純正 GPU ランタイム bitcode 全量) のコールグラフを再構築する器。

目的 (前回セッションで喪失した抽出木の再建 + リッチ化):
  1. 全ユニット (32 ar アーカイブ + fat コンテナ + 10 metallib) を開き
  2. モジュール SHA-1 で重複排除した unique モジュール群について
  3. llvmlite で定義関数 → call 命令 → callee を全走査しエッジ化
  4. `__air_impl_*` (rtlib 公開実装) → `air.*` 直接呼出を別表化
     (promote_map.py ingest-callgraph が対応表の補助証拠として join する)

出力:
  data/callgraph_edges.csv         (archive, member, caller, callee) 全 call エッジ
  data/callgraph_air_impl.csv      (__air_impl_X → air.* 直接呼出の一覧)
  data/callgraph_summary.md        (再生物語: 件数・impl/member 対応検証・例)

設計: units 抽出は dump_ir_all_os.py と同一ロジック (C-4 実証済)。
      callee は call 命令の最終オペランド (bitcast 透過後の関数名)。
      idempotent: 同じ入力から同じ CSV を再生成できる (喪失耐性 = 生成器が信頼の起点)。
"""
import csv
import hashlib
import os
import re
import struct
import subprocess
import sys
import collections

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

import llvmlite.binding as llvm

LIB = "/home/user/metal-repo/reference/clang/32023.883/lib/darwin"
WORK = os.path.join(S.ROOT, "work", "ir_all")   # dump_ir_all_os.py と展開先を共用


def unwrap(blob: bytes):
    if blob[:4] == b"\xde\xc0\x17\x0b":
        _, _, off, size, _ = struct.unpack("<5I", blob[:20])
        return blob[off:off + size]
    if blob[:4] == b"BC\xc0\xde":
        return blob
    return None


def os_of(filename: str) -> str:
    m = re.search(r"_(iosmac|iossim|tvossim|watchossim|xrossim|xros|ios|tvos|watchos|osx)(?:[._]|\.a$|\.rtlib$|\.metallib$|_fast)",
                  filename)
    return m.group(1) if m else "?"


def collect_units():
    """dump_ir_all_os.py と同一の抽出 (ar メンバー + fat/裸MTLB スライス)。"""
    units = []  # (unit_id, archive, os, member, bc)

    def add_fat(fn, blob, tag):
        if blob[:4] == b"MTLB":
            slices = [(0, 0, 0, len(blob))]
        elif blob[:4] == b"\xcb\xfe\xba\xbe":
            ns = struct.unpack_from(">I", blob, 4)[0]
            slices = []
            for s in range(ns):
                _, subtype, off, size, _ = struct.unpack_from(">5I", blob, 8 + s * 20)
                slices.append((s, subtype, off, size))
        else:
            print("  unknown container:", fn, blob[:4].hex())
            return
        for s, subtype, off, size in slices:
            slc = blob[off:off + size] if blob[:4] != b"MTLB" else blob
            for m in re.finditer(rb"\xde\xc0\x17\x0b", slc):
                bc = unwrap(slc[m.start():])
                if bc:
                    units.append((f"{fn}#{tag}{s}(st{subtype})", fn, os_of(fn),
                                  f"slice{s}@{m.start()}", bc))

    for fn in sorted(os.listdir(LIB)):
        if not fn.endswith((".rtlib", ".a")):
            continue
        path = os.path.join(LIB, fn)
        blob = open(path, "rb").read()
        if blob[:4] == b"\xcb\xfe\xba\xbe":          # 拡張子 .a だが fat
            add_fat(fn, blob, "fat")
            continue
        d = os.path.join(WORK, fn)
        os.makedirs(d, exist_ok=True)
        r = subprocess.run(["ar", "x", path], cwd=d, capture_output=True)
        if r.returncode != 0:
            print("  skip (ar fail):", fn)
            continue
        for mem in sorted(os.listdir(d)):
            bc = unwrap(open(os.path.join(d, mem), "rb").read())
            if bc:
                units.append((fn, fn, os_of(fn), mem, bc))
    for fn in sorted(os.listdir(LIB)):
        if fn.endswith(".metallib"):
            add_fat(fn, open(os.path.join(LIB, fn), "rb").read(), "slice")
    return units


def main():
    units = collect_units()
    print(f"units: {len(units)}")

    # モジュール内容ハッシュで重複排除 (unique のみ parse)
    seen: dict[str, dict] = {}
    ordered = []
    for unit_id, arc, osn, mem, bc in units:
        h = hashlib.sha1(bc).hexdigest()[:16]
        if h not in seen:
            seen[h] = {"unit_id": unit_id, "arc": arc, "os": osn, "mem": mem, "bc": bc}
            ordered.append(h)
    print(f"unique modules: {len(ordered)}")

    edges = []          # (archive, member, caller, callee)
    air_impl = collections.defaultdict(set)   # __air_impl_X → {air.callee}
    member_impl_defs = collections.defaultdict(set)  # member → {__air_impl_X defined}
    errors = []
    n_calls = 0
    for i, h in enumerate(ordered):
        rec = seen[h]
        if i % 250 == 0:
            print(f" ... {i}/{len(ordered)}")
        try:
            mod = llvm.parse_bitcode(rec["bc"])
        except Exception as e:
            errors.append((rec["unit_id"], str(e)[:150]))
            continue
        for f in mod.functions:
            if f.is_declaration:
                continue
            fname = f.name or ""
            if fname.startswith("__air_impl_"):
                member_impl_defs[rec["mem"]].add(fname)
            for b in f.blocks:
                for ins in b.instructions:
                    if ins.opcode != "call":
                        continue
                    ops = list(ins.operands)
                    if not ops:
                        continue
                    callee = ops[-1]
                    cname = callee.name or ""
                    if not cname:
                        continue
                    n_calls += 1
                    edges.append((rec["arc"], rec["mem"], fname, cname))
                    if fname.startswith("__air_impl_") and cname.startswith("air."):
                        air_impl[fname].add(cname)

    out_edges = os.path.join(S.DATA, "callgraph_edges.csv")
    with open(out_edges, "w", newline="", encoding="utf-8") as fo:
        w = csv.writer(fo)
        w.writerow(["archive", "member", "caller", "callee"])
        for arc, mem, caller, callee in edges:
            w.writerow([arc, mem, caller, callee])

    out_impl = os.path.join(S.DATA, "callgraph_air_impl.csv")
    with open(out_impl, "w", newline="", encoding="utf-8") as fo:
        w = csv.writer(fo)
        w.writerow(["air_impl_symbol", "air_callee", "n_variants_note"])
        for sym in sorted(air_impl):
            for callee in sorted(air_impl[sym]):
                w.writerow([sym, callee, ""])

    # pairing 検証 (2026-07-21 修正版):
    # rtlib_pairing の impl_object (=__loweringlib.internal.N) は「ar メンバー名」ではなく
    # **関数名**であることがエッジ解析で判明 (初回版は member 名前提の誤検証だった)。
    # 正しい検証 = 「__air_impl_X (公開) → __loweringlib.internal.N (内部実装)」の
    # 直接呼出エッジが存在するか。
    pair_note = []
    p = os.path.join(S.DATA, "rtlib_pairing.csv")
    if os.path.exists(p):
        edge_set = {(c, l) for _a, _m, c, l in edges}
        with open(p, newline="", encoding="utf-8") as f:
            pairs = list(csv.DictReader(f))
        ok = miss = 0
        misses = []
        for r in pairs:
            obj = r["impl_object"].strip()
            if obj.startswith("(no_impl"):
                continue
            syms = [s.strip() for s in r["public_symbols_before_next_impl"].split(";") if s.strip()]
            hits = [s for s in syms if (s, obj) in edge_set]
            if hits:
                ok += 1
            else:
                miss += 1
                misses.append(f"  - {r['archive']}!{obj}: 公開 {syms[:2]}… 直接エッジ無し")
        pair_note.append(
            f"- pairing 行 {len(pairs)} 件 (no_impl 除く): 直接 call エッジ確認 {ok} 件 / 未確認 {miss} 件"
        )
        pair_note.append("- 未確認は 2-hop 以上 (別 internal 経由) か pairing のarchive非対応 (osxのみ検証対象外) の可能性。一覧:")
        pair_note.extend(misses[:12])

    callee_air = {c for *_x, c in edges if c.startswith("air.")}
    summ = [
        "# callgraph 再構築サマリ", "",
        f"生成: {S.utcnow()} by build_callgraph.py@{S.SCRIPT_VERSION}", "",
        f"- 入力: `{LIB}` ({len(units)} units → unique modules {len(ordered)})",
        f"- 総 call エッジ: {len(edges)} (callee 名解決 {n_calls})",
        f"- air.* callee (unique 名): {len(callee_air)}",
        f"- `__air_impl_*` → air.* 直接呼出のある公開実装: {len(air_impl)} 件",
        f"- parse エラー: {len(errors)}",
        "",
        "## 例 (impl → air)", "",
    ]
    for sym in sorted(air_impl)[:15]:
        summ.append(f"- `{sym}` → {sorted(air_impl[sym])[:4]}")
    summ += ["", "## rtlib_pairing との整合検証", ""] + pair_note
    if errors:
        summ += ["", "## parse エラー (最大5件)", ""] + [f"- {u}: {e}" for u, e in errors[:5]]
    with open(os.path.join(S.DATA, "callgraph_summary.md"), "w", encoding="utf-8") as fo:
        fo.write("\n".join(summ) + "\n")

    S.log_event("CALLGRAPH", f"build_callgraph.py@{S.SCRIPT_VERSION}",
                "data/callgraph_edges.csv 他",
                f"units={len(units)} unique={len(ordered)} edges={len(edges)} "
                f"air_impl={len(air_impl)} errors={len(errors)}")
    print(f"\nedges={len(edges)} air_callee_names={len(callee_air)} "
          f"air_impl={len(air_impl)} errors={len(errors)}")
    print("wrote", out_edges, ",", out_impl)


if __name__ == "__main__":
    main()
