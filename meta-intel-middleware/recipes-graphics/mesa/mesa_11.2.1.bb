require ${COREBASE}/meta/recipes-graphics/mesa/mesa.inc

DEPENDS += "python-mako-native"

inherit pythonnative

SRC_URI = "git://anongit.freedesktop.org/mesa/mesa;branch=11.2 \
           file://mesa_version_diff.patch"

SRCREV = "79b0e13913b5189bb8629e80439fea746f99fe79"

LIC_FILES_CHKSUM = "file://docs/COPYING;md5=ab19091db2ee1aae8753474f8a074a5c"

S = "${WORKDIR}/git"

EXTRA_OECONF = "--build=$host --enable-glx-tls"

PACKAGECONFIG = "egl gles dri dri3 \
		 ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}\
		 ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', '', d)}\
		"

PACKAGECONFIG[debug] = "--enable-debug"

#because we cannot rely on the fact that all apps will use pkgconfig,
#make eglplatform.h independent of MESA_EGL_NO_X11_HEADER
do_install_append() {
    if ${@bb.utils.contains('PACKAGECONFIG', 'egl', 'true', 'false', d)}; then
        sed -i -e 's/^#if defined(MESA_EGL_NO_X11_HEADERS)/#if ${@bb.utils.contains('PACKAGECONFIG', 'x11', '0', '1', d)}/' ${D}${includedir}/EGL/eglplatform.h
    fi
}
