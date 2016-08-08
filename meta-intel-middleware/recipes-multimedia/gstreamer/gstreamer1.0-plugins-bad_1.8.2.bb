include gstreamer1.0-plugins-bad.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=73a5855a8119deb017f5f13cf327095d \
                    file://gst/tta/filters.h;beginline=12;endline=29;md5=8a08270656f2f8ad7bb3655b83138e5a \
                    file://COPYING.LIB;md5=21682e4e8fea52413fd26c60acb907e5 \
                    file://gst/tta/crc32.h;beginline=12;endline=29;md5=27db269c575d1e5317fffca2d33b3b50"

SRC_URI += " \
            http://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${PV}.tar.xz \
            file://0001-glimagesink-Downrank-to-marginal.patch \
            file://configure-allow-to-disable-libssh2.patch \
            file://Enable_BDU_parsing_for_bitstream.patch"

SRC_URI[md5sum] = "83abc2e70684e7b195f18ca2992ef6e8"
SRC_URI[sha256sum] = "d7995317530c8773ec088f94d9320909d41da61996b801ebacce9a56af493f97"

S = "${WORKDIR}/gst-plugins-bad-${PV}"
