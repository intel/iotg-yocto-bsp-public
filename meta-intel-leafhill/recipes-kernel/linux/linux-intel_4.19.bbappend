FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

SRCREV_machine = "8e69644ab5b84be1400874ac1dbcb4389aa2412c"
LINUX_VERSION = "4.19.152"

# Enable i2c-dev autoload
INTEL_COMMON_AUTOLOAD += "i2c-dev"
