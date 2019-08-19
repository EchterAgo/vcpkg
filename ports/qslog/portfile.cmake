include(vcpkg_common_functions)

vcpkg_from_bitbucket(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ago/qslog
    REF e3a70d2dd806d23b66ffde9adca62e5425d1c19f
    SHA512 759e6c390d7feb91343c6d512f678bacb1f03e47d29040d3068021feafb08a9200a5d5c02aaf53448fcb5659574dc06e16893178afa8253933632d4908a9d370
    HEAD_REF master
)

set(DEBUG_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
set(RELEASE_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DQS_LOG_BUILD_WINDOW=ON
        -DCONFIG_INSTALL_PATH=share/QsLog
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
