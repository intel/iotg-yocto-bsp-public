require xf86-video-intel.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=8730ad58d11c7bbad9a7066d69f7808e"

SRC_URI = "git://anongit.freedesktop.org/xorg/driver/xf86-video-intel;branch=master \
           file://xf86-video-intel_version_diff.patch"

SRCREV = "2100efa105e8c9615eda867d39471d78e500b1bb"

S = "${WORKDIR}/git"

PACKAGECONF[debug] = "--enable-debug"
