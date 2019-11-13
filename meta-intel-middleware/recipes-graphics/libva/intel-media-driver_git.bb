SUMMARY = "VA driver for Intel Gen based graphics hardware"
DESCRIPTION = "Intel Media Driver for VAAPI is a new VA-API (Video Acceleration API) \
user mode driver supporting hardware accelerated decoding, encoding, \
and video post processing for GEN based graphics hardware."

HOMEPAGE = "https://github.com/intel/media-driver"
BUGTRACKER = "https://github.com/intel/media-driver/issues"

LICENSE = "MIT & BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=6aab5363823095ce682b155fef0231f0 \
                    file://media_driver/media_libvpx.LICENSE;md5=d5b04755015be901744a78cc30d390d4 \
                    "

# Only for 64 bit until this is resolved: https://github.com/intel/media-driver/issues/356
COMPATIBLE_HOST = '(x86_64).*-linux'

DEPENDS += "libva gmmlib"

SRC_URI = "git://github.com/intel/media-driver.git;protocol=https;branch=intel-media-19.2 \
           "

SRCREV = "9b648d81fb43f70c49304011371279713cb13ccc"
PV = "19.2.1+git${SRCPV}"
S = "${WORKDIR}/git"

UPSTREAM_CHECK_GITTAGREGEX = "^intel-media-(?P<pver>(?!600\..*)\d+(\.\d+)+)$"

inherit cmake pkgconfig

MEDIA_DRIVER_ARCH_x86    = "32"
MEDIA_DRIVER_ARCH_x86-64 = "64"

EXTRA_OECMAKE += "-DMEDIA_RUN_TEST_SUITE=OFF -DARCH=${MEDIA_DRIVER_ARCH}"

# See: https://github.com/intel/media-driver/issues/358
FILES_${PN} += " \
                 ${libdir}/dri/ \
                 ${libdir}/igfxcmrt64.so \
                 "
