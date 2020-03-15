SUMMARY  = "OpenCL API Headers"
DESCRIPTION = "OpenCL compute API headers from Khronos Group"
LICENSE = "Khronos"
LIC_FILES_CHKSUM = "file://LICENSE;md5=dcefc90f4c3c689ec0c2489064e7273b"
SECTION = "base"

SRC_URI = "git://github.com/KhronosGroup/OpenCL-Headers"
SRCREV = "c60b351ca632da6670d78afdb3c365604efb8e89"

ALLOW_EMPTY_${PN} = "1"
S = "${WORKDIR}/git"

PROVIDES += "virtual/opencl-headers"

PV = "git${SRCPV}"

do_install() {
    install -d ${D}${includedir}/CL/
    install -m 0644 ${S}/CL/*.h ${D}${includedir}/CL
}
