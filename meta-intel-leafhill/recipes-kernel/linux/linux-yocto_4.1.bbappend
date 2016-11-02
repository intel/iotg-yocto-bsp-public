FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kernel_ipu.scc"

SRCREV_machine_corei7-64-intel-common = "${@bb.utils.contains('KERNEL_FEATURES', 'leafhill', '6e06dacda21b3de803e5ca03b8d14e1021861b30', '9195020e5747fba069c19996fab079931584a7fb', d)}"
SRCREV_meta_corei7-64-intel-common = "3c3197e65b6f2f5514853c1fe78ae8ffc131b02c"

KERNEL_EXTRA_ARGS = "EXTRA_CFLAGS="-D_FORTIFY_SOURCE=2 -Wformat -O2 -Wformat-security""
