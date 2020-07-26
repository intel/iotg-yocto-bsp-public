SUMMARY = "Intel(R) Media SDK for hardware accelerated media processing"
DESCRIPTION = "Intel(R) Media SDK provides an API to access hardware-accelerated \
video decode, encode and filtering on Intel® platforms with integrated graphics."

HOMEPAGE = "https://github.com/Intel-Media-SDK/MediaSDK"
BUGTRACKER = "https://github.com/Intel-Media-SDK/MediaSDK/issues"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3cb331af679cd8f968bf799a9c55b46e"

CVE_DETAILS = "intel:media_sdk"

# Only for 64 bit until media-driver issues aren't fixed
COMPATIBLE_HOST = '(x86_64).*-linux'
COMPATIBLE_HOST_x86-x32 = "null"

inherit distro_features_check
REQUIRED_DISTRO_FEATURES = "opengl"

DEPENDS += "libdrm libva intel-media-driver"

PACKAGECONFIG ??= "${@bb.utils.contains("DISTRO_FEATURES", "x11", "dri3", "", d)} \
                   ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "wayland", "", d)}"

PACKAGECONFIG[dri3] 	= "-DENABLE_X11_DRI3=ON, -DENABLE_X11_DRI3=OFF"
PACKAGECONFIG[wayland]	= "-DENABLE_WAYLAND=ON, -DENABLE_WAYLAND=OFF, wayland wayland-native"

SRC_URI = "git://github.com/Intel-Media-SDK/MediaSDK.git;protocol=https;branch=${BPN}-20.1;lfs=0 \
	file://0001-H264dec-reset-DPB-size-if-needed.patch \
	file://MediaSDK-0001-h265d-Enable-the-SPS-PPS-error-reporting.patch \
	"
SRCREV = "3d6abcfb19ba2e31b6a8d32cddd1893c3e419ffc"
S = "${WORKDIR}/git"

UPSTREAM_CHECK_GITTAGREGEX = "^intel-mediasdk-(?P<pver>(\d+(\.\d+)+))$"

inherit cmake pkgconfig

EXTRA_OECMAKE += "-DMFX_INCLUDE=${S}/api/include -DBUILD_SAMPLES=ON"

# compiled code should not be in datadir
do_install_append(){
	mv ${D}${datadir}/mfx/samples ${D}${libdir}/mfx/samples

	install -d -m 755 ${D}/usr/share/${PN}/src/sample_encode/include
        install -d -m 755 ${D}/usr/share/${PN}/src/sample_encode/src
        install -d -m 755 ${D}/usr/share/${PN}/src/sample_decode/include
        install -d -m 755 ${D}/usr/share/${PN}/src/sample_decode/src
        install -d -m 755 ${D}/usr/share/${PN}/src/sample_vpp/include
        install -d -m 755 ${D}/usr/share/${PN}/src/sample_vpp/src
        install -d -m 755 ${D}/usr/share/${PN}/src/sample_multi_trancode/include
        install -d -m 755 ${D}/usr/share/${PN}/src/sample_multi_trancode/src

     	install  -m 644 ${S}/samples/sample_encode/include/* ${D}/usr/share/${PN}/src/sample_encode/include 
	install -m 644 ${S}/samples/sample_encode/src/* ${D}/usr/share/${PN}/src/sample_encode/src
     	install -m 644 ${S}/samples/sample_decode/include/* ${D}/usr/share/${PN}/src/sample_decode/include
     	install -m 644 ${S}/samples/sample_decode/src/* ${D}/usr/share/${PN}/src/sample_decode/src
     	install -m 644 ${S}/samples/sample_vpp/include/* ${D}/usr/share/${PN}/src/sample_vpp/include
     	install -m 644 ${S}/samples/sample_vpp/src/* ${D}/usr/share/${PN}/src/sample_vpp/src
     	install -m 644 ${S}/samples/sample_multi_transcode/include/* ${D}/usr/share/${PN}/src/sample_multi_trancode/include
     	install -m 644 ${S}/samples/sample_multi_transcode/src/* ${D}/usr/share/${PN}/src/sample_multi_trancode/src

}

FILES_${PN} += " \
                 ${libdir}/mfx \
                 ${datadir}/mfx/plugins.cfg \
		 ${libdir}/mfx/samples \
		 "
FILES_${PN}-staticdev += "${libdir}/mfx/samples/*.a"
