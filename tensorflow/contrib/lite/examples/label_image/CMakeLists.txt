project(label_image)

find_package(Threads REQUIRED)

add_executable(label_image bitmap_helpers.cc label_image.cc)
target_link_libraries(label_image tensorflow-lite ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS})
