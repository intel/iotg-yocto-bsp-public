FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://github.com/01org/TPM2.0-TSS.git;protocol=git;name=TPM2.0-TSS;destsuffix=TPM2.0-TSS \
	   file://ax_pthread.m4"

SRCREV = "4271dd6a863b9fa721c954367dc6993ec8cad519"

PACKAGES += "${PN}-test"

do_install_append() {
        install -d ${D}${bindir}
        install -m 755 test/tpmtest/.libs/tpmtest ${D}${bindir}/tpmtest
}

FILES_${PN}-test = "${bindir}/tpmtest"
