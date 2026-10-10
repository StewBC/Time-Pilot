# cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=gcc-850.toolchain.cmake
# cmake --build build
cmake_minimum_required(VERSION 3.20)

set(APPNAME tpilot)
project("${APPNAME}" VERSION "1.0" LANGUAGES C)

add_executable(${APPNAME}.elf
	src/ai.c
	src/audio.c
	src/audio_data.c
	src/collide.c
	src/data.c
	src/draw.c
	src/erase.c
	src/game.c
	src/globals.c
	src/input.c
	src/archie.c
	src/main.c
	src/print.c
	src/screen.c
	src/sprite.c
	src/text.c
	src/things.c
	src/tpr.c
	src/ui.c
	src/update.c
)

# Sample Makefile adds -O2 on top of config.mk defaults
target_compile_options(${APPNAME}.elf PRIVATE
    -O2
)

target_include_directories(${APPNAME}.elf SYSTEM PRIVATE
    "${ARCHIESDK_ROOT}/tools/lib/gcc/arm-archie/8.5.0/include"
    "${ARCHIESDK_ROOT}/tools/lib/gcc/arm-archie/8.5.0/include-fixed"
    "${ARCHIESDK_ROOT}/SDK/include"
)

target_link_directories(${APPNAME}.elf PRIVATE
    "${ARCHIESDK_LIBRARY_DIR}"
)

# Extra libraries would go here if needed later
target_link_libraries(${APPNAME}.elf PRIVATE OSLib32)

set(ARCHIE_BINARY "${CMAKE_CURRENT_BINARY_DIR}/${APPNAME},ff8")

add_custom_command(
    OUTPUT "${ARCHIE_BINARY}"
    COMMAND "${ARCHIESDK_OBJCOPY}" -O binary
            "$<TARGET_FILE:${APPNAME}.elf>"
            "${ARCHIE_BINARY}"
    DEPENDS ${APPNAME}.elf
    VERBATIM
    COMMENT "Generating ${APPNAME},ff8"
)

add_custom_target(${APPNAME}_image ALL
    DEPENDS "${ARCHIE_BINARY}"
)

# Optional copy step, matching the Makefile idea.
if(DEFINED ENV{ARCHIECOPYPATH} AND NOT "$ENV{ARCHIECOPYPATH}" STREQUAL "")
    add_custom_command(
        TARGET ${APPNAME}_image POST_BUILD
        COMMAND "${CMAKE_COMMAND}" -E copy_if_different
                "${ARCHIE_BINARY}"
                "$ENV{ARCHIECOPYPATH}/${APPNAME},ff8"
        VERBATIM
        COMMENT "Copying ${APPNAME},ff8 to ARCHIECOPYPATH"
    )
endif()

# Use the same headers and target flags as the game build.
add_custom_target(asm
    COMMAND "${CMAKE_C_COMPILER}"
            -mno-thumb-interwork -O2 -S
            -I "${ARCHIESDK_ROOT}/SDK/include"
            -I "${CMAKE_CURRENT_SOURCE_DIR}/src"
            "${CMAKE_CURRENT_SOURCE_DIR}/src/main.c"
            -o "${CMAKE_CURRENT_BINARY_DIR}/main.s"
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    COMMENT "Generating main.s"
    VERBATIM
)

