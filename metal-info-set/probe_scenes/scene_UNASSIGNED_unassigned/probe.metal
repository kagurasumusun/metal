// scene UNASSIGNED: カテゴリ未判定セル (人間による割当待ち)
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_clear_barrier_compute_command ====
//   candidate: air.clear.barrier.compute.command
//   stdlib 実呼出: metal_command_buffer:438: __metal_clear_barrier_compute_command(icb, icb_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_clear_barrier_render_command ====
//   candidate: air.clear.barrier.render.command
//   stdlib 実呼出: metal_command_buffer:1137: __metal_clear_barrier_render_command(icb, icb_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_command_buffer_t ====
//   candidate: air.command.buffer.t
//   stdlib 実呼出: metal_command_buffer:203: __metal_command_buffer_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_compute_pipeline_state_t ====
//   candidate: air.compute.pipeline.state.t
//   stdlib 実呼出: metal_command_buffer:373: __metal_compute_pipeline_state_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_concurrent_dispatch_threadgroups_compute_command ====
//   candidate: air.concurrent.dispatch.threadgroups.compute.command
//   stdlib 実呼出: metal_command_buffer:423: __metal_concurrent_dispatch_threadgroups_compute_command(icb, icb_index, threadgroups_per_grid
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_concurrent_dispatch_threads_compute_command ====
//   candidate: air.concurrent.dispatch.threads.compute.command
//   stdlib 実呼出: metal_command_buffer:428: __metal_concurrent_dispatch_threads_compute_command(icb, icb_index, threads_per_grid, threads_
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_copy_compute_command ====
//   candidate: air.copy.compute.command
//   stdlib 実呼出: metal_command_buffer:466: __metal_copy_compute_command(icb, icb_index, that.icb, that.icb_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_copy_render_command ====
//   candidate: air.copy.render.command
//   stdlib 実呼出: metal_command_buffer:1149: __metal_copy_render_command(icb, icb_index, that.icb, that.icb_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_depth_stencil_state_t ====
//   candidate: air.depth.stencil.state.t
//   stdlib 実呼出: metal_command_buffer:790: __metal_depth_stencil_state_t s;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_draw_indexed_patches_render_command ====
//   candidate: air.draw.indexed.patches.render.command
//   stdlib 実呼出: metal_command_buffer:1018: __metal_draw_indexed_patches_render_command(icb, icb_index, num_patch_control_points, patch_s
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_draw_indexed_primitives_render_command ====
//   candidate: air.draw.indexed.primitives.render.command
//   stdlib 実呼出: metal_command_buffer:953: __metal_draw_indexed_primitives_render_command(icb, icb_index, uint(type), index_count, index_
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_draw_mesh_threadgroups_render_command ====
//   candidate: air.draw.mesh.threadgroups.render.command
//   stdlib 実呼出: metal_command_buffer:1122: __metal_draw_mesh_threadgroups_render_command(icb, icb_index, threadgroups_per_grid, threads_
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_draw_mesh_threads_render_command ====
//   candidate: air.draw.mesh.threads.render.command
//   stdlib 実呼出: metal_command_buffer:1127: __metal_draw_mesh_threads_render_command(icb, icb_index, threads_per_grid, threads_per_object
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_draw_patches_render_command ====
//   candidate: air.draw.patches.render.command
//   stdlib 実呼出: metal_command_buffer:965: __metal_draw_patches_render_command(icb, icb_index, num_patch_control_points, patch_start, pat
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_draw_primitives_render_command ====
//   candidate: air.draw.primitives.render.command
//   stdlib 実呼出: metal_command_buffer:947: __metal_draw_primitives_render_command(icb, icb_index, uint(type), vertex_start, vertex_count,
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_size_command_buffer ====
//   candidate: air.get.size.command.buffer
//   stdlib 実呼出: metal_command_buffer:173: return __metal_get_size_command_buffer(t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_render_pipeline_state_t ====
//   candidate: air.render.pipeline.state.t
//   stdlib 実呼出: metal_command_buffer:620: __metal_render_pipeline_state_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_reset_compute_command ====
//   candidate: air.reset.compute.command
//   stdlib 実呼出: metal_command_buffer:460: __metal_reset_compute_command(icb, icb_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_reset_render_command ====
//   candidate: air.reset.render.command
//   stdlib 実呼出: metal_command_buffer:1143: __metal_reset_render_command(icb, icb_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_barrier_compute_command ====
//   candidate: air.set.barrier.compute.command
//   stdlib 実呼出: metal_command_buffer:433: __metal_set_barrier_compute_command(icb, icb_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_barrier_render_command ====
//   candidate: air.set.barrier.render.command
//   stdlib 実呼出: metal_command_buffer:1132: __metal_set_barrier_render_command(icb, icb_index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_cull_mode_render_command ====
//   candidate: air.set.cull.mode.render.command
//   stdlib 実呼出: metal_command_buffer:834: __metal_set_cull_mode_render_command(icb, icb_index, uint(mode));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_depth_bias_render_command ====
//   candidate: air.set.depth.bias.render.command
//   stdlib 実呼出: metal_command_buffer:852: __metal_set_depth_bias_render_command(icb, icb_index, bias, slope_scale, clamp);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_depth_clip_mode_render_command ====
//   candidate: air.set.depth.clip.mode.render.command
//   stdlib 実呼出: metal_command_buffer:859: __metal_set_depth_clip_mode_render_command(icb, icb_index, uint(mode));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_depth_stencil_state_render_command ====
//   candidate: air.set.depth.stencil.state.render.command
//   stdlib 実呼出: metal_command_buffer:866: __metal_set_depth_stencil_state_render_command(icb, icb_index, state.s);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_fragment_buffer_render_command ====
//   candidate: air.set.fragment.buffer.render.command
//   stdlib 実呼出: metal_command_buffer:906: __metal_set_fragment_buffer_render_command(icb, icb_index, static_cast<device void *>(const_ca
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_front_facing_winding_render_command ====
//   candidate: air.set.front.facing.winding.render.command
//   stdlib 実呼出: metal_command_buffer:839: __metal_set_front_facing_winding_render_command(icb, icb_index, uint(w));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_imageblock_size_compute_command ====
//   candidate: air.set.imageblock.size.compute.command
//   stdlib 実呼出: metal_command_buffer:454: __metal_set_imageblock_size_compute_command(icb, icb_index, size);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_kernel_buffer_compute_command ====
//   candidate: air.set.kernel.buffer.compute.command
//   stdlib 実呼出: metal_command_buffer:397: __metal_set_kernel_buffer_compute_command(icb, icb_index, static_cast<device void *>(const_cas
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_mesh_buffer_render_command ====
//   candidate: air.set.mesh.buffer.render.command
//   stdlib 実呼出: metal_command_buffer:936: __metal_set_mesh_buffer_render_command(icb, icb_index, static_cast<device void *>(const_cast<d
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_object_buffer_render_command ====
//   candidate: air.set.object.buffer.render.command
//   stdlib 実呼出: metal_command_buffer:919: __metal_set_object_buffer_render_command(icb, icb_index, static_cast<device void *>(const_cast
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_object_threadgroup_memory_length_render_command ====
//   candidate: air.set.object.threadgroup.memory.length.render.command
//   stdlib 実呼出: metal_command_buffer:929: __metal_set_object_threadgroup_memory_length_render_command(icb, icb_index, length, idx);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_pipeline_state_compute_command ====
//   candidate: air.set.pipeline.state.compute.command
//   stdlib 実呼出: metal_command_buffer:390: __metal_set_pipeline_state_compute_command(icb, icb_index, pipeline_state.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_pipeline_state_render_command ====
//   candidate: air.set.pipeline.state.render.command
//   stdlib 実呼出: metal_command_buffer:827: __metal_set_pipeline_state_render_command(icb, icb_index, pipeline_state.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_stage_in_region_compute_command ====
//   candidate: air.set.stage.in.region.compute.command
//   stdlib 実呼出: metal_command_buffer:443: __metal_set_stage_in_region_compute_command(icb, icb_index, origin, size);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_threadgroup_memory_length_compute_command ====
//   candidate: air.set.threadgroup.memory.length.compute.command
//   stdlib 実呼出: metal_command_buffer:448: __metal_set_threadgroup_memory_length_compute_command(icb, icb_index, length, idx);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_triangle_fill_mode_render_command ====
//   candidate: air.set.triangle.fill.mode.render.command
//   stdlib 実呼出: metal_command_buffer:844: __metal_set_triangle_fill_mode_render_command(icb, icb_index, uint(mode));
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_vertex_buffer_render_command ====
//   candidate: air.set.vertex.buffer.render.command
//   stdlib 実呼出: metal_command_buffer:878: __metal_set_vertex_buffer_render_command(icb, icb_index, static_cast<device void *>(const_cast
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (全般) ====
//   candidate: datalayout/addressspace
//   stdlib 実呼出: compile addrspace probe & dump .ll
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (metadata) ====
//   candidate: air.kernel entry md
//   stdlib 実呼出: vertex/fragment/kernel probe → .ll
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (metadata) ====
//   candidate: air.arg_* / compile_options
//   stdlib 実呼出: 同上
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (呼出規約) ====
//   candidate: entry CC
//   stdlib 実呼出: llvm-bcanalyzer / ll dump
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (type) ====
//   candidate: texture/sampler opaque 表現
//   stdlib 実呼出: texture probe
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (type) ====
//   candidate: packed_vector_type
//   stdlib 実呼出: packed_float3 probe
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (機能) ====
//   candidate: function_constant
//   stdlib 実呼出: fc probe
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (機能) ====
//   candidate: visible_function_table
//   stdlib 実呼出: vft probe
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (ra) ====
//   candidate: raytracing/mesh/tensor
//   stdlib 実呼出: RT/mesh/tensor probe
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): (rt) ====
//   candidate: rtlib リンクトリガ
//   stdlib 実呼出: nextafter/printf 等で実測
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_unassigned_xxx 系で extern "C" 推奨)
