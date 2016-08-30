inherit kernel
require recipes-kernel/linux/linux-yocto.inc

SUMMARY = "Linux Kernel for enabling Intel Apollo Lake-i"

SRC_URI = "git://github.com/01org/iotg-yocto-linux-public.git;protocol=ssh;branch=e3900/master;name=machine"

# Linux Kernel Config Fragments
SRC_URI += "file://intel-corei7-64.cfg"
SRC_URI += "file://generic.scc"

SRC_URI_append_intel-corei7-64 = " file://legacy_hda.scc"
SRC_URI_append_intel-corei7-64-cavs-hda = " file://cavs_hda.scc"
SRC_URI_append_intel-corei7-64-cavs-ssp = " file://cavs_ssp.scc"

# Latest source commit for target machine
SRCREV = "41fc98f785ad56f0df1b85ac039bd5e391697842"

LINUX_VERSION ?= "4.1.27"
LINUX_VERSION_EXTENSION = "apollolake"

PR = "r0"
PV = "${LINUX_VERSION}+${LINUX_VERSION_EXTENSION}-git${SRCPV}"

COMPATIBLE_MACHINE = "(intel-corei7-64|intel-corei7-64-cavs-hda|intel-corei7-64-cavs-ssp)"

KERNEL_EXTRA_ARGS = "EXTRA_CFLAGS="-D_FORTIFY_SOURCE=2 -Wformat -O2 -Wformat-security""
