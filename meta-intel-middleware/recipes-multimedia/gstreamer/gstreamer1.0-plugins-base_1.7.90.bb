include gstreamer1.0-plugins-base.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=c54ce9345727175ff66d17b67ff51f58 \
                    file://common/coverage/coverage-report.pl;beginline=2;endline=17;md5=a4e1830fce078028c8f0974161272607 \
                    file://COPYING.LIB;md5=6762ed442b3822387a51c92d928ead0d \
                   "

SRC_URI += "file://get-caps-from-src-pad-when-query-caps.patch \
            file://0004-subparse-set-need_segment-after-sink-pad-received-GS.patch \
            file://encodebin-Need-more-buffers-in-output-queue-for-bett.patch \
"

SRC_URI[md5sum] = "11d03497e0d3e0df663301cf15e04381"
SRC_URI[sha256sum] = "7564b8b2a8c0d78aa2c1742968bef83d35fa83a2cfc167d46a5fc4715794742c"

S = "${WORKDIR}/gst-plugins-base-${PV}"
