cmake_minimum_required(VERSION 3.9)
project(robot)

if(SOURCE_PATH)
    set(CMAKE_SOURCE_DIR ${SOURCE_PATH})
endif()

include(ProcessorCount)
ProcessorCount(PROCS)

include(GNUInstallDirs)

find_program(MAKE make)
if(NOT MAKE)
    message(FATAL_ERROR "MAKE not found")
endif()

if(NOT PROCS EQUAL 0)
    set(MAKE_FLAGS -j${PROCS})
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(MODE "debug")
    set(LIBNAME "libRobotd")
else()
    set(MODE "release")
    set(LIBNAME "libRobot")
endif()

add_custom_target(robot ALL COMMAND ${MAKE} ${MAKE_FLAGS} mode=${MODE} build WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/)

install(FILES ${CMAKE_SOURCE_DIR}/Binaries/Linux/${LIBNAME}.a DESTINATION ${CMAKE_SOURCE_DIR}/${CMAKE_BUILD_TYPE}/lib/)
