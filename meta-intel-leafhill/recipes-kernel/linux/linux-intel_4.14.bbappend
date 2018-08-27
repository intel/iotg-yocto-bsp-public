FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

SRCREV_machine = "c89f345c45c43fbb4c51bf975d3ddcb29cc4f723"
LINUX_VERSION = "4.14.52"

# Enable i2c-dev autoload
INTEL_COMMON_AUTOLOAD += "i2c-dev"

do_shared_workdir_append() {
       oe_runmake CC="${KERNEL_CC}" LD="${KERNEL_LD}" AR="${KERNEL_AR}" \
               -C ${STAGING_KERNEL_DIR} O=${STAGING_KERNEL_BUILDDIR} scripts prepare
}
