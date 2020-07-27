FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
        file://0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch \
           "

LIC_FILES_CHKSUM_remove = " file://WHENCE;md5=37a01e379219d1e06dbccfa90a8fc0ad "

LIC_FILES_CHKSUM_append = " file://WHENCE;md5=65bc4f1f5e8de5ff9f359172594c2605 "

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
