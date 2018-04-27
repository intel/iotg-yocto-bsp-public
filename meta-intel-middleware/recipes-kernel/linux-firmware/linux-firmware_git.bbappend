FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
        file://0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch \
        file://0002-i915-GuC-firmware-for-Broxton-v9.29.patch \
        file://0003-i915-GuC-firmware-for-Broxton-v9.37.patch \
           "

LIC_FILES_CHKSUM_remove = " file://WHENCE;md5=038edbc9e744171d8b6235e0224028ba \
"

LIC_FILES_CHKSUM_append = " file://WHENCE;md5=a540765eee7595c4e923245684f4f873 \
"

RDEPENDS_${PN} += " python"

do_patch() {
    cd ${S}
    # Binary patch must be patched in sequence
    git am ${WORKDIR}/0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch
    git am ${WORKDIR}/0002-i915-GuC-firmware-for-Broxton-v9.29.patch
    git am ${WORKDIR}/0003-i915-GuC-firmware-for-Broxton-v9.37.patch
}

do_install_append() {
        # Copy the NVRAM file required for Broadcom Wi-Fi card
        cp ${WORKDIR}/brcmfmac43241b4-sdio.txt ${D}/lib/firmware/brcm/
}
