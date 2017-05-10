cmake_minimum_required(VERSION 2.8)
project(ZlibARM)

if(EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  conan_basic_setup()
endif()

add_executable(example example.cpp)
target_link_libraries(example ${CONAN_LIBS})
