FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

SRCREV_machine = "8730ef329298cdc0347b528fe8c2339b48d963f8"
LINUX_VERSION = "4.14.67"

# Enable i2c-dev autoload
INTEL_COMMON_AUTOLOAD += "i2c-dev"

do_shared_workdir_append() {
       oe_runmake CC="${KERNEL_CC}" LD="${KERNEL_LD}" AR="${KERNEL_AR}" \
               -C ${STAGING_KERNEL_DIR} O=${STAGING_KERNEL_BUILDDIR} scripts prepare
}
