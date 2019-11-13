SUMMARY = "Khronos OpenCL CLHPP"
LIC_FILES_CHKSUM = "file://${S}/LICENSE.txt;md5=7e4a01f0c56b39419aa287361a82df00"
LICENSE = "Khronos"

inherit pkgconfig cmake

DEPENDS = "opencl-headers ruby"

S = "${WORKDIR}/git"

SRC_URI = "gitsm://github.com/KhronosGroup/OpenCL-CLHPP.git;protocol=https"
SRCREV = "acd6972bc65845aa28bd9f670dec84cbf8b760f3"

EXTRA_OECMAKE = "-DCMAKE_INSTALL_PREFIX=/usr -DOPENCL_INCLUDE_DIR=/usr/include -DOPENCL_LIB_DIR=/usr/lib -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF"

ALLOW_EMPTY_${PN} = "1"
