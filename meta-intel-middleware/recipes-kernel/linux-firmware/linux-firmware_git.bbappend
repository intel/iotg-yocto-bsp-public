FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
	    file://0001-Add-BXT-DMC-1.07-firmware.patch \
	    file://0002-linux-firmware-i915-GuC-firmware-for-Broxton-v8.7.patch \
           "

LIC_FILES_CHKSUM_remove = " file://LICENSE.radeon;md5=6c7f97c6c62bdd9596d0238bb205118c \
                            file://LICENCE.qat_dh895xcc_firmware;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
                            file://LICENCE.ti-connectivity;md5=186e7a43cf6c274283ad81272ca218ea \
                            "

LIC_FILES_CHKSUM_append = " file://LICENSE.radeon;md5=69612f4f7b141a97659cb1d609a1bde2 \
                            file://LICENCE.qat_firmware;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
                            file://LICENCE.ti-connectivity;md5=c5e02be633f1499c109d1652514d85ec \
                            "

LICENSE += " & Firmware-qat"
LICENSE_remove = "Firmware-qat_dh895xcc_firmware"

NO_GENERIC_LICENSE[Firmware-qat] = "LICENCE.qat_firmware"

SRCREV = "80d463be829abcee4dbdca8432b9a69452e2021d"

do_patch() {
	cd ${S}
	# Binary patch must be patched in sequence
	git am ${WORKDIR}/0001-Add-BXT-DMC-1.07-firmware.patch
	git am ${WORKDIR}/0002-linux-firmware-i915-GuC-firmware-for-Broxton-v8.7.patch
}

do_install_append() {
        # Copy the NVRAM file required for Broadcom Wi-Fi card
        cp ${WORKDIR}/brcmfmac43241b4-sdio.txt ${D}/lib/firmware/brcm/
}

LICENSE_${PN} += " & Firmware-qat "
