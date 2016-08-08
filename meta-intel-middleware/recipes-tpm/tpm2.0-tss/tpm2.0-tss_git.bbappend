FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Make sure we fetch source from specific tag
SRC_URI = "git://github.com/01org/TPM2.0-TSS.git;protocol=git;tag=1.0-alpha_0;name=TPM2.0-TSS;destsuffix=TPM2.0-TSS \
	   file://ax_pthread.m4"

SRCREV = ""

PV = "${PVBASE}.${SRCPV}-tag1.0-alpha_0"
