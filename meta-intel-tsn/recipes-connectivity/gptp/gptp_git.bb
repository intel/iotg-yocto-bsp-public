SUMMARY = "gptp"
HOMEPAGE = "https://github.com/AVnu/gptp"
AUTHOR = "Abdul Muttalib, Abdul Arif"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "\
	file://LICENSE;md5=b3e2a6e620763288bcbc3190f6cb1704 \
	"
RDEPENDS_${PN} = "bash sed"

inherit useradd

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "ptp"

SRC_URI = "\
	gitsm://github.com/AVnu/gptp.git;protocol=https;nobranch=1;name=gptp \
	file://0001-gPTP-use-standard-kernel-interface-to-start-stop-PPS.patch \
	"

SRCREV_gptp = "8ca230fc23593235e0692b779f903835687e3ad8"

SECURITY_CFLAGS_pn-${PN} = "${SECURITY_NO_PIE_CFLAGS}"
S = "${WORKDIR}/git"

FILES_${PN} += "${bindir} ${libdir} /opt/gptp/*"
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
	cd linux/build
	oe_runmake all ARCH=I210
}

do_install() {
	# Copy executables to /usr/bin
	install -d ${D}${bindir}
	install -m 0755 linux/build/obj/daemon_cl ${D}${bindir}

	# Copy clean source code to /opt/openavnu
	install -d ${D}${base_prefix}/opt/gptp/
	cp -r ${WORKDIR}/git_clean/* ${D}${base_prefix}/opt/gptp/
}
