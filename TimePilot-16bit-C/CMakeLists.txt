cmake_minimum_required(VERSION 3.16)
cmake_policy(SET CMP0091 NEW)

# Set default build-type (AKA the configuration in other IDEs).
set(CMAKE_BUILD_TYPE_INIT Release)

# Setup Release and Debug build-types (only).
# No reason to set CMAKE_CONFIGURATION_TYPES if it's not a multiconfig generator
# Also no reason mess with CMAKE_BUILD_TYPE if it's a multiconfig generator.
get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if (isMultiConfig)
	set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo" CACHE STRING "" FORCE)
else()
	if (NOT DEFINED CMAKE_BUILD_TYPE)
		message(STATUS "time_pilot -- Default to Release build.")
		set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose Build Type" FORCE)
	endif()
	message(STATUS "time_pilot -- Build type set to: ${CMAKE_BUILD_TYPE}")
	set_property(CACHE CMAKE_BUILD_TYPE PROPERTY HELPSTRING "Choose Build Type")

	# Set the valid options for cmake-gui drop-down list. CMake tools for vscode does not (but should) respect this.
	set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release")
endif()

# This include specifies the project and version.
include("src/version.cmake.h")
project(time_pilot VERSION "${TIME_PILOT_VERSION}" LANGUAGES C)
message(STATUS "${PROJECT_NAME} version ${PROJECT_VERSION}")

find_package(OpenAL CONFIG REQUIRED)
find_package(FreeALUT CONFIG REQUIRED)
if (APPLE)
	find_package(OpenGL REQUIRED)
	find_library(COCOA_LIBRARY Cocoa)
endif ()

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
	src/tigr.c
	src/ui.c
)

# Include directories needed to build.
target_include_directories(
	"${PROJECT_NAME}"
	PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/src
		${OPENAL_INCLUDE_DIRS}
		${ALUT_INCLUDE_DIRS}
)

target_compile_definitions(
	${PROJECT_NAME}
	PRIVATE
		ARCHITECTURE_X64
		$<$<CONFIG:Debug>:CONFIG_DEBUG>
		$<$<CONFIG:Release>:CONFIG_RELEASE>
		$<$<CXX_COMPILER_ID:MSVC>:_CRT_SECURE_NO_DEPRECATE>
		$<$<PLATFORM_ID:Windows>:PLATFORM_WINDOWS>
		$<$<PLATFORM_ID:Linux>:PLATFORM_LINUX>
)

# Set compiler option flags based on specific compiler and configuration.
target_compile_options(
	${PROJECT_NAME}
	PRIVATE
		# MSVC compiler.
		$<$<CXX_COMPILER_ID:MSVC>:/W2 /GS /Gy /Zc:wchar_t /Gm- /Zc:inline /fp:precise /WX- /Zc:forScope /Gd /FC>

		# Clang compiler.
		$<$<CXX_COMPILER_ID:Clang>:-Wno-switch>

		# GNU compiler.
		$<$<CXX_COMPILER_ID:GNU>:-Wno-unused-result>
		$<$<CXX_COMPILER_ID:GNU>:-Wno-multichar>

		# Clang and GNU.
		$<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:-Wno-format-security>

		$<$<AND:$<CONFIG:Debug>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:-O0>
		$<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:MSVC>>:/Od>
		$<$<AND:$<CONFIG:Release>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:-O2>
		$<$<AND:$<CONFIG:Release>,$<CXX_COMPILER_ID:MSVC>>:/O2>
)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)

# This is how you set things like CMAKE_DEBUG_POSTFIX for a target.
set_target_properties(
	${PROJECT_NAME}
	PROPERTIES
	# DEBUG_POSTFIX "d"												# Add a 'd' before the extension for debug builds.
	MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>"	# Use multithreaded or multithreaded-debug runtime on windows.
)

# Dependencies.
target_link_libraries(
	${PROJECT_NAME}
	PRIVATE
		${OPENAL_LIBRARY}
		FreeALUT::alut

		# Windows
		$<$<PLATFORM_ID:Windows>:opengl32.lib>
		$<$<PLATFORM_ID:Windows>:gdi32.lib>
		$<$<PLATFORM_ID:Windows>:XInput.lib>

		# macOS
		$<$<PLATFORM_ID:Darwin>:${OPENGL_LIBRARY}>
		$<$<PLATFORM_ID:Darwin>:${COCOA_LIBRARY}>

		# Linux
		$<$<PLATFORM_ID:Linux>:GLU>
		$<$<PLATFORM_ID:Linux>:GL>
		$<$<PLATFORM_ID:Linux>:X11>
		$<$<PLATFORM_ID:Linux>:m>
		$<$<PLATFORM_ID:Linux>:stdc++>
		$<$<PLATFORM_ID:Linux>:dl>
)

if (MSVC OR _MSVC)
	# Add the line below for a Windows GUI
	# target_link_options(${PROJECT_NAME} PRIVATE "/ENTRY:mainCRTStartup")
	if (CMAKE_BUILD_TYPE MATCHES Debug)
		target_link_options(${PROJECT_NAME} PRIVATE "/NODEFAULTLIB:LIBCMT.lib")
	endif()
endif()

# Install
set(TIME_PILOT_INSTALL_DIR "${CMAKE_BINARY_DIR}/..")
message(STATUS "time_pilot -- ${PROJECT_NAME} will be installed to ${TIME_PILOT_INSTALL_DIR}")

# Installation.
install(
	TARGETS ${PROJECT_NAME}
	RUNTIME DESTINATION "${TIME_PILOT_INSTALL_DIR}"
)
