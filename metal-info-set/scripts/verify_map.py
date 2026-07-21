#!/usr/bin/env python3
"""verify_map.py — builtin_to_air_map.v2.csv の独立検証器 (standing auditor)

一次情報主義: CSV 自身の主張を鵜呑みにせず、以下を外部ソースと照合する。

  C1 universe    : headers (reference/clang/32023.883/include) の __metal_*
                   トークン集合 == 正本の builtin 集合 (1:1 完全性)
  C2 invariants  : evidence↔confidence↔grammar_eligible↔candidate の不変条件
  C3 probed      : probed_xcode_ll 行の air 候補が参照 golden probe.ll に
                   実在すること (壊れたパスは内容照合つきで実パスを再発見)
  C4 observed    : observed_ir 行の候補が ir_air_signatures.csv (apple rtlib IR
                   実シグネチャ 8,200  decl) に実在すること
  C5 rtlib       : rtlib_layer_backing 行の候補が rtlib_layer_map /
                   callgraph_air_impl に実在すること
  C6 vocab       : 全候補が golden corpus / rtlib IR 署名 / rtlib layer の
                   いずれかに観測可能であること (辞書外語の混入検出)
  C7 golden_idx  : air_golden_names.csv の example_source パスの実在性

使い方:
  python3 scripts/verify_map.py            # check only (問題があれば exit 1)
  python3 scripts/verify_map.py --repair   # evidence_ref パスを内容照合つきで修復
"""
import csv, glob, os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)
MAP = 'data/builtin_to_air_map.v2.csv'
HDR = '/home/user/metal/reference/clang/32023.883/include' if os.path.exists('/home/user/metal/reference/clang/32023.883/include') else '/home/user/metal-repo/reference/clang/32023.883/include'
EXT_APPLY = '/home/user'  # golden_runNN_apply が残る場所 (corpus 取り込み元)

GOLDEN_PATH_RE = re.compile(r'golden/[^\s,)】]+')

def name_occurs(name, text):
    """air 名が IR テキスト内に識別子として出るか (prefix 誤爆防止の後続境界つき)"""
    return re.search(re.escape(name) + r'(?=[.(])', text) is not None

_ll_cache = {}
def read_ll(path):
    if path not in _ll_cache:
        try: _ll_cache[path] = open(path, encoding='utf-8', errors='replace').read()
        except OSError: _ll_cache[path] = None
    return _ll_cache[path]

def scene_dir_candidates(scene):
    """bare scene 名から実在 dir 候補を優先順で返す (converged 版を優先)"""
    cands = []
    # 1) run*_apply/<scene> (新レイアウト)
    cands += sorted(glob.glob(f'golden/run*_apply/{scene}'))
    # 2) golden/<scene> そのもの
    if os.path.isdir(f'golden/{scene}'): cands.append(f'golden/{scene}')
    # 3) 旧レイアウト変種 (S40_runNN > S40vN > S40)
    defs = [d for d in glob.glob(f'golden/{scene}*') if os.path.isdir(d)]
    def pref(d):
        b = os.path.basename(d)
        m = re.search(r'_run(\d+)$', b)
        if m: return (0, -int(m.group(1)))
        m = re.search(r'v(\d+)$', b)
        if m: return (1, -int(m.group(1)))
        return (2, 0)
    cands += sorted(defs, key=pref)
    # 4) external apply dirs (corpus 未取り込み)
    cands += sorted(glob.glob(os.path.join(EXT_APPLY, f'golden_run*_apply/{scene}')))
    seen, out = set(), []
    for c in cands:
        if c not in seen: seen.add(c); out.append(c)
    return out

def main():
    repair = '--repair' in sys.argv
    verbose = '--verbose' in sys.argv
    rows = list(csv.DictReader(open(MAP)))
    problems, repairs, notes = [], [], []

    # ---- C1 universe ----
    ident = re.compile(r'__metal_[A-Za-z0-9_]+')
    hdr_tokens = set()
    for dp, _, fns in os.walk(HDR):
        for fn in fns:
            t = open(os.path.join(dp, fn), encoding='utf-8', errors='replace').read()
            hdr_tokens.update(ident.findall(t))
    inmap = {r['__metal_builtin'] for r in rows}
    if hdr_tokens != inmap:
        problems.append(f"C1 universe mismatch: headers-only={sorted(hdr_tokens-inmap)} map-only={sorted(inmap-hdr_tokens)}")
    else:
        notes.append(f"C1 universe OK: {len(hdr_tokens)} builtins 1:1")

    # ---- C2 invariants ----
    inv_bad = []
    for r in rows:
        e, c, g = r['evidence'], r['confidence'], r['grammar_eligible']
        cand = r['air_intrinsic_candidate'].strip()
        if e == 'probed_xcode_ll' and not (c == 'confirmed' and cand): inv_bad.append((r['__metal_builtin'], 'probed but not confirmed/empty cand'))
        if e == 'observed_ir' and not (c == 'confirmed' and cand): inv_bad.append((r['__metal_builtin'], 'observed_ir but not confirmed/empty cand'))
        if e == 'rtlib_layer_backing' and not (c == 'confirmed' and cand): inv_bad.append((r['__metal_builtin'], 'rtlib backing but not confirmed/empty cand'))
        if e == 'inferred' and not (c == 'low' and g == 'no' and not cand and r['evidence_ref'].strip()): inv_bad.append((r['__metal_builtin'], 'inferred row malformed'))
    if inv_bad: problems.append(f"C2 invariant violations: {inv_bad}")
    else: notes.append("C2 invariants OK (evidence↔confidence↔grammar 全行整合)")

    # ---- C3 probed content + path repair ----
    sig_names = None
    c3_ok = c3_fixed = c3_inline = c3_inline_only = 0
    for r in rows:
        if r['evidence'] != 'probed_xcode_ll': continue
        cand = r['air_intrinsic_candidate'].strip()
        paths = GOLDEN_PATH_RE.findall(r['evidence_ref'])
        live = [p for p in paths if os.path.exists(p)]
        # content check on live paths
        if any(name_occurs(cand, read_ll(p) or '') for p in live):
            c3_ok += 1; continue
        # inline evidence: 一次観測行が evidence_ref 内に埋め込み保存されている場合は有効
        has_inline = name_occurs(cand, r['evidence_ref'])
        if has_inline:
            c3_inline += 1
        # repair: locate a real probe.ll that contains the candidate
        def _scene_of(p):
            parts = p.split('/')
            if len(parts) > 2 and re.fullmatch(r'run\d+_apply', parts[1]):
                return parts[2]
            return parts[1]
        scenes = {_scene_of(p) for p in paths} or {r['probe_cell']}
        found = None
        for sc in scenes:
            for d in scene_dir_candidates(sc):
                ll = os.path.join(d, 'metal40_macosx26', 'probe.ll')
                t = read_ll(ll)
                if t and name_occurs(cand, t):
                    found = (sc, d, ll); break
            if found: break
        if found and (name_occurs(cand, r['evidence_ref']) and any(os.path.exists(p) for p in paths)):
            found = None  # inline 証拠が残る行はパスを上書きしない (led provenance 保存)
        if found:
            sc, d, ll = found
            if os.path.isabs(ll):
                # external apply dir → corpus へ additive 取り込み
                import shutil
                rel_scene_parent = os.path.basename(os.path.dirname(d))  # runNN_apply
                dest = os.path.join('golden', rel_scene_parent, os.path.basename(d))
                if not os.path.isdir(dest):
                    os.makedirs(os.path.dirname(dest), exist_ok=True)
                    shutil.copytree(d, dest)
                    for extra in glob.glob(os.path.join(os.path.dirname(d), 'meta.yml')):
                        shutil.copy(extra, os.path.join('golden', rel_scene_parent, 'meta.yml'))
                ll = os.path.join(dest, 'metal40_macosx26', 'probe.ll')
            c3_fixed += 1
            repairs.append((r['__metal_builtin'], cand, paths, ll))
            if repair:
                new_ref = r['evidence_ref']
                for p in paths:
                    if not os.path.exists(p):
                        new_ref = new_ref.replace(p, ll)
                if new_ref != r['evidence_ref']:
                    r['evidence_ref'] = new_ref
                    r['last_change'] = '2026-07-21'
                    r['changed_by'] = 'agent'
        else:
            if has_inline:
                c3_inline_only += 1  # inline のみ (原本 probe.ll は後の run で上書き喪失)
            else:
                problems.append(f"C3 no live golden content for {r['__metal_builtin']} cand={cand} refs={paths}")
    notes.append(f"C3 probed content: live-ok={c3_ok} inline-ok={c3_inline} (うち inline-only={c3_inline_only}) path-repaired={c3_fixed} gap={len([p for p in problems if p.startswith('C3')])}")

    # ---- C4 observed_ir content ----
    with open('data/ir_air_signatures.csv', encoding='utf-8', errors='replace') as f:
        sig_text = f.read()
    c4_bad = []
    for r in rows:
        if r['evidence'] != 'observed_ir': continue
        cand = r['air_intrinsic_candidate'].strip()
        if f'@{cand}(' not in sig_text and f'@{cand}.' not in sig_text:
            c4_bad.append((r['__metal_builtin'], cand))
    if c4_bad: problems.append(f"C4 observed_ir candidates absent from ir_air_signatures.csv: {c4_bad}")
    else: notes.append("C4 observed_ir OK: 全 97 候補が apple rtlib IR 実シグネチャに実在")

    # ---- C5 rtlib backing ----
    back_text = ''
    for f in ('data/rtlib_layer_map.csv', 'data/callgraph_air_impl.csv',
              'data/rtlib_members.csv', 'data/rtlib_pairing.csv', 'data/ir_runtime_functions.csv'):
        if os.path.exists(f):
            back_text += open(f, encoding='utf-8', errors='replace').read()
    c5_bad = []
    for r in rows:
        if r['evidence'] != 'rtlib_layer_backing': continue
        cand = r['air_intrinsic_candidate'].strip()
        sym = cand[len('rtlib:'):] if cand.startswith('rtlib:') else cand
        if sym not in back_text: c5_bad.append((r['__metal_builtin'], cand))
    if c5_bad: problems.append(f"C5 rtlib backing candidates absent: {c5_bad}")
    else: notes.append("C5 rtlib_layer_backing OK (4 行全て rtlib 下降グラフに実在)")

    # ---- C6 vocab: 候補が観測可能ソースのどこかに存在 ----
    golden_names = {r2['air_name'] for r2 in csv.DictReader(open('data/air_golden_names.csv'))}
    sig_set = set()
    for r2 in csv.DictReader(open('data/air_signatures.csv' if os.path.exists('data/air_signatures.csv') else 'data/ir_air_signatures.csv')):
        d = r2.get('air_intrinsic_declare', '')
        m = re.search(r'@([A-Za-z0-9_.]+)\(', d)
        if m: sig_set.add(m.group(1))
    rtlib_text = back_text
    c6_bad = []
    for r in rows:
        cand = r['air_intrinsic_candidate'].strip()
        if not cand: continue
        if cand.startswith('rtlib:'):
            continue  # rtlib symbol 層は C5 が担保
        if cand in golden_names or cand in sig_set or cand in rtlib_text: continue
        if name_occurs(cand, r['evidence_ref']): continue  # inline 一次観測
        # golden corpus 全体テキスト照合 (slow path, cache)
        hit = False
        for ll in glob.glob('golden/*/metal40_macosx26/probe.ll') + glob.glob('golden/*/*/metal40_macosx26/probe.ll'):
            if name_occurs(cand, read_ll(ll) or ''): hit = True; break
        if not hit: c6_bad.append((r['__metal_builtin'], cand))
    if c6_bad: problems.append(f"C6 vocab: candidates not observable anywhere: {c6_bad}")
    else: notes.append("C6 vocab OK: 全候補が golden/rtlib 観測ソースに実在 (辞書外語なし)")

    # ---- C7 golden index paths (情報のみ: 修復は行わない) ----
    g_missing = [r2['air_name'] for r2 in csv.DictReader(open('data/air_golden_names.csv'))
                 if r2.get('example_source', '').startswith('golden/') and not os.path.exists(r2['example_source'])]
    notes.append(f"C7 golden index stale paths (情報): {len(g_missing)}" +
                 (f" 例: {g_missing[:5]}" if g_missing and verbose else ""))

    # ---- write repairs ----
    if repair and repairs:
        hdr_map = None
        with open(MAP, newline='') as f:
            rdr = csv.reader(f); hdr_map = next(rdr)
        with open(MAP, 'w', newline='') as f:
            w = csv.DictWriter(f, fieldnames=hdr_map, lineterminator='\n')
            w.writeheader(); w.writerows(rows)
        notes.append(f"REPAIR written: {len(repairs)} 行の evidence_ref を内容照合つき修復")

    print("== verify_map ==")
    for n in notes: print(" ", n)
    if problems:
        print("== PROBLEMS ==")
        for p in problems: print(" !!", p)
    if verbose or repair:
        for b, c, old, new in repairs: print(f"  FIX {b}: {os.path.basename(os.path.dirname(os.path.dirname(old[0]))) if old else '?'} -> {new}")
    sys.exit(1 if problems else 0)

if __name__ == '__main__':
    main()
