FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-aplay-Fix-invalid-file-size-check-for-non-regular-fi.patch \
"
