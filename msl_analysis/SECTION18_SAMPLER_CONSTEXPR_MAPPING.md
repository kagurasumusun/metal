# Section 18: Constexpr Sampler Parameters & Bitfield Formats

This section details the parameters, enumerations, constructors, and binary bitfield structures utilized in the Metal Shading Language (MSL) to represent sampler states at compile time.

---

## 1. Table 35: Constexpr Sampler Initializers & Bitfield Formats

The table below catalogs every parameter, enum option, and binary bit mapping used by the compiler to pack a `constexpr sampler` into a single 32-bit scalar value passed directly to GPU hardware units.

| MSL Sampler Enumeration | Enumerator Member | Binary Value (Hex / Dec) | Target Bitfield Range | Hardware Sampling Behavior / Description |
|:---|:---|:---:|:---:|:---|
| `coord` | `coordinates::pixel` | `0x0` / `0` | **Bit [0]** | Coordinates map to raw texel indices (`0` to `width-1`). |
| `coord` | `coordinates::normalized` | `0x1` / `1` | **Bit [0]** | Coordinates are normalized (`0.0` to `1.0`). |
| `address` | `address::clamp_to_zero` | `0x0` / `0` | **Bits [2:4]** (S)<br>**Bits [5:7]** (T)<br>**Bits [8:10]** (R) | Out-of-bounds fetches return transparent black (`0.0, 0.0, 0.0, 0.0`). |
| `address` | `address::clamp_to_edge` | `0x1` / `1` | Same as above | Out-of-bounds coordinates clamp to the boundary texel color. |
| `address` | `address::repeat` | `0x2` / `2` | Same as above | Texture coordinates wrap around (repeating pattern). |
| `address` | `address::mirror_repeat`| `0x3` / `3` | Same as above | Texture coordinates wrap around mirrored. |
| `address` | `address::clamp_to_border`| `0x4` / `4` | Same as above | Out-of-bounds fetches return a user-configured border color. |
| `filter` | `filter::nearest` | `0x0` / `0` | **Bit [11]** (Min)<br>**Bit [12]** (Mag) | Performs nearest-neighbor filtering (blocky sampling). |
| `filter` | `filter::linear` | `0x1` / `1` | Same as above | Performs bilinear interpolation filtering. |
| `mip_filter` | `mip_filter::none` | `0x0` / `0` | **Bits [13:14]** | Disables mipmap filtering; only the base mip level is sampled. |
| `mip_filter` | `mip_filter::nearest` | `0x1` / `1` | **Bits [13:14]** | Selects the nearest mipmap level (point filtering). |
| `mip_filter` | `mip_filter::linear` | `0x2` / `2` | **Bits [13:14]** | Performs trilinear filtering (linear interpolation between two mip levels). |
| `compare_func` | `compare_func::never` | `0x0` / `0` | **Bits [15:17]** | Shadow sampler comparison is disabled. |
| `compare_func` | `compare_func::less` | `0x1` / `1` | **Bits [15:17]** | Comparison passes if comparison value is less than reference. |
| `compare_func` | `compare_func::equal` | `0x2` / `2` | **Bits [15:17]** | Comparison passes if values are equal. |
| `compare_func` | `compare_func::greater` | `0x4` / `4` | **Bits [15:17]** | Comparison passes if comparison value is greater than reference. |
| `lod_clamp` | `max_anisotropy(n)` | Value `1` to `16` | **Bits [18:21]** | Sets maximum anisotropy multiplier clamp ($1\times$ to $16\times$). |

---

## 2. In-Depth Compilation Mechanics

When Clang processes a `constexpr sampler` declaration:
1. It parses the initialization expression and extracts the configuration tokens.
2. It validates the compatibility of wrap modes and coordinate settings (e.g., repeating wrap modes are invalid for unnormalized coordinates and trigger compile-time diagnostics).
3. It maps each argument to its target bits and performs a bitwise-OR to pack them into a single 32-bit unsigned integer (as shown in the matrix above).
4. This packed integer represents the exact sampler hardware state and is written to a read-only constant pool, allowing it to be loaded directly by the GPU's texture sampling units.



## Compile-time Constexpr Sampler Parsing

When a shader initializes a `constexpr sampler`:
- **Compile-Time Evaluation**: Clang evaluates the sampler configuration constructor at compile time.
- **State Bitfield Packaging**: Packs wrap modes, filtering, and comparison configurations into a single 32-bit unsigned integer (Sampler State Bitfield).
- **Constant Pool Allocation**: Emits a global constant containing this packed bitfield, allowing it to be loaded directly by the GPU's texture sampling units.
