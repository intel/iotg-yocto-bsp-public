include gstreamer1.0-plugins-ugly.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=a6f89e2100d9b6cdffcea4f398e37343 \
                    file://tests/check/elements/xingmux.c;beginline=1;endline=21;md5=4c771b8af188724855cb99cadd390068 "

SRC_URI[md5sum] = "bbbe1228970f6b3c8596b5f935b0ea52"
SRC_URI[sha256sum] = "d4874effcac3d568b7209806d5585afedc7e3a411ad24e0a3b14558ace58fc43"

S = "${WORKDIR}/gst-plugins-ugly-${PV}"
