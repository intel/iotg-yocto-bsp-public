SUMMARY = "Linux kernel drivers for all Intel(R) Ethernet adapters and LOMs (LAN On Motherboard)"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=5fc7a973843b32313aec467063cf17fb"

SRC_URI = "http://downloads.sourceforge.net/project/e1000/${PN}/${PV}/${PN}.tar.gz;subdir=${PN}-${PV} \
           file://0001-makefile-make-sure-we-compile-against-the-right-kern.patch \
           "

DEPENDS += "flex-native bison-native bc-native"

SRC_URI[md5sum] = "c60b39e0b4e9ba35d445cfca938999a9"
SRC_URI[sha256sum] = "2ce694854aa73e91269dff72b56616152096acacb9ec3900c5bf3be78db25af1"

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

do_make_scripts_append(){
        make CC="${KERNEL_CC}" LD="${KERNEL_LD}" AR="${KERNEL_AR}" \
        -C ${STAGING_KERNEL_DIR} O=${STAGING_KERNEL_BUILDDIR} prepare
}
