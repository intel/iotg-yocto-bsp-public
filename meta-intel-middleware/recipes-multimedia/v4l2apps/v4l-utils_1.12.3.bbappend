FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-media-ctl-add-substream-support.patch \
    file://0002-media-ctl-add-routing-information-control.patch \
"
