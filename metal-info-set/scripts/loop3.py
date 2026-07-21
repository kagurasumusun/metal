#!/usr/bin/env python3
"""
loop3.py — エラー駆動削りループ器。
指定されたシーンとツールチェーンに対してコンパイルを試み、エラーが出た行をコメントアウト (// DISABLED_BY_LOOP) して収束させる。
使い方:
  python3 loop3.py <SCENE> <root> <std> <sdk> <opt>
例:
  python3 loop3.py P06M32R /Users/runner/work/remote/remote/run27_apply metal3.2 macosx -O2
"""
import sys
import os
import subprocess
import re

def main():
    if len(sys.argv) < 6:
        print("Usage: python3 loop3.py <SCENE> <root> <std> <sdk> <opt>")
        sys.exit(1)
    scene = sys.argv[1]
    root = sys.argv[2]
    std = sys.argv[3]
    sdk = sys.argv[4]
    opt = sys.argv[5]

    # build subdir name, e.g., metal32_macosx26 or metal40_macosx26
    std_clean = std.replace('.', '').replace('-', '')
    subdir = f"{std_clean}_macosx26" if 'metal' in std_clean else f"{std_clean}_{sdk}26"
    work_dir = os.path.join(root, scene, subdir)
    metal_path = os.path.join(work_dir, 'probe.metal')
    ll_path = os.path.join(work_dir, 'probe.ll')
    err_path = os.path.join(work_dir, 'compile.err')

    if not os.path.exists(metal_path):
        print(f"Error: {metal_path} does not exist.")
        sys.exit(1)

    cmd = ["xcrun", "--sdk", sdk, "metal", "-x", "metal", f"-std={std}", opt, "-S", "-emit-llvm", "probe.metal", "-o", "probe.ll"]
    
    print(f"Starting error-driven loop in {work_dir} with command: {' '.join(cmd)}")
    
    iter_count = 0
    while iter_count < 150:
        iter_count += 1
        with open(metal_path, 'r', encoding='utf-8', errors='replace') as f:
            lines = f.readlines()
        
        proc = subprocess.run(cmd, cwd=work_dir, capture_output=True, text=True)
        with open(err_path, 'w', encoding='utf-8') as f:
            f.write(proc.stderr or "")
        
        if proc.returncode == 0 and os.path.exists(ll_path):
            print(f"Success! Converged in {iter_count} iterations.")
            sys.exit(0)
        
        # Parse error line numbers from stderr
        # e.g., probe.metal:141:107: error: ...
        err_lines = set()
        for m in re.finditer(r'probe\.metal:(\d+):(?:\d+:)?\s*error:', proc.stderr):
            err_lines.add(int(m.group(1)))
        
        if not err_lines:
            print(f"Failed with return code {proc.returncode} but no error line numbers found:\n{proc.stderr}")
            sys.exit(1)
        
        # For each error line, disable the enclosing function or statement
        changed = False
        for lnum in sorted(err_lines, reverse=True):
            idx = lnum - 1
            if 0 <= idx < len(lines):
                # Find start of function declaration (extern "C" or similar going upwards)
                start_idx = idx
                while start_idx > 0 and not (lines[start_idx].strip().startswith('extern "C"') or lines[start_idx].strip().startswith('// builtin=')):
                    if lines[start_idx].strip().startswith('// DISABLED_BY_LOOP'):
                        break
                    start_idx -= 1
                
                # Comment out from start_idx to end of function (until next empty line or next extern/builtin)
                end_idx = idx
                while end_idx < len(lines) - 1 and not (lines[end_idx].strip().startswith('extern "C"') or lines[end_idx].strip().startswith('// builtin=') or lines[end_idx].strip() == ''):
                    end_idx += 1
                
                for i in range(start_idx, end_idx + 1):
                    if not lines[i].strip().startswith('//'):
                        lines[i] = '// DISABLED_BY_LOOP ' + lines[i]
                        changed = True
        
        if not changed:
            # Fallback: comment out exactly the error lines
            for lnum in err_lines:
                idx = lnum - 1
                if 0 <= idx < len(lines) and not lines[idx].strip().startswith('//'):
                    lines[idx] = '// DISABLED_BY_LOOP ' + lines[idx]
                    changed = True
        
        if not changed:
            print(f"Could not disable any more lines on iteration {iter_count}. Aborting.")
            sys.exit(1)
        
        with open(metal_path, 'w', encoding='utf-8') as f:
            f.writelines(lines)
        print(f"Iter {iter_count}: Disabled {len(err_lines)} error locations.")

    print("Max iterations reached without convergence.")
    sys.exit(1)

if __name__ == '__main__':
    main()
