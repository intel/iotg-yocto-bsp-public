require libva-intel-driver.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

SRC_URI += "file://intel-va-driver_version_diff.patch"

SRCREV = "4643f94991e4e36ce3a23de63cce9fe543ed1725"

S = "${WORKDIR}/git"
