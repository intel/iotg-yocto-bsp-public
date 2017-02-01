FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kernel-patch-integration.scc \
	    file://kernel_ipu.scc \
	    file://kernel_ish.scc \
	    file://kernel_io.scc"

SRCREV_meta_corei7-64-intel-common = "89785d2b18fa49233046125fddee8e161c8bec4d"

KERNEL_EXTRA_ARGS = "EXTRA_CFLAGS="-D_FORTIFY_SOURCE=2 -Wformat -O2 -Wformat-security""
