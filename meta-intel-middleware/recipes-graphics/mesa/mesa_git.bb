require ${COREBASE}/meta/recipes-graphics/mesa/mesa.inc

inherit pythonnative update-alternatives

DEPENDS += "python-mako-native wayland-native wayland wayland-protocols xrandr"

SRC_URI = "git://github.com/intel/external-mesa.git;branch=release-july \
           file://disable-asm-on-non-gcc.patch \
           file://0001-Use-wayland-scanner-in-the-path.patch \
           file://0002-hardware-gloat.patch \
           file://llvm-config-version.patch \
           file://0001-winsys-svga-drm-Include-sys-types.h.patch \
           file://0001-Makefile.vulkan.am-explictly-add-lib-expat-to-intel-.patch \
          "

PV = "18.2.0-rc4"

S = "${WORKDIR}/git"

SRCREV = "2b825b6884fddf9c1541c9a59a7fd78096b0fedf"

#because we cannot rely on the fact that all apps will use pkgconfig,
#make eglplatform.h independent of MESA_EGL_NO_X11_HEADER
do_install_append() {
    if ${@bb.utils.contains('PACKAGECONFIG', 'egl', 'true', 'false', d)}; then
        sed -i -e 's/^#if defined(MESA_EGL_NO_X11_HEADERS)$/#if defined(MESA_EGL_NO_X11_HEADERS) || ${@bb.utils.contains('PACKAGECONFIG', 'x11', '0', '1', d)}/' ${D}${includedir}/EGL/eglplatform.h
    fi
}

PACKAGECONFIG_remove += "vulkan"
