#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
MSL API → 内部実装 対応表 (stage1) 抽出
metal_stdlib ヘッダの全 METAL_FUNC (free function) を解析し、
各MSL APIが (a) __metal_* builtin直叩き (要clang CodeGen対応)
          (b) 複数builtin/既存関数の合成 (要Sema最適化戦略)
          (c) ヘッダ内完結 (backend変更不要)
のどれに分類されるかを機械分類する。
"""
import csv, os, re, collections

REPO = "/home/user/metal-repo"
HDR = f"{REPO}/reference/clang/32023.883/include/metal"
OUT = "/home/user/metal-info-set/data"
os.makedirs(OUT, exist_ok=True)

# free function が定義されている主要 numeric/stdlib ヘッダ
TARGETS = ["metal_math", "metal_integer", "metal_geometric", "metal_relational",
           "metal_common", "metal_numeric", "metal_array", "metal_utility",
           "metal_matrix", "metal_pack", "metal_packed_numeric", "metal_extended_vector"]
RX_BUILTIN = re.compile(r"__metal_[a-z0-9_]+")
RX_CLBUILTIN = re.compile(r"__builtin_[a-z0-9_]+")

def parse_file(path):
    rel = os.path.relpath(path, HDR)
    txt = open(path, errors="replace").read()
    lines = txt.splitlines()
    records = []
    ns = "metal"          # fast / precise 検出用 (単純追跡)
    guards = []           # #if ガードスタック
    i = 0
    n = len(lines)
    while i < n:
        line = lines[i]
        s = line.strip()
        m = re.match(r"#\s*if(?:\s+defined)?\(?\s*(__HAVE_[A-Z0-9_]+__)", s)
        if m: guards.append(m.group(1))
        elif re.match(r"#\s*if\b", s) and not s.startswith("#ifdef __METAL"): guards.append("cond")
        elif re.match(r"#\s*endif", s) and guards: guards.pop()
        m2 = re.match(r"^namespace\s+(fast|precise)\s*\{", s)
        if m2: ns = m2.group(1)
        if re.match(r"^}\s*(//.*)?$", s) and ns != "metal": ns = "metal"
        if re.match(r"^METAL_FUNC\s+", line):  # free function は行頭 METAL_FUNC
            start = i + 1
            sig = line.strip()
            # シグネチャ完結待ち ( ')' が閉じるまで )
            while sig.count("(") > sig.count(")") and i + 1 < n:
                i += 1; sig += " " + lines[i].strip()
            # body 抽出: 次の { から対応 } まで
            body = ""
            brace = 0; j = i
            started = False
            while j < n:
                l2 = lines[j]
                for ch in l2:
                    if ch == "{": brace += 1; started = True
                    elif ch == "}": brace -= 1
                body += l2 + "\n"
                j += 1
                if started and brace == 0: break
            ret_name = re.sub(r"^METAL_FUNC\s+", "", sig)
            builtins = RX_BUILTIN.findall(body)
            clbs = RX_CLBUILTIN.findall(body)
            other_calls = sorted(set(re.findall(r"\b(as_type|fast::|precise::)\w*", body)))
            if builtins:
                kind = "builtin_direct" if len(set(builtins)) == 1 and not re.search(r"\breturn\s+(?!__metal_)", body.replace("return __metal_", "__KEEP__")[:0] or "") else "builtin_direct"
                # 分類: body 内で最後の return が単一 __metal_ 呼出のみか
                if len(set(builtins)) > 1 or re.search(r"\b(if|for|while|switch)\b", body):
                    kind = "builtin_composed"
            elif clbs or other_calls:
                kind = "header_composed"
            else:
                kind = "header_only"
            records.append({
                "file": rel, "line": start, "namespace": ns,
                "signature": ret_name,
                "guard": "|".join(g for g in guards) or "",
                "kind": kind,
                "metal_builtins": " ".join(sorted(set(builtins))),
                "clang_builtins": " ".join(sorted(set(clbs))),
            })
            i = j; continue
        i += 1
    return records

def main():
    allrecs = []
    for t in TARGETS:
        p = os.path.join(HDR, t)
        if os.path.isfile(p): allrecs.extend(parse_file(p))
    with open(f"{OUT}/msl_stage1_api_to_builtin.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["msl_api_signature", "namespace", "guard", "class", "metal_builtins", "clang_builtins", "file", "line"])
        for r in allrecs:
            w.writerow([r["signature"], r["namespace"], r["guard"], r["kind"],
                        r["metal_builtins"], r["clang_builtins"], r["file"], r["line"]])
    # 統計
    c = collections.Counter(r["kind"] for r in allrecs)
    files = collections.Counter(r["file"] for r in allrecs)
    direct_builtins = sorted({b for r in allrecs if r["kind"].startswith("builtin") for b in r["metal_builtins"].split() if b})
    never_direct = None
    with open(f"{OUT}/msl_stage1_summary.md", "w") as f:
        f.write("# MSL API → 変換経路 分類結果 (stage1 抽出)\n\n")
        f.write("| 分類 | 件数 | clang対応の要否 |\n|---|---:|---|\n")
        need = {"builtin_direct": "**必要**: CodeGenで `air.*` 等へ lower",
                "builtin_composed": "**必要**: 複数 builtin の合成 lowering",
                "header_composed": "概ね不要 (header内で合成済・最終的に既存表現へ)",
                "header_only": "不要 (pure C++)"}
        note = {"builtin_direct": "本体が単一 `__metal_*` 呼出",
                "builtin_composed": "分岐/合成を含む",
                "header_composed": "__builtin_*/as_type 等のみ",
                "header_only": "純粋なヘッダ実装"}
        for k in ["builtin_direct", "builtin_composed", "header_composed", "header_only"]:
            f.write(f"| {k} ({note[k]}) | {c.get(k,0)} | {need[k]} |\n")
        f.write(f"\n合計 {sum(c.values())} API (free functions, {len(files)} headers)\n\n")
        f.write("## header 別件数\n\n| header | APIs |\n|---|---:|\n")
        for fn, cnt in files.most_common(): f.write(f"| `{fn}` | {cnt} |\n")
        f.write(f"\n## builtin_direct/composed が参照するユニーク __metal_* builtin 数: **{len(direct_builtins)}**\n")
        f.write("(カタログ 686 個のうち free function 経由で使われるもの。残りは texture 等クラスメソッド経由)\n")
    print("rows:", len(allrecs), dict(c), "unique builtins used:", len(direct_builtins))

if __name__ == "__main__":
    main()
