include gstreamer1.0-rtsp-server.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6762ed442b3822387a51c92d928ead0d"

SRC_URI[md5sum] = "f72da4a5f7c22901c9f29a8b268e9b8a"
SRC_URI[sha256sum] = "2d523dfbf232993e8e755fbc0b5b634dc68cc45c77d59788b561388befb2a339"

FILES_${PN} += "${libdir}/gstreamer-1.0/libgstrtspclientsink.so"
FILES_${PN}-dbg += "${libdir}/gstreamer-1.0/.debug"
FILES_${PN}-dev += "${libdir}/gstreamer-1.0/libgstrtspclientsink.la"
