FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
	    file://0001-Add-BXT-DMC-1.07-firmware.patch \
	    file://0002-linux-firmware-i915-GuC-firmware-for-Broxton-v8.7.patch \
	    file://0003-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch \
           "

LICENSE = "\
    Firmware-Abilis \
    & Firmware-agere \
    & Firmware-amd-ucode \
    & Firmware-atheros_firmware \
    & Firmware-broadcom_bcm43xx \
    & Firmware-ca0132 \
    & Firmware-chelsio_firmware \
    & Firmware-cw1200 \
    & Firmware-dib0700 \
    & Firmware-ene_firmware \
    & Firmware-fw_sst_0f28 \
    & Firmware-go7007 \
    & Firmware-i2400m \
    & Firmware-ibt_firmware \
    & Firmware-it913x \
    & Firmware-iwlwifi_firmware \
    & Firmware-IntcSST2 \
    & Firmware-Marvell \
    & Firmware-mwl8335 \
    & Firmware-myri10ge_firmware \
    & Firmware-OLPC \
    & Firmware-phanfw \
    & Firmware-qat \
    & Firmware-qla2xxx \
    & Firmware-r8a779x_usb3 \
    & Firmware-radeon \
    & Firmware-ralink_a_mediatek_company_firmware \
    & Firmware-ralink-firmware \
    & Firmware-rtlwifi_firmware \
    & Firmware-tda7706-firmware \
    & Firmware-ti-connectivity \
    & Firmware-ueagle-atm4-firmware \
    & Firmware-via_vt6656 \
    & Firmware-wl1251 \
    & Firmware-xc4000 \
    & Firmware-xc5000 \
    & Firmware-xc5000c \
    & Firmware-siano \
"

LIC_FILES_CHKSUM_remove = " file://LICENSE.radeon;md5=6c7f97c6c62bdd9596d0238bb205118c \
                            file://LICENCE.qat_dh895xcc_firmware;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
                            file://LICENCE.ti-connectivity;md5=186e7a43cf6c274283ad81272ca218ea \
                            "

LIC_FILES_CHKSUM_append = " file://LICENSE.radeon;md5=69612f4f7b141a97659cb1d609a1bde2 \
                            file://LICENCE.qat_firmware;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
                            file://LICENCE.ti-connectivity;md5=c5e02be633f1499c109d1652514d85ec \
                            "

NO_GENERIC_LICENSE[Firmware-qat] = "LICENCE.qat_firmware"

SRCREV = "80d463be829abcee4dbdca8432b9a69452e2021d"

do_patch() {
	cd ${S}
	# Binary patch must be patched in sequence
	git am ${WORKDIR}/0001-Add-BXT-DMC-1.07-firmware.patch
	git am ${WORKDIR}/0002-linux-firmware-i915-GuC-firmware-for-Broxton-v8.7.patch
	git am ${WORKDIR}/0003-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch
}

do_install_append() {
        # Copy the NVRAM file required for Broadcom Wi-Fi card
        cp ${WORKDIR}/brcmfmac43241b4-sdio.txt ${D}/lib/firmware/brcm/
}

LICENSE_${PN} += " Firmware-qat"
LICENSE_${PN}_remove = " Firmware-qat_dh895xcc_firmware"
