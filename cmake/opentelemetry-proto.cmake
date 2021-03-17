set(PROTO_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third_party/opentelemetry-proto")

set(COMMON_PROTO "${PROTO_PATH}/opentelemetry/proto/common/v1/common.proto")
set(RESOURCE_PROTO
    "${PROTO_PATH}/opentelemetry/proto/resource/v1/resource.proto")
set(TRACE_PROTO "${PROTO_PATH}/opentelemetry/proto/trace/v1/trace.proto")
set(LOGS_PROTO "${PROTO_PATH}/opentelemetry/proto/logs/v1/logs.proto")
set(METRICS_PROTO "${PROTO_PATH}/opentelemetry/proto/metrics/v1/metrics.proto")

set(TRACE_SERVICE_PROTO
    "${PROTO_PATH}/opentelemetry/proto/collector/trace/v1/trace_service.proto")
set(LOGS_SERVICE_PROTO
    "${PROTO_PATH}/opentelemetry/proto/collector/logs/v1/logs_service.proto")
set(METRICS_SERVICE_PROTO
    "${PROTO_PATH}/opentelemetry/proto/collector/metrics/v1/metrics_service.proto"
)

set(GENERATED_PROTOBUF_PATH
    "${CMAKE_BINARY_DIR}/generated/third_party/opentelemetry-proto")

file(MAKE_DIRECTORY "${GENERATED_PROTOBUF_PATH}")

set(COMMON_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/common/v1/common.pb.cc")
set(COMMON_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/common/v1/common.pb.h")
set(RESOURCE_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/resource/v1/resource.pb.cc")
set(RESOURCE_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/resource/v1/resource.pb.h")
set(TRACE_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/trace/v1/trace.pb.cc")
set(TRACE_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/trace/v1/trace.pb.h")
set(LOGS_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/logs/v1/logs.pb.cc")
set(LOGS_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/logs/v1/logs.pb.h")
set(METRICS_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/metrics/v1/metrics.pb.cc")
set(METRICS_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/metrics/v1/metrics.pb.h")

set(TRACE_SERVICE_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/trace/v1/trace_service.pb.cc"
)
set(TRACE_SERVICE_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/trace/v1/trace_service.pb.h"
)
set(TRACE_SERVICE_GRPC_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/trace/v1/trace_service.grpc.pb.cc"
)
set(TRACE_SERVICE_GRPC_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/trace/v1/trace_service.grpc.pb.h"
)
set(LOGS_SERVICE_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/logs/v1/logs_service.pb.cc"
)
set(LOGS_SERVICE_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/logs/v1/logs_service.pb.h"
)
set(LOGS_SERVICE_GRPC_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/logs/v1/logs_service.grpc.pb.cc"
)
set(LOGS_SERVICE_GRPC_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/logs/v1/logs_service.grpc.pb.h"
)
set(METRICS_SERVICE_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/metrics/v1/metrics_service.pb.cc"
)
set(METRICS_SERVICE_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/metrics/v1/metrics_service.pb.h"
)
set(METRICS_SERVICE_GRPC_PB_CPP_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/metrics/v1/metrics_service.grpc.pb.cc"
)
set(METRICS_SERVICE_GRPC_PB_H_FILE
    "${GENERATED_PROTOBUF_PATH}/opentelemetry/proto/collector/metrics/v1/metrics_service.grpc.pb.h"
)

foreach(IMPORT_DIR ${PROTOBUF_IMPORT_DIRS})
  list(APPEND PROTOBUF_INCLUDE_FLAGS "-I${IMPORT_DIR}")
endforeach()

include(FetchContent)

FetchContent_Declare(
        gRPC
        GIT_REPOSITORY https://github.com/grpc/grpc.git
        GIT_TAG v1.30.2
)

FetchContent_MakeAvailable(gRPC)

set(_REFLECTION grpc++_reflection)
set(_GRPC_GRPCPP grpc++)

set(gRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:grpc_cpp_plugin>)

set(PROTOBUF_PROTOC_EXECUTABLE $<TARGET_FILE:protoc>)

add_custom_command(
  OUTPUT ${COMMON_PB_H_FILE}
         ${COMMON_PB_CPP_FILE}
         ${RESOURCE_PB_H_FILE}
         ${RESOURCE_PB_CPP_FILE}
         ${TRACE_PB_H_FILE}
         ${TRACE_PB_CPP_FILE}
         ${LOGS_PB_H_FILE}
         ${LOGS_PB_CPP_FILE}
         ${METRICS_PB_H_FILE}
         ${METRICS_PB_CPP_FILE}
         ${TRACE_SERVICE_PB_H_FILE}
         ${TRACE_SERVICE_PB_CPP_FILE}
         ${TRACE_SERVICE_GRPC_PB_H_FILE}
         ${TRACE_SERVICE_GRPC_PB_CPP_FILE}
         ${LOGS_SERVICE_PB_H_FILE}
         ${LOGS_SERVICE_PB_CPP_FILE}
         ${LOGS_SERVICE_GRPC_PB_H_FILE}
         ${LOGS_SERVICE_GRPC_PB_CPP_FILE}
         ${METRICS_SERVICE_PB_H_FILE}
         ${METRICS_SERVICE_PB_CPP_FILE}
         ${METRICS_SERVICE_GRPC_PB_H_FILE}
         ${METRICS_SERVICE_GRPC_PB_CPP_FILE}
  COMMAND
    ${PROTOBUF_PROTOC_EXECUTABLE} ARGS "--proto_path=${PROTO_PATH}"
    ${PROTOBUF_INCLUDE_FLAGS} "--cpp_out=${GENERATED_PROTOBUF_PATH}"
    "--grpc_out=${GENERATED_PROTOBUF_PATH}"
    --plugin=protoc-gen-grpc="${gRPC_CPP_PLUGIN_EXECUTABLE}" ${COMMON_PROTO}
    ${RESOURCE_PROTO} ${TRACE_PROTO} ${LOGS_PROTO} ${METRICS_PROTO}
    ${TRACE_SERVICE_PROTO} ${LOGS_SERVICE_PROTO} ${METRICS_SERVICE_PROTO})

include_directories("${GENERATED_PROTOBUF_PATH}")

add_library(
  opentelemetry_proto STATIC
  ${COMMON_PB_CPP_FILE}
  ${RESOURCE_PB_CPP_FILE}
  ${TRACE_PB_CPP_FILE}
  ${LOGS_PB_CPP_FILE}
  ${METRICS_PB_CPP_FILE}
  ${TRACE_SERVICE_PB_CPP_FILE}
  ${TRACE_SERVICE_GRPC_PB_CPP_FILE}
  ${LOGS_SERVICE_PB_CPP_FILE}
  ${LOGS_SERVICE_GRPCPB_CPP_FILE}
  ${METRICS_SERVICE_PB_CPP_FILE}
  ${METRICS_SERVICE_GRPC_PB_CPP_FILE})

set_target_properties(opentelemetry_proto PROPERTIES EXPORT_NAME proto)

install(
  TARGETS opentelemetry_proto
  EXPORT "${PROJECT_NAME}-target"
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
  TARGETS ${_REFLECTION}
  EXPORT "${PROJECT_NAME}-target"
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
  TARGETS  ${_GRPC_GRPCPP}
  EXPORT "${PROJECT_NAME}-target"
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

set(gRPC_ABSL_USED_TARGETS
  absl_algorithm
  absl_atomic_hook
  absl_bad_optional_access
  absl_base
  absl_base_internal
  absl_bits
  absl_civil_time
  absl_compressed_tuple
  absl_config
  absl_core_headers
  absl_dynamic_annotations
  absl_endian
  absl_errno_saver
  absl_inlined_vector
  absl_inlined_vector_internal
  absl_int128
  absl_log_severity
  absl_memory
  absl_optional
  absl_raw_logging_internal
  absl_span
  absl_spinlock_wait
  absl_str_format
  absl_str_format_internal
  absl_strings
  absl_strings_internal
  absl_throw_delegate
  absl_time
  absl_time_zone
  absl_type_traits
  absl_utility
  absl_meta
)

install(
  TARGETS grpc gpr address_sorting upb ssl zlibstatic c-ares crypto
  EXPORT "${PROJECT_NAME}-target"
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
  TARGETS ${gRPC_ABSL_USED_TARGETS}
  EXPORT "${PROJECT_NAME}-target"
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
  DIRECTORY ${GENERATED_PROTOBUF_PATH}/opentelemetry
  DESTINATION include
  FILES_MATCHING
  PATTERN "*.h")

if(TARGET protobuf::libprotobuf)
  target_link_libraries(opentelemetry_proto
                        PUBLIC protobuf::libprotobuf
                        ${_REFLECTION}
                        ${_GRPC_GRPCPP})
else() # cmake 3.8 or lower
  target_include_directories(opentelemetry_proto
                             PUBLIC ${Protobuf_INCLUDE_DIRS})
  target_link_libraries(opentelemetry_proto
                        INTERFACE ${Protobuf_LIBRARIES})
endif()

if(BUILD_SHARED_LIBS)
  set_property(TARGET opentelemetry_proto PROPERTY POSITION_INDEPENDENT_CODE ON)
endif()
