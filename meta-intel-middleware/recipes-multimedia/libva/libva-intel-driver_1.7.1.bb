require libva-intel-driver.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

SRC_URI += "file://intel-va-driver_version_diff.patch"

SRCREV = "396224348ae47f3093e79dc84a7d4f1f1513ba55"

S = "${WORKDIR}/git"
