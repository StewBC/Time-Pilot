# This is how to make this go:
# In the path replace /home/swessels/develop/external/github/ with the appropriate prefix
# Manual:
# mkdir build
# cd build
# cmake .. -DCMAKE_TOOLCHAIN_FILE=/home/swessels/develop/external/github/Retro68-build/toolchain/m68k-apple-macos/cmake/retro68.toolchain.cmake -DARGS_CREATOR=SWTP
# SWTP is Stefan Wessels Time Pilot so this is whatever unique ID of choice and matches the resource bundle

#
# Using VS Code:
# Settings, Extensions, Cmake Tools, Cmake: Configure Args (and add both)
# -DCMAKE_TOOLCHAIN_FILE=/home/swessels/develop/external/github/Retro68-build/toolchain/m68k-apple-macos/cmake/retro68.toolchain.cmake
# -DARGS_CREATOR=SWTP
# Generator:
# Unix Makefiles

cmake_minimum_required(VERSION 3.16)
cmake_policy(SET CMP0091 NEW)

# This include specifies the project and version.
project("Time.Pilot" VERSION "1.0" LANGUAGES C)
message(STATUS "${PROJECT_NAME} version ${PROJECT_VERSION}")

# This does not set the creator code as I expexted.  I found I had to manually edit the file:
# build/CMakeFiles/Time.Pilot_APPL.dir/build.make and look for -t APPL -c ???? and
# change the ???? to SWTP (Or whatever owner/creator ID you choose in the resource file)
set(ARGS_CREATOR "SWTP")

# Files needed to create executable.
add_application(
	"${PROJECT_NAME}"
	src/ai.c
	src/audio.c
	src/collide.c
	src/data.c
	src/draw.c
	src/erase.c
	src/game.c
	src/globals.c
	src/input.c
	src/mac.c
	src/main.c
	src/print.c
	src/screen.c
	src/sprite.c
	src/text.c
	src/things.c
	src/ui.c
	src/update.c
	src/audio.r
	src/timepilot.r
	src/tpr.r
)

# Set a dependency for timepilot.r on tpr.r
set_source_files_properties(
    ${CMAKE_BINARY_DIR}/timepilot.r.rsrc.bin
    PROPERTIES OBJECT_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/tpr.r
)

set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_OPTIONS -ffunction-sections)
if(CMAKE_SYSTEM_NAME MATCHES Retro68)
    set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-Wl,-gc-sections -Wl,--mac-strip-macsbug")
else()
    set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "-Wl,-gc-sections")
endif()
