# gcc-850.toolchain.cmake

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

if(NOT DEFINED ENV{ARCHIESDK})
    message(FATAL_ERROR "ARCHIESDK environment variable is not set")
endif()

file(TO_CMAKE_PATH "$ENV{ARCHIESDK}" ARCHIESDK_ROOT)
set(ARCHIESDK_ROOT "${ARCHIESDK_ROOT}" CACHE PATH "Path to ArchieSDK root")

set(ARCHIESDK_BIN     "${ARCHIESDK_ROOT}/tools/bin")
set(ARCHIESDK_INC     "${ARCHIESDK_ROOT}/tools/include")
set(ARCHIESDK_LIB     "${ARCHIESDK_ROOT}/tools/lib")

set(CMAKE_C_COMPILER  "${ARCHIESDK_BIN}/arm-archie-gcc")
set(CMAKE_ASM_COMPILER "${ARCHIESDK_BIN}/arm-archie-as")
set(CMAKE_AR          "${ARCHIESDK_BIN}/arm-archie-ar")

set(ARCHIESDK_OBJCOPY "${ARCHIESDK_BIN}/arm-archie-objcopy" CACHE FILEPATH "Archie objcopy")
set(ARCHIESDK_ZIP     "${ARCHIESDK_BIN}/arm-archie-zip"     CACHE FILEPATH "Archie zip")

# Cross-compile sanity: do not try to run built test programs.
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Let find_* look inside the SDK for target headers/libs.
set(CMAKE_FIND_ROOT_PATH "${ARCHIESDK_ROOT}/tools")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Defaults taken from config.mk
set(CMAKE_C_FLAGS_INIT
    "-mno-thumb-interwork -Wdouble-promotion -Wfloat-conversion -Wall -Wextra"
)

# Export useful paths for project CMakeLists.txt
set(ARCHIESDK_INCLUDE_DIR "${ARCHIESDK_INC}" CACHE PATH "ArchieSDK include dir")
set(ARCHIESDK_LIBRARY_DIR "${ARCHIESDK_LIB}" CACHE PATH "ArchieSDK library dir")
