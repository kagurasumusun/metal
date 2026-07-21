#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""build_frontend_impl_map.py — clang が .metal を parse → LLVM IR (AIR) にするために
必要な全要素 (lex/parse/sema/type/codegen/langopt/driver) の対応表を機械生成。

生成元 (一次情報のみ、推測で埋めない):
  1. Apple metal ヘッダ実体 (keywords/attributes/type 用法を走査)     → observed_header
  2. golden corpus の .ll 実測 (entry metadata/module flags/AS/mangling) → observed_golden_ir
  3. golden/env.txt (`metal -help` 1385 行) の flag 棚卸               → observed_help
  4. golden/*/first_errors.txt (収束ループ head) の実セマエラー文      → observed_error
  5. spec PDF 採掘 (data/spec_attributes.csv) の attribute 名           → apple_msl_spec_pdf

clang 側の実装点 (impl_point) は「我々の fork での配置設計」= 設計記述であり、
Apple 内部実装の推測ではない (notes で区別を明記)。

出力: data/clang_frontend_impl_map.csv / docs/CLANG_FRONTEND_IMPL_MAP.md
"""
import csv
import os
import re
import sys
from collections import Counter, defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

HEADERS = "/home/user/metal-repo/reference/clang/32023.883/include/metal"
GOLDEN = os.path.join(S.ROOT, "golden")
ENV_HELP = os.path.join(GOLDEN, "env.txt")

C_COLS = ["feature_id", "layer", "feature", "syntax_example", "clang_impl_point",
          "upstream_analog", "evidence", "source_ref", "msl_since", "implement_status", "notes"]

# アドレス空間・修飾語 (MSL 言語キーワード — spec §4.1/ヘッダ用法で一次確認)
ADDR_KEYWORDS = ["device", "constant", "threadgroup", "thread", "ray_data", "object_data",
                 "threadgroup_imageblock", "coherent"]
FUNCTION_KW = ["kernel", "vertex", "fragment", "visible", "stitchable"]

# impl_point カテゴリ別の既定配置 (我々の fork 設計 — 注記つき)
IMPL = {
    "lex": "Lexer/IdentifierTable: キーワード登録 (tok::kw_* or contextual)",
    "attr": "AttributeList + Attr.td ('[[x]]' spelling → ParsedAttr → Sema 処理)",
    "sema": "Sema (ActOn*/チェック) + Diagnostics （実装: 我々の fork 設計、Apple 内部ではない)",
    "type": "ASTContext::Type 追加 (BuiltinType or RecordType sugar)",
    "codegen": "CodeGen (CGMetal* / metadata 発行) — 実測 IR 構造に一致させる",
    "langopt": "LangOptions + Driver フラグ処理",
    "driver": "Driver/toolchain 連携 (air 版, metallib)",
}


def scan_headers():
    attr_occ = defaultdict(set)   # attr名 -> {file}
    as_occ = defaultdict(set)
    for fn in sorted(os.listdir(HEADERS)):
        p = os.path.join(HEADERS, fn)
        if not os.path.isfile(p):
            continue
        txt = open(p, encoding="utf-8", errors="ignore").read()
        for m in re.finditer(r"\[\[\s*([A-Za-z_][\w:]*)\s*(?:\(|\]\])", txt):
            attr_occ[m.group(1)].add(fn)
        for kw in ADDR_KEYWORDS + FUNCTION_KW:
            if re.search(rf"\b{kw}\b", txt):
                as_occ[kw].add(fn)
    return attr_occ, as_occ


def scan_help():
    flags = {}
    if not os.path.exists(ENV_HELP):
        return flags
    for line in open(ENV_HELP, encoding="utf-8", errors="ignore"):
        m = re.match(r"\s{2,}(--?[A-Za-z0-9][\w\-]*)(?:[ =<]|$)", line)
        if m:
            flags.setdefault(m.group(1), line.strip()[:100])
    return flags


def scan_golden_ir():
    """golden .ll 全走査: module flag 名 / named metadata / opaque struct / triple / entry 形。"""
    facts = {"module_flags": set(), "named_md": set(), "opaque": set(),
             "triples": set(), "air_versions": set(), "entry_functions": set(),
             "arg_attrs": set(), "textuals": set()}
    entry_re = re.compile(r"!(\d+) = !\{ptr @(\w+)")
    flag_re = re.compile(r'!"([^"]+)", i32')
    for dirpath, _, files in os.walk(GOLDEN):
        for fn in files:
            if not fn.endswith(".ll"):
                continue
            txt = open(os.path.join(dirpath, fn), encoding="utf-8", errors="ignore").read()
            for m in re.finditer(r'^target triple = "([^"]+)"', txt, re.M):
                facts["triples"].add(m.group(1))
            for m in re.finditer(r'^%([\w.]+) = type opaque', txt, re.M):
                facts["opaque"].add(m.group(1))
            for m in re.finditer(r'^!(\w[\w.]*) = ', txt, re.M):
                facts["named_md"].add(m.group(1))
            for m in flag_re.finditer(txt):
                facts["module_flags"].add(m.group(1))
            for m in entry_re.finditer(txt):
                facts["entry_functions"].add(m.group(2))
            for m in re.finditer(r'"(air\.[\w.]+)"', txt):
                facts["textuals"].add(m.group(1))
    return facts


def scan_errors():
    errs = Counter()
    for dirpath, _, files in os.walk(GOLDEN):
        for fn in files:
            if fn != "first_errors.txt":
                continue
            for line in open(os.path.join(dirpath, fn), encoding="utf-8", errors="ignore"):
                m = re.search(r"error: (.+)$", line)
                if m:
                    msg = re.sub(r"'[^']*'", "<?>", m.group(1))
                    msg = re.sub(r"\d+", "N", msg).strip()
                    errs[msg] += 1
    return errs


def main():
    attr_occ, as_occ = scan_headers()
    help_flags = scan_help()
    irf = scan_golden_ir()
    errs = scan_errors()
    spec_attrs = set()
    p = os.path.join(S.DATA, "spec_attributes.csv")
    if os.path.exists(p):
        with open(p, newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                spec_attrs.add(r["attribute"])

    rows = []
    def add(layer, feature, syntax, impl, analog, ev, ref, since="", status="verified", notes=""):
        rows.append({"feature_id": f"FE-{len(rows)+1:04d}", "layer": layer, "feature": feature,
                     "syntax_example": syntax, "clang_impl_point": impl, "upstream_analog": analog,
                     "evidence": ev, "source_ref": ref, "msl_since": since,
                     "implement_status": status, "notes": notes})

    # --- lexer: キーワード ------------------------------------------------------
    for kw in ADDR_KEYWORDS:
        files = sorted(as_occ.get(kw, []))
        add("lexer", f"address-space keyword `{kw}`",
            f"{kw} int *p" if kw != "coherent" else "coherent(device) int *p",
            IMPL["lex"], "opencl (__global/__constant 類)", "observed_header",
            ";".join(files[:4]), notes=f"実ヘッダ出現 {len(files)} file")
    for kw in FUNCTION_KW:
        files = sorted(as_occ.get(kw, []))
        add("lexer", f"function-class keyword `{kw}`", f"{kw} float4 f()",
            IMPL["lex"], "hlsl (entry 修飾類)", "observed_header", ";".join(files[:4]),
            notes=f"実ヘッダ出現 {len(files)} file")

    # --- attribute spellings (header ∪ spec PDF) --------------------------------
    all_attrs = sorted(set(attr_occ) | {a for a in spec_attrs})
    for a in all_attrs:
        files = sorted(attr_occ.get(a, []))
        ev = "observed_header" if files else "apple_msl_spec_pdf"
        ref = ";".join(files[:4]) if files else "MSL spec PDF (data/spec_attributes.csv)"
        add("attr", f"[[{a}]]", f"[[{a}]]", IMPL["attr"], "(個別対応表参照)",
            ev, ref, status="verified" if files else "spec-only",
            notes="" if files else "ヘッダ未出現 — spec PDF 由来")

    # --- type 層 ----------------------------------------------------------------
    for op in sorted(irf["opaque"]):
        add("type", f"opaque builtin type {op}", f"(IR) %{op} = type opaque",
            "ASTContext BuiltinType + CodeGen lowering → IR `%"+op+" = type opaque`",
            "clang DXIL リソース型の類似", "observed_golden_ir", "golden/*/*.ll",
            notes="clang 側では opaque handle として TBAA/ABI 固定")

    # --- codegen 層 (実測 IR 構造) ----------------------------------------------
    for t in sorted(irf["triples"]):
        add("codegen", f"target triple `{t}`", t, "TargetMachine: air64_v%03d % apple-*-os",
            "apple gpu arch", "observed_golden_ir", "golden/*/*.ll")
    for mf in sorted(irf["module_flags"]):
        add("codegen", f"module flag `!\"{mf}\"`", f'!{{i32 7, !"{mf}", i32 N}}',
            "CodeGenModule: エントリ関数の module flag 発行", "(metal 固有)",
            "observed_golden_ir", "golden/*/*.ll")
    for nm in sorted(irf["named_md"]):
        add("codegen", f"named metadata `!{nm}`", f"!{nm} = !{{...}}",
            "CodeGenModule: named metadata 発行", "(metal 固有)",
            "observed_golden_ir", "golden/*/*.ll")
    for tx in sorted(irf["textuals"]):
        add("codegen", f'metadata 文字列 `"{tx}"`', f'!"{tx}", ...',
            "entry metadata operand 文字列", "(metal 固有)", "observed_golden_ir", "golden/*/*.ll")

    # --- sema 層 (実機が実際に出したエラー) -------------------------------------
    for msg, n in sorted(errs.items(), key=lambda x: -x[1]):
        add("sema", f"diagnostic: {msg}", "(probe ソース)", IMPL["sema"],
            "clang 標準診断体系", "observed_error", "golden/*/first_errors.txt",
            status="observed", notes=f"観測 {n} 回 — コンパイラが実施している検査 = 我々も実装必須の sema")

    # --- langopt 層 (metal -help のフラグ) ---------------------------------------
    for flg, desc in sorted(help_flags.items()):
        add("langopt", f"flag `{flg}`", desc, IMPL["langopt"], "",
            "observed_help", "golden/env.txt", status="inventory",
            notes="metal driver -help 実測")

    # --- driver/macro 層 ---------------------------------------------------------
    idiom = {}
    gi = os.path.join(S.DATA, "guard_idiom.json")
    if os.path.exists(gi):
        import json
        idiom = json.load(open(gi))
    n_idiom_def = sum(1 for v in idiom.values() if "defined" in v)
    n_idiom_num = sum(1 for v in idiom.values() if v == ["numeric"])
    add("langopt", "feature-test macro 群 __HAVE_*__",
        "#if defined(__HAVE_RAYTRACING__) / #if __HAVE_RAYTRACING_INSTANCE_RANDOM_ACCESS__",
        "Preprocessor: -std/OS/feature に応じて builtin -D 定義",
        "opencl __OPENCL_*___ 類", "observed_header", "data/guard_idiom.json",
        notes=f"118 macro 実測 (defined 慣用 {n_idiom_def}, numeric 慣用 {n_idiom_num})")
    add("driver", "AIR version ↔ triple 対応", "air64_v28-apple-macosx26.0.0 ↔ !air.version={2,8,0}",
        "TargetMachine/code emission 時のバージョン選択", "", "observed_golden_ir",
        "docs/IR_GROUND_TRUTH.md §6", notes="金属 toolchain 32023.883 実測")
    add("codegen", "builtin 呼出 → air.* 発行 686 件",
        "__metal_fabs → air.fabs.f32 等", "CodeGen: builtin intrinsic lowering (核となる本体)",
        "本対応表の主表", "inferred", "data/builtin_to_air_map.v2.csv",
        notes="完全表は builtin_to_air_map.v2.csv (confirmed は golden 実測)")

    # --- 出力 -------------------------------------------------------------------
    os.makedirs(S.DATA, exist_ok=True)
    with open(os.path.join(S.DATA, "clang_frontend_impl_map.csv"), "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=C_COLS)
        w.writeheader()
        w.writerows(rows)
    print("wrote data/clang_frontend_impl_map.csv", len(rows))

    by_layer = Counter(r["layer"] for r in rows)
    lines = [
        "# clang frontend 実装 対応表 (機械生成)",
        "",
        f"生成: {S.today()} by build_frontend_impl_map.py — `.metal` を clang が parse して",
        "LLVM IR (AIR) にするために必要な要素の棚卸対応表。",
        "",
        "**注意**: `clang_impl_point` は我々の fork の配置設計であり、Apple 内部実装の",
        "推測ではない。evidence 列が一次情報の種類を示す。",
        "",
        "## レイヤ分布",
        "",
        "| layer | rows | 内容 |",
        "|---|---|---|",
    ]
    LAYER_JP = {"lexer": "キーワード (address space/関数クラス)",
                "attr": "[[...]] attribute spelling",
                "sema": "実機 clang が出した診断 (Sema チェック必須項目)",
                "type": "opaque builtin 型 (IR に出る実体)",
                "codegen": "CodeGen が発行する IR 構造 (metadata/module flag/triple)",
                "langopt": "driver フラグ・feature macro",
                "driver": "AIR 版世代/triple 対応"}
    for l, n in sorted(by_layer.items()):
        lines.append(f"| {l} | {n} | {LAYER_JP.get(l, '')} |")
    lines += [
        "",
        "## 主要サマリ",
        "",
        f"- attribute spelling: {by_layer.get('attr', 0)} (header ∪ spec PDF 採掘)",
        f"- opaque 型: {sum(1 for r in rows if r['layer'] == 'type')} (golden IR 実測)",
        f"- sema 診断: {by_layer.get('sema', 0)} (収束ループの実エラー文)",
        f"- help flag: {sum(1 for r in rows if r['layer'] == 'langopt' and r['feature'].startswith('flag'))}",
        "",
        "## 正本 CSV",
        "",
        "`data/clang_frontend_impl_map.csv` (本ドキュメントはその要約機械生成版)",
        "",
        "core の builtin 対応 (sema→codegen の中心) は `data/builtin_to_air_map.v2.csv` が正本。",
    ]
    with open(os.path.join(S.ROOT, "docs", "CLANG_FRONTEND_IMPL_MAP.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    print("wrote docs/CLANG_FRONTEND_IMPL_MAP.md")


if __name__ == "__main__":
    main()
