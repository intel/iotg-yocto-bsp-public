require libva-intel-driver.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

SRC_URI += "file://intel-va-driver_version_diff.patch"

SRCREV = "ce444fb412966ca6afbb1331b7cae8ab621c1108"

S = "${WORKDIR}/git"
