FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
        file://0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch \
           "

LIC_FILES_CHKSUM_remove = " file://WHENCE;md5=37a01e379219d1e06dbccfa90a8fc0ad "

LIC_FILES_CHKSUM_append = " file://WHENCE;md5=fa36af6d4cbceba6e639ff5615fcb1d5 "

LIC_FILES_CHKSUM_remove = " file://LICENSE.amdgpu;md5=ab515ef6495ab5c5a3b08ab2db62df11 "

LIC_FILES_CHKSUM_append = " file://LICENSE.amdgpu;md5=d357524f5099e2a3db3c1838921c593f "

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

SRCREV = "3d3a06f720856cb897a8541951edd0b8f6f54a98"
