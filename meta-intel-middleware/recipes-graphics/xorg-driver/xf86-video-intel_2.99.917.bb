require xf86-video-intel.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=8730ad58d11c7bbad9a7066d69f7808e"

SRC_URI = "git://anongit.freedesktop.org/xorg/driver/xf86-video-intel;branch=master \
           file://xf86-video-intel_version_diff.patch"

SRCREV = "cb6ba2da056f3298a765b4da5cd626343c00a533"

S = "${WORKDIR}/git"

PACKAGECONF[debug] = "--enable-debug"
