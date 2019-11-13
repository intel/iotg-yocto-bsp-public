FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

SRCREV_machine = "1a09b72d36b427a54dc6757acc200d4afe2c269a"
LINUX_VERSION = "4.19.80"

# Enable i2c-dev autoload
INTEL_COMMON_AUTOLOAD += "i2c-dev"
