cmake_minimum_required(VERSION 3.18)
set(LLVM_MOS_PLATFORM cx16)
find_package(llvm-mos-sdk REQUIRED)
project(llvm-mos-sdk-foo)

# This include specifies the project and version.
include("src/version.cmake.h")
project(time_pilot VERSION "${TIME_PILOT_VERSION}" LANGUAGES C)
message(STATUS "${PROJECT_NAME} version ${PROJECT_VERSION}")

# Files needed to create executable.
add_executable(
	${PROJECT_NAME}
	src/ai.c
	src/audio.c
	src/collide.c
	src/data.c
	src/draw.c
	src/erase.c
	src/game.c
	src/globals.c
	src/input.c
	src/main.c
	src/print.c
	src/screen.c
	src/text.c
	src/things.c
	src/ui.c
)

# Include directories needed to build.
target_include_directories(
	"${PROJECT_NAME}"
	PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/src
)
