# Setup extra CFLAGS and LDFLAGS which have 'security' benefits.
# Some of these packages don't belong to this layer. However,
# keeping them here to ensure everything compiles. These
# should be removed when they've been fixed upstream.

SECURITY_CFLAGS_pn-mraa = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-libproxy = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gcc-sanitizers = "${SECURITY_NO_PIE_CFLAGS}"

# Deal with linker failures when using the cflags
SECURITY_CFLAGS_pn-graphviz = ""

SECURITY_CFLAGS_pn-at-spi2-core = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-at-spi2-atk = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-freetype = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-glib-2.0 = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-glib-networking = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gobject-introspection = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-libepoxy = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-pango = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gdk-pixbuf = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-libinput = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-libmodulemd = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-libsoup-2.4 = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-systemd = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-sysprof = "${SECURITY_NO_PIE_CFLAGS}"

SECURITY_CFLAGS_pn-json-glib = "${SECURITY_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gstreamer1.0 = "${SECURITY_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gstreamer1.0-plugins-base = "${SECURITY_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gstreamer1.0-plugins-bad = "${SECURITY_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gstreamer1.0-plugins-ugly = "${SECURITY_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gstreamer1.0-plugins-good = "${SECURITY_PIE_CFLAGS}"
SECURITY_CFLAGS_pn_gstreamer1.0-rtsp-server = "${SECURITY_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-gstreamer1.0-libav = "${SECURITY_PIE_CFLAGS}"
