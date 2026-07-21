// scene P04: 整数 builtin 代表: .s/.u 規則, i 接尾辞
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// cell=__metal_absdiff candidate=air.absdiff
extern "C" uchar probe_p04_absdiff(char x, char y) { return metal::absdiff(x, y); }

// cell=__metal_addsat candidate=air.addsat
extern "C" char probe_p04_addsat(char x, char y) { return metal::addsat(x, y); }

// cell=__metal_extract_bits candidate=air.extract.bits
extern "C" char probe_p04_extract_bits(char x, uint offset, uint bits) { return metal::extract_bits(x, offset, bits); }

// cell=__metal_insert_bits candidate=air.insert.bits
extern "C" char probe_p04_insert_bits(char base, char insert, uint offset, uint bits) { return metal::insert_bits(base, insert, offset, bits); }

// cell=__metal_madhi candidate=air.madhi
extern "C" char probe_p04_madhi(char x, char y, char z) { return metal::madhi(x, y, z); }

// cell=__metal_madsat candidate=air.madsat
extern "C" char probe_p04_madsat(char x, char y, char z) { return metal::madsat(x, y, z); }

// cell=__metal_max3 candidate=air.max3
extern "C" char probe_p04_max3(char x, char y, char z) { return metal::max3(x, y, z); }

// cell=__metal_median3 candidate=air.median3
extern "C" char probe_p04_median3(char x, char y, char z) { return metal::median3(x, y, z); }

// cell=__metal_min3 candidate=air.min3
extern "C" char probe_p04_min3(char x, char y, char z) { return metal::min3(x, y, z); }

// cell=__metal_mulhi candidate=air.mulhi
extern "C" char probe_p04_mulhi(char x, char y) { return metal::mulhi(x, y); }

// cell=__metal_reverse_bits candidate=air.reverse.bits
extern "C" char probe_p04_reverse_bits(char x) { return metal::reverse_bits(x); }

// cell=__metal_subsat candidate=air.subsat
extern "C" char probe_p04_subsat(char x, char y) { return metal::subsat(x, y); }
