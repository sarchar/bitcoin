# - Find qrencode-win32
#
# See https://code.google.com/p/qrencode-win32/
#
# QRENCODE_INCLUDES - where to find qrencode.h
# QRENCODE_LIBRARIES - required libraries when using QRENCODE.
# QRENCODE_FOUND - True if protobuf is found.

set(QRENCODE_ROOT "" CACHE STRING "qrencode-win32 root directory")

find_path(QRENCODE_INCLUDE_DIR qrencode.h HINTS "${QRENCODE_ROOT}/qrencode-win32")
find_library(QRENCODE_RELEASE_LIBRARY qrcodelib  HINTS "${QRENCODE_ROOT}/qrencode-win32/vc8/.build/Release-Lib")
find_library(QRENCODE_DEBUG_LIBRARY qrcodelib  HINTS "${QRENCODE_ROOT}/qrencode-win32/vc8/.build/Debug-Lib")

set(QRENCODE_LIBRARY optimized ${QRENCODE_RELEASE_LIBRARY} debug ${QRENCODE_DEBUG_LIBRARY})
set(QRENCODE_INCLUDE_DIRS ${QRENCODE_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)

# handle the QUIETLY and REQUIRED arguments and set QRENCODE_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(QRENCODE DEFAULT_MSG
    QRENCODE_LIBRARY QRENCODE_INCLUDE_DIR)

mark_as_advanced(QRENCODE_LIBRARY QRENCODE_INCLUDE_DIRS)
