SUMMARY = "Userspace interface to the kernel DRM services"
DESCRIPTION = "The runtime library for accessing the kernel DRM services.  DRM \
stands for \"Direct Rendering Manager\", which is the kernel portion of the \
\"Direct Rendering Infrastructure\" (DRI).  DRI is required for many hardware \
accelerated OpenGL drivers."
HOMEPAGE = "http://dri.freedesktop.org"
SECTION = "x11/base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://README;md5=4b3cbc63e3a058ac3259f62316a3ace5"
PROVIDES = "drm"
DEPENDS = "libpthread-stubs udev libpciaccess"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://anongit.freedesktop.org/mesa/drm;branch=master \
           file://libdrm_version_diff.patch"

SRCREV = "cc9a53f076d4e958e595e1daaff2c286ce1b7bb1"

inherit autotools pkgconfig

EXTRA_OECONF += "--disable-cairo-tests \
		 --enable-omap-experimental-api \
		 --enable-install-test-programs \
		 --disable-manpages \
		 --disable-valgrind \
		"

S = "${WORKDIR}/git"

ALLOW_EMPTY_${PN}-drivers = "1"
PACKAGES =+ "${PN}-tests ${PN}-drivers ${PN}-radeon ${PN}-nouveau ${PN}-omap \
	     ${PN}-intel ${PN}-exynos ${PN}-kms ${PN}-freedreno"

RRECOMMENDS_${PN}-drivers = "${PN}-radeon ${PN}-nouveau ${PN}-omap ${PN}-intel \
			     ${PN}-exynos ${PN}-freedreno"

PACKAGECONF[debug] = "--enable-debug"

FILES_${PN}-tests = "${bindir}/dr* ${bindir}/mode* ${bindir}/*test"
FILES_${PN}-radeon = "${libdir}/libdrm_radeon.so.*"
FILES_${PN}-nouveau = "${libdir}/libdrm_nouveau.so.*"
FILES_${PN}-omap = "${libdir}/libdrm_omap.so.*"
FILES_${PN}-intel = "${libdir}/libdrm_intel.so.*"
FILES_${PN}-exynos = "${libdir}/libdrm_exynos.so.*"
FILES_${PN}-kms = "${libdir}/libkms*.so.*"
FILES_${PN}-freedreno = "${libdir}/libdrm_freedreno.so.*"
