include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO EchterAgo/robot
    REF 65174ac4bb68b47ec35139285260f6c3ebf1ed4d
    SHA512 a4e27b2db5564fa67af0dfc2de49bc559355a5b614c574370e33b5889c4ff9bf84d33c71fc1426caa46b5db9d31ace7c39d142f28bb1af0c48e167c2f46d426e
    HEAD_REF master
)

if(NOT VCPKG_CMAKE_SYSTEM_NAME)
    # Windows is built using Visual C++

    if(VCPKG_PLATFORM_TOOLSET STREQUAL "v140")
        set(VS_VERSION "vs15")
    elseif(VCPKG_PLATFORM_TOOLSET STREQUAL "v141")
        set(VS_VERSION "vs17")
    elseif(VCPKG_PLATFORM_TOOLSET STREQUAL "v142")
        set(VS_VERSION "vs19")
    else()
        message(FATAL_ERROR "Unsupported platform toolset.")
    endif()

    if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
        set(REL_CFG "DLL")
        set(DBG_CFG "DLLd")
    elseif(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
        set(REL_CFG "LIB")
        set(DBG_CFG "LIBd")
    else()
        message(FATAL_ERROR "Unsupported library linkage.")
    endif()

    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
        set(PLATFORM "Win32")
    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
        set(PLATFORM "Win64")
    else()
        message(FATAL_ERROR "Unsupported target architecture.")
    endif()

    vcpkg_install_msbuild(
        SOURCE_PATH ${SOURCE_PATH}
        PROJECT_SUBPATH Robot.${VS_VERSION}.sln
        RELEASE_CONFIGURATION ${REL_CFG}
        DEBUG_CONFIGURATION ${DBG_CFG}
        TARGET Robot
        PLATFORM ${PLATFORM})
else()
    vcpkg_configure_cmake(
        SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR}
        PREFER_NINJA
        OPTIONS
            -DSOURCE_PATH=${SOURCE_PATH}
            -DLIBRARY_LINKAGE:STRING=${VCPKG_LIBRARY_LINKAGE}
    )

    vcpkg_install_cmake()

    file(INSTALL ${SOURCE_PATH}/Release/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
    file(INSTALL ${SOURCE_PATH}/Debug/lib/ DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
endif()

file(COPY ${SOURCE_PATH}/Source/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/Robot FILES_MATCHING PATTERN "*.h")
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
