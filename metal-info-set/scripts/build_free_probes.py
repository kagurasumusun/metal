#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_free_probes.py — free 関数系 builtin の extern-C wrapper probe を機械生成。

対象: builtin_to_air_map.v2 で inferred/observed_airconv かつ stage1 (class 空) の
free 関数呼出が取れる builtin (atomics explicit/coherent, simd sync, command_buffer 等)。
方式: builtin ごとに最初の parse 可能 signature を選び、テンプレ T/U は
{int,float,uint} の順で具体化したダミーを生成。atomic 引数は
threadgroup atomic_int ローカル変数で供給 (kernel 外関数でも threadgroup 変数は
宣言可能か? → 実機の削りループに検証を委ねる。失敗分は DISABLED として落ちる)。

出力: probe_scenes_methods/scene_P07F_free/probe.metal, MANIFEST_free.csv
      data/free_probe_coverage.csv
"""
import csv
import os
import re
import sys
from collections import defaultdict, Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

OUT_DIR = os.path.join(S.ROOT, "probe_scenes_methods")

SIG_HEAD = re.compile(
    r"^(?:METAL_FUNC\s+)?(?P<ret>.+?)\s+(?P<name>[A-Za-z_]\w*)(?P<rest>\(.*)$", re.S)


def split_paren(s):
    i0 = s.find("(")
    if i0 < 0:
        return None, s
    d = 0
    for i in range(i0, len(s)):
        if s[i] == "(":
            d += 1
        elif s[i] == ")":
            d -= 1
            if d == 0:
                return s[i0 + 1:i], s[i + 1:]
    return None, s


def split_top_commas(s):
    out, cur, d = [], "", 0
    for ch in s:
        if ch in "(<[":
            d += 1
        elif ch in ")>]":
            d -= 1
        if ch == "," and d == 0:
            out.append(cur)
            cur = ""
        else:
            cur += ch
    if cur.strip():
        out.append(cur)
    return out


SCALAR = {"bool": "true", "char": "0", "short": "0", "int": "0", "uint": "0u",
          "uchar": "0", "ushort": "0", "long": "0", "ulong": "0ul",
          "half": "1.0h", "float": "1.0f", "double": "1.0", "bfloat": "1.0",
          "size_t": "0"}
ENUM_VAL = {"memory_order": "memory_order_relaxed",
            "mem_flags": "mem_flags::mem_device",
            "thread_scope": "thread_scope_device"}
VEC_RE = re.compile(r"^(float|half|int|uint|bool|short|ushort|char|uchar|bfloat|double|long|ulong)([234])$")


def concrete(t, vt):
    return {"T": vt, "U": vt, "T2": "int"}.get(t, t)


def dummy(ty, locals_defs, vt, externs):
    """locals_defs: (type, name, init) のリスト (wrapper 本体内で宣言するローカル変数)。
    externs: name->decl (wrapper 引数)"""
    raw = ty.strip()
    is_ptr = "*" in raw
    is_ref = "&" in raw
    base = re.sub(r"\b(thread|device|constant|threadgroup|volatile|const)\b", "", raw)
    base = re.sub(r"coherent\s*\([^)]*\)", "", base)
    base = base.replace("*", "").replace("&", "").strip()
    base = re.sub(r"\s+", " ", base)
    base = concrete(base, vt)
    if is_ptr or is_ref:
        # _atomic<T>* は device extern 引数 (threadgroup local は非 kernel 関数では宣言不可:
        # 実機診断 observed_error。device overload へ name で解決される)
        inner = base
        m = re.match(r"_?atomic<\s*(\w+)\s*>", inner)
        if m:
            t = concrete(m.group(1), vt)
            nm = f"at{len(externs)}"
            externs[nm] = f"device atomic_{t} *"
            return nm
        name = f"pv{len(locals_defs)}"
        t = inner if inner not in ("void",) else "int"
        tt = VEC_RE.match(t)
        ini = f"{t}(0)" if tt else SCALAR.get(t)
        if ini is None:
            return None
        locals_defs.append((t, name, f" = {ini}"))
        return (f"&{name}" if is_ptr else name)
    if base in SCALAR:
        return SCALAR[base]
    if base in ENUM_VAL:
        return ENUM_VAL[base]
    m = VEC_RE.match(base)
    if m:
        return f"{base}({SCALAR.get(m.group(1),'0')})"
    if base.startswith("vec<"):
        inner = base[4:-1].replace(" ", "")
        p = inner.split(",")
        if len(p) == 2:
            t = concrete(p[0], vt)
            return f"{t}{p[1]}({SCALAR.get(t,'0')})"
    if base == "sampler":
        externs["s"] = "sampler"
        return "s"
    # texture/depth/vft 等のリソース型は extern 引数として wrapper が受ける
    tm = re.match(r"^((?:texture|depth)\w*)<([^>]*)>$", base)
    if tm:
        tname = tm.group(1)
        externs.setdefault("t" + str(len(externs)), f"{tname}<float>")
        nm = [k for k in externs if externs[k].startswith(tname)][-1]
        return nm
    if re.match(r"^(texture|depth)\w*$", base):
        externs.setdefault("t" + str(len(externs)), f"{base}<float>")
        return [k for k in externs if externs[k].startswith(base)][-1]
    if base.startswith("visible_function_table"):
        # run10 一次診断: visible_function_table<R(Args...)> は関数シグネチャ必須
        externs.setdefault("vft", "visible_function_table<void(uint)>")
        return "vft"
    if base.startswith("intersection_function_table"):
        # run10 一次診断: ift extern は metal::raytracing 完全修飾の tags 形
        externs.setdefault("ift",
            "metal::raytracing::intersection_function_table<metal::raytracing::instancing, metal::raytracing::triangle_data>")
        return "ift"
    if base == "function_handle":
        externs.setdefault("fn", "function_handle")
        return "fn"
    return None


def normalize_ret(ret, vt):
    r = re.sub(r"\s+", "", ret)
    r = re.sub(r"^(static|const|inline|constexpr|volatile)", "", r)
    tmpl = {"T": vt, "T2": "int", "U": vt}
    if r in tmpl:
        return tmpl[r]
    m = re.match(r"vec<(\w+),(\d)>", r)
    if m:
        t = concrete(m.group(1), vt)
        return f"{t}{m.group(2)}"
    m = re.match(r"^(\w+)(\d)$", r)
    if m and m.group(1) in tmpl:
        return f"{tmpl[m.group(1)]}{m.group(2)}"
    # テンプレ内の裸の型パラメータも具体化 (sparse_color<T> 等)
    r = re.sub(r"\bT2\b", "int", r)
    r = re.sub(r"\bT\b", vt, r)
    r = re.sub(r"\bU\b", vt, r)
    return re.sub(r"[^A-Za-z0-9_:<>]", "", r)


def resolve_branch(sig: str) -> str:
    """'#if defined(X) A #else B #endif' → B 側を決定的に採用 (coherent でない
    汎用変種は全ターゲットで有効。最終検証は実コンパイラ)。
    #if/#else/#endif に文字列レベルで作用するので `coherent(device)` のような
    括弧は影響しない。"""

    def _top_branch(s: str):
        i = s.find("#if")
        if i < 0:
            return s
        depth, j = 0, i + 3
        split_at = None
        end_at = None
        while j < len(s):
            if s.startswith("#if", j):
                depth += 1
                j += 3
                continue
            if s.startswith("#else", j) and depth == 1:
                split_at = j + 5
                j += 5
                continue
            if s.startswith("#endif", j):
                depth -= 1
                if depth == 0:
                    end_at = j
                    break
                j += 6
                continue
            j += 1
        if end_at is None:          # 対応する #endif が無い = 何もしない
            return s
        middle = s[split_at:end_at] if split_at is not None else s[i + 3:end_at]
        return s[:i] + middle + s[end_at + 6:]

    out, guard = sig, 0
    while "#if" in out and guard < 32:
        prev, out = out, _top_branch(out)
        guard += 1
        if out == prev:
            break
    return out


def parse_free(sig):
    sig = resolve_branch(sig)
    if "#if" in sig or "#else" in sig:
        return None
    m = SIG_HEAD.match(sig.strip())
    if not m:
        return None
    raw_args, tail = split_paren(m.group("rest"))
    if raw_args is None or "= delete" in tail:
        return None
    args = []
    raw_args = raw_args.strip()
    if raw_args and raw_args != "void":
        for a in split_top_commas(raw_args):
            a = a.strip()
            if "=" in a and not re.search(r"[<>]=", a):
                a = a.split("=")[0].strip()
            # METAL_MAYBE_UNDEF 等の引数装飾マクロは除去 (型には影響しない)
            a = re.sub(r"\bMETAL_[A-Z_]+\b", "", a).strip()
            a = re.sub(r"\s+", " ", a)
            # 'T *name' (ポインタ直結) / 'T &name' / 'T name' の全てを受理
            am = re.match(r"^(.+?)[\s\*&]+([A-Za-z_]\w*)$", a)
            if not am:
                return None
            ty = (am.group(1) + ("*" if "*" in a[:am.start(2)] else
                                  "&" if "&" in a[:am.start(2)] else "")).strip()
            args.append((ty, am.group(2).strip()))
    return {"ret": m.group("ret"), "name": m.group("name"), "args": args}


def main():
    rows = S.read_v2()
    targets = {r["__metal_builtin"] for r in rows
               if r["evidence"] in ("inferred", "observed_airconv")}
    idx_free = defaultdict(list)
    with open(os.path.join(S.DATA, "msl_stage1_methods.csv"), newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            if r["class"].strip():
                continue
            for b in re.split(r"[ ;]", r["metal_builtins"]):
                b = b.strip()
                if b in targets:
                    idx_free[b].append(r)

    coverage = []
    blocks = []
    manifest = []
    for b in sorted(targets):
        cands = idx_free.get(b, [])
        if not cands:
            continue
        chosen = None
        for r in cands:
            pm = parse_free(r["member_signature"])
            if pm and len(pm["args"]) <= 6:
                chosen = (r, pm)
                if not r["guard"].strip():
                    break
        if not chosen:
            coverage.append({"builtin": b, "status": "no_parseable"})
            continue
        r, pm = chosen
        # T 具体化の方針: atomic は int、quad_and/or/xor・simd 整数還元は integral 限定
        # (一次ヘッダ __is_valid_quadgroup_integral_type / simd 還元の enable_if)
        INTEGRAL_ONLY = ("quad_and", "quad_or", "quad_xor",
                         "simd_and", "simd_or", "simd_xor",
                         "simd_min", "simd_max", "simd_product", "simd_sum",
                         "popcount", "clz", "ctz")
        if "atomic" in pm["name"] or "atomic" in b or pm["name"] in INTEGRAL_ONLY:
            vt = "int"
        else:
            vt = "float"
        locals_defs, externs, call_args = [], {}, []
        ok = True
        for ty, _an in pm["args"]:
            dv = dummy(ty, locals_defs, vt, externs)
            if dv is None:
                ok = False
                break
            call_args.append(dv)
        if not ok:
            coverage.append({"builtin": b, "status": "unsupported_args"})
            continue
        ret = normalize_ret(pm["ret"], vt)
        sym = f"probe_p07f_{pm['name']}_{len(manifest)}"
        decls = "".join(f"  {t} {n}{ini};\n" for t, n, ini in locals_defs)
        # run10 一次診断: intersection_function_table 系は metal::raytracing:: 名前空間
        ns = "metal::raytracing::" if "intersection_function_table" in pm["name"] else "metal::"
        call = f"{ns}{pm['name']}({', '.join(call_args)});"
        params = ", ".join(f"{d} {n}" for n, d in externs.items())
        body = decls + (f"  return {call}" if ret != "void" else f"  {call}")
        if ret != "void":
            body = decls + f"  return {call}"
        src = (f"// builtin={b}\n"
               f'extern "C" {ret} {sym}({params}) {{\n{body}\n}}\n')
        guard = S.guard_expr(r["guard"].strip())
        if guard:
            src = f"#if {guard}\n{src}#endif\n"
        blocks.append(src)
        manifest.append({"scene": "P07F", "file": "probe.metal", "symbol": sym,
                         "builtin": b, "stage1_source": "auto_free"})
        coverage.append({"builtin": b, "status": "generated"})

    d = os.path.join(OUT_DIR, "scene_P07F_free")
    os.makedirs(d, exist_ok=True)
    header = ("// scene P07F: free 関数 builtin wrapper (build_free_probes.py)\n"
              f"// 生成: {S.today()}\n"
              "#include <metal_stdlib>\nusing namespace metal;\n\n")
    with open(os.path.join(d, "probe.metal"), "w", encoding="utf-8") as f:
        f.write(header + "\n".join(blocks))
    with open(os.path.join(OUT_DIR, "MANIFEST_free.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["scene", "file", "symbol", "builtin", "stage1_source"])
        w.writeheader()
        w.writerows(manifest)
    with open(os.path.join(S.DATA, "free_probe_coverage.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["builtin", "status"])
        w.writeheader()
        w.writerows(coverage)
    st = Counter(c["status"] for c in coverage)
    S.log_event("GEN_FREE_PROBES", f"build_free_probes.py@{S.SCRIPT_VERSION}",
                "probe_scenes_methods/scene_P07F_free",
                f"generated={st.get('generated',0)} no_parseable={st.get('no_parseable',0)} "
                f"unsupported={st.get('unsupported_args',0)} (対象 free 索引 {len(idx_free)})")
    print(dict(st), "manifest", len(manifest))


if __name__ == "__main__":
    main()
