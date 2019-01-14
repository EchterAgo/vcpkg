include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO artyom-beilis/nowide
    REF ec9672b6cd883193be8451ee4cedab593420ae19
    SHA512 db660843a4c5d3629a254464e74c92f175bc35890731e7c3dded8941265c7259b1bb2d7358f3b26722c88362e8733861ca97ddc3aa5009d2fda847636dece73d
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
