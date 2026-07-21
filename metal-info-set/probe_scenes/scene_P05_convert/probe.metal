// scene P05: as_type/cast/saturate 変換: air.convert 文法確定
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_is_function_constant_defined ====
//   candidate: air.is.function.constant.defined
//   stdlib 実呼出: metal_types:173: #define is_function_constant_defined(c) __metal_is_function_constant_defined(c)
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_pack_snorm1x16 ====
//   candidate: air.pack.snorm1x16
//   stdlib 実呼出: metal_pixel:1141: return __metal_pack_snorm1x16(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_pack_snorm1x8 ====
//   candidate: air.pack.snorm1x8
//   stdlib 実呼出: metal_pixel:1091: return __metal_pack_snorm1x8(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// cell=__metal_pack_snorm2x16 candidate=air.pack.snorm2x16
extern "C" uint probe_p05_pack_float_to_snorm2x16(float2 x) { return metal::pack_float_to_snorm2x16(x); }

// ==== TODO(manual_needed): __metal_pack_snorm2x8 ====
//   candidate: air.pack.snorm2x8
//   stdlib 実呼出: metal_pixel:1191: return __metal_pack_snorm2x8(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_pack_snorm4x16 ====
//   candidate: air.pack.snorm4x16
//   stdlib 実呼出: metal_pixel:1367: return __metal_pack_snorm4x16(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// cell=__metal_pack_snorm4x8 candidate=air.pack.snorm4x8
extern "C" uint probe_p05_pack_float_to_snorm4x8(float4 x) { return metal::pack_float_to_snorm4x8(x); }

#if defined(__HAVE_PACK_UNPACK_RGB10A2_SNORM_FUNCTIONS__)
// cell=__metal_pack_snorm_rgb10a2 candidate=air.pack.snorm.rgb10a2
extern "C" uint probe_p05_pack_float_to_snorm10a2(float4 x) { return metal::pack_float_to_snorm10a2(x); }
#else
// NOTE: __HAVE_PACK_UNPACK_RGB10A2_SNORM_FUNCTIONS__ 無効ターゲットのため wrapper 無効化 (この builtin は対応ターゲットで別途 probe)
#endif

// ==== TODO(manual_needed): __metal_pack_unorm1x16 ====
//   candidate: air.pack.unorm1x16
//   stdlib 実呼出: metal_pixel:1117: return __metal_pack_unorm1x16(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_pack_unorm1x8 ====
//   candidate: air.pack.unorm1x8
//   stdlib 実呼出: metal_pixel:1065: return __metal_pack_unorm1x8(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// cell=__metal_pack_unorm2x16 candidate=air.pack.unorm2x16
extern "C" uint probe_p05_pack_float_to_unorm2x16(float2 x) { return metal::pack_float_to_unorm2x16(x); }

// ==== TODO(manual_needed): __metal_pack_unorm2x8 ====
//   candidate: air.pack.unorm2x8
//   stdlib 実呼出: metal_pixel:1165: return __metal_pack_unorm2x8(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_pack_unorm4x16 ====
//   candidate: air.pack.unorm4x16
//   stdlib 実呼出: metal_pixel:1343: return __metal_pack_unorm4x16(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// cell=__metal_pack_unorm4x8 candidate=air.pack.unorm4x8
extern "C" uint probe_p05_pack_float_to_unorm4x8(float4 x) { return metal::pack_float_to_unorm4x8(x); }

// cell=__metal_pack_unorm4x8_srgb candidate=air.pack.unorm4x8.srgb
extern "C" uint probe_p05_pack_float_to_srgb_unorm4x8(float4 x) { return metal::pack_float_to_srgb_unorm4x8(x); }

// ==== TODO(manual_needed): __metal_pack_unorm_rg11b10f ====
//   candidate: air.pack.unorm.rg11b10f
//   stdlib 実呼出: metal_pixel:1417: return __metal_pack_unorm_rg11b10f(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// cell=__metal_pack_unorm_rgb10a2 candidate=air.pack.unorm.rgb10a2
extern "C" uint probe_p05_pack_float_to_unorm10a2(float4 x) { return metal::pack_float_to_unorm10a2(x); }

// cell=__metal_pack_unorm_rgb565 candidate=air.pack.unorm.rgb565
extern "C" ushort probe_p05_pack_float_to_unorm565(float3 x) { return metal::pack_float_to_unorm565(x); }

// ==== TODO(manual_needed): __metal_pack_unorm_rgb9e5 ====
//   candidate: air.pack.unorm.rgb9e5
//   stdlib 実呼出: metal_pixel:1443: return __metal_pack_unorm_rgb9e5(data);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p05_xxx 系で extern "C" 推奨)

// cell=__metal_saturate candidate=air.saturate
extern "C" float probe_p05_saturate(float x) { return metal::saturate(x); }

// cell=__metal_unpack_snorm2x16 candidate=air.unpack.snorm2x16
extern "C" float2 probe_p05_unpack_snorm2x16_to_float(uint x) { return metal::unpack_snorm2x16_to_float(x); }

// cell=__metal_unpack_snorm4x8 candidate=air.unpack.snorm4x8
extern "C" float4 probe_p05_unpack_snorm4x8_to_float(uint x) { return metal::unpack_snorm4x8_to_float(x); }

#if defined(__HAVE_PACK_UNPACK_RGB10A2_SNORM_FUNCTIONS__)
// cell=__metal_unpack_snorm_rgb10a2 candidate=air.unpack.snorm.rgb10a2
extern "C" float4 probe_p05_unpack_snorm10a2_to_float(uint x) { return metal::unpack_snorm10a2_to_float(x); }
#else
// NOTE: __HAVE_PACK_UNPACK_RGB10A2_SNORM_FUNCTIONS__ 無効ターゲットのため wrapper 無効化 (この builtin は対応ターゲットで別途 probe)
#endif

// cell=__metal_unpack_unorm2x16 candidate=air.unpack.unorm2x16
extern "C" float2 probe_p05_unpack_unorm2x16_to_float(uint x) { return metal::unpack_unorm2x16_to_float(x); }

// cell=__metal_unpack_unorm4x8 candidate=air.unpack.unorm4x8
extern "C" float4 probe_p05_unpack_unorm4x8_to_float(uint x) { return metal::unpack_unorm4x8_to_float(x); }

// cell=__metal_unpack_unorm4x8_srgb candidate=air.unpack.unorm4x8.srgb
extern "C" float4 probe_p05_unpack_unorm4x8_srgb_to_float(uint x) { return metal::unpack_unorm4x8_srgb_to_float(x); }

// cell=__metal_unpack_unorm_rgb10a2 candidate=air.unpack.unorm.rgb10a2
extern "C" float4 probe_p05_unpack_unorm10a2_to_float(uint x) { return metal::unpack_unorm10a2_to_float(x); }

// cell=__metal_unpack_unorm_rgb565 candidate=air.unpack.unorm.rgb565
extern "C" float3 probe_p05_unpack_unorm565_to_float(ushort x) { return metal::unpack_unorm565_to_float(x); }
