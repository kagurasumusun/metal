#!/usr/bin/env python3
"""
analyze_metallib.py — .metallib コンテナの精密解体・解析スクリプト。
mach-o fat header (32/64), slice header (88B), tag blob (NAME, TYPE, HASH, VERS, MDSZ, ENDT),
types blob, empties blob, および bitcode wrapper の構造を全バイト解析して表示する。
"""
import sys
import struct
import os

def parse_tag_blob(data, start, length):
    end = start + length
    offset = start
    entries = []
    current_entry = {}
    while offset < end:
        tag = data[offset:offset+4].decode('latin1', errors='replace')
        offset += 4
        if tag == 'ENDT':
            current_entry['ENDT'] = True
            entries.append(current_entry)
            current_entry = {}
            rem = offset % 8
            if rem != 0:
                offset += (8 - rem)
            continue
        if tag == 'NAME':
            name_start = offset
            while offset < end and data[offset] != 0:
                offset += 1
            name = data[name_start:offset].decode('utf-8', errors='replace')
            offset += 1 # skip NUL
            current_entry['NAME'] = name
            rem = offset % 8
            if rem != 0:
                offset += (8 - rem)
        elif tag == 'TYPE':
            val = data[offset:offset+4]
            offset += 4
            current_entry['TYPE'] = val.hex()
            rem = offset % 8
            if rem != 0:
                offset += (8 - rem)
        elif tag == 'HASH':
            val = data[offset:offset+32]
            offset += 32
            current_entry['HASH'] = val.hex()
            rem = offset % 8
            if rem != 0:
                offset += (8 - rem)
        elif tag == 'VERS':
            val = data[offset:offset+8]
            offset += 8
            current_entry['VERS'] = val.hex()
            rem = offset % 8
            if rem != 0:
                offset += (8 - rem)
        elif tag == 'MDSZ':
            val = struct.unpack('<Q', data[offset:offset+8])[0]
            offset += 8
            current_entry['MDSZ'] = val
            rem = offset % 8
            if rem != 0:
                offset += (8 - rem)
        else:
            current_entry[f'UNKNOWN_{tag}'] = offset
            break
    return entries

def analyze_slice(data, slice_offset, slice_size, slice_idx):
    print(f"\n=================== SLICE {slice_idx} (offset={slice_offset}, size={slice_size}) ===================")
    slice_data = data[slice_offset:slice_offset+slice_size]
    
    if len(slice_data) < 88:
        print("Slice too small (<88B)")
        return
    
    hdr = struct.unpack('<IIQQQQQQQQQ8s', slice_data[:88])
    magic, unknown4, version_u64, file_size, headers_start, headers_len, types_start, types_len, empties_start, empties_len, bitcode_wrapper_offset, tail8 = hdr[0], hdr[1], hdr[2], hdr[3], hdr[4], hdr[5], hdr[6], hdr[7], hdr[8], hdr[9], hdr[10], hdr[11]
    
    print("--- SLICE HEADER (88B) ---")
    print(f"  magic                  : 0x{magic:08x} ({magic.to_bytes(4, 'little')})")
    print(f"  unknown4               : 0x{unknown4:08x} ({unknown4})")
    print(f"  version_u64            : 0x{version_u64:016x} ({version_u64}) [major={version_u64>>16}, minor={version_u64&0xffff}]")
    print(f"  file_size              : {file_size}")
    print(f"  headers_start / len    : {headers_start} / {headers_len}")
    print(f"  types_start / len      : {types_start} / {types_len}")
    print(f"  empties_start / len    : {empties_start} / {empties_len}")
    print(f"  bitcode_wrapper_offset : {bitcode_wrapper_offset}")
    print(f"  tail 8B                : {tail8.hex()}")
    
    if headers_start + headers_len <= len(slice_data):
        print(f"\n--- HEADERS BLOB (offset {headers_start}, len {headers_len}) ---")
        # Check first 8B of headers blob
        hb_head = struct.unpack('<II', slice_data[headers_start:headers_start+8])
        print(f"  Directory head (8B): num_entries={hb_head[0]}, table_offset_or_size={hb_head[1]}")
        entries = parse_tag_blob(slice_data, headers_start + 8, headers_len - 8)
        print(f"  Total tag entries parsed: {len(entries)}")
        for i, e in enumerate(entries[:10]):
            print(f"    Entry {i}: {e}")
        if len(entries) > 10:
            print(f"    ... and {len(entries)-10} more entries.")
    
    if types_start + types_len <= len(slice_data):
        print(f"\n--- TYPES BLOB (offset {types_start}, len {types_len}) ---")
        tb = slice_data[types_start:types_start+types_len]
        print(f"  Hex dump (first 64B): {tb[:64].hex()}")
    
    if empties_start + empties_len <= len(slice_data):
        print(f"\n--- EMPTIES BLOB (offset {empties_start}, len {empties_len}) ---")
        eb = slice_data[empties_start:empties_start+empties_len]
        print(f"  Hex dump (first 64B): {eb[:64].hex()}")

    if bitcode_wrapper_offset + 16 <= len(slice_data):
        print(f"\n--- BITCODE WRAPPER (offset {bitcode_wrapper_offset}) ---")
        bw = slice_data[bitcode_wrapper_offset:bitcode_wrapper_offset+20]
        magic = struct.unpack('<I', bw[:4])[0]
        if magic == 0x0B17C0DE or magic == 0xDEC0170B:
            print(f"  Wrapper Magic: 0x{magic:08x} (Valid LLVM Bitcode Wrapper)")
            ver, off, size, cputype = struct.unpack('<IIII', bw[4:20])
            print(f"  Wrapper fields: version={ver}, offset={off}, size={size}, cputype=0x{cputype:08x}")
        else:
            print(f"  First 16B at bitcode offset: {bw[:16].hex()} (magic=0x{magic:08x})")

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 analyze_metallib.py <path_to_metallib>")
        sys.exit(1)
    
    path = sys.argv[1]
    with open(path, 'rb') as f:
        data = f.read()
    
    magic = struct.unpack('>I', data[:4])[0]
    if magic == 0xcafebabe:
        nfat = struct.unpack('>I', data[4:8])[0]
        print(f"=== FAT 32 METALLIB: {path} (nfat_arch={nfat}) ===")
        arches = []
        for i in range(nfat):
            off = 8 + i * 20
            cputype, cpusubtype, offset, size, align = struct.unpack('>IIIII', data[off:off+20])
            arches.append((cputype, cpusubtype, offset, size, align))
            print(f"  Arch {i}: cputype=0x{cputype:08x}, subtype=0x{cpusubtype:08x}, offset={offset}, size={size}, align=2^{align}")
        
        for i, (cputype, cpusubtype, offset, size, align) in enumerate(arches):
            analyze_slice(data, offset, size, i)
    elif magic == 0xcbfebabe:
        nfat = struct.unpack('>I', data[4:8])[0]
        print(f"=== FAT 64 METALLIB: {path} (nfat_arch={nfat}) ===")
        arches = []
        for i in range(nfat):
            off = 8 + i * 32
            cputype, cpusubtype, offset, size, align, reserved = struct.unpack('>IIQQII', data[off:off+32])
            arches.append((cputype, cpusubtype, offset, size, align))
            print(f"  Arch {i}: cputype=0x{cputype:08x}, subtype=0x{cpusubtype:08x}, offset={offset}, size={size}, align=2^{align}")
        
        for i, (cputype, cpusubtype, offset, size, align) in enumerate(arches):
            analyze_slice(data, offset, size, i)
    else:
        magic_le = struct.unpack('<I', data[:4])[0]
        if magic_le == 0x00020080 or data[:4] == b'\x4d\x54\x4c\x42':
            print(f"=== SINGLE SLICE / DIRECT METALLIB: {path} ===")
            analyze_slice(data, 0, len(data), 0)
        else:
            print(f"Unknown magic: 0x{magic:08x} (first 16B: {data[:16].hex()})")
            analyze_slice(data, 0, len(data), 0)

if __name__ == '__main__':
    main()
