# http://www.cmake.org/cmake/help/cmake2.6docs.html

cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}")
project(Bitcoin)

set_property(GLOBAL PROPERTY DEBUG_CONFIGURATIONS "Debug;RelWithDebInfo")

add_subdirectory(src)

