#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""MSL 仕様書 PDF (抽出テキスト) からの情報採掘"""
import csv, re, collections, os

SPEC = "/home/user/metal-info-set/work/spec/msl4.1.txt"
OUT = "/home/user/metal-info-set/data"
os.makedirs(OUT, exist_ok=True)
txt = open(SPEC, errors="replace").read()
lines = txt.splitlines()

# ---- 1. [[attribute]] 全量 (使用例と出現回数)
rx_attr = re.compile(r"\[\[\s*([a-z_][a-z0-9_]*)(?:\s*\(([^]]*)\))?\s*\]\]")
attrs = collections.defaultdict(lambda: {"n": 0, "examples": set(), "pages": set()})
page = 0
for ln in lines:
    m = re.match(r"<<<PAGE (\d+)>>>", ln)
    if m: page = int(m.group(1))
    for mm in rx_attr.finditer(ln):
        name, arg = mm.group(1), (mm.group(2) or "").strip()[:60]
        a = attrs[name]; a["n"] += 1; a["pages"].add(page)
        if len(a["examples"]) < 3 and arg: a["examples"].add(arg)
with open(f"{OUT}/spec_attributes.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["attribute", "occurrences", "first_page", "arg_examples"])
    for name, a in sorted(attrs.items()):
        w.writerow([name, a["n"], min(a["pages"]), " | ".join(sorted(a["examples"]))])
print("attributes:", len(attrs))

# ---- 2. 制約・コンパイラオプション・アドレス空間の本文スナップショット
def grab(start_pat, end_pat):
    """パターン間の本文を取得"""
    s = txt.find(start_pat); e = txt.find(end_pat, s + 1) if s >= 0 else -1
    if s < 0 or e < 0: return ""
    return txt[s:e]

snaps = {
    "1.5.4_restrictions": grab("1.5.4 Restrictions", "1.5.5"),
    "1.6_compiler_options_intro": grab("1.6 Compiler Options", "1.6.1"),
    "1.6.1_math_intrinsics": grab("1.6.1 Compiler Options for Math Intrinsics", "1.6.2"),
    "1.6.2_optimization": grab("1.6.2 Compiler Options for Controlling Optimization", "1.6.3"),
    "4_address_spaces": grab("4 Address Spaces", "4.1 Device"),
}
with open(f"{OUT}/spec_key_sections.md", "w") as f:
    f.write("# MSL 4.1 仕様書 主要セクション抜粋 (一次情報)\n\n")
    for k, v in snaps.items():
        f.write(f"## {k}\n\n```\n{v.strip()[:4000]}\n```\n\n")
print("sections:", [k for k, v in snaps.items() if v])

# ---- 3. 組込変数/属性の参照表 (Table 5.2〜5.13 の表題行を索引化)
tables = []
for i, ln in enumerate(lines):
    m = re.match(r"(Table \d+\.\d+)\.\s+(Attributes for .+|.+Data Types|.+functions? .*|Memory flag .+)", ln.strip())
    if m: tables.append((m.group(1), m.group(2).strip()))
with open(f"{OUT}/spec_table_index.csv", "w", newline="") as f:
    w = csv.writer(f); w.writerow(["table", "caption"]); w.writerows(tables)
print("tables indexed:", len(tables))

# ---- 4. OS availability 表記の走査
osmarks = collections.Counter(re.findall(r"(All OS|macOS [0-9.]+|iOS [0-9.]+|iPadOS [0-9.]+|tvOS [0-9.]+|watchOS [0-9.]+|visionOS [0-9.]+)", txt) for _ in [0])
with open(f"{OUT}/spec_os_availability_forms.csv", "w", newline="") as f:
    w = csv.writer(f); w.writerow(["form", "count"])
    for k, n in osmarks.most_common(): w.writerow([k, n])
print("os availability forms:", dict(osmarks))
