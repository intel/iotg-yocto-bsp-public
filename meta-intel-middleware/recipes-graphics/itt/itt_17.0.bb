SUMMARY = "Intel® Single Event API"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://sea_itt_lib/Copyright.txt;md5=7d54dfc8860742fb06b9c5ad28f41fcd"

SRC_URI = " \
    git://github.com/intel/IntelSEAPI.git;protocols=https \
"

SRCREV="e44fcec85e98562614282efca524a14c54ea4cb7"

DEPENDS += "python cmake-native"
ALLOW_EMPTY_${PN} = "1"

S = "${WORKDIR}/git"

inherit pkgconfig

do_compile() {
     python ${S}/buildall.py --force_bits 64 -i
}

do_install() {
     install -d -m 755 ${D}${libdir} ${D}${includedir}
     install -m 644 ${S}/bin/*.a ${D}${libdir}
     install -m 644 ${S}/ittnotify/include/ittnotify.h ${D}${includedir}
}
