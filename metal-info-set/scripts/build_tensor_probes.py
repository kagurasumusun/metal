#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_tensor_probes.py — tensor 系 builtin の extern-C wrapper probe を機械生成 (v2)。

一次情報 (metal_tensor 実ヘッダ):
  - ElementType は address-space 修飾必須: tensor_handle 記述子では
    device / constant のみ (__is_tensor_addrspace, metal_tensor:259-281)
    → `tensor<device float, extents<int,4,8>>` が正しい具体形
  - default ctor thread: _t(__metal_get_null_tensor()) (metal_tensor:1451)
  - observer get_extent/get_stride → __metal_get_extent_tensor/__metal_get_stride_tensor (685-665)
  - rank0 accessor .get() → __metal_load_tensor / .set(v) → __metal_store_tensor (686-699)
  - operator[] (rank>0) → __metal_get_data_pointer_tensor (1250)
  - thread tensor::operator=(const device tensor&) → __metal_slice_tensor (2147-2155)
  - tensor_inline default ctor → __metal_init_strided_tensor (1856)
  - tensor<> handle() thread = __metal_get_tensor_handle(this) (2171)
  - [[sizeas(__metal_descriptor_size_tensor(rank, sizeof(index)))]] 属性 (1799)
  - is_null_tensor(const thread tensor&) → __metal_is_null_tensor (238-246, 452)

scene: probe_scenes_methods/scene_P10T_tensor/probe.metal, MANIFEST_tensor.csv
"""
import csv
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

OUT_DIR = os.path.join(S.ROOT, "probe_scenes_methods")

TH = "tensor<device float, extents<int, 4, 8>>"       # tensor_handle, rank2
TH0 = "tensor<device float, extents<int>>"            # tensor_handle, rank0
TI = "tensor<device float, extents<int, 4, 8>, tensor_inline>"


def main():
    rows = S.read_v2()
    targets = {r["__metal_builtin"] for r in rows
               if "tensor" in r["__metal_builtin"] and r["confidence"] != "confirmed"}
    blocks, manifest = [], []

    def add(key, b, ret, body, params="void"):
        if b not in targets:
            return
        sym = f"probe_p10t_{key}_{len(blocks)}"
        blocks.append(f"// builtin={b} cls=tensor\n"
                      f'extern "C" {ret} {sym}({params}) {{ {body} }}\n')
        manifest.append({"scene": "P10T", "file": "probe.metal", "symbol": sym,
                         "builtin": b, "stage1_source": "auto_tensor"})

    add("extent", "__metal_get_extent_tensor", "int",
        f"{TH} __t; return __t.get_extent(0);")
    add("stride", "__metal_get_stride_tensor", "int",
        f"{TH} __t; return __t.get_stride(0);")
    add("load", "__metal_load_tensor", "float",
        f"{TH0} __t; return __t.get();")
    add("store", "__metal_store_tensor", "void",
        f"{TH0} __t; __t.set(1.0f); return;")
    add("dptr", "__metal_get_data_pointer_tensor", "float",
        f"{TH} __t; return __t[0,0];")
    add("slice", "__metal_slice_tensor", "void",
        f"{TH} __t; __t = *__p; return;",
        params=f"device {TH} *__p")
    add("init", "__metal_init_strided_tensor", "void",
        f"{TI} __t; (void)__t; return;")
    add("isnull", "__metal_is_null_tensor", "bool",
        f"{TH} __t; return is_null_tensor(__t);")
    add("null", "__metal_get_null_tensor", "bool",
        f"{TH} __t; return is_null_tensor(__t);")
    add("handle", "__metal_get_tensor_handle", "int",
        f"{TH} __t; return __t.get_extent(0);")
    add("descsize", "__metal_descriptor_size_tensor", "void",
        f"{TI} __t; (void)__t; return;")
    add("type_h", "__metal_tensor_t", "bool",
        f"{TH} __t; return is_null_tensor(__t);")
    add("type_th", "__metal_tensor_thread_t", "bool",
        f"{TH} __t; return is_null_tensor(__t);")

    os.makedirs(OUT_DIR, exist_ok=True)
    d = os.path.join(OUT_DIR, "scene_P10T_tensor")
    os.makedirs(d, exist_ok=True)
    header = (f"// scene P10T: tensor builtin wrapper v2 (build_tensor_probes.py@{S.SCRIPT_VERSION})\n"
              f"// 一次情報: metal_tensor (ElementType は device/constant 修飾必須)\n"
              "#include <metal_stdlib>\n#include <metal_tensor>\nusing namespace metal;\n\n")
    with open(os.path.join(d, "probe.metal"), "w", encoding="utf-8") as f:
        f.write(header + "\n".join(blocks))
    with open(os.path.join(OUT_DIR, "MANIFEST_tensor.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["scene", "file", "symbol", "builtin", "stage1_source"])
        w.writeheader()
        w.writerows(manifest)
    print(f"wrote {d} ({len(blocks)} blocks), manifest {len(manifest)} 件")


if __name__ == "__main__":
    main()
