// scene P10: visible function table + intersection (raytracing): air.dyld_flat_table, RT intrinsic 実名
// 生成: 2026-07-21 build_probe_scenes.py@1.0.0 (再生成可能: 一次入力 data/probe_cells.csv 他)
// 実機未検証: コンパイル可否は docs/PROBING_PLAN.md §1 の手順 (xcrun metal) で確認
#include <metal_stdlib>
using namespace metal;

// ==== TODO(manual_needed): __metal_abort_intersection_query ====
//   candidate: air.abort.intersection.query
//   stdlib 実呼出: metal_raytracing:4383: __metal_abort_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_commit_bounding_box_intersection_intersection_query ====
//   candidate: air.commit.bounding.box.intersection.intersection.query
//   stdlib 実呼出: metal_raytracing:4403: __metal_commit_bounding_box_intersection_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_commit_curve_intersection_intersection_query ====
//   candidate: air.commit.curve.intersection.intersection.query
//   stdlib 実呼出: metal_raytracing:4396: __metal_commit_curve_intersection_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_commit_triangle_intersection_intersection_query ====
//   candidate: air.commit.triangle.intersection.intersection.query
//   stdlib 実呼出: metal_raytracing:4389: __metal_commit_triangle_intersection_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_function_handle_t ====
//   candidate: air.function.handle.t
//   stdlib 実呼出: metal_visible_function_table:18: static METAL_FUNC function_handle __get_from_opaque_handle(__metal_function_handle_t f)
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_buffer_intersection_function_table ====
//   candidate: air.get.buffer.intersection.function.table
//   stdlib 実呼出: metal_raytracing:1641: return __metal_get_buffer_intersection_function_table(t, index, T());
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_curve_distance_intersection_query ====
//   candidate: air.get.candidate.curve.distance.intersection.query
//   stdlib 実呼出: metal_raytracing:4464: return __metal_get_candidate_curve_distance_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_curve_parameter_intersection_query ====
//   candidate: air.get.candidate.curve.parameter.intersection.query
//   stdlib 実呼出: metal_raytracing:4335: return __metal_get_candidate_curve_parameter_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_geometry_id_intersection_query ====
//   candidate: air.get.candidate.geometry.id.intersection.query
//   stdlib 実呼出: metal_raytracing:4477: return __metal_get_candidate_geometry_id_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_instance_count_intersection_query ====
//   candidate: air.get.candidate.instance.count.intersection.query
//   stdlib 実呼出: metal_raytracing:4197: return __metal_get_candidate_instance_count_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_instance_id_intersection_query ====
//   candidate: air.get.candidate.instance.id.intersection.query
//   stdlib 実呼出: metal_raytracing:4116: return __metal_get_candidate_instance_id_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_intersection_type_intersection_query ====
//   candidate: air.get.candidate.intersection.type.intersection.query
//   stdlib 実呼出: metal_raytracing:4451: __metal_get_candidate_intersection_type_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_object_to_world_transform_intersection_query ====
//   candidate: air.get.candidate.object.to.world.transform.intersection.query
//   stdlib 実呼出: metal_raytracing:4131: __metal_get_candidate_object_to_world_transform_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_primitive_data_intersection_query ====
//   candidate: air.get.candidate.primitive.data.intersection.query
//   stdlib 実呼出: metal_raytracing:4490: return __metal_get_candidate_primitive_data_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_primitive_id_intersection_query ====
//   candidate: air.get.candidate.primitive.id.intersection.query
//   stdlib 実呼出: metal_raytracing:4483: return __metal_get_candidate_primitive_id_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_ray_direction_intersection_query ====
//   candidate: air.get.candidate.ray.direction.intersection.query
//   stdlib 実呼出: metal_raytracing:4503: return __metal_get_candidate_ray_direction_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_ray_origin_intersection_query ====
//   candidate: air.get.candidate.ray.origin.intersection.query
//   stdlib 実呼出: metal_raytracing:4497: return __metal_get_candidate_ray_origin_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_triangle_barycentric_coord_intersection_query ====
//   candidate: air.get.candidate.triangle.barycentric.coord.intersection.query
//   stdlib 実呼出: metal_raytracing:4295: return __metal_get_candidate_triangle_barycentric_coord_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_triangle_distance_intersection_query ====
//   candidate: air.get.candidate.triangle.distance.intersection.query
//   stdlib 実呼出: metal_raytracing:4457: return __metal_get_candidate_triangle_distance_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_user_instance_id_intersection_query ====
//   candidate: air.get.candidate.user.instance.id.intersection.query
//   stdlib 実呼出: metal_raytracing:4123: return __metal_get_candidate_user_instance_id_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_candidate_world_to_object_transform_intersection_query ====
//   candidate: air.get.candidate.world.to.object.transform.intersection.query
//   stdlib 実呼出: metal_raytracing:4141: __metal_get_candidate_world_to_object_transform_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_curve_parameter_intersection_query ====
//   candidate: air.get.committed.curve.parameter.intersection.query
//   stdlib 実呼出: metal_raytracing:4342: return __metal_get_committed_curve_parameter_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_distance_intersection_query ====
//   candidate: air.get.committed.distance.intersection.query
//   stdlib 実呼出: metal_raytracing:4516: return __metal_get_committed_distance_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_geometry_id_intersection_query ====
//   candidate: air.get.committed.geometry.id.intersection.query
//   stdlib 実呼出: metal_raytracing:4522: return __metal_get_committed_geometry_id_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_instance_count_intersection_query ====
//   candidate: air.get.committed.instance.count.intersection.query
//   stdlib 実呼出: metal_raytracing:4242: return __metal_get_committed_instance_count_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_instance_id_intersection_query ====
//   candidate: air.get.committed.instance.id.intersection.query
//   stdlib 実呼出: metal_raytracing:4150: return __metal_get_committed_instance_id_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_intersection_type_intersection_query ====
//   candidate: air.get.committed.intersection.type.intersection.query
//   stdlib 実呼出: metal_raytracing:4510: __metal_get_committed_intersection_type_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_object_to_world_transform_intersection_query ====
//   candidate: air.get.committed.object.to.world.transform.intersection.query
//   stdlib 実呼出: metal_raytracing:4165: __metal_get_committed_object_to_world_transform_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_primitive_data_intersection_query ====
//   candidate: air.get.committed.primitive.data.intersection.query
//   stdlib 実呼出: metal_raytracing:4535: return __metal_get_committed_primitive_data_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_primitive_id_intersection_query ====
//   candidate: air.get.committed.primitive.id.intersection.query
//   stdlib 実呼出: metal_raytracing:4528: return __metal_get_committed_primitive_id_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_ray_direction_intersection_query ====
//   candidate: air.get.committed.ray.direction.intersection.query
//   stdlib 実呼出: metal_raytracing:4548: return __metal_get_committed_ray_direction_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_ray_origin_intersection_query ====
//   candidate: air.get.committed.ray.origin.intersection.query
//   stdlib 実呼出: metal_raytracing:4542: return __metal_get_committed_ray_origin_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_triangle_barycentric_coord_intersection_query ====
//   candidate: air.get.committed.triangle.barycentric.coord.intersection.query
//   stdlib 実呼出: metal_raytracing:4309: return __metal_get_committed_triangle_barycentric_coord_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_user_instance_id_intersection_query ====
//   candidate: air.get.committed.user.instance.id.intersection.query
//   stdlib 実呼出: metal_raytracing:4157: return __metal_get_committed_user_instance_id_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_committed_world_to_object_transform_intersection_query ====
//   candidate: air.get.committed.world.to.object.transform.intersection.query
//   stdlib 実呼出: metal_raytracing:4175: __metal_get_committed_world_to_object_transform_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_curve_parameter_intersection_result ====
//   candidate: air.get.curve.parameter.intersection.result
//   stdlib 実呼出: metal_raytracing:2330: return __metal_get_curve_parameter_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_distance_intersection_result ====
//   candidate: air.get.distance.intersection.result
//   stdlib 実呼出: metal_raytracing:2391: return __metal_get_distance_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_function_pointer_visible_function_table ====
//   candidate: air.get.function.pointer.visible.function.table
//   stdlib 実呼出: metal_visible_function_table:351: return reinterpret_cast<function_pointer_type>(__metal_get_function_pointer_visible_fu
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_geometry_id_intersection_result ====
//   candidate: air.get.geometry.id.intersection.result
//   stdlib 実呼出: metal_raytracing:2397: return __metal_get_geometry_id_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_instance_acceleration_structure_instance_acceleration_structure ====
//   candidate: air.get.instance.acceleration.structure.instance.acceleration.structure
//   stdlib 実呼出: metal_raytracing:732: return Derived<ResultTags...>(__metal_get_instance_acceleration_structure_instance_acceleration_st
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_instance_count_instance_acceleration_structure ====
//   candidate: air.get.instance.count.instance.acceleration.structure
//   stdlib 実呼出: metal_raytracing:701: return __metal_get_instance_count_instance_acceleration_structure(derived.as);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_instance_count_intersection_result ====
//   candidate: air.get.instance.count.intersection.result
//   stdlib 実呼出: metal_raytracing:2281: return __metal_get_instance_count_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_instance_id_intersection_result ====
//   candidate: air.get.instance.id.intersection.result
//   stdlib 実呼出: metal_raytracing:2242: return __metal_get_instance_id_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_intersection_params_intersection_query ====
//   candidate: air.get.intersection.params.intersection.query
//   stdlib 実呼出: metal_raytracing:4410: __metal_get_intersection_params_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_function_handle ====
//   candidate: air.get.null.function.handle
//   stdlib 実呼出: metal_raytracing:1372: METAL_FUNC intersection_function_handle() thread : function_handle(__metal_get_null_function_hand
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_instance_acceleration_structure ====
//   candidate: air.get.null.instance.acceleration.structure
//   stdlib 実呼出: metal_raytracing:684: return __metal_get_null_instance_acceleration_structure();
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_intersection_function_table ====
//   candidate: air.get.null.intersection.function.table
//   stdlib 実呼出: metal_raytracing:1467: METAL_FUNC intersection_function_table() thread : t(__metal_get_null_intersection_function_table(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_primitive_acceleration_structure ====
//   candidate: air.get.null.primitive.acceleration.structure
//   stdlib 実呼出: metal_raytracing:663: return __metal_get_null_primitive_acceleration_structure();
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_null_visible_function_table ====
//   candidate: air.get.null.visible.function.table
//   stdlib 実呼出: metal_visible_function_table:191: METAL_FUNC visible_function_table() thread : t(__metal_get_null_visible_function_table
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_object_to_world_transform_intersection_result ====
//   candidate: air.get.object.to.world.transform.intersection.result
//   stdlib 実呼出: metal_raytracing:2362: __metal_get_object_to_world_transform_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_primitive_acceleration_structure_instance_acceleration_structure ====
//   candidate: air.get.primitive.acceleration.structure.instance.acceleration.structure
//   stdlib 実呼出: metal_raytracing:739: return Derived<ResultTags...>(__metal_get_primitive_acceleration_structure_instance_acceleration_s
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_primitive_data_intersection_result ====
//   candidate: air.get.primitive.data.intersection.result
//   stdlib 実呼出: metal_raytracing:2409: return __metal_get_primitive_data_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_primitive_id_intersection_result ====
//   candidate: air.get.primitive.id.intersection.result
//   stdlib 実呼出: metal_raytracing:2403: return __metal_get_primitive_id_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_ray_direction_intersection_result ====
//   candidate: air.get.ray.direction.intersection.result
//   stdlib 実呼出: metal_raytracing:2421: return __metal_get_ray_direction_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_ray_min_distance_intersection_query ====
//   candidate: air.get.ray.min.distance.intersection.query
//   stdlib 実呼出: metal_raytracing:4444: return __metal_get_ray_min_distance_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_ray_min_distance_intersection_result ====
//   candidate: air.get.ray.min.distance.intersection.result
//   stdlib 実呼出: metal_raytracing:2427: return __metal_get_ray_min_distance_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_ray_origin_intersection_result ====
//   candidate: air.get.ray.origin.intersection.result
//   stdlib 実呼出: metal_raytracing:2415: return __metal_get_ray_origin_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_resource_id_instance_acceleration_structure ====
//   candidate: air.get.resource.id.instance.acceleration.structure
//   stdlib 実呼出: metal_raytracing:693: return {__metal_get_resource_id_instance_acceleration_structure(as)};
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_resource_id_primitive_acceleration_structure ====
//   candidate: air.get.resource.id.primitive.acceleration.structure
//   stdlib 実呼出: metal_raytracing:672: return {__metal_get_resource_id_primitive_acceleration_structure(as)};
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_size_intersection_function_table ====
//   candidate: air.get.size.intersection.function.table
//   stdlib 実呼出: metal_raytracing:1610: return __metal_get_size_intersection_function_table(t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_size_visible_function_table ====
//   candidate: air.get.size.visible.function.table
//   stdlib 実呼出: metal_visible_function_table:413: return __metal_get_size_visible_function_table(t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_triangle_barycentric_coord_intersection_result ====
//   candidate: air.get.triangle.barycentric.coord.intersection.result
//   stdlib 実呼出: metal_raytracing:2309: return __metal_get_triangle_barycentric_coord_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_type_intersection_result ====
//   candidate: air.get.type.intersection.result
//   stdlib 実呼出: metal_raytracing:2279: return static_cast<intersection_type>(__metal_get_type_intersection_result(_build_intersection_fl
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_user_instance_id_intersection_result ====
//   candidate: air.get.user.instance.id.intersection.result
//   stdlib 実呼出: metal_raytracing:2249: return __metal_get_user_instance_id_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_visible_function_table_intersection_function_table ====
//   candidate: air.get.visible.function.table.intersection.function.table
//   stdlib 実呼出: metal_raytracing:1656: __metal_get_visible_function_table_intersection_function_table(t, index)
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_world_space_ray_direction_intersection_query ====
//   candidate: air.get.world.space.ray.direction.intersection.query
//   stdlib 実呼出: metal_raytracing:4438: return __metal_get_world_space_ray_direction_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_world_space_ray_origin_intersection_query ====
//   candidate: air.get.world.space.ray.origin.intersection.query
//   stdlib 実呼出: metal_raytracing:4432: return __metal_get_world_space_ray_origin_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_get_world_to_object_transform_intersection_result ====
//   candidate: air.get.world.to.object.transform.intersection.result
//   stdlib 実呼出: metal_raytracing:2352: __metal_get_world_to_object_transform_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_instance_acceleration_structure_t ====
//   candidate: air.instance.acceleration.structure.t
//   stdlib 実呼出: metal_raytracing:681: using handle_type = __metal_instance_acceleration_structure_t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_intersect ====
//   candidate: air.intersect
//   stdlib 実呼出: metal_raytracing:2465: __metal_intersect(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_intersect_direct_access ====
//   candidate: air.intersect.direct.access
//   stdlib 実呼出: metal_raytracing:2546: __metal_intersect_direct_access(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_intersection_function_table_t ====
//   candidate: air.intersection.function.table.t
//   stdlib 実呼出: metal_raytracing:1868: __metal_intersection_function_table_t t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_intersection_query_t ====
//   candidate: air.intersection.query.t
//   stdlib 実呼出: metal_raytracing:4552: __metal_intersection_query_t q;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_intersection_result_t ====
//   candidate: air.intersection.result.t
//   stdlib 実呼出: metal_raytracing:2432: __metal_intersection_result_t result;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_candidate_non_opaque_bounding_box_intersection_query ====
//   candidate: air.is.candidate.non.opaque.bounding.box.intersection.query
//   stdlib 実呼出: metal_raytracing:4471: return __metal_is_candidate_non_opaque_bounding_box_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_candidate_triangle_front_facing_intersection_query ====
//   candidate: air.is.candidate.triangle.front.facing.intersection.query
//   stdlib 実呼出: metal_raytracing:4302: return __metal_is_candidate_triangle_front_facing_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_committed_triangle_front_facing_intersection_query ====
//   candidate: air.is.committed.triangle.front.facing.intersection.query
//   stdlib 実呼出: metal_raytracing:4316: return __metal_is_committed_triangle_front_facing_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_equal_function_handle ====
//   candidate: air.is.equal.function.handle
//   stdlib 実呼出: metal_visible_function_table:162: return __metal_is_equal_function_handle(lhs.f, rhs.f);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_function_handle ====
//   candidate: air.is.null.function.handle
//   stdlib 実呼出: metal_visible_function_table:172: return __metal_is_null_function_handle(f.f);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_instance_acceleration_structure ====
//   candidate: air.is.null.instance.acceleration.structure
//   stdlib 実呼出: metal_raytracing:688: return __metal_is_null_instance_acceleration_structure(as);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_intersection_function_table ====
//   candidate: air.is.null.intersection.function.table
//   stdlib 実呼出: metal_raytracing:1879: return __metal_is_null_intersection_function_table(t.t);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_null_primitive_acceleration_structure ====
//   candidate: air.is.null.primitive.acceleration.structure
//   stdlib 実呼出: metal_raytracing:667: return __metal_is_null_primitive_acceleration_structure(as);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_is_triangle_front_facing_intersection_result ====
//   candidate: air.is.triangle.front.facing.intersection.result
//   stdlib 実呼出: metal_raytracing:2302: return __metal_is_triangle_front_facing_intersection_result(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_next_intersection_query ====
//   candidate: air.next.intersection.query
//   stdlib 実呼出: metal_raytracing:4371: return __metal_next_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_primitive_acceleration_structure_t ====
//   candidate: air.primitive.acceleration.structure.t
//   stdlib 実呼出: metal_raytracing:660: using handle_type = __metal_primitive_acceleration_structure_t;
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_release_intersect_payload ====
//   candidate: air.release.intersect.payload
//   stdlib 実呼出: metal_raytracing:2585: __metal_release_intersect_payload(_build_intersection_flags(Tags{}...), out_payload_ptr, sizeof(P
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_release_intersection_result ====
//   candidate: air.release.intersection.result
//   stdlib 実呼出: metal_raytracing:2584: __metal_release_intersection_result(_build_intersection_flags(Tags{}...), result_ref);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_reset_intersection_query ====
//   candidate: air.reset.intersection.query
//   stdlib 実呼出: metal_raytracing:3988: __metal_reset_intersection_query(
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_buffer_intersection_function_table ====
//   candidate: air.set.buffer.intersection.function.table
//   stdlib 実呼出: metal_raytracing:1773: __metal_set_buffer_intersection_function_table(t, buf, index);
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_set_visible_function_table_intersection_function_table ====
//   candidate: air.set.visible.function.table.intersection.function.table
//   stdlib 実呼出: metal_raytracing:1784: __metal_set_visible_function_table_intersection_function_table(t, vft.__get_opaque_handle(), inde
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)

// ==== TODO(manual_needed): __metal_visible_function_table_t ====
//   candidate: air.visible.function.table.t
//   stdlib 実呼出: metal_visible_function_table:184: static METAL_FUNC visible_function_table __get_from_opaque_handle(__metal_visible_func
//   → 上記呼出を包む最小 wrapper を probe 時に手書きで追加 (symbol は probe_p10_xxx 系で extern "C" 推奨)
