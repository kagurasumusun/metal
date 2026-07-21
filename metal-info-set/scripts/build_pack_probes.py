#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_pack_probes.py — pack/unpack 系 builtin の extern-C wrapper probe を機械生成。

一次情報: metal_pixel 1050-1460 行 (ヘッダ実シグネチャ)。
  _pixel_type_traits<_TAG>::pack(T data) / unpack(storage data) が
  __metal_pack_* / __metal_unpack_* を直接呼ぶ構造。
probe 戦略: 公開テンプレ `_pixel_type<T, _TAG_tag>` を保持する wrapper を
extern "C" で包む。T は storage を具体化するため float/half 系で与える:
  pack 側:  `extern "C" <storage> sym(T a) { return <pkg<T>>::pack(a); }`
  unpack側: `extern "C" T sym(<storage> a) { return <pkg<T>>::unpack(a); }`
T は _is_pixel_type<tag, T> で許されるベクトル型 (ヘッダ _is_pixel_type 宣言から機械採取)。

対象 builtin 20 件:
  pack_snorm1x16/1x8/2x8/4x16, pack_unorm1x16/1x8/2x8/4x16,
  pack_unorm_rg11b10f/rgb9e5 および unpack 対応。
scene: probe_scenes_methods/scene_P09F_pack/probe.metal, MANIFEST_pack.csv
"""
import csv
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

OUT_DIR = os.path.join(S.ROOT, "probe_scenes_methods")
METAL_PIXEL = "/home/user/metal-repo/reference/clang/32023.883/include/metal/metal_pixel"

# tag -> (builtin_suffix_pack, builtin_suffix_unpack, storage, value_T)
# 一次情報: metal_pixel _pixel_type_traits / 一次 builtin 呼出行をソース解析で抽出する
def mine_traits():
    src = open(METAL_PIXEL, encoding="utf-8").read()
    out = {}
    # 各 traits struct ブロックを抽出
    for m in re.finditer(
            r"struct _pixel_type_traits<(_\w+_tag)>\s*\{(.*?)\n\};", src, re.S):
        tag, body = m.group(1), m.group(2)
        sm = re.search(r"typedef\s+(\w+)\s+METAL_ALIGN\(\d+\)\s+storage_type", body)
        pm = re.search(r"return __metal_(pack_\w+)\(data\)", body)
        um = re.search(r"return __metal_(unpack_\w+)\(data, T\(\)\)", body)
        if not (sm and pm and um):
            continue
        out[tag] = {"storage": sm.group(1), "pack": pm.group(1), "unpack": um.group(1)}
    # 許容 T 一覧 (_is_pixel_type<tag, T>)
    allowed = {}
    for m in re.finditer(r"struct _is_pixel_type<(_\w+_tag),\s*(\w+)>", src):
        allowed.setdefault(m.group(1), []).append(m.group(2))
    # using alias 名
    aliases = {}
    for m in re.finditer(r"using (\w+)\s*=\s*_pixel_type<T,\s*(_\w+_tag)>", src):
        aliases[m.group(2)] = m.group(1)
    return out, allowed, aliases


def main():
    rows = S.read_v2()
    targets = {r["__metal_builtin"] for r in rows
               if re.match(r"^__metal_(un)?pack_", r["__metal_builtin"])
               and r["confidence"] != "confirmed"}
    traits, allowed, aliases = mine_traits()
    blocks, manifest, coverage = [], [], []
    idx = 0
    for tag, tr in sorted(traits.items()):
        alias = aliases.get(tag)
        if not alias:
            continue
        ts = allowed.get(tag, ["float4", "half4"])
        t = ts[0]  # 先頭の _is_pixel_type 許容ベクトル (実ヘッダ一次情報)
        for kind in ("pack", "unpack"):
            b = f"__metal_{tr[kind]}"
            if b not in targets:
                continue
            sym = f"probe_p09f_{kind}_{idx}"
            idx += 1
            if kind == "pack":
                core = (f"// builtin={b} cls=pixel_traits tag={tag}\n"
                        f'extern "C" {tr["storage"]} {sym}({t} a) '
                        f'{{ return _pixel_type_traits<{tag}>::pack(a); }}\n')
            else:
                core = (f"// builtin={b} cls=pixel_traits tag={tag}\n"
                        # run10 一次診断: traits unpack は template 明示必須 `unpack<T>(storage)`
                        f'extern "C" {t} {sym}({tr["storage"]} a) '
                        f'{{ return _pixel_type_traits<{tag}>::unpack<{t}>(a); }}\n')
            blocks.append(core)
            manifest.append({"scene": "P09F", "file": "probe.metal", "symbol": sym,
                             "builtin": b, "stage1_source": "auto_pack_traits"})
            coverage.append({"builtin": b, "status": "generated", "class": tag})
    os.makedirs(OUT_DIR, exist_ok=True)
    d = os.path.join(OUT_DIR, "scene_P09F_pack")
    os.makedirs(d, exist_ok=True)
    header = (f"// scene P09F: pack/unpack builtin wrapper (build_pack_probes.py@{S.SCRIPT_VERSION})\n"
              f"// 一次情報: metal_pixel _pixel_type_traits (pack/unpack 直通) + _is_pixel_type 許容 T\n"
              "#include <metal_stdlib>\n#include <metal_pixel>\nusing namespace metal;\n\n")
    with open(os.path.join(d, "probe.metal"), "w", encoding="utf-8") as f:
        f.write(header + "\n".join(blocks))
    with open(os.path.join(OUT_DIR, "MANIFEST_pack.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["scene", "file", "symbol", "builtin", "stage1_source"])
        w.writeheader()
        w.writerows(manifest)
    with open(os.path.join(S.DATA, "pack_probe_coverage.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["builtin", "status", "class"])
        w.writeheader()
        w.writerows(coverage)
    print(f"wrote {d} ({len(blocks)} blocks), manifest {len(manifest)} 件; "
          f"targets 未消化 {sorted(targets - {m['builtin'] for m in manifest})}")


if __name__ == "__main__":
    main()
