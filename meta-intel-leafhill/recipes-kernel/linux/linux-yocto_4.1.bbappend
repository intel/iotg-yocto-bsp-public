FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kernel_ipu.cfg"

SRCREV_machine_corei7-64-intel-common ?= "${@bb.utils.contains('KERNEL_FEATURES', 'leafhill', 'fc5acb0869b95bdc2f9827278b75d6554cebac90', '9195020e5747fba069c19996fab079931584a7fb', d)}"
SRCREV_meta_corei7-64-intel-common = "6ba3fd1c82437764d5a31f31820d9db287f7dcd9"
