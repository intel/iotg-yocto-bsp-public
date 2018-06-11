SUMMARY = "Intel Dynamic Application Loader (DAL) Host Interface"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "git://github.com/01org/dynamic-application-loader-host-interface;protocol=https \
           file://0001-makefile-add-libdir-target-with-suffix.patch \
           file://0001-jhi-disable-MEI-driver-and-enable-KDI.patch \
           "

inherit cmake useradd systemd pkgconfig

SRCREV = "747cc592f8a18ba493faf9967c188ed21c5f18bc"

S = "${WORKDIR}/git"

DEPENDS += "util-linux libxml2 systemd"
RDEPENDS_${PN} += "bash"

USERADD_PACKAGES = "${PN}"
USERADD_PARAM_${PN} = "--system --home /dev/null --no-create-home --shell /bin/false -g mei jhi"

GROUPADD_PARAM_${PN} = "-g 880 mei"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "jhi.service"

EXTRA_OECMAKE = "-DCMAKE_SKIP_RPATH=ON \
                 ${@oe.utils.conditional("libdir", "/usr/lib64", "-DLIB_SUFFIX=64", "", d)} \
                 ${@oe.utils.conditional("libdir", "/usr/lib32", "-DLIB_SUFFIX=32", "", d)} \
                 "

do_install_append () {
        install -d ${D}${localstatedir}/lib/intel/dal/applet_repository

        chown -R jhi ${D}${localstatedir}/lib/intel/dal/applet_repository
        chgrp -R mei ${D}${localstatedir}/lib/intel/dal/applet_repository

        install -d ${D}${bindir}
        install -m 755 ${B}/bin_linux/smoketest ${D}${bindir}
        install -m 755 ${B}/bin_linux/bist ${D}${bindir}

        cp -r ${S}/test/smoketest/applets/* ${D}${localstatedir}/lib/intel/dal/applets/
}

PACKAGES += "${PN}-tests"

FILES_${PN}-dev = ""

FILES_${PN} = "\
                ${libdir} \
                ${sbindir} \
                ${sysconfdir}/jhi \
                ${systemd_unitdir} \
                ${localstatedir}/lib/intel/dal/applets/SpoolerApplet.dalp \
                ${localstatedir}/lib/intel/dal/applet_repository \
                "

FILES_${PN}-tests = "\
                     ${bindir} \
                     ${localstatedir}/lib/intel/dal/applets \
                     "
