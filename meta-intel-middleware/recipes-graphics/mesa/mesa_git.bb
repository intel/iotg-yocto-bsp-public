require ${COREBASE}/meta/recipes-graphics/mesa/mesa.inc

inherit pythonnative update-alternatives

DEPENDS += "python-mako-native wayland-native wayland wayland-protocols"

SRC_URI = "git://anongit.freedesktop.org/mesa/mesa;branch=18.0 \
           file://mesa_version_diff.patch \
           file://0001-Simplify-wayland-scanner-lookup.patch \
           file://0001-Fix-wayland-protocols-lookup.patch \
          "

PV = "18.2.0-devel"

S = "${WORKDIR}/git"

SRCREV = "d23dc99cc8ab9a31853db66d2bf09c1ff7f2594e"

#because we cannot rely on the fact that all apps will use pkgconfig,
#make eglplatform.h independent of MESA_EGL_NO_X11_HEADER
do_install_append() {
    if ${@bb.utils.contains('PACKAGECONFIG', 'egl', 'true', 'false', d)}; then
        sed -i -e 's/^#if defined(MESA_EGL_NO_X11_HEADERS)$/#if defined(MESA_EGL_NO_X11_HEADERS) || ${@bb.utils.contains('PACKAGECONFIG', 'x11', '0', '1', d)}/' ${D}${includedir}/EGL/eglplatform.h
    fi
}
