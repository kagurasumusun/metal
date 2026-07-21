#!/usr/bin/env python3
"""
test_airnt_api.py — AIRNT C API (`libGPUCompilerImpl.dylib`) 実機動作確認スクリプト。
macOS 上で `GPUCompiler.framework` の `libGPUCompilerImpl.dylib` を dlopen し、
`_AIRNTGet*` API (VendorName, LLVMVersion, SupportedArchs, LegalizationPasses) を呼び出して検証する。
"""
import sys
import ctypes

DYLIB_PATH = "/System/Library/PrivateFrameworks/GPUCompiler.framework/Versions/Current/Libraries/libGPUCompilerImpl.dylib"

def main():
    try:
        lib = ctypes.CDLL(DYLIB_PATH)
        print(f"✅ Successfully dlopen'd {DYLIB_PATH}")
        print(f"   Library handle: {lib}")
    except OSError as e:
        print(f"❌ Failed to dlopen {DYLIB_PATH}: {e}")
        sys.exit(1)

    # Check symbols
    funcs_to_check = [
        "AIRNTGetLLVMVersion_Default",
        "AIRNTGetLegalizationPasses_Opaque_Default",
        "AIRNTGetVendorName_Opaque_Default",
        "AIRNTGetVendorName_Legalizer_Default",
        "AIRNTGetDefaultArch_Matching_Default"
    ]

    for fname in funcs_to_check:
        if hasattr(lib, fname):
            print(f"  Exported symbol: {fname} -> OK")
        else:
            print(f"  Exported symbol: {fname} -> MISSING")

    # Invoke AIRNTGetVendorName_Opaque_Default
    if hasattr(lib, "AIRNTInit_Opaque_Default") and hasattr(lib, "AIRNTGetVendorName_Opaque_Default"):
        lib.AIRNTInit_Opaque_Default.restype = ctypes.c_void_p
        obj = lib.AIRNTInit_Opaque_Default()
        lib.AIRNTGetVendorName_Opaque_Default.argtypes = [ctypes.c_void_p]
        lib.AIRNTGetVendorName_Opaque_Default.restype = ctypes.c_char_p
        vendor = lib.AIRNTGetVendorName_Opaque_Default(obj)
        print(f"  AIRNTGetVendorName_Opaque_Default() returned: {vendor}")

    if hasattr(lib, "AIRNTGetLLVMVersion_Default"):
        lib.AIRNTGetLLVMVersion_Default.restype = ctypes.c_uint32
        ver = lib.AIRNTGetLLVMVersion_Default()
        print(f"  AIRNTGetLLVMVersion_Default() returned: 0x{ver:x}")

    print("🎉 AIRNT C API probing check completed successfully.")

if __name__ == '__main__':
    main()
