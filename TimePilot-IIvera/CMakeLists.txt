# Time Pilot for Apple II + VERA - cross-platform build (macOS, Linux, Windows).
#
# Requirements:
#   * CMake 3.20+
#   * Python 3.8+
#   * llvm-mos-sdk with the Apple II platform (apple2, or apple2e on older SDKs)
#     https://github.com/llvm-mos/llvm-mos-sdk/releases
#
# Point the build at the SDK with either an environment variable or a cache
# variable (the environment variable is the documented default):
#
#   export LLVM_MOS_SDK=/path/to/llvm-mos      # macOS / Linux
#   set LLVM_MOS_SDK=C:\dev\llvm-mos           # Windows
#
#   cmake -B build
#   cmake --build build
#
# Or without the environment variable:
#   cmake -B build -DLLVM_MOS_SDK=/path/to/llvm-mos
#
# Output: disks/TimePilot-IIvera.hdv, disks/TimePilot-IIvera-D1.po,
#         disks/TimePilot-IIvera-D2.po
#
# LANGUAGES NONE: the 6502 cross-compiler is driven through custom commands, so
# CMake must not probe for a working host C compiler.

cmake_minimum_required(VERSION 3.20)
project(TimePilot-IIvera LANGUAGES NONE)

# ---------------------------------------------------------------------------
# Toolchain discovery
# ---------------------------------------------------------------------------
set(LLVM_MOS_SDK "$ENV{LLVM_MOS_SDK}" CACHE PATH
    "Root of the llvm-mos-sdk installation (contains bin/mos-apple2-clang)")

if(NOT LLVM_MOS_SDK)
    message(FATAL_ERROR
        "LLVM_MOS_SDK is not set.\n"
        "Install llvm-mos-sdk (https://github.com/llvm-mos/llvm-mos-sdk/releases), then either:\n"
        "  export LLVM_MOS_SDK=/path/to/llvm-mos\n"
        "or configure with:\n"
        "  cmake -B build -DLLVM_MOS_SDK=/path/to/llvm-mos")
endif()

# Upstream llvm-mos-sdk ships the Apple II target as "apple2". Some older or
# custom SDK builds name it "apple2e" instead; accept either. The game itself
# needs nothing platform-specific beyond <stdint.h>, so both work.
find_program(MOS_CLANG
    NAMES mos-apple2e-clang mos-apple2e-clang.bat
          mos-apple2-clang  mos-apple2-clang.bat
    HINTS "${LLVM_MOS_SDK}/bin"
    NO_DEFAULT_PATH
    DOC "llvm-mos Apple II C compiler driver")

if(NOT MOS_CLANG)
    message(FATAL_ERROR
        "No Apple II llvm-mos driver found under ${LLVM_MOS_SDK}/bin\n"
        "Looked for: mos-apple2-clang, mos-apple2e-clang (and .bat variants).\n"
        "Check that LLVM_MOS_SDK points at the SDK root (the directory containing bin/).")
endif()

# Derive the platform name from the driver: mos-<platform>-clang[.bat]
get_filename_component(_mos_driver "${MOS_CLANG}" NAME_WE)
string(REGEX REPLACE "^mos-(.+)-clang$" "\\1" MOS_PLATFORM "${_mos_driver}")

if(NOT EXISTS "${LLVM_MOS_SDK}/mos-platform/${MOS_PLATFORM}/include")
    message(FATAL_ERROR
        "Driver ${MOS_CLANG} implies platform '${MOS_PLATFORM}', but\n"
        "  ${LLVM_MOS_SDK}/mos-platform/${MOS_PLATFORM}/include\n"
        "does not exist. The SDK installation looks incomplete.")
endif()

find_package(Python3 3.8 REQUIRED COMPONENTS Interpreter)

message(STATUS "llvm-mos SDK : ${LLVM_MOS_SDK}")
message(STATUS "mos compiler : ${MOS_CLANG}")
message(STATUS "mos platform : ${MOS_PLATFORM}")
message(STATUS "python       : ${Python3_EXECUTABLE}")

# ---------------------------------------------------------------------------
# Layout
# ---------------------------------------------------------------------------
set(SRC_DIR    "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(TOOLS_DIR  "${CMAKE_CURRENT_SOURCE_DIR}/tools")
set(ASSETS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/assets")
set(DISKS_DIR  "${CMAKE_CURRENT_SOURCE_DIR}/disks")
set(STAGE_DIR  "${CMAKE_CURRENT_BINARY_DIR}/stage")

# Cadius creates the bootable ProDOS volume used by the HDV packager. The
# Windows executable is bundled; macOS/Linux users can provide their Cadius
# binary with -DCADIUS_EXECUTABLE=/path/to/cadius.
set(CADIUS_EXECUTABLE "" CACHE FILEPATH "Path to the Cadius disk-image utility")
if(NOT CADIUS_EXECUTABLE AND WIN32 AND EXISTS "${TOOLS_DIR}/cadius.exe")
    set(CADIUS_EXECUTABLE "${TOOLS_DIR}/cadius.exe")
endif()
if(NOT CADIUS_EXECUTABLE)
    find_program(_CADIUS_EXECUTABLE NAMES cadius Cadius cadius.exe
        HINTS "${TOOLS_DIR}")
    if(_CADIUS_EXECUTABLE)
        set(CADIUS_EXECUTABLE "${_CADIUS_EXECUTABLE}" CACHE FILEPATH
            "Path to the Cadius disk-image utility" FORCE)
    endif()
endif()
if(NOT CADIUS_EXECUTABLE OR NOT EXISTS "${CADIUS_EXECUTABLE}")
    message(FATAL_ERROR
        "Cadius was not found. Windows builds use tools/cadius.exe; on macOS/Linux, "
        "install Cadius or configure with -DCADIUS_EXECUTABLE=/path/to/cadius.")
endif()

file(MAKE_DIRECTORY "${STAGE_DIR}")

set(GAME_SOURCES
    "${SRC_DIR}/main.c"
    "${SRC_DIR}/audio.c"
    "${SRC_DIR}/disk.c"
    "${SRC_DIR}/mli.s")

set(GAME_HEADERS
    "${SRC_DIR}/apple2e.h"
    "${SRC_DIR}/art.h"
    "${SRC_DIR}/audio.h"
    "${SRC_DIR}/audio_table.h"
    "${SRC_DIR}/disk.h"
    "${SRC_DIR}/font8x8.h"
    "${SRC_DIR}/frames.h"
    "${SRC_DIR}/theme_psg.h")

set(LINK_SCRIPT "${SRC_DIR}/link1000.ld")

# ---------------------------------------------------------------------------
# Step 1: sprite art blob (regenerates src/art_table.h from src/art.h)
# ---------------------------------------------------------------------------
add_custom_command(
    OUTPUT "${STAGE_DIR}/art.blob" "${SRC_DIR}/art_table.h"
    COMMAND "${Python3_EXECUTABLE}" "${TOOLS_DIR}/mkart.py"
            --src-dir "${SRC_DIR}"
            --build-dir "${STAGE_DIR}"
    DEPENDS "${TOOLS_DIR}/mkart.py" "${SRC_DIR}/art.h"
    COMMENT "Packing sprite art -> art.blob"
    VERBATIM)

# ---------------------------------------------------------------------------
# Step 2: the two 6502 binaries (Slot 2 at $C200, Slot 4 at $C400)
# ---------------------------------------------------------------------------
# src/link1000.ld sizes the zero page as $22..$BE -- 157 bytes -- because it
# starts the imaginary registers at $02 and leaves $C0-$FF to the monitor.
# The stock apple2 platform config passes -mlto-zp=160, which overflows that
# region by exactly 3 bytes, so cap the compiler's zero-page budget to match
# the linker script. Keep this in sync with the zp MEMORY entry in link1000.ld.
set(MOS_LTO_ZP 157 CACHE STRING
    "Zero-page bytes available to the compiler; must match zp LENGTH in link1000.ld")

# Target the 65C02, not the base 6502. This restricts the game to 65C02 hosts:
# Enhanced Apple IIe, IIgs and Laser 128. Apple II+ and the original
# non-enhanced IIe are 6502 machines and are NOT supported.
set(MOS_CPU "mos65c02" CACHE STRING
    "Target CPU. mos65c02 (Enhanced IIe / IIgs / Laser 128).")
message(STATUS "target cpu   : ${MOS_CPU}")

function(add_mos_binary out_name vera_base)
    add_custom_command(
        OUTPUT "${STAGE_DIR}/${out_name}"
        COMMAND "${MOS_CLANG}"
                -Oz
                -mcpu=${MOS_CPU}
                -T "${LINK_SCRIPT}"
                -mlto-zp=${MOS_LTO_ZP}
                -DUSE_PSG_THEME
                -DVERA_BASE=${vera_base}
                -o "${STAGE_DIR}/${out_name}"
                ${GAME_SOURCES}
        DEPENDS ${GAME_SOURCES} ${GAME_HEADERS} "${LINK_SCRIPT}"
                "${SRC_DIR}/art_table.h"
        COMMENT "Compiling ${out_name} (VERA_BASE=${vera_base})"
        VERBATIM)
endfunction()

add_mos_binary(main.bin  0xC200)
add_mos_binary(main4.bin 0xC400)

# TPILOT.SYSTEM — ProDOS SYS loader (stock apple2 link at $2000, no BIN header).
add_custom_command(
    OUTPUT "${STAGE_DIR}/tpilot.sys"
    COMMAND "${MOS_CLANG}"
            -Oz
            -mcpu=${MOS_CPU}
            -o "${STAGE_DIR}/tpilot.sys"
            "${SRC_DIR}/loader.c"
            "${SRC_DIR}/loader.s"
            "${SRC_DIR}/mli.s"
    DEPENDS "${SRC_DIR}/loader.c" "${SRC_DIR}/loader.s" "${SRC_DIR}/mli.s"
    COMMENT "Compiling tpilot.sys (ProDOS SYS loader)"
    VERBATIM)

# Game image is loaded at $0800 by TPILOT.SYSTEM. Must stay below $B800 so the
# MLI disk window ($B800), C stack ($BE00) and ProDOS global page ($BF00)
# remain intact.
option(TPV_STRICT_SIZE "Fail the build when a binary crosses the $B800 ceiling" OFF)
set(_size_args "")
if(TPV_STRICT_SIZE)
    set(_size_args --strict)
endif()

add_custom_command(
    OUTPUT "${STAGE_DIR}/size.checked"
    COMMAND "${Python3_EXECUTABLE}" "${TOOLS_DIR}/check_size.py"
            ${_size_args}
            "${STAGE_DIR}/main.bin" "${STAGE_DIR}/main4.bin"
    COMMAND "${CMAKE_COMMAND}" -E touch "${STAGE_DIR}/size.checked"
    DEPENDS "${TOOLS_DIR}/check_size.py"
            "${STAGE_DIR}/main.bin" "${STAGE_DIR}/main4.bin"
    COMMENT "Checking binaries fit below $B800"
    VERBATIM)

# ---------------------------------------------------------------------------
# Step 3: disk images
# ---------------------------------------------------------------------------
add_custom_command(
    OUTPUT "${DISKS_DIR}/TimePilot-IIvera.hdv"
    COMMAND "${Python3_EXECUTABLE}" "${TOOLS_DIR}/build_hdv.py"
            --src-dir "${SRC_DIR}"
            --assets-dir "${ASSETS_DIR}"
            --build-dir "${STAGE_DIR}"
            --out-dir "${DISKS_DIR}"
            --cadius-path "${CADIUS_EXECUTABLE}"
    DEPENDS "${TOOLS_DIR}/build_hdv.py"
            "${CADIUS_EXECUTABLE}"
            "${ASSETS_DIR}/prodos-system/PRODOS#FF0000"
            "${ASSETS_DIR}/prodos-system/CLOCK.SYSTEM#FF0000"
            "${ASSETS_DIR}/pcm.blob"
            "${STAGE_DIR}/art.blob"
            "${STAGE_DIR}/tpilot.sys"
            "${STAGE_DIR}/main.bin" "${STAGE_DIR}/main4.bin"
            "${STAGE_DIR}/size.checked"
    COMMENT "Building 800KB ProDOS hard disk image"
    VERBATIM)

add_custom_command(
    OUTPUT "${DISKS_DIR}/TimePilot-IIvera-D1.po"
           "${DISKS_DIR}/TimePilot-IIvera-D2.po"
    COMMAND "${Python3_EXECUTABLE}" "${TOOLS_DIR}/build_disk.py"
            --src-dir "${SRC_DIR}"
            --assets-dir "${ASSETS_DIR}"
            --build-dir "${STAGE_DIR}"
            --out-dir "${DISKS_DIR}"
            --cadius-path "${CADIUS_EXECUTABLE}"
    DEPENDS "${TOOLS_DIR}/build_disk.py"
            "${CADIUS_EXECUTABLE}"
            "${ASSETS_DIR}/prodos-system/PRODOS#FF0000"
            "${ASSETS_DIR}/pcm.blob"
            "${STAGE_DIR}/art.blob"
            "${STAGE_DIR}/tpilot.sys"
            "${STAGE_DIR}/main.bin" "${STAGE_DIR}/main4.bin"
            "${STAGE_DIR}/size.checked"
    COMMENT "Building dual 140KB ProDOS floppy images"
    VERBATIM)

add_custom_target(disks ALL
    DEPENDS "${DISKS_DIR}/TimePilot-IIvera.hdv"
            "${DISKS_DIR}/TimePilot-IIvera-D1.po"
            "${DISKS_DIR}/TimePilot-IIvera-D2.po")

# ---------------------------------------------------------------------------
# Editor support
# ---------------------------------------------------------------------------
# clangd needs the cross-compiler's include paths. Custom commands produce no
# compile_commands.json, so generate compile_flags.txt at configure time with
# the SDK path resolved on THIS machine. The file is git-ignored precisely
# because it contains absolute, machine-local paths.
file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/compile_flags.txt"
"-I\n${LLVM_MOS_SDK}/mos-platform/${MOS_PLATFORM}/include\n\
-I\n${LLVM_MOS_SDK}/mos-platform/common/include\n\
-I\n${SRC_DIR}\n\
-D__MOS__\n\
-DVERA_BASE=0xC200\n")
