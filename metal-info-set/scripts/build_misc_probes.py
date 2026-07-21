#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_misc_probes.py — get_null / quad / vote / vft / sampler / rrm / draw / free misc

一次情報 (全てヘッダ実測):
  __bits/metal_texture*: texture1d() thread : t(__metal_get_null_texture_1d_t()) 等
  metal_raytracing 663/684/1467: *_acceleration_structure / ift default ctor = get_null
  __bits/metal_texture_common 841-846: __metal_sampler_t val = _get_metal_sampler(...) (constexpr ctor)
  metal_quadgroup 69/74/96/158/268: quad_vote_all/any(vote_t), quad_and/or/xor(T data) free
  metal_math 86/109: divide(x,y)=__metal_divide, select=__metal_select 直接呼出形
  metal_graphics 211-236: rasterization_rate_map_decoder(constant ...&data) + map_* 4 形
  metal_command_buffer 951-971: render_command::draw_indexed_primitives/draw_patches 実引数形

 scene: probe_scenes_methods/scene_P11M_misc/probe.metal, MANIFEST_misc.csv
"""
import csv
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

OUT_DIR = os.path.join(S.ROOT, "probe_scenes_methods")

CELLS = []


def cell(key, builtin, ret, body, params="void"):
    CELLS.append((key, builtin, ret, body, params))


# --- get_null texture (default ctor 経路) -----------------------------------
_TEX_NULL = {
    "texture1d<float>": "__metal_get_null_texture_1d_t",
    "texture1d_array<float>": "__metal_get_null_texture_1d_array_t",
    "texture2d<float>": "__metal_get_null_texture_2d_t",
    "texture2d_array<float>": "__metal_get_null_texture_2d_array_t",
    "texture2d_ms<float>": "__metal_get_null_texture_2d_ms_t",
    "texture2d_ms_array<float>": "__metal_get_null_texture_2d_ms_array_t",
    "texture3d<float>": "__metal_get_null_texture_3d_t",
    "texture_buffer<float>": "__metal_get_null_texture_buffer_1d_t",
    "texturecube<float>": "__metal_get_null_texture_cube_t",
    "texturecube_array<float>": "__metal_get_null_texture_cube_array_t",
    "depth2d<float>": "__metal_get_null_depth_2d_t",
    "depth2d_array<float>": "__metal_get_null_depth_2d_array_t",
    "depth2d_ms<float>": "__metal_get_null_depth_2d_ms_t",
    "depth2d_ms_array<float>": "__metal_get_null_depth_2d_ms_array_t",
    "depthcube<float>": "__metal_get_null_depth_cube_t",
    "depthcube_array<float>": "__metal_get_null_depth_cube_array_t",
}
for ty, b in sorted(_TEX_NULL.items()):
    cell("texnull", b, "int", f"{ty} __t; (void)__t; return 0;")


def main():
    rows = S.read_v2()
    unresolved = {r["__metal_builtin"] for r in rows if r["confidence"] != "confirmed"}
    for ty, b in _TEX_NULL.items():
        if b not in unresolved:
            CELLS[:] = [c for c in CELLS if c[1] != b]

    # acceleration structure / function handle / ift / tensor / vft
    cell("asnull", "__metal_get_null_primitive_acceleration_structure", "int",
         "metal::raytracing::primitive_acceleration_structure __as; (void)__as; return 0;")
    # (instance 側は confirmed 済)
    cell("fhandle", "__metal_get_null_function_handle", "int",
         "metal::raytracing::intersection_function_handle<> __h; (void)__h; return 0;")
    cell("iftnull", "__metal_get_null_intersection_function_table", "int",
         "metal::raytracing::intersection_function_table<metal::raytracing::instancing, metal::raytracing::triangle_data> __t; (void)__t; return 0;")
    cell("vftnull", "__metal_get_null_visible_function_table", "int",
         "metal::visible_function_table<void(uint)> __v; (void)__v; return 0;")
    cell("fequal", "__metal_is_equal_function_handle", "bool",
         "metal::raytracing::intersection_function_handle<> __a, __b; return __a == __b;")

    # quad vote / reductions (free)
    cell("qvotea", "__metal_quad_vote_all", "bool", "return quad_vote(true).all();")
    cell("qvoteb", "__metal_quad_vote_any", "bool", "return quad_vote(true).any();")
    cell("qand", "__metal_quad_and", "int", "return quad_and(3);")
    cell("qor", "__metal_quad_or", "int", "return quad_or(3);")
    cell("qxor", "__metal_quad_xor", "int", "return quad_xor(3);")

    # divide / select (free, builtin 直接形は内部名のため公開 divide 経路)
    cell("divide", "__metal_divide", "float", "return divide(1.0f, 2.0f);")
    cell("select", "__metal_select", "float",
         "float __t=1.0f; return copysign(__t, -2.0f);",  # copysign 内で __metal_select 使用
         )

    # sampler: 公開 ctor 経路は constexpr のため IR 残らない可能性 →
    # _get_metal_sampler 経路を半公開形で出す (一次ヘッダ 841-846)
    cell("sampler", "__metal_sampler_t", "int", "sampler __s; (void)__s; return 0;")
    cell("getsampler", "__metal_get_sampler", "int",
         "sampler __s; (void)__s; return 0;",)

    # visible function table: get_size / get_function_pointer
    cell("vftsize", "__metal_get_size_visible_function_table", "uint",
         "metal::visible_function_table<void(uint)> __v; return __v.size();")

    # rasterization rate map decoder (一次ヘッダ金属_graphics 211-236)
    for nm, b, argt in (
        ("rrm_p2s_f", "__metal_map_physical_to_screen_coordinates", "float2(0.0f)"),
        ("rrm_s2p_f", "__metal_map_screen_to_physical_coordinates", "float2(0.0f)"),
        ("rrm_p2s_u", "__metal_map_physical_to_screen_coordinates", "uint2(0u)"),
        ("rrm_s2p_u", "__metal_map_screen_to_physical_coordinates", "uint2(0u)"),
    ):
        fn = "map_physical_to_screen_coordinates" if "p2s" in nm else "map_screen_to_physical_coordinates"
        cell(nm, b, "float2" if "_f" in nm else "uint2",
             f"auto __d = metal::rasterization_rate_map_decoder(*(constant metal::rasterization_rate_map_data *)__p); "
             f"return __d.{fn}({argt}, __li);",
             params="constant metal::rasterization_rate_map_data *__p, uint __li")

    # render_command draw 系 (一次ヘッダ実引数)
    cell("draw1", "__metal_draw_indexed_primitives_render_command", "void",
         "metal::render_command __rc(__cb, 0u); "
         "__rc.draw_indexed_primitives(metal::primitive_type::triangle, 0u, (const device uint *)nullptr, 0u); return;",
         params="metal::command_buffer __cb")
    cell("draw2", "__metal_draw_patches_render_command", "void",
         "metal::render_command __rc(__cb, 0u); "
         "__rc.draw_patches(0u, 0u, 0u, (const device uint *)nullptr, 0u, 0u, (const device metal::MTLQuadTessellationFactorsHalf *)nullptr); return;",
         params="metal::command_buffer __cb")
    cell("draw3", "__metal_draw_indexed_patches_render_command", "void",
         "metal::render_command __rc(__cb, 0u); "
         "__rc.draw_indexed_patches(0u, 0u, 0u, (const device uint *)nullptr, (const device void *)nullptr, 0u, 0u, (const device metal::MTLQuadTessellationFactorsHalf *)nullptr); return;",
         params="metal::command_buffer __cb")
    cell("winding", "__metal_set_front_facing_winding_render_command", "void",
         "metal::render_command __rc(__cb, 0u); "
         "__rc.set_front_facing_winding(metal::winding::counterclockwise); return;",
         params="metal::command_buffer __cb")
    cell("setps_r", "__metal_set_pipeline_state_render_command", "void",
         "metal::render_command __rc(__cb, 0u); __rc.set_render_pipeline_state(__ps); return;",
         params="metal::command_buffer __cb, metal::render_pipeline_state __ps")
    cell("setps_c", "__metal_set_pipeline_state_compute_command", "void",
         "metal::compute_command __c(__cb, 0u); __c.set_compute_pipeline_state(__ps); return;",
         params="metal::command_buffer __cb, metal::compute_pipeline_state __ps")

    # 正本未消化のみ残す
    rows = S.read_v2()
    unresolved = {r["__metal_builtin"] for r in rows if r["confidence"] != "confirmed"}
    kept, manifest = [], []
    for key, b, ret, body, params in CELLS:
        if b not in unresolved:
            continue
        sym = f"probe_p11m_{key}_{len(kept)}"
        kept.append(f"// builtin={b} cls=misc\n"
                    f'extern "C" {ret} {sym}({params}) {{ {body} }}\n')
        manifest.append({"scene": "P11M", "file": "probe.metal", "symbol": sym,
                         "builtin": b, "stage1_source": "auto_misc"})

    os.makedirs(OUT_DIR, exist_ok=True)
    d = os.path.join(OUT_DIR, "scene_P11M_misc")
    os.makedirs(d, exist_ok=True)
    header = (f"// scene P11M: misc builtin wrapper (build_misc_probes.py@{S.SCRIPT_VERSION})\n"
              f"// 一次情報: __bits/metal_texture* ctor / metal_quadgroup / metal_graphics / metal_command_buffer\n"
              "#include <metal_stdlib>\n#include <metal_raytracing>\n#include <metal_graphics>\n#include <metal_command_buffer>\n#include <metal_tessellation>\n"
              "#include <metal_visible_function_table>\n#include <metal_quadgroup>\n"
              "using namespace metal;\nusing namespace metal::raytracing;\n\n")
    with open(os.path.join(d, "probe.metal"), "w", encoding="utf-8") as f:
        f.write(header + "\n".join(kept))
    with open(os.path.join(OUT_DIR, "MANIFEST_misc.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["scene", "file", "symbol", "builtin", "stage1_source"])
        w.writeheader()
        w.writerows(manifest)
    print(f"wrote {d} ({len(kept)} blocks), manifest {len(manifest)} 件; "
          f"未消化(対象外で残): {len(CELLS)-len(kept)}")


if __name__ == "__main__":
    main()
