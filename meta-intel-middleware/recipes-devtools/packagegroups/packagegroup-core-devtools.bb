SUMMARY = "A compilation of devtools to enable debugging"
LICENSE = "MIT"
PR = "r1"

PACKAGE_ARCH = "${MACHINE_ARCH}"
inherit packagegroup

PACKAGES = "packagegroup-core-devtools"

ALLOW_EMPTY_${PN} = "1"

RDEPENDS_packagegroup-core-devtools = " \
  gdb \
  strace \
  twm \
  valgrind \
"
