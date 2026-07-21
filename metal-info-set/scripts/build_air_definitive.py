#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""ir_air_signatures.csv (実シグネチャ) で builtin_to_air_map を昇格 +air op 確定表を生成"""
import csv, re, collections

OUT = "/home/user/metal-info-set/data"

# 1) IR 実測の air op stem 集合 (関数名部分から型suffixを剥がす)
def stem_of_fn(fn):
    """air.abs.s.v16i16 → air.abs.s / air.convert……rtp → air.convert.f.u"""
    out = []
    for s in fn.split("."):
        if re.fullmatch(r"rt[zpen]", s): continue
        if re.fullmatch(r"(p\d+)?v?\d*[fibuh]\d+", s): continue
        out.append(s)
    return ".".join(out)

decl_stems = {}   # stem -> [full declares]
name_rx = re.compile(r"@((?:air|llvm)\.[A-Za-z0-9._]+)\(")
for r in csv.DictReader(open(f"{OUT}/ir_air_signatures.csv")):
    sig = r["air_intrinsic_declare"]
    m = name_rx.search(sig)
    if not m: continue
    decl_stems.setdefault(stem_of_fn(m.group(1)), []).append(sig)

with open(f"{OUT}/air_ops_definitive.csv", "w", newline="") as f:
    w = csv.writer(f); w.writerow(["air_op_stem", "n_declares", "example_declare"])
    for s, l in sorted(decl_stems.items()): w.writerow([s, len(l), l[0][:300]])
print("definitive air op stems:", len(decl_stems))

# 2) builtin_to_air_map 昇格: 候補 stem が IR declares にあるか
rows = list(csv.reader(open(f"{OUT}/builtin_to_air_map_old.csv"))) if __import__("os").path.exists(f"{OUT}/builtin_to_air_map_old.csv") else None
if rows is None:
    import shutil; shutil.copy(f"{OUT}/builtin_to_air_map.csv", f"{OUT}/builtin_to_air_map_old.csv")
    rows = list(csv.reader(open(f"{OUT}/builtin_to_air_map_old.csv")))
hdr, body = rows[0], rows[1:]
up = 0
for r in body:
    cand = r[3]
    st = stem_of_fn(cand)
    if st in decl_stems:
        if r[4] != "observed_ir":
            r[4] = "observed_ir"
            r[5] = "✅AIR実シグネチャをIR解析で確認"
            r[3] = sorted(decl_stems[st], key=len)[0].split("(")[0].split("@")[-1]
            up += 1
with open(f"{OUT}/builtin_to_air_map.csv", "w", newline="") as f:
    w = csv.writer(f); w.writerow(hdr); w.writerows(body)
ev = collections.Counter(r[4] for r in body)
print("upgraded:", up, "→", dict(ev))
