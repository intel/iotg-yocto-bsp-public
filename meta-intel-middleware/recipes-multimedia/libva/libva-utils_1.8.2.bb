SUMMARY = "Video Acceleration (VA) API utilities for Linux"
DESCRIPTION = "libva-utils is a collection of utilities and \
examples to exercise VA-API in accordance with the libva project"

HOMEPAGE = "https://01.org/linuxmedia/vaapi"

SECTION = "x11"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=b148fc8adf19dc9aec17cf9cd29a9a5e"

SRC_URI = "git://github.com/01org/libva-utils.git;protocol=https;branch=master"

SRCREV = "0bb87bae2b868a26f185c2db95cad223f727cea9"

DEPENDS = "libva libdrm"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
