#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_probe_scenes.py — probe シーン (probe_scenes/) を機械生成する器。

喪失した probe_scenes/ の**再生物語の起点** (生成器が信頼の起点: いつでも再生成可能)。
一次入力:
  - data/probe_cells.csv          (576 セル: 何を probe すべきか)
  - data/probe_cells.csv の probe_method (stdlib の実呼出箇所)
  - data/msl_stage1_api_to_builtin.csv (free API signature → wrapper 自動生成)
  - docs/PROBING_PLAN.md §2       (P1/P2 等シーン内容の設計一次ソース)

出力:
  probe_scenes/MANIFEST.csv            (scene,file,symbol,builtin,stage1_source)
  probe_scenes/scene_P01_*/probe.metal … (シーン本体)
  data/scene_cell_coverage.csv         (全セルの割当結果: 人間検証用)

生成ルール:
  - free signature が機械展開可能なセル → extern "C" の真の wrapper を生成 (mangling 回避で
    golden .ll との symbol 突合を可能にする)。stage1_source=auto_wrapper
  - それ以外 (method 大半・型不明) → stdlib_sample 付き TODO コメントのみ
    (コンパイルを妨げない)。stage1_source=manual_needed
  - P1/P2 は PLAN §2 の記述を定数テンプレとして書き起こす (実機未検証である旨を明記)
  - 割当はヒューリスティック (generate-and-verify): coverage CSV で人間が検証・修正する
"""
import csv
import os
import re
import sys
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

OUT_DIR = os.path.join(S.ROOT, "probe_scenes")

SCENES = {
    "P01": ("kernel_meta", "最小 kernel: エントリ metadata 全構造 (air.kernel operand 列, air.arg_*, addrspace, buffer/texture/sampler 属性, CC, datalayout)"),
    "P02": ("vertex_fragment_meta", "vertex/fragment 最小対: air.vertex/air.fragment + stage_in/metadata + raster order group/early_fragment_test"),
    "P03": ("math", "数学 builtin 代表: fast/precise 両 namespace, v 接尾辞, __METAL_FAST_MATH__ 解釈"),
    "P04": ("integer", "整数 builtin 代表: .s/.u 規則, i 接尾辞"),
    "P05": ("convert", "as_type/cast/saturate 変換: air.convert 文法確定"),
    "P06": ("texture", "texture 代表: 不透明 IR 型, ch 型接尾辞, read/write/sample/query/fence"),
    "P07": ("atomic", "atomic 代表: 引数列, order/scope エンコード, addrspace 変種"),
    "P08": ("sync", "同期: threadgroup/simdgroup barrier+shuffle, async copy"),
    "P09": ("function_constant", "[[function_constant]] + パイプライン特殊化の IR/metadata 実体"),
    "P10": ("visible_rt", "visible function table + intersection (raytracing): air.dyld_flat_table, RT intrinsic 実名"),
    "P11": ("mesh_tensor", "mesh/object + tensor/cooperative_tensor + simdgroup matrix (MSL4)"),
    "P12": ("logging", "printf/assert/os_log: rtlib リンク trigger 規則, tracepoint 差込み"),
    "P13": ("rtlib_funcs", "rtlib 使用関数: __air_impl_* 呼出の IR 形 (宣言参照か)"),
    "UNASSIGNED": ("unassigned", "カテゴリ未判定セル (人間による割当待ち)"),
}

# probe_method のヘッダ名 → シーン (暫定ヒューリスティック。coverage で検証)
HDR2SCENE = [
    (r"metal_math", "P03"),
    (r"metal_integer", "P04"),
    (r"metal_pack|metal_types|metal_common", "P05"),
    (r"__bits/(metal_texture|metal_depth)|metal_texture", "P06"),
    (r"metal_atomic", "P07"),
    (r"metal_simdgroup$|metal_quadgroup|metal_simdgroup[^_m]|__bits/metal_simdgroup(?!_matrix)", "P08"),
    (r"metal_uniform|metal_function_constant", "P09"),
    (r"metal_raytracing|metal_visible_function_table|metal_intersection", "P10"),
    (r"metal_mesh|metal_tensor|metal_simdgroup_matrix", "P11"),
    (r"metal_logging|metal_printf", "P12"),
    (r"metal_imageblocks|metal_pixel|metal_interpolate|metal_graphics|metal_tessellation|metal_vertex_value", "P06"),
]

# P1/P2 テンプレ (docs/PROBING_PLAN.md §2 の設計記述の書き起こし。
# 実機未検証: コンパイル可否は macOS probe 時に確認)
P01_METAL = """// scene P01: 最小 kernel — エントリ metadata 全構造の確定用
// 設計一次ソース: docs/PROBING_PLAN.md §2 P1 (実機未検証。コンパイル可否は probe 時確認)
#include <metal_stdlib>
using namespace metal;

struct Params { float4 scale; uint mode; };

kernel void probe_p01_kernel(device float* b            [[buffer(0)]],
                             constant Params& p         [[buffer(1)]],
                             texture2d<float> t         [[texture(0)]],
                             sampler s                  [[sampler(0)]],
                             threadgroup float* shm     [[threadgroup(0)]],
                             uint i                     [[thread_position_in_grid]]) {
    uint idx = i % 1024;
    shm[idx] = b[i] * p.scale.x + t.sample(s, float2(0.5f)).x;
    threadgroup_barrier(mem_flags::mem_threadgroup);
    if (idx == 0) b[i] = shm[1023];
}
"""

P02_METAL = """// scene P02: vertex/fragment 最小対 — air.vertex/air.fragment + IO metadata
// 設計一次ソース: docs/PROBING_PLAN.md §2 P2 (実機未検証)
#include <metal_stdlib>
using namespace metal;

struct VSIn  { float4 pos [[attribute(0)]]; float2 uv [[attribute(1)]]; };
struct FSIn  { float4 pos [[position]]; float2 uv; };

struct VSOut { float4 pos [[position]]; float2 uv; };

vertex VSOut probe_p02_vertex(VSIn in [[stage_in]],
                              uint vid [[vertex_id]],
                              uint iid [[instance_id]]) {
    VSOut o;
    o.pos = in.pos;
    o.uv = in.uv + float2(float(vid & 1), float(iid & 1));
    return o;
}

fragment float4 probe_p02_fragment(FSIn in [[stage_in]],
                                   texture2d<float> t [[texture(0)]],
                                   sampler s [[sampler(0)]]) {
    return t.sample(s, in.uv);
}

[[early_fragment_tests]]
fragment float4 probe_p02_fragment_rog(FSIn in [[stage_in, raster_order_group(0)]]) {
    return in.pos;
}
"""

HEADER_TMPL = """// scene {scene}: {desc}
// 生成: {date} build_probe_scenes.py@{ver} (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

"""

SIG_RE = re.compile(
    r"^(?P<ret>[A-Za-z_][\w:<>, ]*?)\s+(?P<name>[A-Za-z_]\w*)\((?P<args>[^)]*)\)\s*$")
ARG_RE = re.compile(r"^(?P<type>[A-Za-z_][\w:<>]*(?:\s*[*&])?)\s+(?P<name>[A-Za-z_]\w*)$")
BAD_ARG_CHARS = re.compile(r"[=\[\]{}()]|::\s|METAL_|__")


def try_parse_sig(sig: str):
    """'float abs(float x)' 形式を解析。機械生成不能なら None。"""
    m = SIG_RE.match(sig.strip())
    if not m:
        return None
    args = []
    raw = m.group("args").strip()
    if raw and raw != "void":
        for part in raw.split(","):
            part = part.strip()
            if BAD_ARG_CHARS.search(part):
                return None
            am = ARG_RE.match(part)
            if not am:
                return None
            args.append((am.group("type").strip(), am.group("name").strip()))
    if len(args) > 8:
        return None
    return m.group("ret").strip(), m.group("name"), args


def scene_of(probe_method: str) -> str:
    for pat, scene in HDR2SCENE:
        if re.search(pat, probe_method):
            return scene
    return "UNASSIGNED"


def main():
    cells = list(csv.DictReader(open(os.path.join(S.DATA, "probe_cells.csv"),
                                     newline="", encoding="utf-8")))
    # builtin -> 最初の free signature (stage1) + __HAVE_* ガード
    builtin2sig = {}
    with open(os.path.join(S.DATA, "msl_stage1_api_to_builtin.csv"),
              newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            b = r["metal_builtins"].strip()
            if b and b not in builtin2sig:
                builtin2sig[b] = (r["msl_api_signature"].strip(),
                                  r["file"].strip(), r["line"].strip(),
                                  r.get("guard", "").strip())
    # rtlib 層確定 builtin は P13 へ (v2 から)
    rtlib_builtins = set()
    if os.path.exists(S.MAP_V2):
        for r in S.read_v2():
            if r["evidence"] == "rtlib_layer_backing":
                rtlib_builtins.add(r["__metal_builtin"])

    # セル割当
    assign = []     # (cell, scene, air_candidate, probe_method)
    for c in cells:
        b = c["cell"]
        if b in rtlib_builtins:
            sc = "P13"
        else:
            sc = scene_of(c["probe_method"])
        assign.append((b, sc, c["air_candidate"], c["probe_method"]))

    os.makedirs(OUT_DIR, exist_ok=True)
    manifest = []
    coverage = []
    scene_bodies = defaultdict(list)    # scene -> [code blocks]
    scene_counts = defaultdict(lambda: {"auto": 0, "manual": 0})

    for b, sc, cand, method in assign:
        stage1 = "manual_needed"
        symbol = ""
        sig_info = builtin2sig.get(b)
        parsed = try_parse_sig(sig_info[0]) if sig_info else None
        if parsed:
            ret, name, args = parsed
            guard = sig_info[3] if len(sig_info) > 3 else ""
            symbol = f"probe_{sc.lower()}_{name}"
            argdecls = ", ".join(f"{t} {a}" for t, a in args)
            arguse = ", ".join(a for _t, a in args)
            body_ret = f"return metal::{name}({arguse});" if ret != "void" \
                else f"metal::{name}({arguse});"
            core = (f"// cell={b} candidate={cand}\n"
                    f'extern "C" {ret} {symbol}({argdecls}) {{ {body_ret} }}\n')
            # __HAVE_* ガード付き API はターゲットによっては存在しない
            # (実機エラー実例: snorm10a2 は macOS26.4+metal3.2 で無効)
            # → #if で囲み、無効ターゲットでは空にしてコンパイル可能を保つ
            if guard:
                core = (f"#if defined({guard})\n{core}"
                        f"#else\n// NOTE: {guard} 無効ターゲットのため wrapper 無効化 "
                        f"(この builtin は対応ターゲットで別途 probe)\n#endif\n")
            block = core
            scene_bodies[sc].append(block)
            stage1 = "auto_wrapper"
            scene_counts[sc]["auto"] += 1
        else:
            src = f"{sig_info[1]}:{sig_info[2]}: {sig_info[0]}" if sig_info else method
            block = (f"// ==== TODO(manual_needed): {b} ====\n"
                     f"//   candidate: {cand}\n"
                     f"//   stdlib 実呼出: {src[:200]}\n"
                     f"//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加"
                     f" (symbol は probe_{sc.lower()}_xxx 系で extern \"C\" 推奨)\n")
            scene_bodies[sc].append(block)
            scene_counts[sc]["manual"] += 1
        manifest.append({"scene": sc, "file": "probe.metal", "symbol": symbol,
                         "builtin": b, "stage1_source": stage1})
        coverage.append({"cell": b, "scene": sc, "air_candidate": cand,
                         "stage1_source": stage1, "probe_method": method})

    # シーンファイル書出し
    for sc, (dir_suffix, desc) in SCENES.items():
        if sc not in scene_bodies and sc not in ("P01", "P02"):
            continue
        d = os.path.join(OUT_DIR, f"scene_{sc}_{dir_suffix}")
        os.makedirs(d, exist_ok=True)
        if sc == "P01":
            content = P01_METAL
        elif sc == "P02":
            content = P02_METAL
        else:
            content = HEADER_TMPL.format(scene=sc, desc=desc, date=S.today(),
                                         ver=S.SCRIPT_VERSION)
            content += "\n".join(scene_bodies[sc])
        with open(os.path.join(d, "probe.metal"), "w", encoding="utf-8") as f:
            f.write(content)

    with open(os.path.join(OUT_DIR, "MANIFEST.csv"), "w", newline="",
              encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["scene", "file", "symbol", "builtin",
                                          "stage1_source"])
        w.writeheader()
        for m in manifest:
            w.writerow(m)

    with open(os.path.join(S.DATA, "scene_cell_coverage.csv"), "w", newline="",
              encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["cell", "scene", "air_candidate",
                                          "stage1_source", "probe_method"])
        w.writeheader()
        for c in coverage:
            w.writerow(c)

    # README (再生物語)
    auto = sum(v["auto"] for v in scene_counts.values())
    manual = sum(v["manual"] for v in scene_counts.values())
    readme = [f"""# probe_scenes — 機械生成 probe シーン集

> **これは生成物** (喪失したら `python3 scripts/build_probe_scenes.py` で再生成)。
> 一次入力: `data/probe_cells.csv` + `data/msl_stage1_api_to_builtin.csv`
> + `data/builtin_to_air_map.v2.csv` (rtlib 層) + `docs/PROBING_PLAN.md` §2。
> 生成日時: {S.utcnow()}

## 使い方 (docs/PROBING_PLAN.md §1 のコマンド形で実行)

```bash
xcrun -sdk macosx metal -x metal -std=metal3.2 -O2 -S -emit-llvm \\
    probe_scenes/scene_P03_math/probe.metal -o probe.ll
```

## golden 回収後の昇格

```
golden/<SCENE>/<std>_<target>/probe.ll + meta.yml (date: YYYY-MM-DD 必須)
    ↓
python3 scripts/promote_map.py apply-golden golden --manifest probe_scenes/MANIFEST.csv
    ↓ builtin_to_air_map.v2.csv が probed_xcode_ll / confirmed に昇格 (EVENTLOG 記録)
```

## 生成内訳

- セル総数: {len(coverage)} (auto_wrapper: {auto} / manual_needed: {manual})
- シーン別:
"""]
    for sc in sorted(SCENES):
        cnt = scene_counts.get(sc)
        if cnt:
            readme.append(f"  - {sc} ({SCENES[sc][0]}): auto {cnt['auto']} / manual {cnt['manual']}")
    readme += ["",
               "manual_needed ブロックはコンパイルに影響しないコメントのみで、",
               "stdlib の実呼出箇所 (file:line) を同封。実機作業時に最小 wrapper を手書き追加する。",
               "P01/P02 は PROBING_PLAN §2 の設計の直訳テンプレ (実機未検証)。",
               "割当はヒューリスティック — `data/scene_cell_coverage.csv` を人間が検証して修正する。",
               ]
    with open(os.path.join(OUT_DIR, "README.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(readme) + "\n")

    S.log_event("GEN_PROBE_SCENES", f"build_probe_scenes.py@{S.SCRIPT_VERSION}",
                "probe_scenes/",
                f"セル {len(coverage)} を {len(scene_counts)} シーンに割当: "
                f"auto={auto} manual={manual} (P01/P02 は PLAN テンプレ)")
    print(f"scenes written to {OUT_DIR}: auto={auto} manual={manual}")
    for sc in sorted(scene_counts):
        print(f"  {sc}: {scene_counts[sc]}")


if __name__ == "__main__":
    main()
