#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""全11バージョンの MSL 仕様書テキストを横断採掘"""
import csv, re, collections, os

OUT = "/home/user/metal-info-set/data"
DOCS = "/home/user/metal-info-set/docs"
VERSIONS = ["1.2", "2.0", "2.1", "2.2", "2.3", "2.4", "3.0", "3.1", "3.2", "4.0", "4.1"]
texts = {v: (open(f"/home/user/metal-info-set/work/spec/msl{v}.txt", errors="replace").read()
             if os.path.exists(f"/home/user/metal-info-set/work/spec/msl{v}.txt") else "")
         for v in VERSIONS}

rx_attr = re.compile(r"\[\[\s*([a-z_][a-z0-9_]*)(?:\s*\(([^]]*)\))?\s*\]\]")
ver_attrs = {v: collections.Counter(a for a, _ in rx_attr.findall(texts[v])) for v in VERSIONS}
all_attrs = sorted({a for v in VERSIONS for a in ver_attrs[v]})

def fv(a):
    for v in VERSIONS:
        if ver_attrs[v][a]: return v
    return ""

# ---- 1. 属性 × バージョン マトリクス
with open(f"{OUT}/spec_attrs_matrix.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["attribute", "intro_version"] + VERSIONS)
    for a in all_attrs:
        w.writerow([a, fv(a)] + [ver_attrs[v][a] or "" for v in VERSIONS])
intro_counts = collections.Counter(fv(a) for a in all_attrs)
print("attr timeline:", len(all_attrs), "attrs;  intro:", dict(intro_counts))

# ---- 2. 新機能セクション抽出 (新版 "New in Metal" / 旧版 "Revision History")
news = {}
for v in VERSIONS:
    t = texts[v]
    idx = t.find("New in Metal", int(len(t) * 0.05))
    if idx >= 0:
        end = re.search(r"\n1\.4\s", t[idx:]) or re.search(r"\n1\.4", t[idx:])
        stop = idx + end.start() if end else idx + 3000
        news[v] = ("New in Metal", t[idx:stop].strip())
    else:
        idx = t.rfind("Revision History")
        if idx >= 0:
            news[v] = ("Revision History", t[idx:idx + 3500].strip())

# ---- 3. 章構成の変遷 (各バージョン自身の ToC から抽出: トップレベル章のみ)
rxA = re.compile(r"(?<![\d.])(\d{1,2})\s+([A-Z][A-Za-z ()\-/]{3,50}?)\s*\.{3,}\s*\d+")
rxB = re.compile(r"(?m)^\s*(\d{1,2})[. ]+([A-Z][A-Za-z ()\-/]{3,50}?)\s+\d+\s*$")
rxC = re.compile(r"(?m)^\s*(\d{1,2})\s+([A-Z][A-Za-z ()\-/]{3,50}?)\s+\d+\s*\.{3,}\s*$")
def toc_of(t):
    head = t[:40000]
    out = []
    for m in list(rxA.finditer(head)) + list(rxB.finditer(head)) + list(rxC.finditer(head)):
        n = int(m.group(1))
        if n > 20: continue
        title = re.sub(r"\s+", " ", m.group(2).strip())
        out.append(f"{m.group(1)} {title}")
    return out
chapters = {v: set(toc_of(texts[v])) for v in VERSIONS}
canon = sorted({c for v in VERSIONS for c in chapters[v]}, key=lambda c: (int(c.split()[0]), c))
with open(f"{OUT}/spec_chapters_matrix.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["chapter", "intro_version"] + VERSIONS)
    for c in canon:
        intro = next((v for v in VERSIONS if c in chapters[v]), "")
        w.writerow([c, intro] + ["1" if c in chapters[v] else "" for v in VERSIONS])
print("chapters tracked:", len(canon))

# ---- 4. タイムラインドキュメント
with open(f"{DOCS}/SPEC_VERSION_TIMELINE.md", "w") as f:
    f.write("# MSL 仕様書 全バージョン横断タイムライン\n\n")
    f.write("11 全バージョンの新機能セクション (新版: \"New in Metal X.Y\" / 旧版: 8 Revision History) 原文抜粋と、"
            "`[[属性]]`・章の導入時期マトリクス。データ: `data/spec_attrs_matrix.csv`, `data/spec_chapters_matrix.csv`\n\n")
    f.write("## 属性導入時期サマリ\n\n| MSL | 新出属性 |\n|---|---|\n")
    for v in VERSIONS:
        born = sorted(a for a in all_attrs if fv(a) == v)
        if born:
            f.write(f"| **{v}** ({len(born)}) | " + ", ".join(f"`{b}`" for b in born) + " |\n")
    f.write("\n## 章レベルの構造変遷 (4.1 ToC 基準の出現検出)\n\n")
    f.write("主要トピックの初出: `ray_data`=" +
            next((v for v in VERSIONS if "ray_data" in texts[v]), "?") +
            ", `object_data`=" + next((v for v in VERSIONS if "object_data" in texts[v]), "?") +
            ", imageblock=" + next((v for v in VERSIONS if "imageblock" in texts[v]), "?") + "\n\n")
    f.write("---\n\n## 各バージョンの新機能 (原文)\n")
    for v in VERSIONS:
        src, body = news.get(v, ("(該当セクション無し: Apple は 3.2 から新機能節を新設)", ""))
        f.write(f"\n### Metal {v} (出典: {src})\n\n```\n{body[:3200]}\n```\n")
print("timeline doc written:", len(news), "versions")

# ---- 5. アドレス空間・主要機能初出ログ
for key in ["ray_data", "object_data", "threadgroup_imageblock", "imageblock", "function_constant",
            "simdgroup", "mesh_grid_properties", "tensor", "bfloat", "packed_numeric"]:
    hist = [v for v in VERSIONS if key in texts[v]]
    print(f"  {key}: first={hist[0] if hist else '-'}")
