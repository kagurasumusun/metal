#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ランタイム bitcode / metallib 埋込 bitcode の全文逆アセンブル → AIR グランドトゥルース

C-4 検証結果: llvmlite (system LLVM) は Apple AIR bitcode を正常に読める。
対象: osx 系ランタイム全メンバ + libtracepoint_rt_osx.metallib の2スライス (実エントリ関数!)
出力:
  data/ir_module_index.csv        モジュール索引 (triple/datalayout/define数/decl数)
  data/ir_air_signatures.csv      air.* の declare 全文 (実シグネチャの確定表)
  data/ir_runtime_functions.csv   定義関数の完全シグネチャ
  data/ir_named_metadata.csv      名前付きメタデータキー実測
  data/builtin_to_air_map.csv     (updated) evidence='observed_ir' へ昇格
  docs/samples/*.ll               代表 IR (kernel エントリ含む)
"""
import csv, os, re, struct, subprocess, sys, collections, glob

import llvmlite.binding as llvm

LIB = "/home/user/metal-repo/reference/clang/32023.883/lib/darwin"
OUT = "/home/user/metal-info-set/data"
SAMPLES = "/home/user/metal-info-set/docs/samples"
WORK = "/home/user/metal-info-set/work/ir"
for d in (OUT, SAMPLES, WORK): os.makedirs(d, exist_ok=True)

TARGET_ARCHIVES = [
    "libair_rt_osx.rtlib", "libmetal_rt_osx.a", "MTLShaderLoggingRuntime.rtlib",
    "MTLRaytracingRuntime.rtlib", "libopencl_rt_osx.a",
    "libopencl_rt_osx_fast-relaxed-math.a", "libpost_mesh_dump_rt_osx.rtlib",
    "libresource_tracking_rt_osx.rtlib", "libtracepoint_rt_workaround_osx.a",
]

def unwrap(blob):
    if blob[:4] == b"\xde\xc0\x17\x0b":
        _, _, off, size, _ = struct.unpack("<5I", blob[:20])
        return blob[off:off+size]
    if blob[:4] == b"BC\xc0\xde": return blob
    return None

def parse_bc(bc):
    try:
        return str(llvm.parse_bitcode(bc)), None
    except Exception as e:
        return None, f"{type(e).__name__}: {str(e)[:200]}"

RX_DEFINE = re.compile(r"^define\s.*?$", re.M)
RX_DECLARE_AIR = re.compile(r"^(declare\s.*@(air\.[A-Za-z0-9._]+)\(.*)$", re.M)
RX_DECLARE_ANY = re.compile(r"^declare\s.*?@([A-Za-z0-9._$]+)\(", re.M)
RX_NMD = re.compile(r"^!(\w[\w.]*) = !", re.M)
RX_TRIPLE = re.compile(r'target triple = "([^"]+)"')
RX_DATAL = re.compile(r'target datalayout = "([^"]+)"')
RX_CALLS_AIR = re.compile(r"@(air\.[A-Za-z0-9._]+)\(")

def analyze(text):
    d = {}
    d["triple"] = (RX_TRIPLE.search(text) or [None, ""])[1]
    d["datalayout"] = (RX_DATAL.search(text) or [None, ""])[1]
    d["defines"] = RX_DEFINE.findall(text)
    d["air_decls"] = [full for full, _name in RX_DECLARE_AIR.findall(text)]
    d["air_calls"] = collections.Counter(RX_CALLS_AIR.findall(text))
    d["nmd"] = RX_NMD.findall(text)
    # calling convention audit: token just before return type in define
    ccs = set()
    for df in d["defines"]:
        m = re.match(r"define\s+([a-z_0-9]+\s+)?", df)
        ccs.add(m.group(1).strip() if m and m.group(1) else "c")
    d["ccs"] = ccs
    return d

def collect_bitcode_units():
    """(unit_id, origin, bitcode_bytes) を列挙"""
    units = []
    for arc in TARGET_ARCHIVES:
        path = f"{LIB}/{arc}"
        if not os.path.exists(path):
            print("missing:", arc); continue
        d = f"{WORK}/{arc}"
        os.makedirs(d, exist_ok=True)
        subprocess.run(["ar", "x", path], cwd=d, check=True)
        for mem in sorted(os.listdir(d)):
            blob = open(f"{d}/{mem}", "rb").read()
            bc = unwrap(blob)
            if bc: units.append((f"{arc}!{mem}", arc, mem, bc))
    # metallib slices
    mlb = f"{LIB}/libtracepoint_rt_osx.metallib"
    blob = open(mlb, "rb").read()
    ns = struct.unpack_from(">I", blob, 4)[0]
    for s in range(ns):
        ct, st, off, size, al = struct.unpack_from(">5I", blob, 8 + s * 20)
        slc = blob[off:off+size]
        for m in re.finditer(rb"\xde\xc0\x17\x0b", slc):
            bc = unwrap(slc[m.start():])
            if bc: units.append((f"libtracepoint_rt_osx.metallib#slice{s}", "metallib", f"slice{s}@{m.start()}", bc))
    return units

def main():
    units = collect_bitcode_units()
    print(f"units to parse: {len(units)}")
    idx_rows, fn_rows, air_sigs, nmd_rows, errors = [], [], collections.Counter(), collections.Counter(), []
    air_decl_examples = {}
    datalayouts, triples, cc_union = collections.Counter(), collections.Counter(), set()
    kernel_samples = {}
    for i, (uid, arc, mem, bc) in enumerate(units):
        if i % 150 == 0: print(f"  ... {i}/{len(units)}")
        text, err = parse_bc(bc)
        if err:
            errors.append((uid, err)); continue
        a = analyze(text)
        triples[a["triple"]] += 1
        datalayouts[a["datalayout"]] += 1
        cc_union |= a["ccs"]
        idx_rows.append([uid, arc, mem, a["triple"], len(a["defines"]),
                         len(a["air_decls"]), sum(a["air_calls"].values()), ",".join(a["nmd"])])
        for df in a["defines"]:
            fn_rows.append([arc, mem, df[:400], ",".join(sorted(a["ccs"]))])
        for sig in a["air_decls"]:
            air_sigs[sig] += 1
            air_decl_examples.setdefault(sig, uid)
        for k in a["nmd"]:
            nmd_rows[k] += 1
        # kernel エントリを含むモジュールは全文保存 (最初の2件)
        if "define" in text and ("_Z24kernel_thread_tracepoint" in text or "_Z22mesh_thread_tracepoint" in text):
            if len(kernel_samples) < 3 and mem.split("@")[0] not in kernel_samples:
                name = mem.split("@")[0].replace("/", "_")
                kernel_samples[name] = text
    for name, text in kernel_samples.items():
        open(f"{SAMPLES}/{name}.ll", "w").write(text)
        print(f"sample IR saved: docs/samples/{name}.ll ({len(text)} bytes)")

    with open(f"{OUT}/ir_module_index.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["unit", "archive", "member", "triple", "n_defines", "n_air_declares", "n_air_calls", "named_metadata_keys"]); w.writerows(idx_rows)
    with open(f"{OUT}/ir_runtime_functions.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["archive", "member", "define_line", "cc_set"]); w.writerows(fn_rows)
    with open(f"{OUT}/ir_air_signatures.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["air_intrinsic_declare", "n_modules_using", "example_module"])
        for sig, n in sorted(air_sigs.items()): w.writerow([sig, n, air_decl_examples[sig]])
    with open(f"{OUT}/ir_named_metadata.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["metadata_key", "n_modules"]); w.writerows(sorted(nmd_rows.items()))

    print(f"\nparsed={len(idx_rows)} errors={len(errors)}")
    for e in errors[:5]: print("  ERR", e)
    print("\ntriples:", dict(triples))
    print("\ndatalayout unique count:", len(datalayouts))
    for dl, n in datalayouts.items(): print(f"  [{n}] {dl}")
    print("\ncalling conventions seen:", cc_union)
    print(f"\nair.* declares (unique): {len(air_sigs)}")
    print("named metadata keys:", list(nmd_rows)[:20])

if __name__ == "__main__":
    main()
