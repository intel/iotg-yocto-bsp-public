SUMMARY = "Intel Dynamic Application Loader (DAL) Host Interface"
DESCRIPTION = "A daemon and libraries which allow user space applications \
to install Java applets on DAL FW and communicate with them"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=833126f14614a3276708a4d7c9734645"

SRC_URI = "git://github.com/intel/dynamic-application-loader-host-interface.git;protocol=https"

inherit cmake useradd systemd pkgconfig

SRCREV = "44d64cdbcf7eacd397ce9c18b9094514b62093e6"

S = "${WORKDIR}/git"

DEPENDS += "util-linux libxml2"
DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
RDEPENDS_${PN} += "bash"

USERADD_PACKAGES = "${PN}"
USERADD_PARAM_${PN} = "--system --no-create-home --shell /bin/false -g mei jhi"

GROUPADD_PARAM_${PN} = "-g 880 mei"

SYSTEMD_PACKAGES = "${PN}"

COMPATIBLE_HOST_libc-musl = 'null'

# systemd is the default so they are installed when sysvinit is not selected as INIT_SYSTEM
EXTRA_OECMAKE = "-DCMAKE_SKIP_RPATH=ON \
                 -DINIT_SYSTEM=${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'SysVinit', 'systemd', d)} \
                 -DAPPLETS_DIR=${libdir}/dal/applets \
                 -DAPP_REPO_DIR=${localstatedir}/cache/dal/applet_repository \
                 "

do_install_append () {
        install -d ${D}${localstatedir}/cache/dal/applet_repository

        chown -R jhi ${D}${localstatedir}/cache/dal/applet_repository
        chgrp -R mei ${D}${localstatedir}/cache/dal/applet_repository

        install -d ${D}${bindir}
        install -m 755 ${B}/bin_linux/smoketest ${D}${bindir}
        install -m 755 ${B}/bin_linux/bist ${D}${bindir}

        install -d ${D}${libdir}/dal/applets
        cp -r ${S}/test/smoketest/applets/* ${D}${libdir}/dal/applets/
}

PACKAGES =+ "${PN}-test"

FILES_${PN}-dev = ""

FILES_${PN} = "\
                ${sbindir} \
                ${sysconfdir} \
                ${libdir} \
                ${libdir}/dal/applets \
                ${nonarch_libdir}/tmpfiles.d \
                ${systemd_system_unitdir} \
                ${localstatedir}/cache/dal/applet_repository \
                "

FILES_${PN}-test = "\
                     ${bindir} \
                     ${libdir}/dal/applets \
                     "
