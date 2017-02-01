require xf86-video-intel.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=8730ad58d11c7bbad9a7066d69f7808e"

SRC_URI = "git://anongit.freedesktop.org/xorg/driver/xf86-video-intel;branch=master \
           file://xf86-video-intel_version_diff.patch"

SRCREV = "169c74fa6c2cd9c28dd7bfacd9639cd245b8c8a8"

S = "${WORKDIR}/git"

PACKAGECONF[debug] = "--enable-debug"
