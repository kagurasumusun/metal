#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""extract_pixel_format_map.py — metal_pixel 一次情報から PIXEL_FORMAT_MAP.md を機械生成。"""
import re
import os
import sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

SRC = "/home/user/metal-repo/reference/clang/32023.883/include/metal/metal_pixel"
OUT = os.path.join(S.DOCS, "PIXEL_FORMAT_MAP.md")


def main():
    src = open(SRC, encoding="utf-8").read()
    traits = {}
    for m in re.finditer(r"struct _pixel_type_traits<(_\w+_tag)>\s*\{(.*?)\n\};", src, re.S):
        tag, body = m.group(1), m.group(2)
        storage = re.search(r"typedef\s+(\w+)\s+METAL_ALIGN\((\d+)\)\s+storage_type", body)
        pack = re.search(r"return __metal_(pack_\w+)\(data\)", body)
        unpack = re.search(r"return __metal_(unpack_\w+)\(data, T\(\)\)", body)
        traits[tag] = {"storage": f"{storage.group(1)} METAL_ALIGN({storage.group(2)})" if storage else "",
                       "pack": pack.group(1) if pack else "",
                       "unpack": unpack.group(1) if unpack else ""}
    allowed = {}
    for m in re.finditer(r"struct _is_pixel_type<(_\w+_tag),\s*(\w+)>", src):
        allowed.setdefault(m.group(1), []).append(m.group(2))
    aliases = {}
    for m in re.finditer(r"using (\w+)\s*=\s*_pixel_type<T,\s*(_\w+_tag)>", src):
        aliases[m.group(2)] = m.group(1)
    out = ["# MSL pixel データ形式対応表 (metal_pixel 一次情報機械抽出)", ""]
    out.append("| alias (metal::) | tag | storage (METAL_ALIGN) | 許容 T (_is_pixel_type) | pack builtin | unpack builtin |")
    out.append("|---|---|---|---|---|---|")
    for tag, tr in traits.items():
        out.append(f"| {aliases.get(tag,'')} | {tag} | {tr['storage']} | "
                   f"{', '.join(allowed.get(tag,[]))} | __metal_{tr['pack']} | __metal_{tr['unpack']} |")
    with open(OUT, "w", encoding="utf-8") as f:
        f.write("\n".join(out) + "\n")
    print(f"wrote {OUT} ({len(traits)} formats)")
    S.log_event("DOC_GENERATE", "kagurasumusun", "docs/PIXEL_FORMAT_MAP.md",
                f"metal_pixel 一次情報機械抽出で pixel 形式対応表生成 ({len(traits)} formats)")


if __name__ == "__main__":
    main()
