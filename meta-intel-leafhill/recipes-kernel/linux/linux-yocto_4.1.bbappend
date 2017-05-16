FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kernel-patch-integration.scc \
	    file://kernel_ipu.scc \
	    file://kernel_ish.scc \
	    file://kernel_io.scc"

SRCREV_meta_corei7-64-intel-common = "46b3153a39950b3542a99486bd964ab2ed65aeb4"

KERNEL_EXTRA_ARGS = "EXTRA_CFLAGS="-D_FORTIFY_SOURCE=2 -Wformat -O2 -Wformat-security""
