FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-qtdemux-reset-reused-QtDemuxStream-while-parsing-a-n.patch \
"
