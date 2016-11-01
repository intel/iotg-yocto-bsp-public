FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kernel_ipu.scc"

SRCREV_machine_corei7-64-intel-common = "${@bb.utils.contains('KERNEL_FEATURES', 'leafhill', 'fc5acb0869b95bdc2f9827278b75d6554cebac90', '9195020e5747fba069c19996fab079931584a7fb', d)}"
SRCREV_meta_corei7-64-intel-common = "3c3197e65b6f2f5514853c1fe78ae8ffc131b02c"

KERNEL_EXTRA_ARGS = "EXTRA_CFLAGS="-D_FORTIFY_SOURCE=2 -Wformat -O2 -Wformat-security""
