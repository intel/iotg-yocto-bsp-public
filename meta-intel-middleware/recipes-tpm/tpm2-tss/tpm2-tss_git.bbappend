DISABLE_STATIC = ""

DEFAULT_PREFERENCE = "1"

DEPENDS += "libgcrypt uriparser"

SRCREV = "d497224d95d82e424949e5bd226df888d496068e"

PACKAGES = " \
    ${PN}-dbg \
    ${PN}-dev \
    ${PN}-staticdev \
    ${PN} \
"

FILES_${PN} = "/"

FILES_${PN}-staticdev = " \
    ${libdir}/*.a \
"
