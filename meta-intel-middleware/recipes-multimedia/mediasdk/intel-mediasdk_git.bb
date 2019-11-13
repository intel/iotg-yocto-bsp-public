SUMMARY = "Intel(R) Media SDK for hardware accelerated media processing"
DESCRIPTION = "Intel(R) Media SDK provides an API to access hardware-accelerated \
video decode, encode and filtering on Intel® platforms with integrated graphics."

HOMEPAGE = "https://github.com/Intel-Media-SDK/MediaSDK"
BUGTRACKER = "https://github.com/Intel-Media-SDK/MediaSDK/issues"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3cb331af679cd8f968bf799a9c55b46e"

# Only for 64 bit until media-driver issues aren't fixed
COMPATIBLE_HOST = '(x86_64).*-linux'

DEPENDS += "libdrm libva intel-media-driver"

PACKAGECONFIG ??= "sample vtune \
                   ${@bb.utils.contains("DISTRO_FEATURES", "x11", "dri3", "", d)} \
                   ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "wayland", "", d)}"

PACKAGECONFIG[dri3]		= "-DENABLE_X11_DRI3=ON, -DENABLE_X11_DRI3=OFF"
PACKAGECONFIG[sample]	= "-DBUILD_SAMPLES=ON, -DBUILD_SAMPLES=OFF"
PACKAGECONFIG[vtune]	= "-DENABLE_OPENCL=ON, -DENABLE_OPENCL=OFF, "
PACKAGECONFIG[wayland]	= "-DENABLE_WAYLAND=ON, -DENABLE_WAYLAND=OFF, wayland wayland-native"

SRC_URI = " \
            git://github.com/Intel-Media-SDK/MediaSDK.git;protocol=https;branch=${BPN}-19.2;lfs=0 \
            file://0001-H264dec-reset-DPB-size-if-needed.patch \
            file://0001-Allow-a-larger-surface-for-mpeg2-jpeg-encoding-1562.patch \
            "

SRCREV = "885c309f57a7a1cbc60edee6b0d014a36da94562"
PV = "19.2.1+git${SRCPV}"

S = "${WORKDIR}/git"

UPSTREAM_CHECK_GITTAGREGEX = "^intel-mediasdk-(?P<pver>(\d+(\.\d+)+))$"

inherit cmake pkgconfig

EXTRA_OECMAKE += "-DMFX_INCLUDE=${S}/api/include "

FILES_${PN} += " \
                 ${libdir}/mfx \
                 ${datadir}/mfx/plugins.cfg \
                 ${datadir}/mfx/samples \
                 "

FILES_${PN}-dbg += " ${datadir}/mfx/samples/.debug"

FILES_${PN}-staticdev += " ${datadir}/mfx/samples/*.a"
