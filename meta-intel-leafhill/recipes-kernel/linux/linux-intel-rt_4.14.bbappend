FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://leafhill.scc \
    ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

SRCREV_machine = "34008f912dbd672959f4f0ef166c4b33fefa22ff"
LINUX_VERSION = "4.14.93-rt53"

# Enable i2c-dev autoload
INTEL_COMMON_AUTOLOAD += "i2c-dev"
