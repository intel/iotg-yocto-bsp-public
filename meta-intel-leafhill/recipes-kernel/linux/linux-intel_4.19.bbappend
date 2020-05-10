FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

SRCREV_machine = "8ef641c89e3c2ff303eb362a7b77760dd2ed7e69"
LINUX_VERSION = "4.19.106"

# Enable i2c-dev autoload
INTEL_COMMON_AUTOLOAD += "i2c-dev"
