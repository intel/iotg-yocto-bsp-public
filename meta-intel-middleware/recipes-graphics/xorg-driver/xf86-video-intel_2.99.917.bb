require xf86-video-intel.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=8730ad58d11c7bbad9a7066d69f7808e"

SRC_URI = "git://anongit.freedesktop.org/xorg/driver/xf86-video-intel;branch=master \
           file://xf86-video-intel_version_diff.patch"

SRCREV = "46caee86db0fb32b16213893c79d9c1a21ed0883"

S = "${WORKDIR}/git"

PACKAGECONF[debug] = "--enable-debug"
