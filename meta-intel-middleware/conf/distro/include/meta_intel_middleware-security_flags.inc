# Setup extra CFLAGS and LDFLAGS which have 'security' benefits.
# Some of these packages don't belong to this layer. However,
# keeping them here to ensure everything compiles. These
# should be removed when they've been fixed upstream.

SECURITY_CFLAGS_pn-jhi = ""

SECURITY_CFLAGS_pn-mraa = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-efivar = "${SECURITY_NO_PIE_CFLAGS}"

SECURITY_CFLAGS_pn-krb5 = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-glog = "${SECURITY_NO_PIE_CFLAGS}"
SECURITY_CFLAGS_pn-imagemagick = "${SECURITY_NO_PIE_CFLAGS}"
