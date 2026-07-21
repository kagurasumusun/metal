#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
全 Apple OS (ios/iosmac/iossim/osx/tvos/tvossim/watchos/watchossim/xros/xrossim) の
ランタイム bitcode + 全 metallib slices を逆アセンブルし、
モジュール内容ハッシュで重複排除した全 OS グランドトゥルースを作る。
出力:
  data/ir_all_os_index.csv        (module_hash, archive, member, triple, n_def, n_air_decl)
  data/ir_all_os_unique.csv       (module_hash, os_set, triple_set, n_def)
  data/ir_air_signatures.csv      (全 OS 集約: declare 全文, 出現OS数, 例)
  data/os_triple_map.csv          (os_name → 観測 triple 集合: デプロイメント対応の確定版)
"""
import csv, os, re, struct, subprocess, collections, hashlib
import llvmlite.binding as llvm

LIB = "/home/user/metal-repo/reference/clang/32023.883/lib/darwin"
OUT = "/home/user/metal-info-set/data"
WORK = "/home/user/metal-info-set/work/ir_all"

RX_DECLARE_AIR = re.compile(r"^(declare\s.*@(air\.[A-Za-z0-9._]+)\(.*)$", re.M)
RX_DEFINE = re.compile(r"^define\s\w+\s*@", re.M)
RX_TRIPLE = re.compile(r'target triple = "([^"]+)"')

def unwrap(blob):
    if blob[:4] == b"\xde\xc0\x17\x0b":
        _, _, off, size, _ = struct.unpack("<5I", blob[:20])
        return blob[off:off+size]
    if blob[:4] == b"BC\xc0\xde": return blob
    return None

def os_of(filename):
    m = re.search(r"_(iosmac|iossim|tvossim|watchossim|xrossim|xros|ios|tvos|watchos|osx)(?:[._]|\.a$|\.rtlib$|\.metallib$|_fast)", filename)
    return m.group(1) if m else "?"

def main():
    units = []  # (archive, os, member, bc)
    def add_fat(fn, blob, tag):
        if blob[:4] == b"MTLB":   # fat なし裸 MTLB
            slices = [(0, 0, 0, len(blob))]
        elif blob[:4] == b"\xcb\xfe\xba\xbe":
            ns = struct.unpack_from(">I", blob, 4)[0]
            slices = []
            for s in range(ns):
                _, subtype, off, size, _ = struct.unpack_from(">5I", blob, 8 + s * 20)
                slices.append((s, subtype, off, size))
            slices = [(s, st, o, z) for (s, st, o, z) in slices]
        else:
            print("  unknown container:", fn, blob[:4].hex()); return
        for s, subtype, off, size in slices:
            slc = blob[off:off+size] if blob[:4] != b"MTLB" else blob
            for m in re.finditer(rb"\xde\xc0\x17\x0b", slc):
                bc = unwrap(slc[m.start():])
                if bc:
                    units.append((f"{fn}#{tag}{s}(st{subtype})", os_of(fn), f"slice{s}@{m.start()}", bc))
    for fn in sorted(os.listdir(LIB)):
        if not fn.endswith((".rtlib", ".a")): continue
        head = open(f"{LIB}/{fn}", "rb").read(4)
        if head == b"\xcb\xfe\xba\xbe":   # fat コンテナ (拡張子.aだがfat)
            add_fat(fn, open(f"{LIB}/{fn}", "rb").read(), "fat")
            continue
        d = f"{WORK}/{fn}"
        os.makedirs(d, exist_ok=True)
        r = subprocess.run(["ar", "x", f"{LIB}/{fn}"], cwd=d, capture_output=True)
        if r.returncode != 0:
            print("  skip (ar fail):", fn); continue
        for mem in sorted(os.listdir(d)):
            bc = unwrap(open(f"{d}/{mem}", "rb").read())
            if bc: units.append((fn, os_of(fn), mem, bc))
    # 全 metallib
    for fn in sorted(os.listdir(LIB)):
        if not fn.endswith(".metallib"): continue
        add_fat(fn, open(f"{LIB}/{fn}", "rb").read(), "slice")
    print("units:", len(units))

    by_hash = {}   # h → dict(triples=set, oses=set, archives=set, member_sig, decls=Counter, defines)
    errors = []
    decl_os = collections.defaultdict(set)      # declare全文 → os集合
    decl_example = {}
    triple_by_os = collections.defaultdict(set)
    n_parsed = 0
    for i, (arc, osn, mem, bc) in enumerate(units):
        if i % 300 == 0: print(f" ... {i}/{len(units)}")
        h = hashlib.sha1(bc).hexdigest()[:16]
        rec = by_hash.get(h)
        if rec is None:
            text = None
            err = None
            try: text = str(llvm.parse_bitcode(bc))
            except Exception as e: err = str(e)[:150]
            if err:
                errors.append((f"{arc}!{mem}", err)); continue
            tri = (RX_TRIPLE.search(text) or [None, ""])[1]
            rec = {"triples": set(), "oses": set(), "archives": set(),
                   "defines": len(RX_DEFINE.findall(text)),
                   "decls": [a for a, _ in RX_DECLARE_AIR.findall(text)]}
            by_hash[h] = rec
            rec["triples"].add(tri)
            for full, _name in RX_DECLARE_AIR.findall(text):
                decl_example.setdefault(full, f"{arc}!{mem}")
            n_parsed += 1
        rec["oses"].add(osn); rec["archives"].add(arc)
        tri_prev = next(iter(rec["triples"])) if rec["triples"] else ""
        if tri_prev: triple_by_os[osn].add(tri_prev)
        for sig in rec["decls"]:
            decl_os[sig].add(osn)

    # 出力
    with open(f"{OUT}/ir_all_os_unique.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["module_hash", "n_defines", "n_air_decls", "oses", "os_count", "archives_sample", "triple"])
        for h, r in sorted(by_hash.items(), key=lambda kv: -len(kv[1]["oses"])):
            w.writerow([h, r["defines"], len(r["decls"]), ";".join(sorted(r["oses"])),
                        len(r["oses"]), ";".join(sorted(r["archives"]))[:80], ";".join(sorted(r["triples"]))])
    with open(f"{OUT}/ir_air_signatures.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["air_intrinsic_declare", "n_os", "os_list", "example_module"])
        for sig, oss in sorted(decl_os.items()):
            w.writerow([sig, len(oss), ";".join(sorted(oss)), decl_example[sig]])
    with open(f"{OUT}/os_triple_map.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["os", "triples_observed"])
        for osn, tris in sorted(triple_by_os.items()):
            w.writerow([osn, ";".join(sorted(tris))])
    print(f"\nparsed unique modules={n_parsed}/{len(units)} errors={len(errors)}")
    for e in errors[:5]: print("  ERR", e)
    print("\nunique module dedup: total_units=%d unique=%d" % (len(units), len(by_hash)))
    print("\nos triple map:")
    for osn, tris in sorted(triple_by_os.items()): print(f"  {osn}: {sorted(tris)}")
    print(f"\nair declare unique: {len(decl_os)}")

if __name__ == "__main__":
    main()
