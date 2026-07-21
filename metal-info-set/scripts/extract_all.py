#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
metal-info-set extractor
リポジトリ内の一次情報 (metal ヘッダ / GPUランタイム bitcode / 実 .metallib) から
LLVM/Clang Metal対応に必要な情報を機械抽出する。

Usage:
  python3 extract_all.py have-matrix    # 能力マクロ行列 (metal_config を cpp で全分岐展開)
  python3 extract_all.py builtins       # __metal_* ビルトイン・カタログ
  python3 extract_all.py rtlib          # ランタイムアーカイブ・シンボル目録
  python3 extract_all.py metallib       # .metallib 構造・タグ目録
  python3 extract_all.py attrs          # ヘッダ属性/型修飾子の使用実態
  python3 extract_all.py all
"""
import csv, os, re, subprocess, struct, sys, collections

REPO = "/home/user/metal-repo"
HDR_DIR = f"{REPO}/reference/clang/32023.883/include/metal"
LIB_DIR = f"{REPO}/reference/clang/32023.883/lib/darwin"
OUT = "/home/user/metal-info-set/data"
os.makedirs(OUT, exist_ok=True)

MSL_VERSIONS = [100, 110, 120, 200, 210, 220, 230, 240, 300, 310, 320, 400]
OSES = ["IOS", "MACOS"]

# ---------------------------------------------------------------- have-matrix
def cmd_have_matrix():
    src = f"{HDR_DIR}/metal_config"
    rows = {}   # macro -> {(os,ver): value}
    order = []
    for osname in OSES:
        for ver in MSL_VERSIONS:
            p = subprocess.run(
                ["cpp", "-undef", "-dM", f"-D__METAL_{osname}__",
                 f"-D__METAL_VERSION__={ver}", src],
                capture_output=True, text=True)
            if p.returncode != 0:
                print("cpp failed", osname, ver, p.stderr[:200]); continue
            for m in re.finditer(r"^#define (__HAVE_[A-Z0-9_]+)\s*(.*)$", p.stdout, re.M):
                name, val = m.group(1), m.group(2).strip() or "1"
                rows.setdefault(name, {})
                rows[name][(osname, ver)] = val
                if name not in order: order.append(name)
    with open(f"{OUT}/have_matrix.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["macro"] + [f"{o.lower()}_{v}" for o in OSES for v in MSL_VERSIONS])
        for name in order:
            w.writerow([name] + [rows[name].get((o, v), "") for o in OSES for v in MSL_VERSIONS])
    # 集計: バージョン毎の有効マクロ数
    with open(f"{OUT}/have_matrix_summary.md", "w") as f:
        f.write("# __HAVE__ capability macro counts per (OS, MSL version)\n\n")
        f.write("| OS | " + " | ".join(str(v) for v in MSL_VERSIONS) + " |\n")
        f.write("|---|" + "---:|" * len(MSL_VERSIONS) + "\n")
        f.write("| **MSL** | " + " | ".join(f"{v//100}.{v%100:02d}" for v in MSL_VERSIONS) + " |\n")
        for osname in OSES:
            cells = [str(sum(1 for n in order if (osname, v) in rows[n])) for v in MSL_VERSIONS]
            f.write(f"| {osname} | " + " | ".join(cells) + " |\n")
        f.write(f"\nTotal unique __HAVE_ macros: **{len(order)}**\n")
        # 新規追加マクロ (前バージョンに無く当バージョンで登場) の変化点
        f.write("\n## 変化点 (初出マクロ: そのバージョンで新たに有効化された機能)\n\n")
        for osname in OSES:
            f.write(f"### {osname}\n\n")
            for i, v in enumerate(MSL_VERSIONS):
                cur = {n for n in order if (osname, v) in rows[n]}
                prv = {n for n in order if (osname, MSL_VERSIONS[i-1]) in rows[n]} if i else set()
                new = sorted(cur - prv); gone = sorted(prv - cur)
                if new or gone:
                    f.write(f"- **__METAL_VERSION__ == {v}**: +" + str(len(new)) + (" / −"+str(len(gone)) if gone else "") + "\n")
                    for n in new[:40]: f.write(f"  - `{n}`\n")
                    if len(new) > 40: f.write(f"  - …(+{len(new)-40})\n")
    print(f"have_matrix.csv: {len(order)} unique macros")

# ----------------------------------------------------------------- builtins
def cmd_builtins():
    recs = collections.defaultdict(lambda: {"files": set(), "occ": 0, "samples": []})
    rx = re.compile(r"__metal_[a-z0-9_]+")
    for root, _, files in os.walk(HDR_DIR):
        for fn in files:
            path = os.path.join(root, fn)
            rel = os.path.relpath(path, HDR_DIR)
            try:
                with open(path, errors="replace") as f: lines = f.readlines()
            except OSError: continue
            for i, line in enumerate(lines, 1):
                if "__metal_" not in line: continue
                for name in rx.findall(line):
                    r = recs[name]; r["files"].add(rel); r["occ"] += 1
                    if len(r["samples"]) < 3:
                        r["samples"].append(f"{rel}:{i}: {line.strip()[:150]}")
    with open(f"{OUT}/metal_builtins.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["builtin", "n_files", "n_occurrences", "sample1", "sample2", "sample3"])
        for name in sorted(recs):
            r = recs[name]
            w.writerow([name, len(r["files"]), r["occ"], *r["samples"]])
    # 構造統計
    tex = [n for n in recs if "_texture_" in n]
    with open(f"{OUT}/metal_builtins_summary.md", "w") as f:
        f.write(f"# __metal_* builtin catalog summary\n\n- unique builtins: **{len(recs)}**\n")
        f.write(f"- of which texture-method variants (`_texture_…_t`): **{len(tex)}**\n")
        base = re.compile(r"^__metal_(.+?)(_texture_.+_t)?$")
        groups = collections.Counter()
        for n in recs: groups[base.match(n).group(1)] += 1
        f.write(f"- base operations (texture派生を畳み込み): **{len(groups)}**\n\n")
        f.write("## Top 30 by call sites\n\n| builtin | files | calls |\n|---|---:|---:|\n")
        for n in sorted(recs, key=lambda x: -recs[x]["occ"])[:30]:
            f.write(f"| `{n}` | {len(recs[n]['files'])} | {recs[n]['occ']} |\n")
    print(f"metal_builtins.csv: {len(recs)} builtins ({len(tex)} texture variants)")

# -------------------------------------------------------------------- rtlib
def iter_archives():
    for fn in sorted(os.listdir(LIB_DIR)):
        if fn.endswith((".rtlib", ".a")) and not fn.endswith(".metallib"):
            yield fn

def cmd_rtlib():
    summary = []
    with open(f"{OUT}/rtlib_members.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["archive", "member", "size_bytes"])
        for fn in iter_archives():
            p = subprocess.run(["ar", "tv", f"{LIB_DIR}/{fn}"], capture_output=True, text=True)
            n = 0
            for line in p.stdout.splitlines():
                parts = line.split()
                if len(parts) >= 7:
                    size = parts[2]; member = parts[-1]
                    w.writerow([fn, member, size]); n += 1
            summary.append((fn, n))
    with open(f"{OUT}/rtlib_summary.md", "w") as f:
        f.write("# GPU runtime archives — member counts\n\n| archive | members |\n|---|---:|\n")
        for fn, n in summary: f.write(f"| `{fn}` | {n} |\n")
        f.write(f"\nTotal archives: {len(summary)}, total members: {sum(n for _, n in summary)}\n")
    print(f"rtlib_members.csv written for {len(summary)} archives")

# ------------------------------------------------------------------ metallib
KNOWN_TAGS = {b"NAME", b"TYPE", b"HASH", b"MDSZ", b"OFFS", b"SIZE", b"VERS", b"LANG",
              b"ENDT", b"UUID", b"SDKV", b"OSVR", b"AIRV", b"DVCS", b"DEPS", b"RECR"}
TAG_RX = re.compile(rb"[A-Z0-9]{4}")
def parse_slice_tags(blob, base):
    """'MTLB' スライスのタグ暫定パース (寛容なヒューリスティクス)"""
    out = []
    if len(blob) < 96 or blob[:4] != b"MTLB": return out
    unk = blob[4:8]
    fields = struct.unpack_from("<8Q", blob, 8)
    out.append(("-", "hdr.unknown4", 4, unk.hex()))
    out.append(("-", "hdr.version_u64", 8, str(fields[0])))
    out.append(("-", "hdr.file_size", 8, str(fields[1])))
    names = ["headers_start", "headers_len", "types_start", "types_len",
             "empties_start", "empties_len", "bitcode_start", "bitcode_len"]
    for nm, v in zip(names, fields[2:8]):
        out.append(("-", f"hdr.{nm}", 8, str(v)))
    # bitcode wrappers
    for m in re.finditer(rb"\xde\xc0\x17\x0b", blob):
        out.append(("-", "bitcode_wrapper_offset", 8, f"{base + m.start()}"))
    # 4CC タグの走査 (NAME/TYPE/HASH は len u16 + data)
    for m in TAG_RX.finditer(blob):
        tag = m.group(0)
        if tag not in KNOWN_TAGS: continue
        pos = m.start()
        if tag == b"ENDT":
            out.append((pos, tag.decode(), 0, "")); continue
        ln = struct.unpack_from("<H", blob, pos + 4)[0] if pos + 6 <= len(blob) else 0
        if ln > 4096 or pos + 6 + ln > len(blob): continue
        data = blob[pos + 6: pos + 6 + ln]
        disp = data.decode("ascii", "replace") if all(32 <= c < 127 for c in data) else data.hex()
        out.append((pos, tag.decode(), ln, disp[:200]))
    return out

def cmd_metallib():
    files = sorted(f for f in os.listdir(LIB_DIR) if f.endswith(".metallib"))
    rows = []
    for fn in files:
        path = f"{LIB_DIR}/{fn}"
        blob = open(path, "rb").read()
        if blob[:4] != b"\xcb\xfe\xba\xbe":
            rows.append([fn, "-", "NOT_FAT", blob[:4].hex(), ""]); continue
        nslices = struct.unpack_from(">I", blob, 4)[0]
        for s in range(nslices):
            cputype, subtype, off, size, align = struct.unpack_from(">5I", blob, 8 + s * 20)
            slc = blob[off:off+size]
            triples = sorted(set(re.findall(rb"air\d+_v\d+-apple-[a-z0-9.]+", slc)))
            rows.append([fn, s, "slice",
                         f"cputype=0x{cputype:08x} subtype=0x{subtype:08x}",
                         f"off={off} size={size} align={align} triples=" +
                         ",".join(t.decode() for t in triples)])
            for pos, tag, ln, disp in parse_slice_tags(blob[off:off+size], off):
                if tag.startswith("hdr.") or tag == "bitcode_wrapper_offset":
                    rows.append([fn, s, tag, pos, disp])
                else:
                    rows.append([fn, s, f"tag.{tag}", pos, disp])
    with open(f"{OUT}/metallib_structure.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["file", "slice", "kind", "pos_or_param", "data"])
        w.writerows(rows)
    # タグ種別の集計
    tags = collections.Counter(r[2] for r in rows if r[2].startswith("tag."))
    with open(f"{OUT}/metallib_summary.md", "w") as f:
        f.write("# .metallib (libtracepoint_rt_*) structure inventory\n\n")
        f.write(f"- files parsed: {len(files)}\n- tag kinds observed: " +
                ", ".join(f"`{t[4:]}`×{c}" for t, c in tags.most_common()) + "\n\n")
        f.write("## fat slice パラメータ ↔ AIR triple 対応\n\n")
        f.write("| file | slice | params | triples |\n|---|---|---|---|\n")
        for r in rows:
            if r[2] != "slice": continue
            params, _, rest = r[3].partition(" ")
            _, _, tr = r[4].partition("triples=")
            f.write(f"| `{r[0]}` | {r[1]} | {params} | {tr.replace(',', '<br>') or '(none)'} |\n")
    print(f"metallib_structure.csv: {len(files)} files, tags={dict(tags)}")

# ---------------------------------------------------------------- attrs
def cmd_attrs():
    counts = collections.Counter()
    for root, _, files in os.walk(HDR_DIR):
        for fn in files:
            p = os.path.join(root, fn)
            try: txt = open(p, errors="replace").read()
            except OSError: continue
            for m in re.finditer(r"__attribute__\s*\(\(([^)]*)\)\)", txt):
                attr = re.sub(r"\s+", "", m.group(1))
                counts[attr] += 1
    with open(f"{OUT}/header_attributes.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["attribute_spelling", "uses"])
        for a, c in counts.most_common(): w.writerow([a, c])
    # upstream clang に無さそうな独自拡張候補のフラグ付け (既知物を除外)
    KNOWN_UPSTREAM = {"__ext_vector_type__", "__packed_vector_type__?"}
    uniq = [a for a in counts]
    with open(f"{OUT}/header_attributes_summary.md", "w") as f:
        f.write("# attribute spellings used by metal_stdlib headers\n\n")
        for a, c in counts.most_common(): f.write(f"- `(({a}))` × {c}\n")
    print(f"header_attributes.csv: {len(uniq)} spellings")

CMDS = {"have-matrix": cmd_have_matrix, "builtins": cmd_builtins, "rtlib": cmd_rtlib,
        "metallib": cmd_metallib, "attrs": cmd_attrs}
if __name__ == "__main__":
    targets = list(CMDS) if sys.argv[1:] == ["all"] else sys.argv[1:]
    for t in targets: CMDS[t]()
