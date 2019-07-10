set(TFLITE_EXAMPLE_LABEL_IMAGE_SOURCES
  bitmap_helpers.cc
  label_image.cc)

find_package(Threads)
find_package(Threads)

add_executable(label_image ${TFLITE_EXAMPLE_LABEL_IMAGE_SOURCES})
add_sanitizers(label_image)

target_link_libraries(label_image tensorflow-lite ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS})

