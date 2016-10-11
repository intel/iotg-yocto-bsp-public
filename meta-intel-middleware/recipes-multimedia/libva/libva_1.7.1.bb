require libva.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

SRC_URI += "file://libva_version_diff.patch"

SRCREV = "6a9ab53720247effd2ff49eac2f7b5b37afc6f62"

S = "${WORKDIR}/git"
