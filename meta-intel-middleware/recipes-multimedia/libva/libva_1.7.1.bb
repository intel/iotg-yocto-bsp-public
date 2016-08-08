require libva.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

SRC_URI += "file://libva_version_diff.patch"

SRCREV = "fa5e03f46ffcc1d609676442db7cfd036a16c078"

S = "${WORKDIR}/git"
