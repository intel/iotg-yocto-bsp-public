include gstreamer1.0-plugins-good.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=a6f89e2100d9b6cdffcea4f398e37343 \
                    file://common/coverage/coverage-report.pl;beginline=2;endline=17;md5=a4e1830fce078028c8f0974161272607 \
                    file://gst/replaygain/rganalysis.c;beginline=1;endline=23;md5=b60ebefd5b2f5a8e0cab6bfee391a5fe"

SRC_URI += "file://0001-gstrtpmp4gpay-set-dafault-value-for-MPEG4-without-co.patch"

SRC_URI[md5sum] = "d06215d21986c7c45a478c90cb689a6a"
SRC_URI[sha256sum] = "fcbebe3cc0272a7ca4865bfbb898a7e3dc8e51948a5fca5477e68a214d172859"

S = "${WORKDIR}/gst-plugins-good-${PV}"
