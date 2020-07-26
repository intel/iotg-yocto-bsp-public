include ${BPN}.inc

SRC_URI += " \
    https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
    file://tpm2-abrmd.default \
"

SRC_URI[md5sum] = "0b0c4cdb4e946fcaf661287fd7970647"
SRC_URI[sha256sum] = "bf9b142bc8f50e94c0b0fa7212a8cff0284e55be9db6bd89f4ce78722e3bc4ec"
