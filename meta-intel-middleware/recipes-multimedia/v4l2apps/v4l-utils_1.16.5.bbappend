FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-PATCH-media-ctl-add-substream-support.patch \
    file://0002-PATCH-2-2-media-ctl-add-routing-information-control.patch \
    "
