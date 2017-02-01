FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://github.com/01org/TPM2.0-TSS.git;protocol=git;name=TPM2.0-TSS;destsuffix=TPM2.0-TSS \
	   file://ax_pthread.m4"

SRCREV = "47d560652f1ae28519323df61d69ec63bbf1a846"

PACKAGES += "${PN}-test"

do_install_append() {
        install -d ${D}${bindir}
        install -m 755 test/tpmtest/.libs/tpmtest ${D}${bindir}/tpmtest
}

FILES_${PN}-test = "${bindir}/tpmtest"
