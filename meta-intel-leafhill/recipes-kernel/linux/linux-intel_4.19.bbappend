FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

SRCREV_machine = "4e145fffdc2a5cfca90f90608f8ce4358b770bd9"
LINUX_VERSION = "4.19.130"

# Enable i2c-dev autoload
INTEL_COMMON_AUTOLOAD += "i2c-dev"
