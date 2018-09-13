FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
        file://0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch \
        file://0002-i915-GuC-firmware-for-Broxton-v9.37.patch \
           "

LIC_FILES_CHKSUM_remove = " file://WHENCE;md5=eaaf310bac02fee05ea1b334f58c5caf \
"

LIC_FILES_CHKSUM_append = " file://WHENCE;md5=20bb19619f53d3fcc9fe32106177acb9 \
"

RDEPENDS_${PN} += " python"

do_patch() {
    cd ${S}
    # Binary patch must be patched in sequence
    git am ${WORKDIR}/0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch
    git am ${WORKDIR}/0002-i915-GuC-firmware-for-Broxton-v9.37.patch
}

do_install_append() {
        # Copy the NVRAM file required for Broadcom Wi-Fi card
        cp ${WORKDIR}/brcmfmac43241b4-sdio.txt ${D}/lib/firmware/brcm/
}
