require iproute2.inc

SRC_URI = "git://git.kernel.org/pub/scm/network/iproute2/iproute2.git"

SRCREV = "97864a5af3a196d909671956b94f92c45cc6f45e"
PV = "1.0-git${SRCPV}"
PR = "r0"

S = "${WORKDIR}/git"

# CFLAGS are computed in Makefile and reference CCOPTS
#
EXTRA_OEMAKE_append = " CCOPTS='${CFLAGS}'"
