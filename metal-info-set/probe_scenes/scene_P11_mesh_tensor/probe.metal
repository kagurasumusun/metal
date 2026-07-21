// scene P11: mesh/object + tensor/cooperative_tensor + simdgroup matrix (MSL4)
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_descriptor_size_tensor ====
//   candidate: air.descriptor.size.tensor
//   stdlib 実呼出: metal_tensor:1799: [[sizeas(__metal_descriptor_size_tensor(__tensor_detail::__tensor_safe_extents<EXTENTS_TYPE>::rank(),
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_data_pointer_tensor ====
//   candidate: air.get.data.pointer.tensor
//   stdlib 実呼出: metal_tensor:1250: return (data_handle_type) __metal_get_data_pointer_tensor(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_extent_tensor ====
//   candidate: air.get.extent.tensor
//   stdlib 実呼出: metal_tensor:590: return __metal_get_extent_tensor(self->handle(),
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_tensor ====
//   candidate: air.get.null.tensor
//   stdlib 実呼出: metal_tensor:1458: METAL_FUNC tensor() thread : _t(__metal_get_null_tensor())
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_stride_tensor ====
//   candidate: air.get.stride.tensor
//   stdlib 実呼出: metal_tensor:597: return __metal_get_stride_tensor(static_cast<const thread  tensor_type *>(this)->handle(),
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_tensor_handle ====
//   candidate: air.get.tensor.handle
//   stdlib 実呼出: metal_tensor:2171: return __metal_get_tensor_handle(this);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_init_strided_tensor ====
//   candidate: air.init.strided.tensor
//   stdlib 実呼出: metal_tensor:1856: __metal_init_strided_tensor(handle(), 0, (thread char *) nullptr, nullptr, nullptr, uint16_t());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_tensor ====
//   candidate: air.is.null.tensor
//   stdlib 実呼出: metal_tensor:1759: return __metal_is_null_tensor(t.handle());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_load_tensor ====
//   candidate: air.load.tensor
//   stdlib 実呼出: metal_tensor:686: return __metal_load_tensor(static_cast<const thread  tensor_type *>(this)->handle(),
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_mesh_grid_properties_t ====
//   candidate: air.mesh.grid.properties.t
//   stdlib 実呼出: metal_mesh:118: __metal_mesh_grid_properties_t p;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_mesh_t ====
//   candidate: air.mesh.t
//   stdlib 実呼出: metal_mesh:98: __metal_mesh_t m;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_index_mesh ====
//   candidate: air.set.index.mesh
//   stdlib 実呼出: metal_mesh:79: __metal_set_index_mesh(m, i, v);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_indices_mesh ====
//   candidate: air.set.indices.mesh
//   stdlib 実呼出: metal_mesh:84: __metal_set_indices_mesh(m, i, v);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_primitive_count_mesh ====
//   candidate: air.set.primitive.count.mesh
//   stdlib 実呼出: metal_mesh:94: __metal_set_primitive_count_mesh(m, n);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_primitive_mesh ====
//   candidate: air.set.primitive.mesh
//   stdlib 実呼出: metal_mesh:36: __metal_set_primitive_mesh(derived->m, i, p);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_threadgroups_per_grid_mesh_grid_properties ====
//   candidate: air.set.threadgroups.per.grid.mesh.grid.properties
//   stdlib 実呼出: metal_mesh:114: __metal_set_threadgroups_per_grid_mesh_grid_properties(p, tgs);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_vertex_mesh ====
//   candidate: air.set.vertex.mesh
//   stdlib 実呼出: metal_mesh:21: __metal_set_vertex_mesh(derived->m, i, v);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simdgroup_matrix_8x8_init_diag ====
//   candidate: air.simdgroup.matrix.8x8.init.diag
//   stdlib 実呼出: metal_simdgroup_matrix:46: return __metal_simdgroup_matrix_8x8_init_diag(value);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simdgroup_matrix_8x8_init_filled ====
//   candidate: air.simdgroup.matrix.8x8.init.filled
//   stdlib 実呼出: metal_simdgroup_matrix:119: d.thread_elements() = __metal_simdgroup_matrix_8x8_init_filled(value);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simdgroup_matrix_8x8_load ====
//   candidate: air.simdgroup.matrix.8x8.load
//   stdlib 実呼出: metal_simdgroup_matrix:138: d.thread_elements() = __metal_simdgroup_matrix_8x8_load(src, elements_per_row, matrix_origin
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simdgroup_matrix_8x8_multiply_accumulate ====
//   candidate: air.simdgroup.matrix.8x8.multiply.accumulate
//   stdlib 実呼出: metal_simdgroup_matrix:193: d.thread_elements() = __metal_simdgroup_matrix_8x8_multiply_accumulate(a.thread_elements(), 
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_simdgroup_matrix_8x8_store ====
//   candidate: air.simdgroup.matrix.8x8.store
//   stdlib 実呼出: metal_simdgroup_matrix:166: __metal_simdgroup_matrix_8x8_store(a.thread_elements(), dst, elements_per_row, matrix_origin
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_slice_tensor ====
//   candidate: air.slice.tensor
//   stdlib 実呼出: metal_tensor:1906: __metal_slice_tensor(handle(), other.handle(), tensor::get_rank(), nullptr, nullptr, index_type());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_store_tensor ====
//   candidate: air.store.tensor
//   stdlib 実呼出: metal_tensor:699: __metal_store_tensor(static_cast<const thread  tensor_type *>(this)->handle(),
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_tensor_t ====
//   candidate: air.tensor.t
//   stdlib 実呼出: metal_tensor:1451: METAL_FUNC tensor(__metal_tensor_t other, const thread offsets_type &other_offsets) thread
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_tensor_thread_t ====
//   candidate: air.tensor.thread.t
//   stdlib 実呼出: metal_tensor:2169: METAL_FUNC __metal_tensor_thread_t handle() thread const
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p11_xxx 系で extern "C" 推奨)
