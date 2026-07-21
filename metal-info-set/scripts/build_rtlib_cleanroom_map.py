#!/usr/bin/env python3
"""build_rtlib_cleanroom_map.py — rtlib 全公開関数のクリーンルーム代替対応表

一次ソース (全て実測由来):
  - data/ir_runtime_functions.csv (24,482 define 行, Apple rtlib bitcode 逆アセンブル)
  - data/callgraph_edges.csv      (31,135 呼出エッジ)
  - data/rtlib_layer_map.csv      (既知の builtin 連結 26 行)

分類 (callee 集合から機械決定、推測なし):
  air-direct  : air.* を直呼び → 同等 AIR 呼出ラッパで代替可
  llvm-only   : llvm.* intrinsic のみ → ポータブル IR で代替可
  impl-chain  : 他の __air_impl*/__metal* のみ (air 非直呼び) → 推移閉包が必要
  leaf        : 呼出なし (自己完結 bitcode) → 仕様 (ヘッダ/pdf) から再実装

出力 (additive 新ファイル): data/rtlib_cleanroom_map.csv + docs/RTLIB_CLEANROOM_MAP.md
"""
import csv, os, re
from collections import OrderedDict, defaultdict

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)

DEF_RE = re.compile(r'define\s+.*?@([A-Za-z0-9_.]+)\s*\(')

# 1) functions: symbol -> info
funcs = {}
for r in csv.DictReader(open('data/ir_runtime_functions.csv')):
    m = DEF_RE.search(r['define_line'])
    if not m: continue
    sym = m.group(1)
    e = funcs.setdefault(sym, {'archives': set(), 'member': r['member'], 'cc': r['cc_set']})
    e['archives'].add(r['archive'])

# 2) module inventory (palette-only object / data object 判定用)
mods = {r['module_member'] for r in csv.DictReader(open('data/stdlib_runtime_module_inventory.csv'))}

# 3) edges: 実シンボル caller のみ受理。callee を primary data でクラス分け
#    (air.* = AIR intrinsic / llvm.* = LLVM intrinsic / 実シンボル = internal /
#     module-inventory = module-object / それ以外 = data-or-external)
calls = defaultdict(lambda: defaultdict(set))
for r in csv.DictReader(open('data/callgraph_edges.csv')):
    a, b = r['caller'], r['callee']
    if not a or not b or a == b or a not in funcs: continue
    if b.startswith('air.'): calls[a]['air'].add(b)
    elif b.startswith('llvm.'): calls[a]['llvm'].add(b)
    elif b in funcs: calls[a]['internal'].add(b)
    elif b in mods: calls[a]['module'].add(b)
    else: calls[a]['data'].add(b)

# 4) known builtin links
links = defaultdict(set)
for r in csv.DictReader(open('data/rtlib_layer_map.csv')):
    if r.get('air_impl_symbol') and r.get('metal_builtin'):
        links[r['air_impl_symbol']].add(r['metal_builtin'])

AIR_PREFIXES = ('air.',)

EMPTY = defaultdict(set)
def classify(sym):
    """closure たどりつき分類。戻り値 (class, air_closure_set)"""
    c = calls.get(sym, EMPTY)
    if c['air']: return 'air-direct', set(c['air'])
    if c['internal']:
        seen, frontier, hops, airhits = set(), list(c['internal']), 0, set()
        while frontier and hops < 8 and not airhits:
            nxt = []
            for x in frontier:
                if x in seen or x == sym: continue
                seen.add(x)
                xc = calls.get(x, EMPTY)
                airhits |= set(xc['air'])
                nxt += [y for y in xc['internal'] if y not in seen]
            hops += 1; frontier = nxt
        if airhits: return f'impl-chain-air@{hops}hop', airhits
        return 'impl-chain-noair', set()
    if c['llvm'] or c['module'] or c['data']: return 'llvm-or-module-only', set()
    return 'leaf', set()

rows = []
for sym in sorted(funcs):
    e = funcs[sym]
    c = calls.get(sym, EMPTY)
    cls, air_closure = classify(sym)
    rows.append(OrderedDict([
        ('symbol', sym),
        ('n_archives', len(e['archives'])),
        ('example_archive', sorted(e['archives'])[0]),
        ('member', e['member']),
        ('cc', e['cc']),
        ('replace_class', cls),
        ('air_vocab_direct', ';'.join(sorted(c['air'])[:8])),
        ('air_vocab_closure', ';'.join(sorted(air_closure)[:8]) if not cls.startswith(('air-direct',)) else ''),
        ('llvm_vocab_direct', ';'.join(sorted(c['llvm'])[:6])),
        ('internal_callees', ';'.join(sorted(c['internal'])[:6])),
        ('module_callees', ';'.join(sorted(c['module'])[:4])),
        ('data_callees', ';'.join(sorted(c['data'])[:4])),
        ('linked_metal_builtin', ';'.join(sorted(links.get(sym, set())))),
        ('evidence', 'apple_rtlib_ir'),
        ('source_ref', 'ir_runtime_functions.csv + callgraph_edges.csv'),
    ]))

with open('data/rtlib_cleanroom_map.csv', 'w', newline='') as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0].keys()), lineterminator='\n')
    w.writeheader(); w.writerows(rows)

from collections import Counter
dist = Counter(r['replace_class'] for r in rows)
arch_hist = Counter(r['n_archives'] for r in rows)
with open('docs/RTLIB_CLEANROOM_MAP.md', 'w') as f:
    f.write('# RTLIB_CLEANROOM_MAP — rtlib 全公開関数のクリーンルーム代替対応表\n\n')
    f.write('生成: scripts/build_rtlib_cleanroom_map.py (機械生成)\n\n')
    f.write(f'- 関数総数: **{len(rows)}** (全 archive 横断でシンボル一意化)\n')
    f.write(f'- 分類分布: {dict(dist)}\n')
    f.write(f'- archive 度数分布: {dict(sorted(arch_hist.items()))}\n\n')
    f.write('## 分類規則 (callee 集合から機械決定、内部シンボルは推移閉包で air 到達を判定)\n\n')
    f.write('| class | 意味 | 代替戦略 |\n|---|---|---|\n')
    f.write('| air-direct | air.* 直呼び | 同等 AIR 呼出を emit する wrapper で代替 (語彙は builtin 対応表と同一正本) |\n')
    f.write('| impl-chain-air@Nhop | 内部連鎖の先 N hop で air.* に到達 | air_vocab_closure 列の語彙で wrapper 化 |\n')
    f.write('| impl-chain-noair | 内部連鎖のみ (air 非到達) | 連鎖先の leaf 実装ごと再実装 |\n')
    f.write('| llvm-or-module-only | llvm.*/module-object/data のみ | ポータブル IR または定数データで代替 |\n')
    f.write('| leaf | 呼出なし自己完結 | ヘッダ / 仕様 pdf の記述から MSL/C++ 等価実装 |\n\n')
    f.write('正本 CSV: `data/rtlib_cleanroom_map.csv`。**air-direct かつ builtin 連結済みの層が最先着の代替対象**。\n')
print(f"rows={len(rows)} dist={dict(dist)} arch_hist={dict(sorted(arch_hist.items()))}")
EOF_MARKER = None
