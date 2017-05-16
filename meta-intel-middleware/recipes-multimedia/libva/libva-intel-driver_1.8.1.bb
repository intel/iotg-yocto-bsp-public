require libva-intel-driver.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

SRC_URI += "file://intel-va-driver_version_diff.patch"

SRCREV = "dbe582c2361d3bb6a04968a2bc21b62bede9c46e"

S = "${WORKDIR}/git"
