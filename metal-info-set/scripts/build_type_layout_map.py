#!/usr/bin/env python3
"""build_type_layout_map.py — opaque `_t` 型の IR 型レイアウト定量表を機械生成

一次ソース:
  - golden corpus 全 probe.ll (実機 Xcode 生成 IR): 型宣言 (= type opaque)、
    使用 addrspace、出現度数を走査
  - reference/clang/32023.883/include 実ヘッダ: `__metal_*_t` builtin の宣言文脈
  - data/builtin_to_air_map.v2.csv: builtin 行との連結

出力 (additive 新ファイル):
  - data/type_layout_map.csv
  - docs/TYPE_LAYOUT_MAP.md
"""
import csv, glob, os, re
from collections import OrderedDict

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)
HDR = '/home/user/metal-repo/reference/clang/32023.883/include'

ll_files = sorted(glob.glob('golden/**/probe.ll', recursive=True) +
                  glob.glob('golden/**/bisect*.ll', recursive=True))

STRUCT_RE = re.compile(r'(%struct\.[A-Za-z0-9_.]+) *= *type *([A-Za-z]+)')
AS_RE = re.compile(r'(%struct\.[A-Za-z0-9_.]+) addrspace\((\d)\)')

# 1) corpus scan
occ = {}
addr = {}
files_of = {}
for f in ll_files:
    t = open(f, encoding='utf-8', errors='replace').read()
    for m in STRUCT_RE.finditer(t):
        s, form = m.group(1), m.group(2)
        if not s.startswith('%struct._') or not s.endswith('_t'):
            continue
        occ.setdefault(s, [0, form])
        occ[s][0] += 1
        files_of.setdefault(s, set()).add(f)
    for m in AS_RE.finditer(t):
        addr.setdefault(m.group(1), set()).add(int(m.group(2)))

# 2) builtin 行連結
rows = {r['__metal_builtin']: r for r in csv.DictReader(open('data/builtin_to_air_map.v2.csv'))}

# 3) ヘッダ宣言文脈
hdr_ctx = {}
for dp, _, fns in os.walk(HDR):
    for fn in fns:
        p = os.path.join(dp, fn)
        rel = os.path.relpath(p, HDR)
        for i, line in enumerate(open(p, encoding='utf-8', errors='replace'), 1):
            for m in re.finditer(r'__metal_[A-Za-z0-9_]+_t\b', line):
                b = m.group(0)
                if b not in hdr_ctx and line.strip():
                    hdr_ctx.setdefault(b, []).append(f'{rel}:{i}: {line.strip()[:110]}')

out_rows = []
for s in sorted(occ):
    n, form = occ[s]
    base = s[len('%struct._'):-len('_t')]  # e.g. texture_2d
    builtin = '__metal_' + base + '_t'
    linked = builtin if builtin in rows else ''
    spaces = ' '.join(f'as{a}' for a in sorted(addr.get(s, set())))
    evid = ';'.join(sorted(files_of.get(s, set()))[:3])
    hdecl = hdr_ctx.get(builtin, [''])[0]
    out_rows.append(OrderedDict([
        ('ir_struct', s), ('builtin_row', linked), ('ir_form', form),
        ('n_corpus_occurrences', n), ('addrspaces_observed', spaces),
        ('pointer_size_bytes', 8), ('header_decl_context', hdecl),
        ('evidence_files', evid), ('status', '✅golden corpus 実測 (opaque 宣言・addrspace 使用)'),
    ]))

with open('data/type_layout_map.csv', 'w', newline='') as f:
    w = csv.DictWriter(f, fieldnames=list(out_rows[0].keys()), lineterminator='\n')
    w.writeheader(); w.writerows(out_rows)

with open('docs/TYPE_LAYOUT_MAP.md', 'w') as f:
    f.write('# TYPE_LAYOUT_MAP — opaque `_t` 型の IR 型レイアウト定量表\n\n')
    f.write('生成: scripts/build_type_layout_map.py (機械生成、golden corpus 全 %d ファイル走査)\n\n' % len(ll_files))
    f.write('MSL のハンドル型 (texture/depth/sampler/AS/ift/vft/pipeline state/tensor/imageblock 等) は\n')
    f.write('AIR IR では **`%struct._<name>_t = type opaque`** (正体不明の opaque 構造体) として現れ、\n')
    f.write('実体サイズはメタデータ (`!air.arg_type_size`) およびホスト側 ABI でのみ意味を持つ。\n')
    f.write('本表は golden corpus に実在する全 opaque `_t` 構造体の宣言・addrspace 使用・出現度数を定量した正本。\n\n')
    f.write('| ir_struct | builtin 行 | addrspace 使用 | 出現 (型宣言箇所) | ヘッダ文脈 (最初の1件) |\n|---|---|---|---|---|\n')
    for r in out_rows:
        f.write(f"| `{r['ir_struct']}` | {r['builtin_row'] or '—'} | {r['addrspaces_observed'] or '(宣言のみ)'} | {r['n_corpus_occurrences']} | {r['header_decl_context'] or '—'} |\n")
print(f"wrote data/type_layout_map.csv rows={len(out_rows)} and docs/TYPE_LAYOUT_MAP.md")
