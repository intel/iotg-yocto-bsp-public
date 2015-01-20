FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://brcmfmac43241b4-sdio.txt \
	    file://0001-Add-BXT-DMC-1.07-firmware.patch \
	    file://0002-linux-firmware-i915-GuC-firmware-for-Broxton-v8.7.patch \
           "

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
