FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

KMETA_BRANCH = "yocto-4.13"
SRCREV_machine = "33752cef64fae22e3089c2a8424f8999b0ec82d8"
SRCREV_meta = "71dec2980bdda27ba85714b756146c84cfdafeb7"
LINUX_VERSION = "4.14.36"
