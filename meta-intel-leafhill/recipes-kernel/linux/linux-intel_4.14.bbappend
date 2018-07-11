FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

KBRANCH = "4.14/yocto/base"
SRCREV_machine = "e304288ff17ddf0062d1262ae7ccaa57a40c433d"
LINUX_VERSION = "4.14.52"

# Enable i2c-dev autoload
INTEL_COMMON_AUTOLOAD += "i2c-dev"

do_shared_workdir_append() {
       oe_runmake CC="${KERNEL_CC}" LD="${KERNEL_LD}" AR="${KERNEL_AR}" \
               -C ${STAGING_KERNEL_DIR} O=${STAGING_KERNEL_BUILDDIR} scripts prepare
}
