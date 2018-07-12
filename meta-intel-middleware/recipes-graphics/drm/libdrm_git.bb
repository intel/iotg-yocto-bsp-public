SUMMARY = "Userspace interface to the kernel DRM services"
DESCRIPTION = "The runtime library for accessing the kernel DRM services.  DRM \
stands for \"Direct Rendering Manager\", which is the kernel portion of the \
\"Direct Rendering Infrastructure\" (DRI).  DRI is required for many hardware \
accelerated OpenGL drivers."
HOMEPAGE = "http://dri.freedesktop.org"
SECTION = "x11/base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://xf86drm.c;beginline=9;endline=32;md5=c8a3b961af7667c530816761e949dc71"
PROVIDES = "drm"
DEPENDS = "libpthread-stubs libpciaccess"

SRC_URI = "git://anongit.freedesktop.org/mesa/drm \
           file://0001-xf86drm-Be-sure-to-closedir-before-return.patch \
           file://0002-Always-pass-O_CLOEXEC-when-opening-DRM-file-descript.patch \
           file://0003-amdgpu-Take-a-lock-before-removing-devices-from-fd_t.patch \
           file://0004-amdgpu-util_hash_table-Add-helper-function-to-count-.patch \
           file://0005-amdgpu-Destroy-fd_hash-table-when-the-last-device-is.patch \
           file://0006-freedreno-add-user-ptr-to-fd_ringbuffer.patch \
           file://0007-intel-Introducing-Whiskey-Lake-platform.patch \
           file://0008-intel-Introducing-Amber-Lake-platform.patch \
           file://0009-intel-New-libdrm-interface-to-create-unbound-wc-user.patch \
           file://0010-intel-add-the-new-bo-emit-reloc2-for-bo-offset.patch \
           file://0011-intel-Watchdog-timeout-DRM-kernel-interface-to-set-t.patch \
           file://0012-xf86drmMode-Add-RGBA-property-helpers.patch \
           file://0013-xf86drmMode-Add-plane-blending-helpers.patch \
           file://0014-To-disable-hook-dist-gzip-to-dist.patch \
          "

PV = "2.4.92"

S = "${WORKDIR}/git"

SRCREV = "b29dffe750de981e562bb605e5674589f23cfda6"

inherit autotools pkgconfig manpages

EXTRA_OECONF += "--disable-cairo-tests \
                 --enable-omap-experimental-api \
                 --enable-etnaviv-experimental-api \
                 --enable-install-test-programs \
                 --disable-valgrind \
                "
PACKAGECONFIG[manpages] = "--enable-manpages, --disable-manpages, libxslt-native xmlto-native"

ALLOW_EMPTY_${PN}-drivers = "1"
PACKAGES =+ "${PN}-tests ${PN}-drivers ${PN}-radeon ${PN}-nouveau ${PN}-omap \
             ${PN}-intel ${PN}-exynos ${PN}-kms ${PN}-freedreno ${PN}-amdgpu \
             ${PN}-etnaviv"

RRECOMMENDS_${PN}-drivers = "${PN}-radeon ${PN}-nouveau ${PN}-omap ${PN}-intel \
                             ${PN}-exynos ${PN}-freedreno ${PN}-amdgpu \
                             ${PN}-etnaviv"

FILES_${PN}-tests = "${bindir}/*"
FILES_${PN}-radeon = "${libdir}/libdrm_radeon.so.*"
FILES_${PN}-nouveau = "${libdir}/libdrm_nouveau.so.*"
FILES_${PN}-omap = "${libdir}/libdrm_omap.so.*"
FILES_${PN}-intel = "${libdir}/libdrm_intel.so.*"
FILES_${PN}-exynos = "${libdir}/libdrm_exynos.so.*"
FILES_${PN}-kms = "${libdir}/libkms*.so.*"
FILES_${PN}-freedreno = "${libdir}/libdrm_freedreno.so.*"
FILES_${PN}-amdgpu = "${libdir}/libdrm_amdgpu.so.*"
FILES_${PN}-etnaviv = "${libdir}/libdrm_etnaviv.so.*"

