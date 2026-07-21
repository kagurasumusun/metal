#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_construct_probes.py — 「extern 引数で渡せないクラス」の probe を機械生成。

対象 (build_method_probes で no_generatable_method になった builtin のうち、
実ヘッダ (metal_raytracing / metal_command_buffer / metal_simdgroup) で
構築方法が一次確認できたクラス):

  intersection_query(+ext)      : ray __r; intersection_query<tags> __q;          __q.m(...)
  intersection_result(+ext)     : intersector 経由 __i.intersect(__r,__as)        __res.m(...)
  intersection_result_ref(+ext) : intersector 経由 callback で受領                __ref.m(...)
  compute/render command        : command_buffer __cb; xxx_command __c(__cb,0u);  __c.m(...)
  simd_vote                     : simd_vote __v;                                  __v.m(...)
  *_t 型 builtin                : pass-through wrapper で opaque 型を IR に出す

設計原則は他の生成器と同じ: 生成不能は毒を混入しない (コメント + coverage に残す)、
最終検証者は実機コンパイラ (削りループ)。
"""
import csv
import os
import re
import sys
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S
from build_method_probes import parse_method  # 共有パーサ (main は __main__ guard 済)

OUT_DIR = os.path.join(S.ROOT, "probe_scenes_methods")

# --- クラス集合 ----------------------------------------------------------------
IQ_CLASSES = {"intersection_query", "_intersection_query_instancing_ext",
              "_intersection_query_triangle_data_ext", "_intersection_query_curve_data_ext"}
IR_CLASSES = {"intersection_result", "_intersection_result_instancing_ext",
              "_intersection_result_triangle_data_ext",
              "_intersection_result_world_space_data_ext"}
IRR_CLASSES = {"intersection_result_ref", "_intersection_result_ref_instancing_ext",
               "_intersection_result_ref_triangle_data_ext",
               "_intersection_result_ref_world_space_data_ext",
               "_intersection_result_ref_curve_data_ext"}
CMD_COMPUTE = {"compute_pipeline_state", "compute_command"}
CMD_RENDER = {"render_pipeline_state", "render_command"}
VOTE_CLASSES = {"simd_vote"}
INTERPOLANT_CLASSES = {"interpolant"}

# stage1 が誤帰属させた builtin の class 訂正 (一次ヘッダ metal_raytracing 1595-1790
# 実測: intersection_function_table のメンバ群が intersection_result に流れていた)
BUILTIN_CLASS_OVERRIDE = {
    "__metal_get_size_intersection_function_table": "intersection_function_table",
    "__metal_set_buffer_intersection_function_table": "intersection_function_table",
    "__metal_get_buffer_intersection_function_table": "intersection_function_table",
}
IFT_CLASSES = {"intersection_function_table"}

# pass-through で opaque 型を IR 上に出したい class -> public 型名 (実ヘッダ由来)
TYPE_PUBLIC = {
    "compute_pipeline_state": "compute_pipeline_state",
    "render_pipeline_state": "render_pipeline_state",
    "command_buffer": "command_buffer",
    "depth_stencil_state": "depth_stencil_state",
    "intersection_function_table": "intersection_function_table<instancing, triangle_data>",
    "ray": "ray",
    "intersection_params": "intersection_params",
    "interpolant": "interpolant<float, interpolation::perspective>",
    "intersection_query": "intersection_query<instancing, triangle_data>",
    "intersection_result": "intersection_result<instancing, triangle_data>",
    "primitive_acceleration_structure": "primitive_acceleration_structure",
    "instance_acceleration_structure": "instance_acceleration_structure",
    "visible_function_table": "visible_function_table<>",
    "os_log": "os_log",
    "tensor": "tensor<float, extents<int, 4, 8>>",
}

AS_TYPE = {"primitive": "primitive_acceleration_structure",
           "instance": "instance_acceleration_structure"}

# enum ダミー (実ヘッダ metal_command_buffer / metal_graphics の定義に一致)
ENUM_DUMMY = {
    "primitive_type": "primitive_type::triangle",
    "cull_mode": "cull_mode::back",
    "winding": "winding::counter_clockwise",
    "triangle_fill_mode": "triangle_fill_mode::fill",
    "depth_clip_mode": "depth_clip_mode::clip",
}
VALUE_DUMMY = {
    "bool": "true", "char": "0", "short": "0", "int": "0", "uint": "0u",
    "uint32_t": "0u", "int32_t": "0", "ushort": "0", "size_t": "0",
    "ulong": "0ul", "long": "0l", "half": "1.0h", "float": "1.0f",
    "double": "1.0", "float3": "float3(0.0f)", "float2": "float2(0.0f)",
    "float4": "float4(0.0f)", "uint3": "uint3(0u)", "uint2": "uint2(0u)",
    "uint": "0u", "ushort2": "ushort2(0u)", "int3": "int3(0)", "int2": "int2(0)",
    "intersection_params": "intersection_params()",
    "viewport": "viewport{0.0, 0.0, 1.0, 1.0, 0.0, 1.0}",
    "scissor_rect": "scissor_rect{0u, 0u, 1u, 1u}",
}
# extern 引数として wrapper に足す型 (opaque / address-space ポインタ)
EXTERN_DUMMY = {
    "compute_pipeline_state": ("ps", "compute_pipeline_state"),
    "render_pipeline_state": ("ps", "render_pipeline_state"),
    "depth_stencil_state": ("dss", "depth_stencil_state"),
    "command_buffer": ("cb", "command_buffer"),
    "intersection_function_table<Tags...>": ("ift", "intersection_function_table<instancing, triangle_data>"),
    "intersection_function_buffer_arguments": ("ifba", "const device void *"),
    "compute_command": ("cc2", "compute_command"),
    "render_command": ("rc2", "render_command"),
}


def _strip_addr(ty: str) -> str:
    ty = re.sub(r"\b(thread|device|constant|threadgroup|volatile|const|coherent\s*\([^)]*\))\b\s*", "", ty)
    return re.sub(r"\s+", " ", ty).strip()


def construct_dummy(ty: str, externs: dict, idx: int):
    """construct 系メソッド引数のダミー。【追加版】pointer / opaque を extern 化。"""
    raw = ty.strip()
    base = _strip_addr(raw).replace("&", "").strip()
    if "T" == base or base == "U":
        base = "int"
    if base in ENUM_DUMMY:
        return ENUM_DUMMY[base]
    if base in VALUE_DUMMY and "*" not in raw and "&" not in raw:
        return VALUE_DUMMY[base]
    if base in EXTERN_DUMMY:
        nm, decl = EXTERN_DUMMY[base]
        externs[nm] = decl
        return nm
    # ポインタ引数: address-space で extern 引数化
    if "*" in raw:
        aspace = "device" if "device" in raw else ("constant" if "constant" in raw else None)
        core = _strip_addr(raw).replace("*", "").strip()
        core = re.sub(r"^(?:const\s+)?", "", core)
        if core in ("T", "U", "void") or core.endswith("/*closure*/ void"):
            core = {"T": "int", "U": "int", "void": "void"}.get(core, "int")
        if core not in ("int", "uint", "float", "void", "char", "uchar", "short", "ushort"):
            return None
        if aspace is None:
            return None
        nm = f"p{len(externs)}"
        cnst = "const " if re.match(r"^\s*const\b", raw) else ""
        externs[nm] = f"{aspace} {cnst}{core} *"
        return nm
    # テクスチャ類
    if base.startswith(("texture", "depth")) or "sampler" == base:
        return None  # 本 wave では texture emit は method 系に任せる
    # visible_function_table<T> は extern 引数化 (一次ヘッダ: template<typename T>
    # set_visible_function_table(visible_function_table<T> vft, uint index))
    if base.startswith("visible_function_table"):
        nm = f"vft{len(externs)}"
        externs[nm] = "visible_function_table<>"
        return nm
    return None


def normalize_ret_raw(ret: str) -> str:
    r = re.sub(r"\s+", " ", ret).strip()
    r = re.sub(r"\b(const |static |inline |constexpr |volatile )", "", r)
    r = re.sub(r"\bT2\b", "int", r)
    r = re.sub(r"\b[TU]\b", "int", r)
    return r


def make_block(sym, ret, receiver_setup, call, guard_src, builtin, cls, wrapper_params):
    params = ", ".join(wrapper_params) if wrapper_params else "void"
    body_lines = "\n    ".join(receiver_setup)
    stmt = f"return {call};" if ret != "void" else f"{call}; return;"
    core = (f"// builtin={builtin} cls={cls}\n"
            f'extern "C" {ret} {sym}({params}) {{\n    {body_lines}\n    {stmt}\n}}\n')
    if guard_src:
        core = (f"#if {guard_src}\n{core}#else\n"
                f"// guard 無効ターゲットでは無効化\n#endif\n")
    return core


def tags_for(guard: str, need_instancing=True) -> str:
    t = "instancing, triangle_data"
    if "CURVES" in guard:
        t += ", curve_data"
    return t


def main():
    rows = S.read_v2()
    targets = {r["__metal_builtin"] for r in rows
               if "method" in r["used_via"]
               and r["evidence"] in ("inferred", "observed_airconv")}
    builtin_methods = defaultdict(list)
    with open(os.path.join(S.DATA, "msl_stage1_methods.csv"), newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            bl = [b.strip() for b in re.split(r"[ ;]", r["metal_builtins"]) if b.strip()]
            for b in bl:
                if b in targets:
                    builtin_methods[b].append(r)

    blocks, manifest, coverage = [], [], []
    idx = 0
    emitted_builtins = set()

    def emit(sym_kind, b, cls, ret, setup, call, guard, params):
        nonlocal idx
        if b in emitted_builtins:
            return False
        emitted_builtins.add(b)
        sym = f"probe_p08m_{sym_kind}_{idx}"
        idx += 1
        blocks.append(make_block(sym, ret, setup, call, S.guard_expr(guard), b, cls, params))
        manifest.append({"scene": "P08M", "file": "probe.metal", "symbol": sym,
                         "builtin": b, "stage1_source": "auto_construct"})
        coverage.append({"builtin": b, "status": "generated", "class": cls})

    for b in sorted(targets):
        cands = builtin_methods.get(b, [])
        emitted = False
        for r in cands:
            cls = BUILTIN_CLASS_OVERRIDE.get(b, r["class"].strip())
            sig = r["member_signature"]
            if "= default" in sig or "= delete" in sig:
                continue
            pm = parse_method(sig)
            if pm is None:
                continue
            name = pm["name"]
            if name in ("intersection_query", "intersection_result", "intersector",
                        "intersection_function_table",
                        "compute_command", "render_command", "simd_vote", "operator="):
                continue
            cls = BUILTIN_CLASS_OVERRIDE.get(b, cls)
            guard = r["guard"].strip()
            # 一次ヘッダ行で検証済の IFT builtin を name ベースで追補
            # (stage1 は enable_if 戻り行の一部を落とすため class 帰属が不安定)
            if b.startswith(("__metal_get_size_", "__metal_set_buffer_",
                             "__metal_get_buffer_", "__metal_get_visible_function_table_",
                             "__metal_set_visible_function_table_")) and \
                    b.endswith(("_intersection_function_table",)):
                cls = "intersection_function_table"
            externs = {}
            args_ok, call_args = True, []
            for ty, an in pm["args"]:
                dv = construct_dummy(ty, externs, idx)
                if dv is None:
                    args_ok = False
                    break
                call_args.append(dv)
            if not args_ok:
                continue
            params = [f"{d} {n}" for n, d in externs.items()]
            call = f"{{recv}}.{name}({', '.join(call_args)})"
            ret = normalize_ret_raw(pm["ret"])
            if re.search(r"[&*]|Tags\.\.\.", ret) and "void" not in ret:
                # 参照/ポインタ返しは wrapper 返却型に使えないもののみ除外 (const device void* は許す)
                if "void *" not in ret.replace("  ", " "):
                    continue
                if "*" in ret and "void" not in ret:
                    continue
            tags = tags_for(guard)
            if cls in IQ_CLASSES:
                setup = ["ray __r;", f"intersection_query<{tags}> __q;"]
                emit("iq", b, cls, ret, setup, call.format(recv="__q"), guard, params)
            elif cls in IR_CLASSES:
                setup = ["ray __r;", "instance_acceleration_structure __as;",
                         f"intersector<{tags}> __i;", "auto __res = __i.intersect(__r, __as);"]
                emit("ir", b, cls, ret, setup, call.format(recv="__res"), guard, params)
            elif cls in IRR_CLASSES:
                if ret == "void":
                    continue
                # 2026-07-21 実機観測: default-construct の primitive AS (= null) を
                # 使うと callback 全体が DCE で畳まれ air 呼出が消える。
                # → AS は extern 引数化して folding を防ぐ。
                setup = ["ray __r;",
                         f"intersector<{tags}> __i;",
                         f"{ret} __out{{}};",
                         f"__i.intersect(__r, __as, [&](intersection_result_ref<{tags}> __ref){{ __out = __ref.{name}({', '.join(call_args)}); }});"]
                emit("irr", b, cls, ret, setup, "(__out)", guard,
                     params + ["primitive_acceleration_structure __as"])
            elif cls in IFT_CLASSES:
                # 一次ヘッダ metal_raytracing 1595-1790 実測に基づく手組 cell
                # (template get_buffer は戻り依存のため明示実引数が必要)
                setup = [f"intersection_function_table<{tags}> __ift;"]
                if name == "get_buffer":
                    ret = "bool"
                    call = "({recv}.get_buffer<device int *>(0u) != nullptr)"
                emit("ift", b, cls, ret, setup, call.format(recv="__ift"), guard, params)
            elif cls in CMD_COMPUTE:
                setup = ["command_buffer __cb;", "compute_command __cc(__cb, 0u);"]
                emit("cc", b, cls, ret, setup, call.format(recv="__cc"), guard, params)
            elif cls in CMD_RENDER:
                setup = ["command_buffer __cb;", "render_command __rc(__cb, 0u);"]
                emit("rc", b, cls, ret, setup, call.format(recv="__rc"), guard, params)
            elif cls in VOTE_CLASSES:
                setup = ["simd_vote __v;"]
                emit("vote", b, cls, ret, setup, call.format(recv="__v"), guard, params)
            elif cls in INTERPOLANT_CLASSES:
                # 実機 oneoff 検証済 (2026-07-21): extern "C" 内で default-construct
                # interpolant 可能、air.interpolate_* 実呼出を確認
                mode = "no_perspective" if "no_perspective" in b else "perspective"
                setup = [f"interpolant<float, interpolation::{mode}> __ip;"]
                emit("ip", b, cls, ret, setup, call.format(recv="__ip"), guard, params)
            elif cls == "_acceleration_structure_base":
                name2 = name
                for kind, ty in AS_TYPE.items():
                    if kind in b:
                        if name2.startswith("get_instance_count"):
                            setup = [f"{ty} __as;"]
                            emit("as", b, cls, ret, setup, "__as.get_instance_count()", guard, params)
                        else:
                            # get_null / is_null は default ctor + free is_null_* で両方出る
                            setup = [f"{ty} __as;"]
                            emit("as", b, cls, "bool", setup, f"is_null_{kind}_acceleration_structure(__as)", guard, params)
                        emitted = True
                        break
                if emitted:
                    emitted = False
                    continue
                break
            else:
                continue
            emitted = True
            break
        if not emitted and (b.endswith("_t") or b.endswith("_t_v2")):
            pass  # 型 pass-through は下で一括

    # --- 型 pass-through probes -------------------------------------------------
    for b in sorted(targets):
        m = re.match(r"^__metal_(.+)_t(?:_v2)?$", b)
        if not m:
            continue
        pub = None
        for clsname, pubty in TYPE_PUBLIC.items():
            key = clsname.replace("_", "")
            if m.group(1).replace("_", "") == key:
                pub = pubty
                break
        if pub is None:
            continue
        if any(mf["builtin"] == b for mf in manifest):
            continue
        sym = f"probe_p08m_type_{idx}"
        idx += 1
        core = (f"// builtin={b} cls=type_passthrough\n"
                f'extern "C" {pub} {sym}({pub} p) {{ return p; }}\n')
        blocks.append(core)
        manifest.append({"scene": "P08M", "file": "probe.metal", "symbol": sym,
                         "builtin": b, "stage1_source": "auto_type_passthrough"})
        coverage.append({"builtin": b, "status": "generated", "class": "type_passthrough"})

    os.makedirs(OUT_DIR, exist_ok=True)
    d = os.path.join(OUT_DIR, "scene_P08M_construct")
    os.makedirs(d, exist_ok=True)
    header = (f"// scene P08M: construct 系 builtin wrapper (build_construct_probes.py@{S.SCRIPT_VERSION})\n"
              f"// 生成: {S.today()} — 実ヘッダ一次情報に基づく構築、実機削りループで収束\n"
              "#include <metal_stdlib>\n#include <metal_raytracing>\n#include <metal_tensor>\nusing namespace metal;\nusing namespace metal::raytracing;\n\n")
    with open(os.path.join(d, "probe.metal"), "w", encoding="utf-8") as f:
        f.write(header + "\n".join(blocks))
    with open(os.path.join(OUT_DIR, "MANIFEST_construct.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["scene", "file", "symbol", "builtin", "stage1_source"])
        w.writeheader()
        w.writerows(manifest)
    with open(os.path.join(S.DATA, "construct_probe_coverage.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["builtin", "status", "class"])
        w.writeheader()
        w.writerows(coverage)
    print(f"wrote {d} ({len(blocks)} blocks), manifest {len(manifest)} 件")


if __name__ == "__main__":
    main()
