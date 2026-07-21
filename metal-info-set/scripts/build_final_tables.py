#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
MSL ↔ LLVM IR(AIR) 対応表 — ローカル抽出の最終一括ビルド
出力:
  data/airconv_air_ops.csv        airconv 内 AIR 生成/解釈パターン (AIRBuilder)
  data/air_strings_binaries.csv   リポ内バイナリ実測の air.* トークン
  data/msl_stage1_methods.csv     クラスメソッド経由 builtin 抽出 (全ヘッダ)
  data/builtin_to_air_map.csv     686 builtin の L2→L3 正規マスタ表
  data/type_map.csv               MSL 型 → LLVM IR 型 対応表 (curated)
  data/rtlib_pairing.csv          __air_impl_* ↔ __loweringlib.internal.N 対応
  data/probe_cells.csv            macOS 実測が必要な未決セル一覧
"""
import csv, os, re, subprocess, collections

REPO = "/home/user/metal-repo"
HDR = f"{REPO}/reference/clang/32023.883/include/metal"
LIB = f"{REPO}/reference/clang/32023.883/lib/darwin"
AIRCONV = "/home/user/metal-info-set/reference-external/dxmt/src/airconv"
OUT = "/home/user/metal-info-set/data"
os.makedirs(OUT, exist_ok=True)

# ======================================================== A. airconv AIR ops
def build_airconv_ops():
    rows = []
    fnctx = ""  # 直近のメソッド名コンテキスト
    for root, _, files in os.walk(AIRCONV):
        for fn in files:
            if not fn.endswith((".cpp", ".hpp", ".h")): continue
            path = os.path.join(root, fn)
            rel = os.path.relpath(path, AIRCONV)
            try: lines = open(path, errors="replace").read().splitlines()
            except OSError: continue
            pending = None  # "air.xxx_" の += 追跡
            for i, line in enumerate(lines, 1):
                m = re.search(r"(?:AIRBuilder::|^[\w:<>&* ]+\s+)(\w*[A-Z]\w+)\s*\(", line)
                if re.match(r"^\S", line) and m and "if" not in line.split("(")[0]:
                    fnctx = m.group(1)
                for mm in re.finditer(r'"(air\.[a-zA-Z0-9._]*[a-zA-Z0-9_])"', line):
                    rows.append([mm.group(1), "literal", fnctx, rel, i])
                if 'FnName = "air.' in line:
                    pending = [line.strip().split('"')[1]]
                    for j in range(i, min(i + 14, len(lines))):
                        add = re.findall(r'\+=\s*"([^"]*)"', lines[j])
                        if add: pending.extend(add)
                    rows.append([" ".join(pending), "name_rule", fnctx, rel, i])
    rows = sorted(set(tuple(r) for r in rows))
    with open(f"{OUT}/airconv_air_ops.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["air_name_or_rule", "kind", "context_method", "file", "line"]); w.writerows(rows)
    lits = sorted({r[0] for r in rows if r[1] == "literal"})
    print(f"A. airconv ops: {len(rows)} rows, {len(lits)} literals, {sum(1 for r in rows if r[1]=='name_rule')} naming rules")
    return lits

# ====================================================== B. binary air tokens
def build_binary_tokens():
    # bitcode文字列表では識別子が連結して現れるため:
    #   1) トークン文字の最大ランを取得  2) 'air.' / 'llvm.' 境界で分割  3) 小文字トークンのみ残す
    rx_run = re.compile(rb"[A-Za-z][A-Za-z0-9_.]*")
    rx_tok = re.compile(r"^air\.[a-z][a-z0-9_.]*$")
    stats = collections.defaultdict(lambda: collections.Counter())
    for fn in sorted(os.listdir(LIB)):
        kind = ("metallib" if fn.endswith(".metallib") else
                "rtlib" if fn.endswith(".rtlib") else "a" if fn.endswith(".a") else None)
        if not kind: continue
        blob = open(os.path.join(LIB, fn), "rb").read()
        toks = set()
        for m in rx_run.finditer(blob):
            run = m.group(0).decode("ascii", "replace")
            if "air." not in run: continue
            parts = run.split("air.")
            for p in parts[1:]:
                tok = "air." + p
                # 後続の結合識別子 (大文字開始のC++シンボル等) を切り落とす
                tok = re.split(r"(?<=[a-z0-9_])(?=[A-Z])", tok)[0]
                tok = tok.split("_Z")[0]
                tok = tok.split("llvm.")[0]          # 結合 llvm.* 文字列
                tok = re.split(r"(?:32023\.[0-9]+|air\d+_v\d+)", tok)[0]  # 結合バージョン文字列
                if rx_tok.match(tok) and len(tok) <= 60:
                    toks.add(tok.rstrip("._"))
        for tok in toks:
            stats[tok][kind] += 1
    with open(f"{OUT}/air_strings_binaries.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["token", "in_rtlib", "in_metallib", "in_a"])
        for tok in sorted(stats):
            c = stats[tok]; w.writerow([tok, c.get("rtlib", 0), c.get("metallib", 0), c.get("a", 0)])
    # ステム語彙表 (型接尾辞を除去した基底op)
    sfx_stem = re.compile(r"(\.(p\d+)?v?\d+[fibuh]\d+|\.[fibuh]\d+)+$")
    stems = collections.Counter()
    for t in stats:
        b = t; prev = None
        while prev != b:
            prev = b
            b = re.sub(r"\.rt[zpen]$", "", b)
            b = sfx_stem.sub("", b)
        stems[b] += 1
    with open(f"{OUT}/air_stems_binaries.txt", "w") as f:
        f.write(f"# binary-observed air.* base stems (n={len(stems)}, total variants={sum(stems.values())})\n")
        f.write("# stem<TAB>n_variants\n")
        for s in sorted(stems): f.write(f"{s}\t{stems[s]}\n")
    print(f"B. binary tokens: {len(stats)} unique ({len(stems)} stems)")
    return sorted(stats)

# ============================================ C. class-method builtin calls
RX_METAL_BUILTIN = re.compile(r"__metal_[a-z0-9_]+")
def parse_all_headers():
    records = []
    for root, _, files in os.walk(HDR):
        for fn in sorted(files):
            path = os.path.join(root, fn)
            rel = os.path.relpath(path, HDR)
            try: lines = open(path, errors="replace").read().splitlines()
            except OSError: continue
            struct_stack = []   # (name, depth_at_open)
            depth = 0
            guards = []
            i, n = 0, len(lines)
            while i < n:
                line = lines[i]; s = line.strip()
                mg = re.match(r"#\s*if[a-z]*\s*\(?\s*defined?\(?\s*(__HAVE_[A-Z0-9_]+__)", s)
                if mg: guards.append(mg.group(1))
                elif re.match(r"#\s*(if|ifdef)\b", s) and "__METAL_" not in s: guards.append("cond")
                elif re.match(r"#\s*endif", s) and guards: guards.pop()
                ms = re.match(r"^(?:template\s*<[^>]*>\s*)?(struct|class)\s+([A-Za-z_0-9]+)", s)
                if ms and not s.startswith("struct {"): struct_stack.append((ms.group(2), depth))
                if re.match(r"^\s*METAL_FUNC\s+", line):
                    start = i + 1
                    sig = s
                    while sig.count("(") > sig.count(")") and i + 1 < n:
                        i += 1; sig += " " + lines[i].strip()
                    body = ""; brace = 0; started = False; j = i
                    while j < n:
                        l2 = lines[j]
                        for ch in l2:
                            if ch == "{": brace += 1; started = True
                            elif ch == "}": brace -= 1
                        body += l2 + "\n"; j += 1
                        if started and brace == 0: break
                    b = sorted(set(RX_METAL_BUILTIN.findall(body)))
                    cls = struct_stack[-1][0] if struct_stack else ""
                    if b:
                        records.append([sig, cls, "|".join(guards), " ".join(b), rel, start])
                    i = j
                    # depth追跡の補正: body 分をすでに消費したので再計算は不要 (brace 0復帰済)
                    continue
                # 深さ更新 (METAL_FUNC 行以外)
                op = line.count("{"); cl = line.count("}")
                depth += op - cl
                while struct_stack and depth < struct_stack[-1][1] + 1 and cl:
                    struct_stack.pop()
                i += 1
    return records

def build_methods():
    recs = parse_all_headers()
    with open(f"{OUT}/msl_stage1_methods.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["member_signature", "class", "guard", "metal_builtins", "file", "line"])
        w.writerows(recs)
    per_cls = collections.Counter(r[1] or "(free)" for r in recs)
    builtins = sorted({b for r in recs for b in r[3].split()})
    with open(f"{OUT}/msl_stage1_methods_summary.md", "w") as f:
        f.write(f"# class-method → __metal_* builtin 抽出結果\n\n- メソッド行数 (builtin参照あり): **{len(recs)}**\n")
        f.write(f"- ユニーク builtin: **{len(builtins)}**\n\n## class 別件数 (Top 25)\n\n| class | count |\n|---|---:|\n")
        for c, n in per_cls.most_common(25): f.write(f"| `{c}` | {n} |\n")
    print(f"C. methods: {len(recs)} rows, {len(builtins)} unique builtins, {len(per_cls)} classes")
    return builtins

# ============================================== D. builtin → AIR master map
TEX_SHAPES = ["1d", "1d_array", "2d", "2d_array", "2d_ms", "2d_ms_array", "3d",
              "cube", "cube_array", "buffer_1d", "depth2d", "depthcube"]
def candidate_air(builtin):
    """__metal_foo[_texture_2d_t] → ['air.sample_texture_2d', ...] 候補生成"""
    name = builtin[len("__metal_"):]
    tex = ""
    m = re.search(r"_texture_([a-z0-9_]+)_t$", name)
    if m: tex = m.group(1); name = name[:m.start()]
    base = f"air.{name.replace('_explicit','').replace('_','.')}"
    cands = [base]
    if tex: cands.insert(0, f"air.{name}_texture_{tex}")
    if name == "atomic_fence": cands.insert(0, "air.atomic.fence")
    # 整数演算は .s/.u 符号付き・なしを併記する接尾辞規則がある
    cands += [base + ".s", base + ".u"]
    if tex:
        cands += [f"air.{name}_texture_{tex}.s", f"air.{name}_texture_{tex}.u"]
    return name, tex, cands

def build_master_map(binary_tokens, airconv_lits):
    # 686 builtin カタログ読み込み
    builtins = []
    with open(f"{OUT}/metal_builtins.csv") as f:
        for r in csv.DictReader(f):
            builtins.append((r["builtin"], int(r["n_occurrences"]), r["sample1"]))
    # 使用経路: stage1 free + methods
    used_free, used_method = set(), set()
    for r in csv.DictReader(open(f"{OUT}/msl_stage1_api_to_builtin.csv")):
        for b in r["metal_builtins"].split(): used_free.add(b)
    for r in csv.DictReader(open(f"{OUT}/msl_stage1_methods.csv")):
        for b in r["metal_builtins"].split(): used_method.add(b)
    binset = set(binary_tokens)
    # 型接尾辞 (v<n>)?{f,i,b,u,h}<bits> / p<as> / rt{z,p,n,e} を剥がした stem で厳密一致させる
    sfx = re.compile(r"(\.rt[zpen])|(\.(p\d+)?v?\d*[fibuh]\d+)+$")
    def stem(t):
        prev = None
        while prev != t:
            prev = t
            t = re.sub(r"\.rt[zpen]$", "", t)
            t = re.sub(r"(\.(p\d+)?v?\d+[fibuh]\d+|\.[fibuh]\d+)+$", "", t)
        return t
    stem2tok = collections.defaultdict(list)
    for t in binset: stem2tok[stem(t)].append(t)
    def bin_hit(cands):
        for c in cands:
            if c in stem2tok:
                return sorted(stem2tok[c], key=len)[0]
        return ""
    rows = []
    probes = []
    for b, occ, sample in builtins:
        name, tex, cands = candidate_air(b)
        hit = bin_hit(cands + [f"air.{name}"])
        lit = next((l for c in cands for l in airconv_lits
                    if l == c or l.startswith(c + ".") or l.startswith(c + "_")), "")
        usage = ("free+method" if b in used_free and b in used_method else
                 "free" if b in used_free else "method" if b in used_method else "no_callsite")
        if hit: ev, air_name, st = "observed_binary", hit, "✅AIR名を実バイナリで確認"
        elif lit: ev, air_name, st = "observed_airconv", lit, "🔶AIR名をairconvで確認 (型suffix等要実測)"
        else:
            ev, air_name, st = "inferred", cands[0], "🧪命名規則からの推測 (probe必須)"
            probes.append([b, cands[0], usage, "type-signature/semantics unknown; probe with .ll dump",
                           sample[:120]])
        rows.append([b, usage, occ, air_name, ev, st, sample[:120]])
    with open(f"{OUT}/builtin_to_air_map.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["__metal_builtin", "used_via", "n_call_sites", "air_intrinsic_candidate",
                    "evidence", "status", "stdlib_sample"])
        w.writerows(rows)
    evc = collections.Counter(r[4] for r in rows)
    print(f"D. master map: {len(rows)} builtins → {dict(evc)}")
    return probes

# ==================================================== E. type map (curated)
TYPES = [
 # msl, category, clang表現(ヘッダ実測), LLVM IR 型案, evidence, status
 ["half","scalar","(組込)","f16","spec/headers","✅"],
 ["float","scalar","(組込)","f32","spec/headers","✅"],
 ["bfloat","scalar","__bf16系 (MSL2.2+)","bf16","headers(__HAVE_BFLOAT__)","🔶probe"],
 ["bool","scalar","(組込)","i1 (メモリ i8)","clang常識","🔶probe"],
 ["char/uchar/short/ushort/int/uint","scalar","(組込)","i8/i8/i16/i16/i32/i32","spec","✅"],
 ["long/ulong","scalar","(組込)","i64/i64","spec","✅"],
 ["vec<T,N> (float4等)","vector","__attribute__((__ext_vector_type__(N)))","<N x T> (align=自然)","headers 25種属性","🔶probe(3要素align要確認)"],
 ["packed_vec<T,N> (packed_float3等)","vector","__attribute__((__packed_vector_type__(N)))","<N x T> packed (align=要素)","headers 実測 **upstream clang には恐らく無い独自属性**","🧪要clang拡張"],
 ["matrix<T,C,R> (float4x4等)","matrix","struct { vec<T,R> columns[C]; }","%struct = { [C x <R x T>] } 列優先","metal_matrix 実測","✅layout確定"],
 ["atomic<T> (_atomic)","struct","template struct (address-space制限ctor)","storage型 T + atomicrmw/cmpxchg IR操作","metal_atomic 実測","🔶"],
 ["texture1d<T>…texture_buffer<T>/depth*","resource","template class (opaque)","opaque handle: ポインタ+専用addrspace or target extension (要実測)","headers __bits/metal_texture*","🧪probe 最重要級"],
 ["sampler","resource","struct sampler (constexpr state)","opaque + 32bit state (sampler state bitfield は metadata/const 値)","headers/spec §18 候補","🧪probe"],
 ["array<T,N> (MSL)","container","metal::array (C++ラッパ)","[N x T]","headers","✅"],
 ["threadgroup/device/constant/thread T*","pointer","言語キーワード(addrspace 0/1/2/3)","ptr addrspace(N)","mangling実測 + datalayout待ち","🔶datalayout確認"],
 ["threadgroup_imageblock","pointer系","キーワード","addrspace 8 とされる値 (要検証)","msl_analysis由来→要probe","🧪"],
 ["visible_function_table / intersection 系","resource","template struct","opaque + air.dyld_flat_table 系実測","binary strings","🔶"],
 ["simdgroup_matrix (simdgroup_float8x8等)","matrix拡張","template struct (MSL2.3+)","専用 layout (fragment型) — cooperative matrix","headers metal_simdgroup_matrix","🧪"],
 ["tensor / cooperative_tensor (MSL4)","tensor","template class","要実測 (新規)","headers metal_tensor/metal_cooperative_tensor","🧪"],
 ["raytracing::acceleration_structure","resource","template struct","opaque + air.ray_*? (要実測)","headers metal_raytracing","🧪"],
]
def build_type_map():
    with open(f"{OUT}/type_map.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["msl_type", "category", "clang_header_representation", "llvm_ir_form", "evidence", "status"])
        w.writerows(TYPES)
    print(f"E. type map: {len(TYPES)} rows")

# ================================================== F. rtlib pairing rules
def build_rtlib_pairing():
    rows = []
    for fn in sorted(os.listdir(LIB)):
        if not (fn.endswith("_rt_osx.rtlib") or fn.endswith(".a")): continue
        p = subprocess.run(["ar", "t", os.path.join(LIB, fn)], capture_output=True, text=True)
        members = p.stdout.split()
        # 実測の並びは [pub_sym, __loweringlib.internal.N, pub_sym, internal.N+1, ...]
        # → 各 internal は直前の public シンボル群の実装オブジェクト
        pubs = []
        for m in members:
            if m.startswith("__loweringlib.internal"):
                rows.append([fn, m, ";".join(pubs)])
                pubs = []
            else:
                pubs.append(m)
        if pubs:  # 末尾に余った public (対応 internal なし)
            rows.append([fn, "(no_impl_tail)", ";".join(pubs)])
    with open(f"{OUT}/rtlib_pairing.csv", "w", newline="") as f:
        w = csv.writer(f); w.writerow(["archive", "impl_object", "public_symbols_before_next_impl"])
        w.writerows(rows)
    n_impl = len(rows); n_pub = sum(len(r[2].split(";")) if r[2] else 0 for r in rows)
    print(f"F. rtlib pairing: {n_impl} impl objects, {n_pub} public symbols")

# ============================================================ G. probe cells
def write_probes(extra):
    cells = list(extra)
    cells += [
      ["(全般)", "datalayout/addressspace", "-", "ptr addrspace 番号確定 (0/1/2/3/8/texture)", "compile addrspace probe & dump .ll"],
      ["(metadata)", "air.kernel entry md", "-", "エントリ属性→名前付きmetadata構造 (air_signature.cpp構造の実測確認)", "vertex/fragment/kernel probe → .ll"],
      ["(metadata)", "air.arg_* / compile_options", "-", "引数metadataのオペランド列仕様", "同上"],
      ["(呼出規約)", "entry CC", "-", "bitcodeの calling convention 値", "llvm-bcanalyzer / ll dump"],
      ["(type)", "texture/sampler opaque 表現", "-", "texture2d<T> 等の IR 型の実体", "texture probe"],
      ["(type)", "packed_vector_type", "-", "upstream clang に無い属性の semantics + layout", "packed_float3 probe"],
      ["(機能)", "function_constant", "-", "特殊化定数の IR/metadata 表現", "fc probe"],
      ["(機能)", "visible_function_table", "-", "air.dyld_flat_table の構築 ABI", "vft probe"],
      ["(ra)", "raytracing/mesh/tensor", "-", "MSL3/4 機能の intrinsic 群", "RT/mesh/tensor probe"],
      ["(rt)", "rtlib リンクトリガ", "-", "どの API が __air_impl_* リンクを引くか", "nextafter/printf 等で実測"],
    ]
    with open(f"{OUT}/probe_cells.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["cell", "subject", "air_candidate", "what_to_determine", "probe_method"])
        w.writerows(cells)
    print(f"G. probe cells: {len(cells)}")

if __name__ == "__main__":
    lits = build_airconv_ops()
    toks = build_binary_tokens()
    build_methods()
    probes = build_master_map(toks, lits)
    build_type_map()
    build_rtlib_pairing()
    write_probes(probes)
