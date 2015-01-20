include gstreamer1.0.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6762ed442b3822387a51c92d928ead0d \
                    file://gst/gst.h;beginline=1;endline=21;md5=e059138481205ee2c6fc1c079c016d0d"

SRC_URI = " \
    http://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${PV}.tar.xz \
"
SRC_URI[md5sum] = "14ad0db045847773d48e317006e29073"
SRC_URI[sha256sum] = "f8c10fc4ecc3ad544aa8e761551ee4c0d9ad812cdb4a57acbfdf413919886c46"

S = "${WORKDIR}/gstreamer-${PV}"
