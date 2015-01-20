require libva.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

SRC_URI += "file://libva_version_diff.patch"

SRCREV = "4cb6d787bd8270bbba8f8334991db974c592c5c2"

S = "${WORKDIR}/git"
