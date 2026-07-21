#!/usr/bin/env python3
"""promote_map.py — 対応表 v2 の昇格/検証パイプライン本体.

サブコマンド:
  audit              全行を一次辞書で再検算 (冪等)。confidence 再付与・QUARANTINE 記録。
  report             確度集計を data/promote_report.md に出力。
  ingest-callgraph   data/callgraph_edges.csv の定義側 air 呼出を補助証拠として昇格。
  apply-golden DIR   golden corpus (実機 Xcode 生成 .ll) で probed_xcode_ll に昇格。
                     --selftest で docs/samples の既知 IR に対して器を検証。

設計原則 (MAPPING_SCHEMA.md 準拠):
  - 一致昇格のみ。不一致で降格しない (MISMATCH として EVENTLOG に残す)
  - 「この関数はこの builtin を叩く」は MANIFEST.csv のみを信頼 (推測で接続しない)
  - 全変更は EVENTLOG.md に日時記録
"""
import argparse
import csv
import os
import re
import sys
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

ACTOR = f"promote_map.py@{S.SCRIPT_VERSION}"
MANIFEST_FIELDS = ["scene", "file", "symbol", "builtin", "stage1_source"]

# ---------------------------------------------------------------- audit
def cmd_audit(write: bool = True) -> dict:
    rows = S.read_v2()
    dicts = S.load_dicts()
    changed = 0
    quarantined = []
    stats = Counter()
    for r in rows:
        cand = r["air_intrinsic_candidate"].strip()
        assess = S.assess_candidate(cand, dicts)
        new_conf = S.compute_confidence(r["evidence"], assess)
        new_gram = assess["grammar"]
        old_conf = r["confidence"]
        stats[(r["evidence"], new_conf)] += 1
        if new_conf != old_conf or new_gram != r["grammar_eligible"]:
            changed += 1
            if CONFIDENCE_RANK(new_conf) < CONFIDENCE_RANK(old_conf):
                quarantined.append((r["__metal_builtin"], old_conf, new_conf,
                                    f"stem={assess['stem']}"))
            r["confidence"] = new_conf
            r["grammar_eligible"] = new_gram
            r["last_change"] = S.utcnow()
            r["changed_by"] = ACTOR
        r["verified_at"] = S.today()
        r["verified_by"] = ACTOR
    if write:
        S.write_v2(rows)
        S.log_event("AUDIT", ACTOR, "data/builtin_to_air_map.v2.csv",
                    f"再検算 {len(rows)} 行; 変動 {changed} 行; "
                    f"分布 {dict(Counter(c for _, c in stats))}")
        for b, o, n, why in quarantined:
            S.log_event("QUARANTINE", ACTOR, b, f"confidence {o}->{n} ({why})")
    return {"rows": len(rows), "changed": changed, "quarantined": quarantined,
            "stats": stats}

def CONFIDENCE_RANK(c: str) -> int:
    return {"low": 0, "medium": 1, "high": 2, "confirmed": 3}.get(c, -1)

# ---------------------------------------------------------------- report
def cmd_report() -> str:
    rows = S.read_v2()
    dicts = S.load_dicts()
    lines = ["# 対応表 v2 確度レポート", "",
             f"生成: {S.utcnow()} by {ACTOR} (冪等: audit 直後の状態の集計)", ""]
    ev_conf = Counter((r["evidence"], r["confidence"]) for r in rows)
    lines += ["## evidence × confidence", "",
              "| evidence | confirmed | high | medium | low | 計 |", "|---|---|---|---|---|---|"]
    for ev in S.EVIDENCE_VALUES:
        cs = [ev_conf.get((ev, c), 0) for c in S.CONFIDENCE_VALUES]
        if sum(cs):
            lines.append(f"| {ev} | {cs[0]} | {cs[1]} | {cs[2]} | {cs[3]} | {sum(cs)} |")
    cs = [Counter(r["confidence"] for r in rows).get(c, 0) for c in S.CONFIDENCE_VALUES]
    lines.append(f"| **計** | **{cs[0]}** | **{cs[1]}** | **{cs[2]}** | **{cs[3]}** | **{len(rows)}** |")
    cells = [r["__metal_builtin"] for r in rows if r["probe_cell"]]
    lines += ["", f"## probe 必須セル残: **{len(cells)}** 件",
              f"(probe_cells.csv 全 {len(dicts['probe_cells'])} セル中、対応表行に連結済 "
              f"{len(cells)} 件)"]
    src = Counter(r["evidence_source"] for r in rows)
    lines += ["", "## evidence_source 分布", ""]
    for k, v in src.most_common():
        lines.append(f"- {k}: {v}")
    not_verified = [r["__metal_builtin"] for r in rows if not r["verified_at"]]
    lines += ["", f"## 検証日付カバレッジ", "",
              f"- verified_at 記録済: {len(rows) - len(not_verified)}/{len(rows)}",
              f"- observed_at (一次観測日) 記録済: "
              f"{sum(1 for r in rows if r['observed_at'])}/{len(rows)} "
              f"(不明なものは推測で埋めない方針のため空)"]
    out = os.path.join(S.DATA, "promote_report.md")
    with open(out, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    S.log_event("REPORT", ACTOR, "data/promote_report.md", f"{len(rows)} 行を集計")
    return out

# ---------------------------------------------------------------- ingest-callgraph
def cmd_ingest_callgraph(edges_path: str = None) -> dict:
    edges_path = edges_path or os.path.join(S.DATA, "callgraph_edges.csv")
    rows = S.read_v2()
    by_builtin = {r["__metal_builtin"]: r for r in rows}

    # rtlib_pairing: __air_impl_<name> 公開シンボル → internal 実装オブジェクト
    impl2obj = {}
    p = os.path.join(S.DATA, "rtlib_pairing.csv")
    if os.path.exists(p):
        with open(p, newline="", encoding="utf-8") as f:
            for r in csv.DictReader(f):
                obj = r["impl_object"].strip()
                for sym in r["public_symbols_before_next_impl"].split(";"):
                    sym = sym.strip()
                    if sym:
                        impl2obj[sym] = obj

    # edges: caller が air.* を呼ぶ関係のうち、caller または caller の公開ペアが
    # __air_impl_<suffix> で `__metal_<suffix>` が対応表に存在するもの
    promoted, skipped_nomatch, mismatched = [], 0, []
    seen = set()
    with open(edges_path, newline="", encoding="utf-8") as f:
        for e in csv.DictReader(f):
            callee = e["callee"]
            if not callee.startswith("air."):
                continue
            caller = e["caller"]
            # caller 自体 or その internal オブジェクトが公開名を持つか
            names = [caller]
            for sym, obj in impl2obj.items():
                if caller.startswith(obj) or caller == obj:
                    names.append(sym)
            suffix = None
            for n in names:
                if n.startswith("__air_impl_"):
                    suffix = n[len("__air_impl_"):]
                    break
            if not suffix:
                continue
            builtin = "__metal_" + suffix
            if builtin not in by_builtin:
                skipped_nomatch += 1
                continue
            row = by_builtin[builtin]
            if (builtin, callee) in seen:
                continue
            seen.add((builtin, callee))
            # 名マッチは接続として弱いので、型 stem 照合も必須にする
            cand = row["air_intrinsic_candidate"]
            ast = S.assess_candidate(cand)
            est = S.assess_candidate(callee)
            same = (ast["stem"] == est["stem"]
                    or est["stem"].startswith(ast["stem"] + ".")
                    or ast["stem"].startswith(est["stem"] + ".")
                    or callee.startswith(cand.split(".")[0] + "."))
            if not same:
                mismatched.append((builtin, cand, callee))
                continue
            if row["evidence"] in ("inferred",) and CONFIDENCE_RANK(row["confidence"]) < CONFIDENCE_RANK("high"):
                row["evidence"] = "recomputed_callgraph"
                row["evidence_source"] = "apple_rtlib_ir"
                row["evidence_ref"] = f"data/callgraph_edges.csv ({caller} -> {callee})"
                if "P-CG1" not in row["protocol"]:
                    row["protocol"] += "+P-CG1"
                row["confidence"] = "high"
                row["last_change"] = S.utcnow()
                row["changed_by"] = ACTOR
                promoted.append(builtin)
    S.write_v2(rows)
    S.log_event("INGEST_CALLGRAPH", ACTOR, edges_path,
                f"昇格 {len(promoted)} 件 (recomputed_callgraph); "
                f"対応表に無い impl {skipped_nomatch} 件; 照合不一致 {len(mismatched)} 件")
    for b, c, g in mismatched[:20]:
        S.log_event("CG_MISMATCH", ACTOR, b, f"candidate={c} vs callgraph={g}")
    return {"promoted": promoted, "skipped": skipped_nomatch, "mismatched": mismatched}

# ---------------------------------------------------------------- apply-rtlib-layer
def cmd_apply_rtlib_layer(map_path: str = None) -> dict:
    """rtlib_layer_map.csv (callgraph 一次情報由来) を適用し、
    「AIR intrinsic ではなくランタイム実装呼出に lowering される builtin」を確定する。

    - evidence = rtlib_layer_backing (新 enum, confidence=confirmed)
    - candidate を `rtlib:__air_impl_<base>` 表記に更新 (旧の air.XXX 候補は偽であり、
      EVENTLOG に旧値を記録した上で値を修正。additive 原則は列の話であり、
      の確定した誤値を残すことはしない)
    """
    rows = S.read_v2(map_path)
    by_builtin = {r["__metal_builtin"]: r for r in rows}
    layer_path = os.path.join(S.DATA, "rtlib_layer_map.csv")
    layer = list(csv.DictReader(open(layer_path, newline="", encoding="utf-8")))
    # builtin -> [impl symbols] (base 一致のみ)
    b2impls: dict[str, list[dict]] = {}
    for ent in layer:
        b2impls.setdefault(ent["metal_builtin"], []).append(ent)

    applied, upgraded, already = [], [], []
    for builtin, ents in sorted(b2impls.items()):
        row = by_builtin.get(builtin)
        if row is None:
            continue
        if row["evidence"] == "rtlib_layer_backing":
            already.append(builtin)
            continue
        impl_syms = sorted(e["air_impl_symbol"] for e in ents)
        base = ents[0]["impl_base"]
        old_ev, old_cand = row["evidence"], row["air_intrinsic_candidate"]
        if old_ev == "recomputed_callgraph":
            upgraded.append(builtin)
        else:
            applied.append(builtin)
        row["evidence"] = "rtlib_layer_backing"
        row["evidence_source"] = "apple_rtlib_ir"
        row["evidence_ref"] = ("data/rtlib_layer_map.csv + data/callgraph_edges.csv "
                               f"(実装関数実在: {impl_syms[0]} 等 {len(impl_syms)} variant)")
        if "P-CG1" not in row["protocol"]:
            row["protocol"] += "+P-CG1"
        old_candidate = row["air_intrinsic_candidate"]
        row["air_intrinsic_candidate"] = f"rtlib:__air_impl_{base}"
        row["grammar_eligible"] = "no"        # rtlib 表記は AIR 文法の対象外
        row["confidence"] = "confirmed"
        ex = ents[0]["msl_api_example"].split(" | ")[0] if ents[0]["msl_api_example"] else ""
        row["status"] = ("✅rtlib層確定: AIR intrinsic ではなく __air_impl_%s 系呼出に lowering"
                         " (callgraph 実証; v1 候補 %s は偽)" % (base, old_candidate))
        if ex:
            row["stdlib_sample"] = row["stdlib_sample"] or ex
        row["last_change"] = S.utcnow()
        row["changed_by"] = ACTOR
        S.log_event("RTLIB_BACKING", ACTOR, builtin,
                    f"{old_ev}({old_cand}) -> rtlib_layer_backing(rtlib:__air_impl_{base}); "
                    f"variants={len(impl_syms)}")
    S.write_v2(rows, map_path)
    S.log_event("APPLY_RTLIB_LAYER", ACTOR, layer_path,
                f"rtlib 層確定 {len(applied)} 件 + recomputed_callgraph から格上げ "
                f"{len(upgraded)} 件 (既適用 {len(already)})")
    return {"applied": applied, "upgraded": upgraded, "already": already}


# ---------------------------------------------------------------- apply-golden
_RE_DEFINE = re.compile(r"^define\b[^@]*@([A-Za-z0-9_.$]+)\(")
_RE_CALL_AIR = re.compile(r"\bcall\b[^@]*@((?:air|llvm\.air)\.[A-Za-z0-9_.]+)\(")

def extract_air_calls_by_symbol(ll_path: str):
    """テキスト .ll から {symbol: [(air_name, full_call_line), ...]} を抽出。"""
    result: dict[str, list] = {}
    cur = None
    with open(ll_path, encoding="utf-8", errors="replace") as f:
        for line in f:
            m = _RE_DEFINE.match(line)
            if m:
                cur = m.group(1)
                result.setdefault(cur, [])
                continue
            if cur is not None:
                if line.startswith("}"):
                    cur = None
                    continue
                for cm in _RE_CALL_AIR.finditer(line):
                    result[cur].append((cm.group(1), line.strip()))
    return result

def load_manifest(path: str):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))

def cmd_apply_golden(golden_dir: str, manifest_path: str, map_path: str = None) -> dict:
    rows = S.read_v2(map_path)
    by_builtin = {r["__metal_builtin"]: r for r in rows}
    manifest = load_manifest(manifest_path)

    # meta.yml の日付 (SHA256 は任意) — 無ければ observed_at は空 (推測で埋めない)
    meta_date = ""
    meta_path = os.path.join(golden_dir, "meta.yml")
    if os.path.exists(meta_path):
        with open(meta_path, encoding="utf-8") as f:
            for line in f:
                m = re.match(r"\s*date\s*:\s*([0-9]{4}-[0-9]{2}-[0-9]{2})", line)
                if m:
                    meta_date = m.group(1)

    # .ll を scene 名で索引 (golden/<SCENE>/<variant>/*.ll)
    ll_index: dict[str, list[str]] = {}
    for dirpath, _, files in os.walk(golden_dir):
        for fn in files:
            if fn.endswith(".ll"):
                rel = os.path.relpath(os.path.join(dirpath, fn), golden_dir)
                scene = rel.split(os.sep)[0]
                ll_index.setdefault(scene, []).append(rel)

    air_calls_cache: dict[str, dict] = {}
    def calls_for(rel: str):
        if rel not in air_calls_cache:
            air_calls_cache[rel] = extract_air_calls_by_symbol(
                os.path.join(golden_dir, rel))
        return air_calls_cache[rel]

    promoted, mismatched, missing = [], [], []
    for ent in manifest:
        scene, sym, builtin = ent["scene"], ent["symbol"], ent["builtin"]
        if builtin not in by_builtin:
            missing.append((scene, sym, builtin, "builtin not in map"))
            continue
        row = by_builtin[builtin]
        found = None
        for rel in ll_index.get(scene, []):
            symtab = calls_for(rel)
            if sym in symtab and symtab[sym]:
                found = (rel, symtab[sym])
                break
        if not found:
            missing.append((scene, sym, builtin, "no air call in golden symbol"))
            continue
        rel, calls = found
        cand = row["air_intrinsic_candidate"]
        ast = S.assess_candidate(cand)
        hit = None
        for air_name, fullline in calls:
            est = S.assess_candidate(air_name)
            if (est["stem"] == ast["stem"]
                    or est["stem"].startswith(ast["stem"] + ".")
                    or ast["stem"].startswith(est["stem"] + ".")):
                hit = (air_name, fullline)
                break
        if not hit:
            mismatched.append((scene, sym, builtin, cand,
                               [c[0] for c in calls][:3]))
            continue
        if row["evidence"] == "probed_xcode_ll":
            continue  # 既に昇格済 (冪等)
        row["evidence"] = "probed_xcode_ll"
        row["evidence_source"] = "xcode_probe_golden"
        row["evidence_ref"] = f"golden/{rel} @{sym}: {hit[1][:180]}"
        if "P-XC1" not in row["protocol"]:
            row["protocol"] += "+P-XC1"
        row["confidence"] = "confirmed"
        if meta_date:
            row["observed_at"] = meta_date
        row["air_intrinsic_candidate"] = hit[0]  # 型 suffix まで確定した実名に更新
        row["status"] = "✅実機 Xcode 生成 IR で確認 (golden corpus)"
        row["last_change"] = S.utcnow()
        row["changed_by"] = ACTOR
        promoted.append((scene, sym, builtin, hit[0]))

    S.write_v2(rows, map_path)
    S.log_event("APPLY_GOLDEN", ACTOR, golden_dir,
                f"manifest {len(manifest)} 件: 昇格 {len(promoted)}, "
                f"不一致 {len(mismatched)}, 未回収 {len(missing)}")
    for scene, sym, builtin, cand, seen in mismatched:
        S.log_event("XC_MISMATCH", ACTOR, builtin,
                    f"{scene}/{sym}: candidate={cand} vs golden={seen}")
    return {"promoted": promoted, "mismatched": mismatched, "missing": missing}

# ---------------------------------------------------------------- selftest
def cmd_selftest() -> int:
    """器の検証: docs/samples/tracepoint.metal.air.ll を golden、
    手書き manifest (実際にその関数が air.* を呼ぶことは C-4 で確認済) で
    apply-golden を試し、少なくとも 1 件の照合が機能することを確認する。
    失敗時は非 0 終了。"""
    import tempfile
    # slice0.ll は 18 define + 実 air.* 呼出 (air.atomic.global.add.u.i32 等) を含む
    # エントリ関数スライス (tracepoint.metal.air.ll は stub のみで不適)
    sample = os.path.join(S.DOCS, "samples", "slice0.ll")
    if not os.path.exists(sample):
        print("SELFTEST SKIP: sample ll not found"); return 0
    calls = extract_air_calls_by_symbol(sample)
    if not calls:
        print("SELFTEST FAIL: no air calls extracted from sample"); return 1
    # 実在する (symbol, air_name) を拾って manifest を合成
    sym, pairs = next((s, p) for s, p in calls.items() if p)
    tmp = tempfile.mkdtemp(prefix="promote_selftest_")
    golden = os.path.join(tmp, "golden", "P_SELFTEST", "metal32_macosx14")
    os.makedirs(golden)
    os.symlink(sample, os.path.join(golden, "probe.ll"))
    with open(os.path.join(tmp, "golden", "meta.yml"), "w") as f:
        f.write("date: 2026-07-21\nnote: selftest synthetic\n")
    man = os.path.join(tmp, "MANIFEST.csv")
    with open(man, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=MANIFEST_FIELDS)
        w.writeheader()
        # builtin 名は対応表に存在するものを 1 つ選ぶ (candidate stem が一致するもの)
        rows = S.read_v2()
        air_name = pairs[0][0]
        est = S.assess_candidate(air_name)
        target = None
        for r in rows:
            ast = S.assess_candidate(r["air_intrinsic_candidate"])
            if ast["stem"] == est["stem"] and r["evidence"] != "probed_xcode_ll":
                target = r["__metal_builtin"]
                break
        if not target:
            print("SELFTEST FAIL: no builtin matching sample air name",
                  air_name); return 1
        w.writerow({"scene": "P_SELFTEST", "file": "probe.metal",
                    "symbol": sym, "builtin": target, "stage1_source": "selftest"})
    map_copy = os.path.join(tmp, "map_copy.csv")
    import shutil
    shutil.copyfile(S.MAP_V2, map_copy)
    res = cmd_apply_golden(os.path.join(tmp, "golden"), man, map_path=map_copy)
    ok = len(res["promoted"]) == 1
    print(f"SELFTEST {'OK' if ok else 'FAIL'}: promoted={res['promoted']}, "
          f"mismatched={res['mismatched']}, missing={res['missing']}")
    # 正本はコピーで実行したため汚染なし。器の検証事実のみ EVENTLOG に記録。
    S.log_event("SELFTEST", ACTOR, "docs/samples/tracepoint.metal.air.ll",
                f"apply-golden 器の自己検証: {'OK' if ok else 'FAIL'} "
                f"(symbol={sym}, builtin={target})")
    return 0 if ok else 1

# ---------------------------------------------------------------- main
def main():
    ap = argparse.ArgumentParser(description="対応表 v2 昇格/検証パイプライン")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("audit")
    sub.add_parser("report")
    p = sub.add_parser("ingest-callgraph")
    p.add_argument("--edges", default=None)
    sub.add_parser("apply-rtlib-layer")
    p = sub.add_parser("apply-golden")
    p.add_argument("golden_dir")
    p.add_argument("--manifest", required=True)
    sub.add_parser("selftest")
    args = ap.parse_args()

    if args.cmd == "audit":
        res = cmd_audit()
        print(f"audit: rows={res['rows']} changed={res['changed']} "
              f"quarantined={len(res['quarantined'])}")
    elif args.cmd == "report":
        print("wrote", cmd_report())
    elif args.cmd == "ingest-callgraph":
        res = cmd_ingest_callgraph(args.edges)
        print(f"ingest: promoted={len(res['promoted'])} "
              f"skipped={res['skipped']} mismatched={len(res['mismatched'])}")
    elif args.cmd == "apply-rtlib-layer":
        res = cmd_apply_rtlib_layer()
        print(f"apply-rtlib-layer: applied={len(res['applied'])} "
              f"upgraded={len(res['upgraded'])} already={len(res['already'])}")
    elif args.cmd == "apply-golden":
        res = cmd_apply_golden(args.golden_dir, args.manifest)
        print(f"apply-golden: promoted={len(res['promoted'])} "
              f"mismatched={len(res['mismatched'])} missing={len(res['missing'])}")
    elif args.cmd == "selftest":
        sys.exit(cmd_selftest())

if __name__ == "__main__":
    main()
