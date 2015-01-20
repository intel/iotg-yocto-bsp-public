SUMMARY = "Linux kernel drivers for all Intel(R) Ethernet adapters and LOMs (LAN On Motherboard)"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=a7a92f0d64f7ec4a99ee76cc7921ff93"

SRC_URI = "http://downloads.sourceforge.net/project/e1000/${PN}/${PV}/${PN}.tar.gz;subdir=${PN}-${PV} \
           file://0001-makefile-make-sure-we-compile-against-the-right-kern.patch \
           "

SRC_URI[md5sum] = "fb6a2a4dc122d39070fcb06985c97a05"
SRC_URI[sha256sum] = "8cb19f3bfe040100a13bb2d05cb2b54f2b259e55cef23f8cc5aa6f2f31e98bec"

inherit module

export NALDIR = "${S}"
export KERNEL_BUILDDIR = "${STAGING_KERNEL_BUILDDIR}"

do_compile() {
        cd ${S}/src/linux/driver
        oe_runmake
}

do_install() {
        cd ${S}/src/linux/driver
        oe_runmake INSTALL_MOD_PATH=${D} INSTALL_MOD_DIR="kernel/drivers/net" install
}
