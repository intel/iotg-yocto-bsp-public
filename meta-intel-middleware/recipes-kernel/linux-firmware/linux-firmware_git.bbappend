FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
	    file://0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch \
	    file://0002-i915-GuC-firmware-for-Broxton-v9.29.patch \
           "

LICENSE = "\
    Firmware-Abilis \
    & Firmware-adsp_sst \
    & Firmware-agere \
    & Firmware-atheros_firmware \
    & Firmware-broadcom_bcm43xx \
    & Firmware-ca0132 \
    & Firmware-cavium \
    & Firmware-chelsio_firmware \
    & Firmware-cw1200 \
    & Firmware-e100 \
    & Firmware-ene_firmware \
    & Firmware-fw_sst_0f28 \
    & Firmware-go7007 \
    & Firmware-i2400m \
    & Firmware-ibt_firmware \
    & Firmware-IntcSST2 \
    & Firmware-it913x \
    & Firmware-iwlwifi_firmware \
    & Firmware-kaweth \
    & Firmware-Marvell \
    & Firmware-moxa \
    & Firmware-myri10ge_firmware \
    & Firmware-nvidia \
    & Firmware-OLPC \
    & Firmware-open-ath9k-htc-firmware \
    & Firmware-phanfw \
    & Firmware-qat \
    & Firmware-qla1280 \
    & Firmware-qla2xxx \
    & Firmware-r8a779x_usb3 \
    & Firmware-ralink_a_mediatek_company_firmware \
    & Firmware-ralink-firmware \
    & Firmware-rockchip \
    & Firmware-rtlwifi_firmware \
    & Firmware-siano \
    & Firmware-tda7706-firmware \
    & Firmware-ti-connectivity \
    & Firmware-ti-keystone \
    & Firmware-ueagle-atm4-firmware \
    & Firmware-via_vt6656 \
    & Firmware-wl1251 \
    & Firmware-xc4000 \
    & Firmware-xc5000 \
    & Firmware-xc5000c \
    & Firmware-amdgpu \
    & Firmware-amd-ucode \
    & Firmware-atmel \
    & Firmware-dib0700 \
    & Firmware-hfi1_firmware \
    & Firmware-i915 \
    & Firmware-qualcommAthos_ar3k \
    & Firmware-qualcommAthos_ath10k \
    & Firmware-radeon \
    & WHENCE \
"

LIC_FILES_CHKSUM_remove = " file://LICENSE.radeon;md5=6c7f97c6c62bdd9596d0238bb205118c \
                            file://LICENCE.qat_dh895xcc_firmware;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
                            file://LICENCE.mwl8335;md5=9a6271ee0e644404b2ff3c61fd070983 \
                            file://LICENCE.ti-connectivity;md5=186e7a43cf6c274283ad81272ca218ea \
                            file://LICENCE.qla2xxx;md5=f5ce8529ec5c17cb7f911d2721d90e91 \
                            file://LICENCE.siano;md5=602c79ae3f98f1e73d880fd9f940a418 \
                            "

LIC_FILES_CHKSUM_append = " file://LICENSE.radeon;md5=68ec28bacb3613200bca44f404c69b16 \
                            file://LICENCE.qat_firmware;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
                            file://LICENCE.ti-connectivity;md5=c5e02be633f1499c109d1652514d85ec \
                            file://LICENCE.qla2xxx;md5=505855e921b75f1be4a437ad9b79dff0 \
                            file://LICENCE.siano;md5=4556c1bf830067f12ca151ad953ec2a5 \
                            file://LICENCE.adsp_sst;md5=615c45b91a5a4a9fe046d6ab9a2df728 \
                            file://LICENCE.cavium;md5=c37aaffb1ebe5939b2580d073a95daea \
                            file://LICENCE.e100;md5=ec0f84136766df159a3ae6d02acdf5a8 \
                            file://LICENCE.kaweth;md5=b1d876e562f4b3b8d391ad8395dfe03f \
                            file://LICENCE.moxa;md5=1086614767d8ccf744a923289d3d4261 \
                            file://LICENCE.nvidia;md5=4428a922ed3ba2ceec95f076a488ce07 \
                            file://LICENCE.open-ath9k-htc-firmware;md5=1b33c9f4d17bc4d457bdb23727046837 \
                            file://LICENCE.qla1280;md5=d6895732e622d950609093223a2c4f5d \
                            file://LICENCE.rockchip;md5=5fd70190c5ed39734baceada8ecced26 \
                            file://LICENCE.ti-keystone;md5=3a86335d32864b0bef996bee26cc0f2c \
                            file://LICENSE.amdgpu;md5=0aa3c2f3e736af320a08a3aeeccecf29 \
                            file://LICENSE.atmel;md5=aa74ac0c60595dee4d4e239107ea77a3 \
                            file://LICENSE.hfi1_firmware;md5=5e7b6e586ce7339d12689e49931ad444 \
                            file://LICENSE.i915;md5=2b0b2e0d20984affd4490ba2cba02570 \
                            file://LICENSE.QualcommAtheros_ar3k;md5=b5fe244fb2b532311de1472a3bc06da5 \
                            file://LICENSE.QualcommAtheros_ath10k;md5=b5fe244fb2b532311de1472a3bc06da5 \
                            file://WHENCE;md5=ea5b4874561218d33da61bdaa8bc3c36 \
"

NO_GENERIC_LICENSE[Firmware-adsp_sst] = "LICENCE.adsp_sst"
NO_GENERIC_LICENSE[Firmware-cavium] = "LICENCE.cavium"
NO_GENERIC_LICENSE[Firmware-e100] = "LICENCE.e100"
NO_GENERIC_LICENSE[Firmware-kaweth] = "LICENCE.kaweth"
NO_GENERIC_LICENSE[Firmware-moxa] = "LICENCE.moxa"
NO_GENERIC_LICENSE[Firmware-nvidia] = "LICENCE.nvidia"
NO_GENERIC_LICENSE[Firmware-open-ath9k-htc-firmware] = "LICENCE.open-ath9k-htc-firmware"
NO_GENERIC_LICENSE[Firmware-qat] = "LICENCE.qat_firmware"
NO_GENERIC_LICENSE[Firmware-qla1280] = "LICENCE.qla1280"
NO_GENERIC_LICENSE[Firmware-rockchip] = "LICENCE.rockchip"
NO_GENERIC_LICENSE[Firmware-ti-keystone] = "LICENCE.ti-keystone"
NO_GENERIC_LICENSE[Firmware-amdgpu] = "LICENSE.amdgpu"
NO_GENERIC_LICENSE[Firmware-atmel] = "LICENSE.atmel"
NO_GENERIC_LICENSE[Firmware-hfi1_firmware] = "LICENSE.hfi1_firmware"
NO_GENERIC_LICENSE[Firmware-i915] = "LICENSE.i915"
NO_GENERIC_LICENSE[Firmware-qualcommAthos_ar3k] = "LICENSE.QualcommAtheros_ar3k"
NO_GENERIC_LICENSE[Firmware-qualcommAthos_ath10k] = "LICENSE.QualcommAtheros_ath10k"
NO_GENERIC_LICENSE[WHENCE] = "WHENCE"

SRCREV = "8d151010a70696952fee4a64f578c44b325fba8b"

RDEPENDS_${PN} += " python"

do_patch() {
	cd ${S}
	# Binary patch must be patched in sequence
	git am ${WORKDIR}/0001-linux-firmware-i915-HuC-firmware-for-Broxton-v1.7.patch
	git am ${WORKDIR}/0002-i915-GuC-firmware-for-Broxton-v9.29.patch
}

do_install_append() {
        # Copy the NVRAM file required for Broadcom Wi-Fi card
        cp ${WORKDIR}/brcmfmac43241b4-sdio.txt ${D}/lib/firmware/brcm/
}

LICENSE_${PN} += "\
    Firmware-qat \
    & Firmware-adsp_sst \
    & Firmware-cavium \
    & Firmware-e100 \
    & Firmware-kaweth \
    & Firmware-moxa \
    & Firmware-nvidia \
    & Firmware-open-ath9k-htc-firmware \
    & Firmware-qla1280 \
    & Firmware-rockchip \
    & Firmware-ti-keystone \
    & WHENCE \
"

PACKAGES =+ "\
    ${PN}-i915-license ${PN}-i915 \
    ${PN}-ath10k-license  ${PN}-ath10k  \
"

LICENSE_${PN}_remove = "\
    Firmware-qat_dh895xcc_firmware \
    & Firmware-mwl8335 \
"

LICENSE_${PN}-i915       = "Firmware-i915"
LICENSE_${PN}-i915-license = "Firmware-i915"
FILES_${PN}-i915-license = "${nonarch_base_libdir}/firmware/LICENSE.i915"
FILES_${PN}-i915         = "${nonarch_base_libdir}/firmware/i915"
RDEPENDS_${PN}-i915      = "${PN}-i915-license"

LICENSE_${PN}-ath10k = "Firmware-qualcommAthos_ath10k"
LICENSE_${PN}-ath10k-license = "Firmware-qualcommAthos_ath10k"
FILES_${PN}-ath10k-license = "${nonarch_base_libdir}/firmware/LICENSE.QualcommAtheros_ath10k"
FILES_${PN}-ath10k = " \
  ${nonarch_base_libdir}/firmware/ath10k \
"
RDEPENDS_${PN}-ath10k += "${PN}-ath10k-license"
