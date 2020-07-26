FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
        file://0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch \
           "

LIC_FILES_CHKSUM_remove = " file://WHENCE;md5=b6e44adf71bc37e5f26ebfe5a08b5490 \
                            file://LICENCE.Marvell;md5=9ddea1734a4baf3c78d845151f42a37a \
"

LIC_FILES_CHKSUM_append = " file://WHENCE;md5=65bc4f1f5e8de5ff9f359172594c2605 \
                            file://LICENCE.Marvell;md5=28b6ed8bd04ba105af6e4dcd6e997772 \
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

SRCREV = "84a7ca591a1b3c9b7a0253af44e227586d02ddd7"
