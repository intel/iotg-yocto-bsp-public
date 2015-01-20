include gstreamer1.0-plugins-bad.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=73a5855a8119deb017f5f13cf327095d \
                    file://gst/tta/filters.h;beginline=12;endline=29;md5=8a08270656f2f8ad7bb3655b83138e5a \
                    file://COPYING.LIB;md5=21682e4e8fea52413fd26c60acb907e5 \
                    file://gst/tta/crc32.h;beginline=12;endline=29;md5=27db269c575d1e5317fffca2d33b3b50"

SRC_URI += "file://0001-glimagesink-Downrank-to-marginal.patch"

SRC_URI[md5sum] = "7ece4d08532244a8ee07ccb53e4e71bd"
SRC_URI[sha256sum] = "01f1c168324738c543ce26b1332b0d77547c9717f3b2fde4f22a8e4ebcb06d14"

S = "${WORKDIR}/gst-plugins-bad-${PV}"
