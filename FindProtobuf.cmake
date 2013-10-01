# - Find Google's Protobuf
#
# GPB_INCLUDES - where to find google/protobuf/*
# GPB_LIBRARIES - required libraries when using GPB.
# GPB_FOUND - True if protobuf is found.

set(GPB_ROOT "" CACHE STRING "Google Protobuf root directory")

find_path(GPB_INCLUDE_DIR google/protobuf/stubs/common.h HINTS "${GPB_ROOT}/src")
find_library(GPB_RELEASE_LIBRARY libprotobuf  HINTS "${GPB_ROOT}/vsprojects/Release")
find_library(GPB_DEBUG_LIBRARY libprotobuf  HINTS "${GPB_ROOT}/vsprojects/Debug")

set(GPB_LIBRARY optimized ${GPB_RELEASE_LIBRARY} debug ${GPB_DEBUG_LIBRARY})
set(GPB_INCLUDE_DIRS ${GPB_INCLUDE_DIR})
set(GPB_PROTOC ${GPB_ROOT}/vsprojects/Release/protoc.exe)

include(FindPackageHandleStandardArgs)

# handle the QUIETLY and REQUIRED arguments and set GPB_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GPB DEFAULT_MSG
                                  GPB_LIBRARY GPB_PROTOC GPB_INCLUDE_DIR)

mark_as_advanced(GPB_LIBRARY GPB_PROTOC GPB_INCLUDE_DIRS)
