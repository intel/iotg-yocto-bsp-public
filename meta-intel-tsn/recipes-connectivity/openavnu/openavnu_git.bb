SUMMARY = "OpenAvnu"
HOMEPAGE = "https://github.com/AVnu/OpenAvnu"
AUTHOR = "Quast, Johannes"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "\
	file://lib/igb_avb/lib/LICENSE;md5=9bc783ca40be823a8b237df5eed80fc4 \
	file://daemons/LICENSE;md5=81ccd62d4bc28bafc5e1a2576536b927 \
	file://examples/LICENSE;md5=81ccd62d4bc28bafc5e1a2576536b927 \
	"
RDEPENDS_${PN} = "bash sed"
DEPENDS = "pciutils libpcap libsndfile1 jack"

inherit useradd

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "ptp"

SRC_URI = "\
	gitsm://github.com/AVnu/OpenAvnu.git;protocol=https;nobranch=1 \
	"

SRCREV = "8fa80d1de59fbef14c8d0e80d8d9a62679a6182a"
PV = "1.1-git${SRCPV}"
PR = "r0"

SECURITY_CFLAGS_pn-${PN} = "${SECURITY_NO_PIE_CFLAGS}"
S = "${WORKDIR}/git"

FILES_${PN} += "${bindir} ${libdir} /opt/openavnu/*"
TARGET_CC_ARCH += "${LDFLAGS}"

# Force staticdev (*.a) to be in ${PN} and not ${PN}-staticdev
FILES_${PN}-staticdev = ""
INSANE_SKIP_${PN} = "staticdev"

PARALLEL_MAKE = ""

do_unpack_extra(){
	# make a clean copy of source code for installation later
	cp ${WORKDIR}/git ${WORKDIR}/git_clean -r
	rm -rf ${WORKDIR}/git_clean/.git*
	rm -rf ${WORKDIR}/git_clean/.pc
}
addtask unpack_extra after do_unpack before do_patch

do_compile() {
	oe_runmake lib
	oe_runmake daemons_all ARCH=I210
	oe_runmake examples_all
}

do_install() {
	# Copy executables to /usr/bin
	install -d ${D}${bindir}

	install -m 0755 daemons/maap/linux/build/maap_daemon ${D}${bindir}
	install -m 0755 daemons/mrpd/mrpctl ${D}${bindir}
	install -m 0755 daemons/mrpd/mrpd ${D}${bindir}
	install -m 0755 examples/mrp_client/mrpl ${D}${bindir}
	install -m 0755 examples/mrp_client/mrpq ${D}${bindir}
	install -m 0755 examples/mrp_client/mrpValidate ${D}${bindir}
	install -m 0755 examples/simple_listener/simple_listener ${D}${bindir}

	# Copy clean source code to /opt/openavnu
	install -d ${D}${base_prefix}/opt/openavnu/
	cp -r ${WORKDIR}/git_clean/* ${D}${base_prefix}/opt/openavnu/
}
