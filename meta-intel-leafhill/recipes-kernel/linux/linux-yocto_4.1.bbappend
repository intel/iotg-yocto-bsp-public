FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kernel-patch-integration.scc \
            file://kernel_ipu.scc \
            file://kernel_io.scc \
            file://kernel_audio.scc \
            ${@bb.utils.contains('AUDIO_FEATURES', 'ssp', 'file://kernel_audio-ssp.scc', '', d)} \
"

KBRANCH_corei7-64-intel-common = "standard/intel/base"

LINUX_VERSION_corei7-64-intel-common = "4.1.42"

SRCREV_machine_corei7-64-intel-common = "2229adbe9ae7aa005c03c3b1a8deb3b52310dc57"
SRCREV_meta_corei7-64-intel-common = "660468df599bbd79a287a8a703d9ca066fd6a074"

KERNEL_EXTRA_ARGS = "EXTRA_CFLAGS="-D_FORTIFY_SOURCE=2 -Wformat -O2 -Wformat-security""
