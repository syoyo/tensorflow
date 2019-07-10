# Basedon Harald's work
# https://medium.com/@haraldfernengel/compiling-tensorflow-lite-for-a-raspberry-pi-786b1b98e646
cmake_minimum_required(VERSION 3.1)
project(tensorflow-lite)

set(CMAKE_CXX_STANDARD 11)

option(TFLITE_WITH_CCACHE "Build with ccache support" ON)

# cmake modules
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/sanitizers)
find_package(Sanitizers) # Address sanitizer (-DSANITIZE_ADDRESS=ON)

# [ccache]
if (TFLITE_WITH_CCACHE)
  find_program(CCACHE_EXE ccache)
  if (CCACHE_EXE)

    message(STATUS "Use ccache : " ${CCACHE_EXE})
    # CMAKE_C_COMPILER_LAUNCHER = available from cmake 3.4+)
    if (CMAKE_C_COMPILER_LAUNCHER)
      set(CMAKE_C_COMPILER_LAUNCHER "${CMAKE_C_COMPILER_LAUNCHER}" "${CCACHE_EXE}")
    else()
      set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_EXE}")
    endif()

    if (CMAKE_CXX_COMPILER_LAUNCHER)
      set(CMAKE_CXX_COMPILER_LAUNCHER "${CMAKE_CXX_COMPILER_LAUNCHER}" "${CCACHE_EXE}")
    else()
      set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_EXE}")
    endif()

  endif (CCACHE_EXE)

endif()


list(APPEND TENSORFLOW_LITE_KERNEL_SOURCES
  ${PROJECT_SOURCE_DIR}/../../kernels/activations.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/add.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/arg_min_max.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/audio_spectrogram.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/basic_rnn.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/batch_to_space_nd.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/bidirectional_sequence_lstm.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/bidirectional_sequence_rnn.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/cast.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/comparisons.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/concatenation.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/conv.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/depthwise_conv.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/dequantize.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/detection_postprocess.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/div.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/eigen_support.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/elementwise.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/embedding_lookup.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/embedding_lookup_sparse.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/expand_dims.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/exp.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/fake_quant.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/fill.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/floor.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/floor_div.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/floor_mod.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/fully_connected.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/gather.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/gemm_support.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/hashtable_lookup.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/kernel_util.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/l2norm.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/layer_norm_lstm.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/local_response_norm.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/logical.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/lsh_projection.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/lstm.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/lstm_eval.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/maximum_minimum.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/mfcc.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/mirror_pad.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/mul.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/neg.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/one_hot.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/pack.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/pad.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/pooling.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/pow.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/range.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/reduce.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/register.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/relu1.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/reshape.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/resize_bilinear.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/resize_nearest_neighbor.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/select.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/shape.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/skip_gram.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/slice.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/space_to_batch_nd.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/space_to_depth.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/sparse_output_fully_connected.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/sparse_to_dense.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/split.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/split_v.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/squared_difference.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/squeeze.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/strided_slice.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/sub.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/svdf.cc
  #${PROJECT_SOURCE_DIR}/../../kernels/test_util.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/tile.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/topk_v2.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/transpose.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/transpose_conv.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/unidirectional_sequence_lstm.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/unidirectional_sequence_rnn.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/unpack.cc
  ${PROJECT_SOURCE_DIR}/../../kernels/zeros_like.cc
  )

message(STATUS ${TENSORFLOW_LITE_KERNEL_SOURCES})

# note - this list was obtained by running "make -n" on the Makefile in this directory
set(TENSORFLOW_LITE_SOURCES
    ${PROJECT_SOURCE_DIR}/../../allocation.cc
    ${PROJECT_SOURCE_DIR}/../../arena_planner.cc
    ${PROJECT_SOURCE_DIR}/../../graph_info.cc
    ${PROJECT_SOURCE_DIR}/../../interpreter.cc
    ${PROJECT_SOURCE_DIR}/../../model.cc
    ${PROJECT_SOURCE_DIR}/../../mutable_op_resolver.cc
    ${PROJECT_SOURCE_DIR}/../../simple_memory_arena.cc
    ${PROJECT_SOURCE_DIR}/../../nnapi_delegate.cc
    ${PROJECT_SOURCE_DIR}/../../optional_debug_tools.cc
    ${PROJECT_SOURCE_DIR}/../../string_util.cc
    ${PROJECT_SOURCE_DIR}/../../util.cc
    ${PROJECT_SOURCE_DIR}/../../mmap_allocation.cc

    ${PROJECT_SOURCE_DIR}/../../stderr_reporter.cc

    ${PROJECT_SOURCE_DIR}/../../core/subgraph.cc

    ${PROJECT_SOURCE_DIR}/../../core/api/error_reporter.cc
    ${PROJECT_SOURCE_DIR}/../../core/api/flatbuffer_conversions.cc
    ${PROJECT_SOURCE_DIR}/../../core/api/op_resolver.cc

    ${TENSORFLOW_LITE_KERNEL_SOURCES}

    ${PROJECT_SOURCE_DIR}/../../kernels/internal/kernel_utils.cc
    ${PROJECT_SOURCE_DIR}/../../kernels/internal/mfcc.cc
    ${PROJECT_SOURCE_DIR}/../../kernels/internal/mfcc_dct.cc
    ${PROJECT_SOURCE_DIR}/../../kernels/internal/mfcc_mel_filterbank.cc
    ${PROJECT_SOURCE_DIR}/../../kernels/internal/optimized/neon_tensor_utils.cc
    ${PROJECT_SOURCE_DIR}/../../kernels/internal/spectrogram.cc
    ${PROJECT_SOURCE_DIR}/../../kernels/internal/quantization_util.cc
    ${PROJECT_SOURCE_DIR}/../../kernels/internal/reference/portable_tensor_utils.cc
    ${PROJECT_SOURCE_DIR}/../../kernels/internal/tensor_utils.cc

    # C-API
    ${PROJECT_SOURCE_DIR}/../../c/c_api_internal.c

    ${PROJECT_SOURCE_DIR}/downloads/farmhash/src/farmhash.cc

    # Add fft file for `rdft()` implementation which is used in spectrogram.
    # FIXME(syoyo): We could use system's fft library.
    ${PROJECT_SOURCE_DIR}/downloads/fft2d/fft4g.c
)

IF (CMAKE_CXX_COMPILER_ID MATCHES "Clang" AND NOT EMSCRIPTEN)
  # Assume C++ sources
  set_source_files_properties(${TENSORFLOW_LITE_SOURCES} PROPERTIES COMPILE_FLAGS "-Wno-extern-c-compat")
ENDIF ()


add_library(tensorflow-lite SHARED ${TENSORFLOW_LITE_SOURCES})
add_sanitizers(tensorflow-lite)

target_include_directories(tensorflow-lite
    PUBLIC ../../../../
    PUBLIC downloads/flatbuffers/include
    PRIVATE downloads
    PRIVATE downloads/eigen
    PRIVATE downloads/gemmlowp
    PRIVATE downloads/neon_2_sse
    PRIVATE downloads/farmhash/src
    PRIVATE gen/obj
)

# out-of-tree build
add_subdirectory(${PROJECT_SOURCE_DIR}/../../examples/label_image examples)
