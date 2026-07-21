#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_method_probes.py — method 系 builtin の extern-C wrapper probe を機械生成する器。

目的: builtin_to_air_map.v2.csv の inferred (used_via に method を含む) を一気に probe 化。
方式: builtin ごとに「その builtin を呼ぶ stdlib メソッド 1 本」を選び、
      ダミー引数つき extern "C" wrapper を生成 (name は apply-golden の突合鍵)。
      生成不能な型はコメント化して残す → リモートのエラー駆動削りループで収束。

出力:
  probe_scenes_methods/scene_<SCENE>M_*/probe.metal  (wrapper 群)
  probe_scenes_methods/MANIFEST_methods.csv          (scene,file,symbol,builtin,stage1_source)
  data/method_probe_coverage.csv                     (builtin → 生成可否・選定メソッド)

設計原則: 生成不能は毒を混入しない (コメント)。リモートのコンパイラが最終検証者 (generate-and-verify)。
"""
import csv
import os
import re
import sys
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

OUT_DIR = os.path.join(S.ROOT, "probe_scenes_methods")

# --- クラス名 → (public 型名, ダミー extern 引数) -------------------------------
TEXTURE_BASES = [
    "texture1d", "texture1d_array", "texture2d", "texture2d_array",
    "texture2d_ms", "texture2d_ms_array", "texture3d", "texture_buffer",
    "texturecube", "texturecube_array",
]
DEPTH_BASES = ["depth2d", "depth2d_array", "depth2d_ms", "depth2d_ms_array",
               "depthcube", "depthcube_array"]

# クラス名 _<base>_<capability...> → base を dict 完全一致で取出す
# (2026-07-21 修正: 旧 _BASE_RE は alternation 順で `_depth2d_ms` を `depth2d` に
#  短縮マッチし class_public_type 誤起票していた — run10 一次エラーで確定。EVENTLOG XW_BUILDERBUG)
_BASES_SORTED = sorted(TEXTURE_BASES + DEPTH_BASES, key=len, reverse=True)

def _match_base(cls: str):
    for b in _BASES_SORTED:
        if cls.startswith("_" + b + "_") or cls == "_" + b:
            return b
    return None


def class_public_type(cls: str):
    """(_class) -> (extern C++ 型宣言, extern 引数名, value_type 例:
    _texture2d_sample -> ('texture2d<float>', 't', 'float')
    _texture2d_atomic_fetch_and -> ('texture2d<uint, access::read_write>', 't', 'uint')
    _depth2d_sample -> ('depth2d<float>', 'd', 'float')
    value_type はクラステンプレ T の具体型 (ダミー引数・返り値の正規化に使用)"""
    base = _match_base(cls)
    if not base:
        return None
    if base in DEPTH_BASES:
        return (f"{base}<float>", "d", "float")
    if base in TEXTURE_BASES:
        if "_atomic" in cls or base == "texture_buffer" and "atomic" in cls:
            return (f"{base}<uint, access::read_write>", "t", "uint")
        # write 系メソッドは access::write 宣言が必須 (run10 一次診断:
        #  "no member named 'write' ... access::sample")。class 名の _write サフィックスで駆動
        if cls.endswith("_write") or "_write_" in cls:
            return (f"{base}<float, access::write>", "t", "float")
        return (f"{base}<float>", "t", "float")
    return None


# 非テクスチャの簡易クラス (コンストラクタ・種類が単純)
SPECIAL_CLASSES = {
    "os_log": ("os_log", "lg"),     # メソッドは static 系が多い
}

# --- ダミー値生成 ----------------------------------------------------------------
SCALAR = {
    "bool": "true", "char": "0", "short": "0", "int": "0", "uint": "0u",
    "uchar": "0", "ushort": "0", "long": "0", "ulong": "0ul",
    "half": "1.0h", "float": "1.0f", "double": "1.0", "bfloat": "1.0",
    "size_t": "0", "ptrdiff_t": "0",
}
ENUM_VAL = {
    "memory_order": "memory_order_relaxed",
    "mem_flags": "mem_flags::mem_device",
    "thread_scope": "thread_scope_device",
    "coordinate": "normalized_coordinate",
    "address": "address::repeat", "mag_filter": "mag_filter::linear",
    "min_filter": "min_filter::linear", "mip_filter": "mip_filter::linear",
    "s_address": "s_address::repeat", "t_address": "t_address::repeat",
    "r_address": "r_address::repeat", "compare_func": "compare_func::less",
    "border_color": "border_color::transparent_black",
    "reduction_operation": "reduction_operation::sum",
    "component": "component::x",
}
OPTION_CTOR = {
    "bias": "bias(1.0f)", "level": "level(1.0f)",
    "min_lod_clamp": "min_lod_clamp(1.0f)", "lod_clamp": "min_lod_clamp(1.0f)",
    "gradient2d": "gradient2d(float2(0.5f), float2(0.5f))",
    "gradient3d": "gradient3d(float3(0.5f), float3(0.5f))",
    "gradientcube": "gradientcube(float3(0.5f), float3(0.5f))",
    "lod_options": "bias(1.0f)",
}
VEC_RE = re.compile(r"^(float|half|int|uint|bool|short|ushort|char|uchar|bfloat|double|long|ulong)([234])$")


def dummy_value(ty: str, externs: dict, vt: str = "float"):
    """型 ty のダミー値と、必要なら externs (wrapper 追加引数) を返す。不可なら None。
    externs: name -> type_decl (wrapper 引数として追加)"""
    ty = ty.strip()
    ty = re.sub(r"\b(thread|device|constant|threadgroup|coherent\s*\([^)]*\)|volatile|const)\b\s*", "", ty).strip()
    ty = re.sub(r"\s+", " ", ty)
    base = ty.replace("&", "").replace("*", "").strip()
    # 修飾除去後の型で判定
    if base in SCALAR:
        return SCALAR[base]
    if base in ENUM_VAL:
        return ENUM_VAL[base]
    if base in OPTION_CTOR:
        return OPTION_CTOR[base]
    m = VEC_RE.match(base)
    if m:
        t, n = m.group(1), m.group(2)
        lit = SCALAR.get(t, "0")
        return f"{t}{n}({lit})"
    if base == "sampler":
        externs["s"] = "sampler"
        return "s"
    if base.endswith("texture") or "texture" in base:
        return None  # texture 引数は複雑なので unsupported
    if base.startswith("vec<"):
        inner = base[4:-1].replace(" ", "")
        if "," in inner:
            t, n = inner.split(",")
            # テンプレ型 T/T2/U はクラス value_type に決め打ち
            t = {"T": vt, "T2": "int" if vt == "uint" else vt, "U": vt}.get(t, t)
            lit = SCALAR.get(t, "0")
            alias = f"{t}{n}" if n in "234" else f"vec<{t},{n}>"
            return f"{alias}({lit})"
    if base in ("uint32_t", "uint16_t", "uint8_t"):
        return "0u"
    if base in ("int32_t", "int16_t", "int8_t"):
        return "0"
    if base in ("size_t",):
        return "0"
    # array index など
    if base in ("T", "U"):
        return "0u" if vt == "uint" else "1.0f"
    if base == "T2":
        return "0"
    if base == "bool_constant":
        return "bool_constant<true>()"
    return None


SIG_HEAD = re.compile(
    r"^METAL_FUNC\s+(?P<ret>.+?)\s+(?P<name>[A-Za-z_]\w*)(?P<rest>\(.*)$", re.S)


def _split_paren_args(s: str):
    """最初の '(' から対応する閉じ ')' までを取り出す (貪欲正規表現回避:
    tail の METAL_CONST_ARG(...) 等を args に飲み込まない)。返り値 (args_str, tail)。"""
    open_idx = s.find("(")
    if open_idx < 0:
        return None, s
    depth = 0
    for i in range(open_idx, len(s)):
        c = s[i]
        if c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
            if depth == 0:
                return s[open_idx + 1:i], s[i + 1:]
    return None, s


def parse_method(sig: str):
    """METAL_FUNC 宣言を分解。失敗/#if混在なら None。"""
    sig = sig.strip()
    if "#if" in sig or "#else" in sig:
        # 条件分岐を含む複雑 declaration は機械生成しない (安全側)
        return None
    m = SIG_HEAD.match(sig)
    if not m:
        return None
    raw_args, tail = _split_paren_args(m.group("rest"))
    if raw_args is None:
        return None
    if "= delete" in tail or "=delete" in tail:
        return None
    ret = m.group("ret").strip()
    # 修飾語除去
    ret = re.sub(r"\b(const|static|inline|constexpr|volatile|METAL_DEPRECATED\([^)]*\))\b", "", ret).strip()
    name = m.group("name")
    raw_args = raw_args.strip()
    args = []
    if raw_args and raw_args != "void":
        depth = 0
        cur = ""
        for ch in raw_args:
            if ch in "(<[":
                depth += 1
            elif ch in ")>]":
                depth -= 1
            if ch == "," and depth == 0:
                args.append(cur)
                cur = ""
            else:
                cur += ch
        if cur.strip():
            args.append(cur)
    parsed_args = []
    for a in args:
        a = a.strip()
        if "=" in a and not re.search(r"[<>]=", a):
            a = a.split("=")[0].strip()   # デフォルト引数は省略 (安全側)
        am = re.match(r"^(.+?)[\s\*&]+([A-Za-z_]\w*)$", a)
        if not am:
            return None
        ty = (am.group(1) + ("*" if "*" in a[:am.start(2)] else
                              "&" if "&" in a[:am.start(2)] else "")).strip()
        parsed_args.append((ty, am.group(2).strip()))
    return {"ret": ret, "name": name, "args": parsed_args,
            "is_static": "static" in m.group(0).split(name)[0]}


def normalize_ret(ret: str, vt: str = "float"):
    r = re.sub(r"\s+", "", ret)
    r = re.sub(r"^(static|const|inline|constexpr)", "", r)
    alias = {"float": "float", "uint": "uint", "int": "int"}[vt]
    tmpl = {"T": alias, "T2": "int" if vt == "uint" else alias, "U": alias}
    def rep(mm):
        t, n = mm.group(1), mm.group(2)
        t = tmpl.get(t, t)
        return f"{t}{n}"
    r = re.sub(r"vec<(\w+),(\d)>", rep, r)
    if r in tmpl:
        return tmpl[r]
    m = re.match(r"^(\w+)(\d)$", r)
    if m and m.group(1) in tmpl:
        return f"{tmpl[m.group(1)]}{m.group(2)}"
    # テンプレ内の裸の型パラメータも具体化 (sparse_color<T>, array<T, N> 等)
    r = re.sub(r"\bT2\b", "int", r)
    r = re.sub(r"\bT\b", alias, r)
    r = re.sub(r"\bU\b", alias, r)
    if re.search(r"[^A-Za-z0-9_:<>]", r):
        r = re.sub(r"[^A-Za-z0-9_:<>]", "", r)
    return r


def main():
    # 対象 builtin: method を含み未確定 (inferred/observed_airconv) のもののみ
    rows = S.read_v2()
    targets = {r["__metal_builtin"] for r in rows
               if "method" in r["used_via"]
               and r["evidence"] in ("inferred", "observed_airconv")}
    print(f"対象 builtin: {len(targets)}")

    # stage1 methods から builtin -> メソッド行を索引
    builtin_methods = defaultdict(list)
    with open(os.path.join(S.DATA, "msl_stage1_methods.csv"), newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            bl = [b.strip() for b in re.split(r"[ ;]", r["metal_builtins"]) if b.strip()]
            for b in bl:
                if b in targets:
                    builtin_methods[b].append(r)

    coverage = []
    blocks_by_scene = defaultdict(list)
    manifest = []
    idx = 0
    for b in sorted(targets):
        cands = builtin_methods.get(b, [])
        chosen = None
        chosen_cls = None
        # 選択優先: クラス既知・guard 空・引数少・単純名
        # 一次一致優先: builtin/class の素片がメソッド名に含まれるものを先に選ぶ
        # (誤帰属 class で同名他メソッドを採用する事故を防ぐ: 一次ヘッダ上
        #  get_num_samples は _depth2d_ms 系、write は _texture*_write 系の実メソッド)
        # builtin から「期待メソッド名」を導出 (一次: class 誤帰属対策の厳密フィルタ)
        kb = b.replace("__metal_", "")
        # texture/depth 型名を剥がす (例: get_num_samples_depth_2d_ms_t -> get_num_samples)
        kb = re.split(r"_(?:texture|depth|render_command|compute_command|intersection_query|intersection_result|command_buffer|mesh|imageblock|tensor|sampler|visible_function_table|function_handle|acceleration_structure)_", kb)[0]
        key = kb
        scored = []
        for r in cands:
            cls = r["class"].strip()
            pt = class_public_type(cls)
            pm = parse_method(r["member_signature"])
            if pt is None or pm is None:
                continue
            if len(pm["args"]) > 6:
                continue
            name_key = key
            # builtin 先頭動詞 (get_width/get_num_samples/read/write/sample...) とメソッド一致で +2
            verb = key.split("_")[0]
            base_verb = "_".join(key.split("_")[:2]) if key.split("_")[0] in ("get", "is", "set", "draw", "map") else verb+("_"+key.split("_")[1] if verb=="get" else "")
            sc = 0
            if pm["name"] in key or key.endswith(pm["name"]):
                sc = 4
            elif pm["name"].replace("_","") in key.replace("_",""):
                sc = 2
            elif pm["name"] == base_verb:
                sc = 1
            scored.append((sc, bool(not r["guard"].strip()), r, pm, cls))
        for sc, ng, r, pm, cls in sorted(scored, key=lambda x: (-x[0], -int(x[1]))):
            chosen = (r, pm)
            chosen_cls = cls
            if sc > 0:
                break
            break

        if not chosen:
            coverage.append({"builtin": b, "status": "no_generatable_method",
                             "method": "", "class": ""})
            continue
        r, pm = chosen
        cls_decl, varname, vt = class_public_type(chosen_cls)
        externs = {}
        call_args = []
        locals_defs = []
        ok = True
        for ty, an in pm["args"]:
            if "*" in ty or "&" in ty:
                # thread ポインタ/参照 (cmpxchg の expected 等) は thread local で供給。
                # device/constant/threadgroup 修飾は非 kernel 関数では不可 → 生成不能。
                if re.search(r"\b(device|constant|threadgroup)\b", ty) and "coherent" not in ty:
                    ok = False
                    break
                b2 = re.sub(r"\b(thread|const|volatile|coherent\s*\([^)]*\))\b", "", ty)
                b2 = b2.replace("*", "").replace("&", "").strip()
                b2 = re.sub(r"\s+", "", b2)
                b2 = {"T": vt, "U": vt, "T2": "int"}.get(b2, b2)
                mv = re.match(r"^vec<(\w+),(\d)>$", b2)
                if mv:
                    b2 = {"T": vt, "U": vt, "T2": "int"}.get(mv.group(1), mv.group(1)) + mv.group(2)
                m2 = VEC_RE.match(b2)
                ini = SCALAR.get(b2) or (f"{b2}(0)" if m2 else None)
                if ini is None:
                    ok = False
                    break
                nm = f"loc{len(locals_defs)}"
                locals_defs.append((b2, nm, ini))
                call_args.append(("&" if "*" in ty else "") + nm)
                continue
            dv = dummy_value(ty, externs, vt)
            if dv is None:
                ok = False
                break
            call_args.append(dv)
        if not ok:
            coverage.append({"builtin": b, "status": "unsupported_arg_types",
                             "method": pm["name"], "class": chosen_cls})
            continue
        ret = normalize_ret(pm["ret"], vt)
        params = [f"{cls_decl} {varname}"] + [f"{d} {n}" for n, d in externs.items()]
        sym = f"probe_p06m_{pm['name']}_{idx}"
        idx += 1
        decls = "".join(f"{t} {n} = {ini}; " for t, n, ini in locals_defs)
        body = f"{varname}.{pm['name']}({', '.join(call_args)});"
        if ret != "void":
            body = f"return {body}"
        core = (f"// builtin={b} cls={chosen_cls}\n"
                f'extern "C" {ret} {sym}({", ".join(params)}) {{ {decls}{body} }}\n')
        guard = S.guard_expr(r["guard"].strip())
        if guard:
            core = (f"#if {guard}\n{core}#else\n"
                    f"// guard {r['guard'].strip()} 無効ターゲットでは無効化\n#endif\n")
        blocks_by_scene["P06M"].append(core)
        manifest.append({"scene": "P06M", "file": "probe.metal", "symbol": sym,
                         "builtin": b, "stage1_source": "auto_method"})
        coverage.append({"builtin": b, "status": "generated",
                         "method": pm["name"], "class": chosen_cls})

    os.makedirs(OUT_DIR, exist_ok=True)
    n_gen = 0
    for scene, blocks in blocks_by_scene.items():
        d = os.path.join(OUT_DIR, f"scene_{scene}_methods")
        os.makedirs(d, exist_ok=True)
        header = (f"// scene {scene}: method 系 builtin wrapper (build_method_probes.py@{S.SCRIPT_VERSION})\n"
                  f"// 生成: {S.today()} — リモート エラー駆動削りループで収束させる\n"
                  "#include <metal_stdlib>\nusing namespace metal;\n\n")
        with open(os.path.join(d, "probe.metal"), "w", encoding="utf-8") as f:
            f.write(header + "\n".join(blocks))
        n_gen += len(blocks)

    with open(os.path.join(OUT_DIR, "MANIFEST_methods.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["scene", "file", "symbol", "builtin", "stage1_source"])
        w.writeheader()
        for m in manifest:
            w.writerow(m)
    with open(os.path.join(S.DATA, "method_probe_coverage.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["builtin", "status", "method", "class"])
        w.writeheader()
        for c in coverage:
            w.writerow({k: c.get(k, "") for k in ["builtin", "status", "method", "class"]})

    from collections import Counter
    st = Counter(c["status"] for c in coverage)
    S.log_event("GEN_METHOD_PROBES", f"build_method_probes.py@{S.SCRIPT_VERSION}",
                "probe_scenes_methods/",
                f"対象 {len(targets)} builtin: generated={st.get('generated',0)} "
                f"no_generatable={st.get('no_generatable_method',0)} "
                f"unsupported_args={st.get('unsupported_arg_types',0)}")
    print("coverage:", dict(st))
    print(f"wrote {OUT_DIR} ({n_gen} blocks), manifest {len(manifest)} 件")


if __name__ == "__main__":
    main()
