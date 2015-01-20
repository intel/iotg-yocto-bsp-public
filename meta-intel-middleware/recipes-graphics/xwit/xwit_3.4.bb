SUMMARY = "X.Org Xwit"
DESCRIPTION = "Xwit Debug Tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://README;md5=e8d4743302cfe0b2586338732859bcce"

SRC_URI = "file://xwit-${PV}.tar.gz"

SRC_URI += "file://0001-comment-out-malloc-and-realloc-functions.patch"

DEPENDS += "virtual/libx11 libxext"

S = "${WORKDIR}/${PN}-${PV}"

CFLAGS += "-I${STAGING_INCDIR}"

do_configure() {
	:
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/xwit ${D}${bindir}
}
