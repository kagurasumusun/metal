#!/usr/bin/env python3
"""lib_mapschema.py — 対応表 v2 スキーマの共有ライブラリ.

全スクリプト (migrate/promote/scene/callgraph) が共用する:
- v2 列定義 / evidence / protocol / confidence の定数
- AIR 命名文法の照合関数 (build_air_definitive.py と同じセグメント分割方式)
- 一次辞書 (ir_air_signatures / air_ops_definitive / air_stems_binaries / airconv) の遅延ロード
- EVENTLOG への append

設計原則: additive のみ。推測で値を埋めない (不明は空)。全変更を EVENTLOG に記録。
"""
from __future__ import annotations

import csv
import datetime
import json
import os
import re

# --- パス ----------------------------------------------------------------
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)                       # metal-info-set/
DATA = os.path.join(ROOT, "data")
DOCS = os.path.join(ROOT, "docs")
EVENTLOG = os.path.join(DOCS, "EVENTLOG.md")

MAP_V1 = os.path.join(DATA, "builtin_to_air_map.csv")      # 凍結 (改変しない)
MAP_V2 = os.path.join(DATA, "builtin_to_air_map.v2.csv")   # 正本

# --- v2 スキーマ -----------------------------------------------------------
V1_FIELDS = ["__metal_builtin", "used_via", "n_call_sites",
             "air_intrinsic_candidate", "evidence", "status", "stdlib_sample"]
V2_ADDED = ["evidence_source", "evidence_ref", "protocol", "confidence",
            "grammar_eligible", "probe_cell", "observed_at",
            "verified_at", "verified_by", "last_change", "changed_by"]
V2_FIELDS = V1_FIELDS + V2_ADDED

EVIDENCE_VALUES = ["observed_ir", "observed_airconv", "inferred",
                   "probed_xcode_ll", "recomputed_callgraph", "rtlib_layer_backing"]
CONFIDENCE_VALUES = ["confirmed", "high", "medium", "low"]
EVIDENCE_SOURCES = ["apple_rtlib_ir", "apple_gpucompiler_symbols",
                    "apple_stdlib_headers", "apple_msl_spec_pdf",
                    "community_airconv_src", "community_naga_wiki",
                    "this_repo_inference", "xcode_probe_golden"]
PROTOCOL_IDS = ["P-IR1", "P-AC1", "P-GR1", "P-ST1", "P-CG1", "P-XC1", "P-MN1"]

SCRIPT_VERSION = "1.0.0"

# --- EVENTLOG --------------------------------------------------------------
def utcnow() -> str:
    return datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%MZ")

def today() -> str:
    return datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d")

_IDIOM_CACHE = None

def _guard_idiom(tok: str) -> str:
    """data/guard_idiom.json (実ヘッダの機械集計) で ifdef/numeric 慣用を判定。"""
    global _IDIOM_CACHE
    if _IDIOM_CACHE is None:
        p = os.path.join(DATA, "guard_idiom.json")
        try:
            _IDIOM_CACHE = json.load(open(p, encoding="utf-8"))
        except OSError:
            _IDIOM_CACHE = {}
    return _IDIOM_CACHE.get(tok, ["defined"])

def guard_expr(g: str) -> str:
    """stage1 抽出の guard 列 ('A|B', 'cond' 混在) を #if 式へ機械変換。

    抽出側の語彙: 'A|B' = 同じ宣言が defined(A) or defined(B) の variant で出現。
    'cond' = マクロ名が取れない variant (#else 側など) = 無条件で有効な変種が
    存在する → probe では guard 無しとして生成 (最終検証は実コンパイラ)。
    numeric 慣用 (#if X 形式) の macro は defined(X) では常に真になるので (X) として出す。
    """
    toks = [t.strip() for t in g.split("|") if t.strip()]
    if not toks or "cond" in toks:
        return ""
    parts = []
    for t in toks:
        idiom = _guard_idiom(t)
        if idiom == ["numeric"]:
            parts.append(f"({t})")
        elif "numeric" in idiom:
            parts.append(f"(!defined({t}) || ({t}))")
        else:
            parts.append(f"defined({t})")
    return " || ".join(parts)

def log_event(event: str, actor: str, target: str, detail: str) -> None:
    """EVENTLOG.md に 1 行 append (冪等ではない: 変更そのものの記録)。"""
    detail = detail.replace("|", "\\|").replace("\n", " ")
    line = f"| {utcnow()} | {event} | {actor} | {target} | {detail} |\n"
    with open(EVENTLOG, "a", encoding="utf-8") as f:
        f.write(line)

# --- AIR 命名文法 (build_air_definitive.py 方式のセグメント分割) ------------
_RE_RT = re.compile(r"^rt[zpen]$")
_RE_TYPE = re.compile(r"^(p\d+)?v?\d*[fibuh]\d+$")

def split_air_name(name: str):
    """air 名を (stem_starts_with_air, type_tail_segments, ok) に分解。

    'air.abs.s.i8'    -> ('air.abs.s', ['i8'], True)
    'air.atomic...'   -> rt は型接尾の一部として剥がす
    'air.' 不正なもの -> (…, …, False)
    """
    if not name or not name.startswith("air."):
        return name, [], False
    segs = name.split(".")
    # 末尾から型セグメント (rtXX / type) を剥がす
    tail: list[str] = []
    i = len(segs)
    while i > 2:  # segs[0]='air', segs[1..] は少なくとも1つ残す
        s = segs[i - 1]
        if _RE_RT.match(s) or _RE_TYPE.match(s):
            tail.insert(0, s)
            i -= 1
        else:
            break
    stem = ".".join(segs[:i])
    # 型 tail が文法的に妥当 (tail の各要素が rt か type に完全マッチ) か
    ok = all(_RE_RT.match(t) or _RE_TYPE.match(t) for t in tail)
    # stem 部分に残ったセグメントが空でない & 型文字混入なし
    if i < 2 or any(not seg for seg in segs[:i]):
        ok = False
    return stem, tail, ok

# --- 一次辞書の遅延ロード ---------------------------------------------------
_cache: dict = {}

def load_dicts() -> dict:
    """一次辞書をまとめてロード (冪等・キャッシュ)。返り値:
       declares: ir_air_signatures の実 declare 関数名集合 (air.xxx 名本体)
       stems_definitive: air_ops_definitive.csv の stem 集合
       stems_binaries: air_stems_binaries.txt の stem 集合
       literals_airconv: airconv_air_ops.csv の literal 名集合 (name_rule 除く)
       probe_cells: probe_cells.csv の cell 名集合
    """
    if _cache:
        return _cache

    declares: set[str] = set()
    p = os.path.join(DATA, "ir_air_signatures.csv")
    if os.path.exists(p):
        with open(p, newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                m = re.search(r"@([a-zA-Z0-9_.]+)\(", r["air_intrinsic_declare"])
                if m:
                    declares.add(m.group(1))

    stems_def: set[str] = set()
    p = os.path.join(DATA, "air_ops_definitive.csv")
    if os.path.exists(p):
        with open(p, newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                stems_def.add(r["air_op_stem"].strip())

    stems_bin: set[str] = set()
    p = os.path.join(DATA, "air_stems_binaries.txt")
    if os.path.exists(p):
        with open(p, encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#") and "\t" in line:
                    stems_bin.add(line.split("\t")[0])

    lit_ac: set[str] = set()
    p = os.path.join(DATA, "airconv_air_ops.csv")
    if os.path.exists(p):
        with open(p, newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                if r.get("kind") == "literal" and r.get("air_name_or_rule", "").startswith("air."):
                    lit_ac.add(r["air_name_or_rule"].strip())

    cells: set[str] = set()
    p = os.path.join(DATA, "probe_cells.csv")
    if os.path.exists(p):
        with open(p, newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                cells.add(r["cell"].strip())

    # golden 実測名 (2026-07-21 実機 probe 由来): 型 suffix を剥いで stems に合流
    p = os.path.join(DATA, "air_golden_names.csv")
    if os.path.exists(p):
        with open(p, newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                nm = r["air_name"].strip()
                if not nm:
                    continue
                stem, _tail, ok = split_air_name(nm)
                if ok and stem.startswith("air."):
                    stems_bin.add(stem)
                declares.add(nm)

    _cache.update(declares=declares, stems_definitive=stems_def,
                  stems_binaries=stems_bin, literals_airconv=lit_ac,
                  probe_cells=cells)
    return _cache

def assess_candidate(candidate: str, dicts=None):
    """candidate の文法照合。返り値 dict:
       grammar: 'yes'/'no' (文法的に正当に分解可能か)
       in_declares / in_stems_definitive / in_stems_binaries / in_airconv: bool
       stem: 分解後の stem
    """
    d = dicts or load_dicts()
    stem, tail, ok = split_air_name(candidate)
    # 完全一致 (実 declare 名) 優先、その後 stem 包含
    in_decl = candidate in d["declares"]
    in_def = stem in d["stems_definitive"]
    in_bin = stem in d["stems_binaries"]
    # airconv literal は型無し名が多いので、candidate そのもの or stem の前方一致も見る
    in_ac = candidate in d["literals_airconv"] or any(
        candidate.startswith(l + ".") or candidate == l for l in d["literals_airconv"])
    return {
        "grammar": "yes" if (ok and stem.startswith("air.")) else "no",
        "stem": stem,
        "in_declares": in_decl,
        "in_stems_definitive": in_def,
        "in_stems_binaries": in_bin,
        "in_airconv": in_ac,
    }

def compute_confidence(evidence: str, assess: dict, has_meta=False) -> str:
    """MAPPING_SCHEMA.md §4 の機械ルール。"""
    if evidence == "probed_xcode_ll":
        return "confirmed" if has_meta or True else "high"  # apply-golden 時は既に照合済
    if evidence == "rtlib_layer_backing":
        # callgraph で __air_impl_* 実装体の実在を確認済 = 一次証拠
        return "confirmed"
    if evidence == "observed_ir":
        if assess["in_declares"] or (assess["in_stems_definitive"] and assess["grammar"] == "yes"):
            return "confirmed"
        return "low"
    if evidence == "recomputed_callgraph":
        return "high"
    if evidence == "observed_airconv":
        return "high" if assess["grammar"] == "yes" else "medium"
    # inferred
    if assess["grammar"] == "yes":
        if assess["in_stems_binaries"] or assess["in_stems_definitive"] or assess["in_airconv"]:
            return "high"
        return "medium"
    return "low"

# --- CSV I/O (v2) -----------------------------------------------------------
def read_v2(path=None) -> list[dict]:
    path = path or MAP_V2
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))

def write_v2(rows: list[dict], path=None) -> None:
    path = path or MAP_V2
    with open(path, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=V2_FIELDS, extrasaction="ignore")
        w.writeheader()
        for r in rows:
            w.writerow({k: r.get(k, "") for k in V2_FIELDS})

if __name__ == "__main__":
    # 自己診断: 辞書サイズと照合サンプル
    d = load_dicts()
    print("dicts:", {k: len(v) for k, v in d.items()})
    for c in ["air.abs.s.i8", "air.atomic.global.add.u.i32",
              "air.absdiff", "air.fence_", "air.convert.f.f32.f16"]:
        print(c, "->", assess_candidate(c, d))
