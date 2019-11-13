FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
        file://0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch \
           "

LIC_FILES_CHKSUM_remove = " file://WHENCE;md5=b6e44adf71bc37e5f26ebfe5a08b5490 \
"

LIC_FILES_CHKSUM_append = " file://WHENCE;md5=fe77f15efcb7a4e8778bdde5d734d322 \
"

RDEPENDS_${PN} += " python"

do_patch() {
    cd ${S}
    # Binary patch must be patched in sequence
    git am ${WORKDIR}/0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch
}

do_install_append() {
        # Copy the NVRAM file required for Broadcom Wi-Fi card
        cp ${WORKDIR}/brcmfmac43241b4-sdio.txt ${D}/lib/firmware/brcm/
}
