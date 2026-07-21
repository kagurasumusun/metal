#!/usr/bin/env python3
"""
write_metallib.py — クリーンルーム .metallib コンテナ生成スクリプト (spec draft v0.1 準拠)。
LLVM bitcode (.air / .bc) とシンボルリストから、Apple Metal ランタイムで直接ロード可能
(`makeLibrary(URL:)`) な .metallib コンテナ (単一 MTLB または Mach-O Fat 形式) を機械生成する。

使い方:
  python3 write_metallib.py -i <input.air> -s <symbol_name> [-t <kernel|function>] -o <output.metallib>
"""
import sys
import os
import argparse
import struct
import hashlib

def align_to(buf, align=8):
    rem = len(buf) % align
    if rem != 0:
        buf += b'\x00' * (align - rem)
    return buf

def make_tag(tag_str, payload):
    # tag_str: 4 chars, payload: bytes
    # length is 2 bytes LE
    return tag_str.encode('latin1') + struct.pack('<H', len(payload)) + payload

def make_single_slice(air_data, symbols, reflection_data=b''):
    """
    symbols: list of dicts {'name': 'my_kernel', 'kind': 'kernel'}
    reflection_data: optional trailing reflection block (NAME ... ENDT + RBUF/AIRR)
    """
    # 1. Bitcode wrapper (20B) + bitcode (check if already wrapped)
    if air_data[:4] == b'\xde\xc0\x17\x0b' or air_data[:4] == b'\x0b\x17\xc0\xde':
        wrapped_bitcode = air_data
    else:
        bc_size = len(air_data)
        bc_wrapper = struct.pack('<IIIII', 0x0B17C0DE, 0, 20, bc_size, 0x01000017)
        wrapped_bitcode = bc_wrapper + air_data
    
    # If no reflection_data provided, generate a minimal valid module reflection block
    if not reflection_data:
        mod_name = b'custom.metallib\x00'
        refl_buf = bytearray()
        refl_buf += make_tag('NAME', mod_name)
        # minimal RBUF / AIRR block
        # 01 00 00 00 (1 entry), size, RBUF...
        refl_buf += b'\x01\x00\x00\x00\x18\x00\x00\x00RBUF\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00AIRR\x04\x00\x00\x00'
        reflection_data = bytes(refl_buf)

    mdsz_val = len(wrapped_bitcode)
    total_bitcode_and_refl = wrapped_bitcode + reflection_data

    # 2. Types blob & Empties blob (8B each when empty/minimal)
    types_blob = b'\x08\x00\x00\x00ENDT'
    empties_blob = b'\x08\x00\x00\x00ENDT'

    # 3. Headers blob tag records
    entries_buf = bytearray()
    for sym in symbols:
        name_bytes = sym['name'].encode('utf-8') + b'\x00'
        entries_buf += make_tag('NAME', name_bytes)
        
        kind_byte = b'\x02' if sym.get('kind', 'kernel') == 'kernel' else b'\x03'
        entries_buf += make_tag('TYPE', kind_byte)
        
        sha = hashlib.sha256(air_data).digest()
        entries_buf += make_tag('HASH', sha)
        
        entries_buf += make_tag('OFFT', b'\x00' * 24)
        entries_buf += make_tag('VERS', b'\x02\x00\x08\x00\x03\x00\x02\x00')
        entries_buf += make_tag('MDSZ', struct.pack('<Q', mdsz_val))
        entries_buf += make_tag('RFLT', b'\x04\x00\x00\x00\x00\x00\x00\x00')

    # Add HDYN metadata block after symbol entries (exactly 74 bytes: ENDT + HDYN 22B + RLST 22B + UUID 22B + ENDT 4B)
    hdyn_buf = bytearray()
    hdyn_buf += b'ENDT'
    hdyn_buf += b'HDYN\x10\x00\x0f\x0e\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\x00\x00\x00\x00'
    hdyn_buf += b'RLST\x10\x00$\x0e\x00\x00\x00\x00\x00\x00L\x01\x00\x00\x00\x00\x00\x00'
    # Use fixed/consistent UUID bytes (or random if not strict byte-ident)
    hdyn_buf += b'UUID\x10\x00\xaa\xf3\xde\xb1\x92\x6f\x39\xa0\xb6\xa6\xe6\x7f\x79\xb3\x1f\x2e'
    hdyn_buf += b'ENDT'

    headers_len = 8 + len(entries_buf)
    headers_start = 88
    directory_head = struct.pack('<II', len(symbols), headers_len)
    headers_blob = directory_head + bytes(entries_buf)

    types_start = headers_start + headers_len + len(hdyn_buf)
    types_len = len(types_blob)
    empties_start = types_start + types_len
    empties_len = len(empties_blob)
    bc_off = empties_start + empties_len

    file_size = bc_off + len(total_bitcode_and_refl)

    # 4. 88B Slice header
    magic = 0x424c544d # 'MTLB'
    unknown4 = 0x00028001
    ver = 0x1a81000009
    tail = b'\xd0\x0c\x00\x00\x00\x00\x00\x00'

    hdr = struct.pack('<IIQQQQQQQQQ8s',
                      magic, unknown4, ver, file_size,
                      headers_start, headers_len,
                      types_start, types_len,
                      empties_start, empties_len,
                      bc_off, tail)

    return hdr + headers_blob + bytes(hdyn_buf) + types_blob + empties_blob + total_bitcode_and_refl

def make_fat_metallib(slices):
    """
    slices: list of tuples (cputype, cpusubtype, slice_bytes, align_pow2)
    e.g., [(0x01000017, 7, slice0_bytes, 4), (0x01000017, 9, slice1_bytes, 4)]
    """
    nfat = len(slices)
    # fat_arch_64 table size: 8 + nfat * 32
    header_size = 8 + nfat * 32
    
    # Calculate offsets
    arches_meta = []
    current_offset = header_size
    for cputype, cpusubtype, sbytes, align_pow in slices:
        align_val = 1 << align_pow
        rem = current_offset % align_val
        if rem != 0:
            current_offset += (align_val - rem)
        arches_meta.append((cputype, cpusubtype, current_offset, len(sbytes), align_pow))
        current_offset += len(sbytes)

    # Build fat header
    out = bytearray()
    out += struct.pack('>II', 0xcbfebabe, nfat)
    for cputype, cpusubtype, offset, size, align_pow in arches_meta:
        out += struct.pack('>IIQQII', cputype, cpusubtype, offset, size, align_pow, 0)

    # Write slices with alignment padding
    for i, (_, _, sbytes, align_pow) in enumerate(slices):
        target_off = arches_meta[i][2]
        while len(out) < target_off:
            out += b'\x00'
        out += sbytes

    return bytes(out)
    ap = argparse.ArgumentParser(description="Generate .metallib container from bitcode.")
    ap.add_argument("-i", "--input", required=True, help="Input AIR/bitcode file (.air or .bc)")
    ap.add_argument("-s", "--symbol", required=True, help="Public kernel/function name")
    ap.add_argument("-t", "--type", default="kernel", choices=["kernel", "function"], help="Symbol kind")
    ap.add_argument("-r", "--reflection", help="Optional reflection binary block (.refl)")
    ap.add_argument("-o", "--output", required=True, help="Output .metallib file path")
    args = ap.parse_args()

    if not os.path.exists(args.input):
        print(f"Error: input file {args.input} not found.")
        sys.exit(1)

    with open(args.input, "rb") as f:
        air_data = f.read()

    refl_data = b''
    if args.reflection and os.path.exists(args.reflection):
        with open(args.reflection, "rb") as f:
            refl_data = f.read()

    symbols = [{"name": args.symbol, "kind": args.type}]
    metallib_bytes = make_single_slice(air_data, symbols, refl_data)

    with open(args.output, "wb") as f:
        f.write(metallib_bytes)

    print(f"✅ Generated {args.output} ({len(metallib_bytes)} bytes) with symbol '{args.symbol}' ({args.type})")

if __name__ == '__main__':
    main()
