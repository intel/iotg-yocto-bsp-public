FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://leafhill.scc \
           ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://snd_ssp_intel.scc', '', d)} \
"

KMETA_BRANCH = "yocto-4.13"
SRCREV_machine = "b700ffafd0dc5e7a81da64b5e220128330000efd"
SRCREV_meta = "71dec2980bdda27ba85714b756146c84cfdafeb7"
LINUX_VERSION = "4.14.40"

do_shared_workdir_append() {
       oe_runmake CC="${KERNEL_CC}" LD="${KERNEL_LD}" AR="${KERNEL_AR}" \
               -C ${STAGING_KERNEL_DIR} O=${STAGING_KERNEL_BUILDDIR} scripts prepare
}
