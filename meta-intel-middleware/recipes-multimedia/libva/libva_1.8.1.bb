require libva.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

SRC_URI += "file://libva_version_diff.patch"

SRCREV = "d829a36cf71ee3bcbeff670fde4287070bb6000a"

S = "${WORKDIR}/git"

RRECOMMENDS_${PN} = "libva-utils"
