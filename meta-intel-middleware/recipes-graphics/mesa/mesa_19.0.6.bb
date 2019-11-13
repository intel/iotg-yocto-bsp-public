require ${COREBASE}/meta/recipes-graphics/mesa/mesa.inc

SRC_URI = "https://mesa.freedesktop.org/archive/mesa-${PV}.tar.xz \
           file://0001-Simplify-wayland-scanner-lookup.patch \
           file://0002-winsys-svga-drm-Include-sys-types.h.patch \
           file://0003-Properly-get-LLVM-version-when-using-LLVM-Git-releas.patch \
           file://0004-use-PKG_CHECK_VAR-for-defining-WAYLAND_PROTOCOLS_DAT.patch \
           file://0001-i965-rebased-SIMD32-heuristic-patches.patch \
           file://0002-i965-SIMD32-heuristics-control-data-from-drirc.patch \
           file://0003-i965-fs-Save-the-instruction-count-of-each-dispatch-.patch \
           file://0004-i965-fs-SIMD32-selection-heuristic-based-on-grouped-.patch \
           file://0005-i965-fs-Enable-all-SIMD32-heuristics.patch \
           file://0006-i965-handle-batch-or-state-mapping-failures-in-submi.patch \
           file://0007-mesa-Helper-functions-for-counting-set-bits-in-a-mas.patch \
           file://0001-i965-support-UYVY-for-external-import-only.patch \
"

SRC_URI[md5sum] = "b97159690eba564311d88a818bdbd64d"
SRC_URI[sha256sum] = "2db2f2fcaa4048b16e066fad76b8a93944f7d06d329972b0f5fd5ce692ce3d24"

#because we cannot rely on the fact that all apps will use pkgconfig,
#make eglplatform.h independent of MESA_EGL_NO_X11_HEADER
do_install_append() {
    if ${@bb.utils.contains('PACKAGECONFIG', 'egl', 'true', 'false', d)}; then
        sed -i -e 's/^#if defined(MESA_EGL_NO_X11_HEADERS)$/#if defined(MESA_EGL_NO_X11_HEADERS) || ${@bb.utils.contains('PACKAGECONFIG', 'x11', '0', '1', d)}/' ${D}${includedir}/EGL/eglplatform.h
    fi
}
