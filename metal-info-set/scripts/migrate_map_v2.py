#!/usr/bin/env python3
"""migrate_map_v2.py — 対応表 v1 (凍結) から v2 (正本) を additive 生成する一回きりの器。

- v1 の 7 列は意味そのままコピー (リネーム・削除なし)
- v2 追加分は v1 evidence から *確実に分かるものだけ* 埋める (推測で日付等を埋めない)
- confidence / grammar_eligible は lib_mapschema の機械ルールで初期採点 (audit と同一ロジック)
- 生成後は promote_map.py が正本を更新する (このスクリプトは再実行しない前提で冪等にはしていないが、
  再実行しても同じ v1 から同じ v2 を生成するよう決定的に書く)
"""
import csv
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib_mapschema as S

EVIDENCE_INIT = {
    # v1 evidence -> (evidence_source, evidence_ref, protocol)
    "observed_ir": ("apple_rtlib_ir",
                    "data/ir_air_signatures.csv (C-4: rtlib bitcode 全文 parse)",
                    "P-IR1+P-MN1"),
    "observed_airconv": ("community_airconv_src",
                         "reference-external/dxmt/src/airconv (data/airconv_air_ops.csv)",
                         "P-AC1+P-MN1"),
    "inferred": ("this_repo_inference",
                 "docs/AIR_VOCABULARY.md (AIR 命名文法)",
                 "P-GR1+P-MN1"),
}

def main() -> None:
    dicts = S.load_dicts()
    with open(S.MAP_V1, newline="", encoding="utf-8") as f:
        rows_v1 = list(csv.DictReader(f))

    rows_v2 = []
    for r in rows_v1:
        ev = r["evidence"].strip()
        src, ref, proto = EVIDENCE_INIT.get(ev, ("this_repo_inference", "", "P-MN1"))
        cand = r["air_intrinsic_candidate"].strip()
        assess = S.assess_candidate(cand, dicts)
        conf = S.compute_confidence(ev, assess)
        # probe_cells.csv に同名 cell を持つ行は必須 probe 対象として連結
        row = {k: r.get(k, "") for k in S.V1_FIELDS}
        row.update({
            "evidence_source": src,
            "evidence_ref": ref,
            "protocol": proto,
            "confidence": conf,
            "grammar_eligible": assess["grammar"],
            "probe_cell": r["__metal_builtin"] if r["__metal_builtin"] in dicts["probe_cells"] else "",
            # 観測日は正確に分からない (推測で埋めない) → 空。verified_at は audit が埋める
            "observed_at": "",
            "verified_at": S.today(),
            "verified_by": f"migrate_map_v2.py@{S.SCRIPT_VERSION}",
            "last_change": S.utcnow(),
            "changed_by": f"migrate_map_v2.py@{S.SCRIPT_VERSION}",
        })
        rows_v2.append(row)

    S.write_v2(rows_v2)
    from collections import Counter
    dist = Counter(r["confidence"] for r in rows_v2)
    S.log_event("MIGRATE_V2", f"migrate_map_v2.py@{S.SCRIPT_VERSION}",
                "data/builtin_to_air_map.v2.csv",
                f"v1 の {len(rows_v1)} 行から v2 を additive 生成。初期 confidence 分布: {dict(dist)}")
    print(f"wrote {S.MAP_V2}: {len(rows_v2)} rows, confidence={dict(dist)}")

if __name__ == "__main__":
    main()
