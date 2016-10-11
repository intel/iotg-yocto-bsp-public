FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://git.yoctoproject.org/linux-yocto-4.1.git;name=machine;branch=${KBRANCH}; \
           git://github.com/anujm1/yocto-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=yocto-4.1;destsuffix=${KMETA}"

SRC_URI += "file://kernel-patch-integration.scc \
	    file://kernel_ipu.cfg"

SRCREV_meta_corei7-64-intel-common = "${AUTOREV}"
